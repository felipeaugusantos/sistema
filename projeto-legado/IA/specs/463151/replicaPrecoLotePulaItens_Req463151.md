# Análise de Requisito — Req. 463151

**Título:** Replicação de preço/frete em lote pula itens
**Módulo:** Movimentação de Itens — Ativação de Lote de Preços
**Unit:** `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas` (classe `TLotePrecos`)
**Data da análise:** 22/09/2026

## 1. Contexto de negócio

A tela de **Ativação de Lote de Preços** é usada, entre outros fluxos, na entrada de mercadorias por
nota fiscal: ao lançar um documento de compra, o operador confere/ajusta os componentes de preço de
custo e de venda de cada item do lote (preço de compra, descontos, ICMS, IPI, frete, acréscimo
financeiro, margem, preço de venda por até 7 tabelas de preço, etc.), gravados na tabela `LOTPRE` (um
registro por item/documento, com colunas pareadas `_ANT` (valor anterior), atual e `_ALT` (valor
alterado pendente) para cada campo de preço).

Para agilizar a conferência de documentos com muitos itens, a tela permite alterar um campo em **um**
item e marcar a opção **"replicar para todos os itens"** — o sistema então aplica o mesmo valor a todos
os demais itens do lote (ou a todos os itens de um mesmo grupo de preço, quando configurado). Essa
replicação é usada com frequência para campos como frete (`LTP_FREENT`), que tipicamente é o mesmo para
todos os itens de uma mesma nota fiscal.

## 2. Problema relatado

Cliente reportou, no mesmo atendimento do Req. 461662 (Zendesk 1655410, Moto Mais), que ao alterar o
valor de frete em um item e marcar "replicar para todos os itens", **parte dos itens do documento não
recebia o valor replicado** — sem nenhuma mensagem de erro, sem travamento, sem qualquer sinal visível
de que algo tinha falhado. O usuário só percebia o problema ao conferir manualmente, campo a campo, após
gravar o documento.

### 2.1 Hipótese inicial descartada

A primeira hipótese levantada foi a de que a ordenação do grid de itens, alterada manualmente pelo
usuário durante a conferência, estivesse interferindo na replicação. Essa hipótese foi **descartada em
teste ao vivo**: o usuário relatou explicitamente que o grid já abria ordenado pela coluna "% Difer.
Custo" por padrão, e que não alterou a ordenação durante o teste. Um teste concreto foi realizado:
alterado o frete no item 43481, marcado replicar; o item 43465 recebeu o valor corretamente, mas o item
43446 não — com o grid nunca reordenado manualmente pelo usuário durante o teste.

Adicionalmente, o usuário observou que a replicação de **preço de venda e margem** (campos PREVE/MARBR)
sempre funcionou corretamente para todos os itens, independentemente da ordenação — um dado importante
que ajudou a direcionar o diagnóstico para uma diferença de comportamento entre campos, e não para um
problema genérico de toda replicação.

## 3. Investigação realizada

### 3.1 Instrumentação de diagnóstico

Foi criado um log de diagnóstico temporário (nunca commitado, gravado em arquivo local fora do
versionamento — `C:\Users\<usuario>\Desktop\temp\log_pAlterarPrecoMargem.txt`), instrumentando:

- `TLotePrecos.pAlterarPrecoMargem` (procedure que aplica o valor a um único item, com todas as
  validações e o cálculo/recálculo de preço): logado o campo alterado, o valor, o item em processamento,
  e o ponto de saída de cada validação (`Exit`), incluindo o resultado de `fDigitaValor`.
- `TLotePrecos.pReplicaPrecoParaItens` (procedure que percorre os itens do lote chamando
  `pAlterarPrecoMargem` para cada um): logado o início/fim do laço, a quantidade de itens do dataset
  (`RecordCount`), e, em rodadas sucessivas de refinamento, o estado de navegação do dataset a cada
  iteração (`RecNo`, `RecordCount`, `Bof`, `Eof`).

Uma versão manual do log (`_VERSAO_LOG_DBG`, incrementada a cada mudança na instrumentação, ex.: `V1.1`,
`V1.2`) foi usada para o usuário confirmar, a cada novo teste, que o build em execução já refletia a
última instrumentação — necessário porque `untFuncoesSimples.fRetornaVersao()` (versão do executável)
retorna sempre o mesmo valor em modo debug, não servindo para esse propósito.

### 3.2 Evidência: quantidade de itens

