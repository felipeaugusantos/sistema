# Análise de Requisito — Req. 462864

**Título:** Erro de FOREIGN KEY (FK_HISENT_02) ao confirmar entrada de mercadorias de nota de devolução
**Solicitante:** Gabriel — cliente SO Tintas RJ (empresa 400 - VIKS IMPORTAÇÃO E EXPORTAÇÃO LTDA)
**Ticket Zendesk:** https://citelsoftware.zendesk.com/agent/tickets/1678785
**Data da análise/implementação:** 2026-09-18

## 1. Contexto de negócio

A rotina de **Entrada de Mercadorias** (`PRINCIPAL > MOVIMENTAÇÃO DE ITENS > ENTRADA DE MERCADORIAS`, unit
`untEntMercadorias.pas` / `untEntDadosFiscaisResumo.pas`) processa tanto entradas normais de compra de
fornecedor quanto **devoluções de venda feitas por um cliente**, recebimentos de cliente em garantia e
retornos de consignação de equipamento. Nesses três últimos casos o "documento de origem" referenciado pela
entrada é, na prática, um pedido de venda anteriormente emitido para um **cliente** — não um pedido de
compra de um fornecedor.

Ao confirmar a entrada, a rotina `fConfirmaEntradaMercadorias` (`untPcmGer.pas`) baixa o pedido vinculado e
grava um histórico de movimentação na tabela `HISENT`. O campo `HISENT.HIS_CODFOR` possui a restrição de
chave estrangeira `FK_HISENT_02`, que exige que o valor gravado exista em `CADFOR.FOR_CODFOR` (cadastro de
fornecedores).

## 2. Problema e causa raiz

### 2.1 Sintoma relatado

Ao confirmar a entrada de uma nota de devolução, o sistema apresentava o erro:

```
#23000Cannot add or update a child row: a foreign key constraint fails
(`AUTCOM`.`HISENT`, CONSTRAINT `FK_HISENT_02` FOREIGN KEY (`HIS_CODFOR`) REFERENCES `CADFOR` (`FOR_CODFOR`)).
```

com `HIS_CODFOR = 10103835` (documento de teste do call stack) / `10094988` (código informado nas consultas
de simulação do chamado). Como medida paliativa, o cliente foi orientado a confirmar a entrada sem
referenciar a nota de venda original — contornando o problema, mas perdendo o vínculo com o documento de
origem.

### 2.2 Mecanismo em uso e causa raiz

O call stack do erro (madExcept) mostra a cadeia:

```
TfrmEntMercadorias.btnConfirmaClick
  → TfrmEntDadosFiscaisResumo.btnConfirmaClick
    → fConfirmaEntradaMercadorias        (untPcmGer.pas)
      → fBaixaPedidosEntrada             (função aninhada em fConfirmaEntradaMercadorias)
        → fBaixaPedidosEmbalagem         (untPcmGer.pas)
          → fGravaHistoricoEntradaMercadorias   ← INSERT em HISENT que dispara a FK
```

`fBaixaPedidosEmbalagem` recebia o parâmetro `strCodFor` e, sempre que ele estivesse preenchido
(`Not fEmptyStr(strCodFor)`), chamava incondicionalmente `fGravaHistoricoEntradaMercadorias`, gravando esse
valor em `HISENT.HIS_CODFOR`.

O problema é que, em `fConfirmaEntradaMercadorias`, o parâmetro `strCodFor` é reaproveitado para carregar o
código da **contraparte do documento**, seja ela fornecedor ou cliente — a própria função já decide isso em
outros pontos do mesmo arquivo, por exemplo: `IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or
AblnAcessadoViaRetornoConsignacao, strCodFor, '')` grava esse código como **cliente**
(`GER_CODCLI`)/`FIS_TIP_FC='C'` quando qualquer uma dessas flags está ativa. Ou seja: para devolução,
garantia de cliente ou consignação de equipamento, `strCodFor` contém um **código de cliente**, não de
fornecedor — mas `fBaixaPedidosEmbalagem` não tinha acesso a nenhuma dessas flags para saber disso, e
gravava o valor em `HISENT.HIS_CODFOR` do mesmo jeito, violando a FK quando esse código não existe (ou não
é o mesmo) em `CADFOR`.

### 2.3 Validação (consulta somente-leitura, ambiente de simulação indicado no chamado)

Consultas fornecidas para simulação (schema `AUTCOM`, acesso somente leitura):

```sql
SELECT * FROM DEL_CADFOR WHERE FOR_CODFOR='10094988';
SELECT * FROM CADFOR     WHERE FOR_CODFOR='10094988';
```

confirmam que o código informado não corresponde a um fornecedor ativo em `CADFOR` — consistente com se
tratar, na verdade, de um código de cliente sendo gravado no campo errado.

Documento de origem indicado (devolução, nota `000000020991`/`NF`/série `036`):

```sql
SELECT P.PCG_NUMPED, P.PCG_CODEMP
  FROM PCMGER P
 WHERE P.PCG_DOCORI = CONCAT('000000020991', 'NF', '036')
   AND P.PCG_BAIXAD = 0
   AND P.PCG_ESPDOC = "PD"
   AND P.PCG_EMPDES = '400'
```

confirma a existência do pedido de compra vinculado (`PCMGER`), que precisa continuar sendo baixado
normalmente após a correção — o ajuste não pode deixar o pedido pendente.

## 3. Investigação realizada

1. Localizada a cadeia de chamadas a partir do call stack do erro (madExcept), até
   `fBaixaPedidosEmbalagem` / `fGravaHistoricoEntradaMercadorias` em `untPcmGer.pas`.
2. Lida por completo a função `fBaixaPedidosEmbalagem` (assinatura, variáveis em escopo, laço de baixa de
   pedidos) e confirmado que **nenhum parâmetro relacionado a devolução/garantia/consignação existia na sua
   assinatura** — ela não tinha como saber se `strCodFor` continha um código de fornecedor ou de cliente.
3. Localizados, dentro de `fConfirmaEntradaMercadorias`, os usos de `blnDevolu`, `blnRecCliGarantia`,
   `blnConEqu` e `AblnAcessadoViaRetornoConsignacao` — confirmando que são parâmetros já existentes da
   própria função (não variáveis globais), disponíveis por escopo léxico dentro da função aninhada
   `fBaixaPedidosEntrada`, que é quem chama `fBaixaPedidosEmbalagem`.
4. Localizados, por busca textual exaustiva no arquivo, **todos** os call sites de `fBaixaPedidosEmbalagem`
   (função não declarada na interface da unit, portanto de uso restrito a `untPcmGer.pas`): dois dentro de
   `fBaixaPedidosEntrada` (o caminho do bug) e um terceiro dentro do wrapper público `fBaixaPedidos`
   (usado fora do fluxo de entrada de mercadorias, sem acesso às flags de devolução/garantia/consignação).
5. Confirmada, por leitura da estrutura das três working copies (`74.150.45`, `74.150.100`, `74.150`), que a
   função e os call sites têm o mesmo texto exato em todas (apenas deslocados em número de linha), permitindo
   aplicar a mesma correção por conteúdo em cada uma.
6. Durante a leitura do arquivo, identificada uma **corrupção de encoding pré-existente e não relacionada a
   este requisito** — ver seção 7.

## 4. Abordagens consideradas e descartadas

- **Adicionar a validação de devolução dentro de `fGravaHistoricoEntradaMercadorias`** — descartada porque
  essa função já recebe `strCodFor` sem contexto de por que está sendo chamada; o ponto correto para decidir
  se a gravação deve ocorrer é o chamador (`fBaixaPedidosEmbalagem`), que está no fluxo de baixa do pedido e
  é onde a condição `Not fEmptyStr(strCodFor)` já existia.
- **Usar variável global/de unit para carregar as flags de devolução** — descartada por violar a diretriz do
  projeto de evitar estado mutável compartilhado via variável global de unit; optou-se por parâmetros
  explícitos com valor default, preservando o estilo de passagem de parâmetros já usado no restante da
  função.