Consulta somente leitura (via conexão MySQL read-only) em `LOTPRE` para o documento de teste
(`LTP_NUMDOC = '000000011682'`, `LTP_CODFOR = '00001059'`) confirmou que o documento possuía **30
itens**. O primeiro log capturado, no entanto, mostrava apenas **3 itens** processados pelo laço de
replicação (43446, 43481, 43465) antes do laço terminar (`Eof`). Essa divergência (30 esperados vs. 3
processados) descartou qualquer hipótese de problema de dados e apontou definitivamente para o laço de
navegação em `pReplicaPrecoParaItens` como a origem do problema.

### 3.3 Evidência: reordenação em tempo real do dataset

Uma rodada adicional de instrumentação, logando `RecNo`/`RecordCount`/`Bof`/`Eof` do dataset de itens a
cada iteração do laço, revelou o mecanismo exato da falha:

1. O laço inicia em `RecNo=1` (item 43446, primeiro pela ordenação ativa) e chama `pAlterarPrecoMargem`
   para esse item.
2. **Durante essa chamada** (antes do `Dataset.Next` seguinte ser executado), o `RecNo` do item recém
   processado muda sozinho de `1` para `28`.
3. O `Dataset.Next` seguinte avança para `29` (item 43481) e depois `30` (item 43465) — os itens que
   ficaram entre as posições 2 e 27 na nova ordenação (26 itens) nunca são revisitados, porque o laço só
   avança a partir da posição atual, e a posição atual já "pulou" para a frente.
4. O laço termina (`Eof`) tendo processado apenas os itens 43446, 43481 e 43465 — exatamente os 3
   observados no log original.