- **Alterar a assinatura para receber apenas um único parâmetro agregador (ex.: `blnContraparteEhCliente`)**
  — descartada em favor de manter os quatro nomes de flag originais (`blnDevolu`, `blnRecCliGarantia`,
  `blnConEqu`, `blnAcessadoViaRetornoConsignacao`), pois são os mesmos nomes já usados extensivamente no
  restante do arquivo para essa mesma distinção — manter a nomenclatura idêntica facilita rastreabilidade e
  evita introduzir um novo conceito paralelo.

## 5. Solução aplicada

`fBaixaPedidosEmbalagem` passou a receber quatro novos parâmetros booleanos opcionais, todos com valor
default `False` (preservando compatibilidade com o único call site que não tem essas flags em escopo):
`blnDevolu`, `blnRecCliGarantia`, `blnConEqu`, `blnAcessadoViaRetornoConsignacao`.

A condição que decide gravar o histórico de fornecedor (`fGravaHistoricoEntradaMercadorias`) passou de:

```pascal
If Not fEmptyStr(strCodFor) Then
```

para:

```pascal
If Not fEmptyStr(strCodFor) And
   (Not (blnDevolu Or blnRecCliGarantia Or blnConEqu Or blnAcessadoViaRetornoConsignacao)) Then
```

ou seja, a gravação em `HISENT.HIS_CODFOR` só ocorre quando o documento é efetivamente uma entrada de
fornecedor — nunca para devolução de cliente, recebimento de garantia ou retorno de consignação de
equipamento.

### Arquivos alterados (mesmo diff aplicado em todas as cópias)

| Working copy | Status |
|---|---|
| `379.48.2.30.74.150.45` (origem da correção) | Alterado |
| `379.48.2.30.74.150.100` | Alterado (mesmo diff, verificado por conteúdo exato) |
| `379.48.2.30.74.150` | Alterado (mesmo diff, verificado por conteúdo exato) |
| `74.Fechadas\74.150.45.Fechadas\379.48.2.30.74.150.45.69` | Alterado (mesmo diff, verificado por conteúdo exato — aplicado a pedido do usuário após revisão inicial ter coberto só as 3 cópias acima) |
| `74.Fechadas\74.150.45.Fechadas\379.48.2.30.74.150.45.68` | Alterado (mesmo diff, verificado por conteúdo exato — aplicado a pedido do usuário) |

Em todas: `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas`, três pontos:

1. **Assinatura de `fBaixaPedidosEmbalagem`** — quatro novos parâmetros booleanos opcionais adicionados após
   `blnUtilizarCFG_CLARET`, todos default `False`.
2. **Condição de gravação do histórico**, dentro do laço principal de `fBaixaPedidosEmbalagem` — descrita
   acima.
3. **Dois call sites, dentro da função aninhada `fBaixaPedidosEntrada`** (aninhada em
   `fConfirmaEntradaMercadorias`):
   - Ramo `If (Not fZeraDataEntrada(ValidacaoZeraData)) or (blnGarantia) Then` — chamada original só ia até
     `pgbDados`; passou a incluir `False` explícito para `blnUtilizarCFG_CLARET` e os quatro novos argumentos
     (`blnDevolu`, `blnRecCliGarantia`, `blnConEqu`, `AblnAcessadoViaRetornoConsignacao` — variáveis já
     existentes no escopo de `fConfirmaEntradaMercadorias`, sem necessidade de nova declaração).
   - Ramo `If (blnConferenciaDepoisDaEntrada and blnUtilizarCFG_CLARET) and (Not blnGarantia) Then` — chamada
     já passava `blnUtilizarCFG_CLARET`; os mesmos quatro argumentos foram adicionados na sequência.

O wrapper público `fBaixaPedidos` (usado fora do fluxo de entrada de mercadorias, ex.: chamado sem as flags
de devolução em escopo) **não foi alterado** — continua chamando `fBaixaPedidosEmbalagem` sem os quatro
novos parâmetros, usando os valores default `False`, preservando exatamente o comportamento anterior para
esse caminho (que não faz parte do bug reportado).

Como as três cópias têm o mesmo trecho de código (mesmo texto exato, apenas deslocado em número de linha
entre `74.150.45` e as demais), a correção foi localizada e aplicada por **conteúdo exato do trecho de
código** em cada arquivo — nunca por número de linha fixo — e cada ocorrência foi confirmada individualmente
(contagem de 1 match por trecho) antes da gravação.

### Validação pós-implementação

Validação por revisão de lógica e rastreamento de escopo de variáveis (sem simulação em ambiente de
homologação nesta sessão, por não haver acesso a IDE Delphi/compilador no ambiente de execução):

- Confirmado, por busca textual exaustiva, que `fBaixaPedidosEmbalagem` não é declarada na interface da
  unit — logo os três call sites localizados (dois alterados + o wrapper `fBaixaPedidos`) são **todos** os
  pontos de chamada existentes no projeto; não há chamadas externas a esta unit que precisassem de ajuste.
- Confirmado que `blnConEqu` e `AblnAcessadoViaRetornoConsignacao` já eram parâmetros de
  `fConfirmaEntradaMercadorias`, portanto disponíveis por escopo léxico dentro de `fBaixaPedidosEntrada`
  sem necessidade de nova variável ou parâmetro adicional na função aninhada.
- Para o fluxo de fornecedor (`blnDevolu=False`, `blnRecCliGarantia=False`, `blnConEqu=False`,
  `blnAcessadoViaRetornoConsignacao=False`), a nova condição é logicamente equivalente à antiga
  (`Not fEmptyStr(strCodFor) And True`) — **nenhum comportamento muda para entrada normal de fornecedor**.
- A baixa do pedido de compra (`fBaixaPcmDet`/`fBaixaPcmGer`, chamadas nas linhas seguintes do mesmo laço em
  `fBaixaPedidosEmbalagem`) permanece fora do bloco condicional alterado — a correção afeta **apenas** a
  gravação do histórico de fornecedor em `HISENT`, não a baixa do pedido em si, atendendo ao requisito de
  que o pedido de compra continue sendo baixado corretamente mesmo para devolução.

## 6. Decisões de escopo

**Incluído:** correção do ponto único identificado em `untPcmGer.pas` (`fBaixaPedidosEmbalagem` + dois call
sites), aplicada nas três working copies listadas.

**Excluído deliberadamente:**

- **Simulação/reprodução em ambiente de homologação** — validação feita por revisão de código/escopo de
  variáveis, sem reproduzir o cenário em um ambiente real (sem acesso a IDE Delphi neste ambiente de
  execução).
- **Correção da corrupção de encoding pré-existente** encontrada nos três arquivos (ver seção 7) — fora do
  escopo deste requisito, tratada apenas como ressalva registrada.
- **Alteração do wrapper `fBaixaPedidos`** — não recebeu os novos parâmetros por não ter as flags de
  devolução/garantia/consignação disponíveis em seu escopo de chamada e por não fazer parte do fluxo do bug
  reportado; manter seu comportamento inalterado (defaults `False`) foi decisão deliberada para não expandir
  o raio de impacto da correção além do necessário.

## 7. Achados colaterais (fora de escopo, registrados para não serem esquecidos)