Essa reordenação em tempo real é consistente com a coluna de ordenação padrão do grid ("% Difer.
Custo"), calculada a partir do próprio custo/preço do item — ao alterar o frete (que compõe o custo) de
um item, o valor dessa coluna muda, e a grade se reordena. Isso também explica por que a replicação de
**preço de venda/margem** nunca apresentou o problema: embora esses campos também possam influenciar
colunas calculadas, os testes do usuário e a instrumentação confirmaram que a replicação desses campos
processa todos os itens corretamente antes e depois da correção (ver seção 6).

### 3.4 Causa raiz: origem no histórico de versionamento

A reordenação em tempo real só é capaz de interromper o laço porque, entre uma iteração e outra, o
sistema processa a fila de mensagens do Windows (`Application.ProcessMessages`) — é esse processamento
que dá à grade a oportunidade de se redesenhar/reordenar imediatamente após o recálculo do item, ainda
dentro do próprio laço.

Usando `svn log` e `svn diff` sobre as últimas três revisões de `untLotePrecos.pas`:

| Revisão | Requisito | Toca `pReplicaPrecoParaItens`? | Relevante? |
|---------|-----------|-------------------------------|------------|
| r494484 | 461662 (trava e fecha sozinho ao ativar lote de preços) | **Sim** | **Sim — causa raiz** |
| r494179 | 461107 (itens não aparecem no fluxo de compras) | Não | Não |
| r493303 | 460063 (lentidão no arredondamento de preço de venda) | Não | Não |

O `svn diff -c 494484` confirma que essa revisão adicionou, dentro do laço `While not Dataset.eof do`,
imediatamente antes do `Dataset.Next` já existente, o seguinte trecho:

```pascal
If Assigned(pgbStatus) Then
Begin
  pgbStatus.Position := pgbStatus.Position + 1;
  Application.ProcessMessages;   {<- introduzido na r494484}
End;

Dataset.Next;
```

O objetivo dessa mudança (r494484, Req. 461662) era legítimo e documentado: sem esse
`Application.ProcessMessages`, o Windows marcava a tela como "não responde" em lotes com muitos itens,
podendo levar o Autcom a fechar sozinho — o mesmo atendimento do cliente que originou este requisito
(Zendesk 1655410). **Antes dessa revisão, esse laço não continha nenhuma chamada que liberasse o
processamento de eventos do Windows no meio da iteração**, então a grade nunca tinha oportunidade de se
reordenar durante o próprio laço — a fragilidade de fundo (navegação por posição relativa num dataset
que pode reordenar) já existia antes, mas era inofensiva até esse ponto.

**Conclusão:** o bug de itens pulados na replicação é um efeito colateral direto e não intencional da
correção de performance/travamento do Req. 461662. As outras duas revisões analisadas (r494179 e
r493303) não têm qualquer relação — tocam, respectivamente, o carregamento de documentos "PD Entrada" no
fluxo de compras (`fCarregaNota`) e a tela de seleção em lote de itens para arredondamento
(`TfrmLotePrecosEfetivacaoCx`), sem tocar em `pReplicaPrecoParaItens` nem em qualquer mecanismo de
ordenação do dataset de itens.

## 4. Abordagens avaliadas e descartadas

- **Reverter o `Application.ProcessMessages` da r494484:** descartada. Reintroduziria o travamento/
  fechamento inesperado do Autcom em lotes grandes, que é um problema real e documentado, afetando o
  mesmo cliente.
- **Detectar e recompensar a reordenação (ex.: salvar `Bookmark` do próximo item antes de processar o
  atual):** avaliada e descartada em favor de uma solução mais simples e definitiva — bookmarks de
  `TDataSet` podem ser invalidados por outras operações (`Refresh`, `Requery`) e adicionam complexidade
  de gerenciamento (`FreeBookmark`) sem necessidade, já que o dataset já expõe uma chave de negócio
  estável (`ITE_CODITE`).
- **Desabilitar a ordenação/índice ativo do dataset de itens durante o laço de replicação:** descartada
  por ser uma alteração de escopo mais amplo (afetaria a experiência do usuário durante a replicação,
  fazendo a grade "pular" visualmente para uma ordem diferente ao final) e por não ser necessária — a
  solução por chave resolve o problema sem tocar em comportamento de UI.

## 5. Solução aplicada

`TLotePrecos.pReplicaPrecoParaItens` foi reescrita para não depender de navegação por posição relativa:

1. **Antes de aplicar qualquer alteração**, o dataset de itens é percorrido uma única vez
   (`Dataset.First` / `While not Dataset.Eof do ... Dataset.Next`) apenas para coletar o `ITE_CODITE` de
   cada item numa `TStringList` (`lstCodItens`) — uma "foto" da composição do lote antes de qualquer
   recálculo.
2. A replicação em si passa a ser um `For` sobre essa lista fixa. A cada iteração, o dataset é
   reposicionado no item correspondente via `Dataset.Locate('ITE_CODITE', lstCodItens[intIdx], [])` —
   busca pelo valor da chave, imune a qualquer reordenação física do dataset.
3. Se o `Locate` não encontrar o item (cenário defensivo — ex.: item removido/filtrado durante o
   processamento), a iteração é simplesmente pulada (`Continue`), sem interromper o processamento dos
   demais itens da lista.
4. Todo o restante do comportamento por item foi mantido sem alteração: filtro por grupo de preço
   (`strGrupoPrecoReplica`/`ITE_CODGPR`), chamada a `pAlterarPrecoMargem`, reposicionamento de
   `DataSetPrecos.RecNo` para a linha de preço correta, atualização da barra de progresso (`pgbStatus`)
   e o `Application.ProcessMessages` do Req. 461662 (mantido exatamente como estava).

### 5.1 Trecho final (para referência)

```pascal
lstCodItens := TStringList.Create;
Try
  While not Dataset.Eof do
  Begin
    lstCodItens.Add(Dataset.FieldByName('ITE_CODITE').AsString);
    Dataset.Next;
  End;

  For intIdx := 0 To lstCodItens.Count - 1 Do
  Begin
    If Not Dataset.Locate('ITE_CODITE', lstCodItens[intIdx], []) Then
      Continue;

    FStrCodIteProcessando := 'Item: ' + cdsConsulta.FieldByName('ITE_CODITE').AsString + ' - ' + Dataset.FieldByName('ITE_DESCRI').AsString;

    If ((strGrupoPrecoReplica <> '') And (strGrupoPrecoReplica =  Dataset.FieldByName('ITE_CODGPR').AsString)) Or
        (strGrupoPrecoReplica = '') Then
      pAlterarPrecoMargem(False, Dataset, DataSetPrecos, -1, -1, 0, False, fltValorASerReplicado, blnReplicaTabela, FTravarApenasNaTabelaDePrecoAlterada);

    DataSetPrecos.RecNo:= intRegPrc;

    If Assigned(pgbStatus) Then
    Begin
      pgbStatus.Position := pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;
  End;
Finally
  lstCodItens.Free;
End;
```

## 6. Validação / testes realizados

Sem suite DUnit cobrindo este fluxo (Ativação de Lote de Preços / replicação em massa). Validação feita
manualmente pelo usuário, em cenário real, no mesmo documento de 30 itens usado no diagnóstico:

| Teste | Antes da correção | Depois da correção |
|-------|--------------------|---------------------|
| Alterar frete (FREENT) no item 43481 e replicar | 3 de 30 itens recebem o valor (43446, 43481, 43465) | 30 de 30 itens recebem o valor |
| Alterar margem/preço de venda (MARBR1) e replicar | 30 de 30 (já funcionava) | 30 de 30 (sem regressão) |
| Responsividade da tela durante a replicação (30 itens) | Sem travamento | Sem travamento (mantido) |

Resultado confirmado pelo usuário como "ok" após recompilação e reteste em tela.

## 7. Decisões de escopo

**Incluído:**
- Correção da navegação de `pReplicaPrecoParaItens` para ser imune a reordenação do dataset durante o
  processamento.

**Deliberadamente fora de escopo:**
- Não foi alterado o mecanismo de ordenação/índice da grade de itens em si (o fato de a grade reordenar
  ao vivo durante o recálculo de preço não foi "corrigido" — apenas contornado no laço de replicação).
- Não foi tocado o `Application.ProcessMessages`/`TfrmGravando` introduzidos pelos Req. 461662/460063
  (mecanismo de responsividade), que permanecem exatamente como estavam.
- Não foi feita uma revisão de outros laços do sistema que eventualmente também usem `Dataset.Next`
  sobre datasets potencialmente reordenáveis — ficou registrado como achado colateral (seção 8) para
  eventual atenção futura, mas não foi investigado nem corrigido nesta sessão.

## 8. Achados colaterais (não corrigidos nesta sessão)

- O padrão de navegar um `TDataSet` por `Next` (posição relativa) enquanto o próprio processamento pode
  alterar a ordenação/índice ativo é um risco genérico, não exclusivo desta rotina. Não foi feito um
  levantamento de outros pontos do sistema com o mesmo padrão — registrado aqui apenas como alerta para
  quem for investigar sintomas semelhantes ("processamento em lote que aparenta pular itens
  aleatoriamente") em outras rotinas.

## 9. Ressalvas e lições de processo

- **Encoding:** todas as edições em `untLotePrecos.pas` (arquivo `cp1252` + CRLF) foram feitas
  exclusivamente via script Python com `encoding='cp1252'` explícito, nunca pela ferramenta de edição de
  texto genérica — validado após cada gravação (decodificação sem erro, ausência de
  `\xef\xbf\xbd`, contagem de CRLF consistente).
- **Log de diagnóstico:** toda a instrumentação temporária (método `pLogDbgArquivo`, o wrapper `pLogDbg`
  aninhado em `pAlterarPrecoMargem`, e todas as chamadas de log em ambas as procedures) foi removida por
  completo ao final da investigação. Não restou no fonte nenhum vestígio do log — apenas a correção
  definitiva e seu comentário curto de referência.
- **Conexão de banco:** a consulta a `LOTPRE` durante o diagnóstico foi feita em modo estritamente
  somente leitura (sem nenhum teste de escrita/estresse), por instrução explícita do usuário.

## Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/unit:** `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas`
**Função:** `TLotePrecos.pReplicaPrecoParaItens`

A rotina de replicação percorria a lista de itens usando avanço por posição relativa (`Dataset.Next`), a
partir do início da lista. Um ajuste anterior do sistema (Req. 461662), destinado a evitar que a tela
ficasse "não responde" em lotes grandes, passou a liberar periodicamente o processamento de eventos do
Windows (`Application.ProcessMessages`) a cada item processado. Essa liberação periódica permite que a
grade de itens, quando ordenada por uma coluna calculada a partir do próprio valor sendo alterado (ex.:
"% Difer. Custo"), se reordene imediatamente após o valor de um item ser recalculado — deslocando esse
item para outra posição na lista, ainda dentro da mesma chamada que o processou.

Como a rotina continuava a percorrer a lista a partir da posição seguinte à anterior (`Dataset.Next`), e
não pela posição real do próximo item a processar, os itens que ficaram "para trás" na nova ordenação
eram definitivamente pulados — o laço terminava (`Eof`) muito antes de processar todos os itens do lote.

Confirmado em teste real com documento de 30 itens, via instrumentação temporária que logava
`RecNo`/`RecordCount`/`Bof`/`Eof` do dataset a cada iteração: o `RecNo` do primeiro item processado
(originalmente `1`) mudava sozinho para `28` durante a própria chamada de `pAlterarPrecoMargem`, antes
do `Dataset.Next` seguinte ser executado. Resultado prático: apenas 3 dos 30 itens do documento recebiam
o valor replicado (o primeiro item, mais os dois últimos da nova ordenação, alcançados pelos dois `Next`
restantes antes do `Eof`).

A correção substituiu o avanço por posição pela identificação de cada item pelo próprio código de
negócio (`ITE_CODITE`), capturando a lista completa de códigos **antes** de iniciar qualquer alteração,
e reposicionando o dataset a cada iteração via `Dataset.Locate('ITE_CODITE', ..., [])` — uma busca por
valor, imune a qualquer reordenação física que ocorra no dataset durante o processamento. Uma revisão
futura não deve substituir esse `Locate` por `Dataset.Next` "para simplificar" ou "por performance" sem
antes confirmar que a coluna/índice de ordenação ativo da grade de itens não pode mais ser recalculado a
partir dos campos que essa rotina replica — caso contrário, reintroduziria exatamente este bug.