1. **Corrupção de encoding pré-existente em `untPcmGer.pas` (nas 4 working copies) — NÃO CORRIGIDA; tentativa
   revertida nesta sessão.** O arquivo contém, em 15 a 17 linhas por cópia (espalhadas por diversas funções,
   não só o comentário de `fZeraDataEntrada` inicialmente identificado), trechos de comentário cujos bytes
   — quando o arquivo é lido estritamente como cp1252/Latin-1 — não decodificam (`0x81`/`0x87`/`0x83` etc.).
   Confirmado via `svn cat` (BASE) que isso já está commitado no SVN havia tempo, não é uma alteração local
   desta sessão. A revisão que introduziu o primeiro trecho identificado (comentário de `fZeraDataEntrada`)
   foi a `432653` (`svn blame`), do próprio autor `danilo.ste`.

   **Tentativa de correção nesta sessão (revertida):** a pedido do usuário, essas linhas foram inicialmente
   reinterpretadas como "UTF-8 gravado por engano num arquivo cp1252" e convertidas para bytes cp1252 puros
   (decode UTF-8 → encode cp1252). Essa suposição se mostrou **errada**: comparando `svn diff` (que neste
   ambiente renderiza como UTF-8), a versão BASE original exibia os acentos corretamente (`ENDEREÇAR`, `NÃO`,
   `JÁ`...), enquanto a versão "corrigida" passou a exibir `�` — sinal de que essas linhas específicas são
   efetivamente lidas/gravadas como UTF-8 pelas ferramentas usadas no dia a dia (svn diff, possivelmente o
   próprio editor), não como cp1252, ao contrário do que o `.editorconfig` declara para o arquivo como um
   todo. O usuário reportou "você zuou todos os comentários!" ao ver o resultado, e a conversão foi revertida
   integralmente (byte a byte, de volta ao exato conteúdo BASE) nas 4 working copies, mantendo apenas o fix
   funcional do Req. 462864 intacto — confirmado via `corrigeUnitFlipCRLF-LF` que o `svn diff` resultante
   contém somente as 4 alterações pretendidas.

   **Estado atual:** corrupção/inconsistência de encoding permanece exatamente como estava antes desta
   sessão (não corrigida, não piorada). **Não investigar/corrigir via suposição de encoding único para o
   arquivo inteiro** — este arquivo aparenta misturar cp1252 (maioria) com trechos que precisam ser tratados
   como UTF-8 por pelo menos uma ferramenta usada pela equipe, e uma correção real exigiria primeiro
   confirmar, com o usuário, qual encoding cada ferramenta relevante (Delphi IDE, SVN client, diff) realmente
   usa para este arquivo antes de tocar em qualquer byte — não apenas inferir do padrão de decodificação.

## 8. Ressalvas e lições

- **Arquivo `.pas` em encoding legado (cp1252/Latin-1) com corrupção pré-existente:** por causa do achado da
  seção 7, a leitura/escrita de `untPcmGer.pas` nesta sessão foi feita **em nível de bytes** (Python,
  `open(path, 'rb')`/`open(path, 'wb')`, sem decodificar o arquivo inteiro), em vez do padrão usual
  `io.open(..., encoding='cp1252', newline='')`. Isso foi necessário porque o arquivo inteiro **não
  decodifica** em cp1252 (a corrupção pré-existente quebra a decodificação global), então uma leitura em modo
  texto teria falhado antes mesmo de chegar ao trecho a ser editado. Trabalhar em bytes, comparando e
  substituindo os trechos exatos (codificados para cp1252 apenas no momento da comparação, sem acentos nas
  strings novas), evitou tocar na região já corrompida — preservando-a exatamente como estava (nem
  corrigindo, nem piorando) — e evitou introduzir qualquer nova sequência UTF-8 (validado: ausência de
  `\xef\xbf\xbd` após a gravação, nas três cópias).
- **Ferramenta de edição de texto genérica nunca utilizada neste arquivo:** por ser um arquivo de encoding
  legado, todas as edições foram feitas via Python — nunca pela ferramenta de edição de texto genérica —, que
  resalva o arquivo inteiro e corromperia a acentuação (inclusive a região já corrompida, agravando o
  problema) caso presumisse UTF-8.
- **Três working copies com numeração de linha divergente:** apesar de terem o mesmo trecho de código (mesmo
  texto exato), `74.150.100` e `74.150` têm todas as linhas subsequentes deslocadas em ~4 linhas em relação a
  `74.150.45`. A correção foi localizada por conteúdo textual exato em cada arquivo, nunca por número de
  linha fixo, e cada substituição foi validada com contagem de ocorrências igual a 1 antes de ser aplicada.
- **Não confiar em decodificação bem-sucedida como prova de qual é o encoding "certo" de um trecho:** o
  fato de um trecho decodificar sem erro como UTF-8 não significa que ele *deva* ser convertido para o
  encoding declarado do arquivo (cp1252) — pode ser que aquele trecho específico já seja consumido como
  UTF-8 pelas ferramentas reais do dia a dia (neste caso, ao menos o `svn diff` do ambiente), e "corrigi-lo"
  para bater com o encoding nominal do restante do arquivo pode trocar uma leitura que funcionava por uma
  que não funciona. A prova de round-trip (`decode/encode` sem perda) garante que a transformação é
  reversível, mas **não** garante que o encoding de destino escolhido é o que as ferramentas do usuário
  realmente esperam para aquele trecho — isso só se confirma comparando a renderização antes/depois em
  ferramentas reais (`svn diff`, o próprio editor), ou perguntando ao usuário, antes de gravar.
- **Análise de escopo léxico foi decisiva:** a causa raiz só ficou completa ao perceber que
  `fBaixaPedidosEmbalagem` é uma função de nível de unit **separada** de `fConfirmaEntradaMercadorias`, sem
  acesso automático às variáveis desta última — diferente de `fBaixaPedidosEntrada`, que é uma função
  **aninhada** dentro de `fConfirmaEntradaMercadorias` e por isso já "enxergava" `blnDevolu` etc. por
  closure. A correção sugerida inicialmente (apenas adicionar a condição dentro de
  `fBaixaPedidosEmbalagem` usando essas variáveis diretamente) não compilaria sem antes threading os quatro
  parâmetros através da assinatura e dos dois call sites internos a `fBaixaPedidosEntrada`.

## 9. Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit:** `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas`
**Função:** `fBaixaPedidosEmbalagem`

**Explicação completa:** a condição original (`If Not fEmptyStr(strCodFor) Then`) disparava a gravação do
histórico de fornecedor (`fGravaHistoricoEntradaMercadorias`, `INSERT` em `HISENT.HIS_CODFOR`) sempre que
`strCodFor` estivesse preenchido, sem verificar **por que** o documento estava sendo processado. Em
`fConfirmaEntradaMercadorias` (a função-mãe, via a função aninhada `fBaixaPedidosEntrada`), o parâmetro
`strCodFor` é reaproveitado para carregar o código da contraparte do documento — que é um código de
**cliente**, não de fornecedor, sempre que o documento é uma devolução de venda (`blnDevolu`), um
recebimento de cliente em garantia (`blnRecCliGarantia`), uma consignação de equipamento (`blnConEqu`) ou um
acesso via retorno de consignação (`blnAcessadoViaRetornoConsignacao`) — o próprio `fConfirmaEntradaMercadorias`
já trata essa distinção em vários outros pontos do arquivo (ex.: grava `GER_CODCLI`/`FIS_TIP_FC='C'` nesses
casos).

Como `HISENT.HIS_CODFOR` tem a restrição `FK_HISENT_02` apontando para `CADFOR.FOR_CODFOR`, gravar ali um
código que é na verdade de um cliente (que não existe, ou não corresponde ao mesmo código, em `CADFOR`)
provoca o erro `#23000` de violação de chave estrangeira e impede a confirmação da entrada — exatamente o
sintoma relatado no Req. 462864.

**Por que isso não é óbvio e por que uma revisão futura não deve remover a condição adicionada:** a condição
original parecia correta à primeira vista, porque de fato "se há um fornecedor, grava o histórico dele" é a
regra certa **para entrada de compra normal**. O que não é evidente ao ler só esse trecho é que a mesma
variável `strCodFor` é reaproveitada, no fluxo de devolução/garantia/consignação, para carregar um código de
**cliente** — informação que só existe olhando o restante de `fConfirmaEntradaMercadorias` (fora do escopo
de `fBaixaPedidosEmbalagem`). Remover a checagem de `blnDevolu Or blnRecCliGarantia Or blnConEqu Or
blnAcessadoViaRetornoConsignacao` reintroduziria exatamente o erro de FK relatado neste requisito, para todo
documento de entrada originado de devolução de cliente, garantia ou consignação de equipamento que informe
o código dessa contraparte.
