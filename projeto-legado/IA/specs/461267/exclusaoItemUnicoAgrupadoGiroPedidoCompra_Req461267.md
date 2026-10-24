# Correção — Exclusão de item único apaga todo o grupo de "Nível de Giro" no Pedido de Compra (Req. 461267)

**Tela(s):** Principal > Movimentação de Itens > Pedido de Compra (Digitação de Pedido de Compra) — grid de itens
agrupado por Nível de Giro; popup "Complete as informações do item" (`frmPedidoCompraItem`); Consulta de Itens por
Giro (`frmConsultaItensGiro`)
**Units alteradas:** `untPedidoCompra.pas`, `untConsultaItensGiro.pas`
**Componente/Dataset:** `cxvItens` (`TcxGridDBTableView`), coluna de agrupamento `cxvItensNVLGIR`; `cdsItensPedido`
(`TUniClientDataSet`); `sltItems` (`TStringList` Sorted, compartilhada entre `TfrmPedidoDeCompra` e
`TfrmConsultaItensGiro`)
**Envolvidos:** Rodolfo (Diretor) — KUSMA
**Cliente/evidência do ticket:** KUSMA, fluxo de consulta por Giro
**Working copies alteradas:** `379.48.2.30.74.150.45` (original), `379.48.2.30.74.150.100`, `379.48.2.30.74.150`

## 1. Contexto do problema (requisito)

Requisito 461267, relatado pelo cliente KUSMA através de Rodolfo (Diretor): no módulo de Pedido de Compra, ao
pesquisar um produto, pressionar **TAB** (marca o item / abre o popup "Complete as informações do item",
`frmPedidoCompraItem`) e clicar em **"Excluir"** (exclusão de **um único item**, não a exclusão múltipla por
marcação), três sintomas foram relatados:

1. Ao excluir um produto (04025 no relato original do ticket), **todos os itens do grupo "Nível de Giro: B"**
   somem da tela/pesquisa — não apenas o item excluído.
2. Ao pesquisar (TAB) outro item em seguida, o botão **"Excluir"** deixa de aparecer dentro de
   `frmPedidoCompraItem`.
3. Produtos específicos (05609, 05384, 04888) deixam de ser marcados como "já incluídos no pedido" ao serem
   pesquisados novamente na consulta por Giro.

O cliente usa o fluxo de **consulta por Giro** (`TfrmConsultaItensGiro`/`untConsultaItensGiro.pas`), confirmado
explicitamente pelo usuário como o fluxo utilizado por este cliente — relevante porque a tela de consulta por
Giro tem seu próprio marcador de "item já no pedido" (coluna `TAB`), independente do `cdsItensPedido.Locate` usado
para exibir o botão "Excluir".

## 2. Causa raiz

### Reprodução confirmada (print do usuário, 2026-09-14)

Com o grid `cxvItens` agrupado pela coluna de Nível de Giro (`cxvItensNVLGIR`, grupos A/B/C visíveis no grid),
excluir o item **05949** (pertencente ao grupo B, que continha **20 itens**) removeu **os 20 itens do grupo B**
de `cdsItensPedido` — não apenas o item focado. Evidência quantitativa via instrumentação de log temporária:
`cdsItensPedido.RecordCount` caiu de **149 para 129** (diferença de 20 = tamanho exato do grupo B) após a
exclusão de um único item.

Em seguida, pesquisando o item **05609** (que também pertencia ao grupo B recém-apagado por completo), o botão
"Excluir" não aparecia mais em `frmPedidoCompraItem`. O próprio usuário identificou corretamente, antes mesmo da
confirmação técnica, que se tratava de **efeito colateral esperado**: o item de fato não estava mais em
`cdsItensPedido` (havia sido excluído junto com o restante do grupo), então `cdsItensPedido.Locate('ITE_CODITE',
...)` legitimamente não encontrava o registro. Testando um item de **outro** nível de Giro (não afetado pela
exclusão em massa), o botão "Excluir" aparecia normalmente — confirmando que a causa era a exclusão indevida em
massa, e não uma falha isolada na lógica do botão/Locate.

### Causa raiz técnica

Em `untPedidoCompra.pas`, `TfrmPedidoDeCompra.btnApagaClick`, existem dois caminhos de exclusão:

- **Exclusão múltipla** (`stlProdutosMarcados.Count > 0`): já tratava corretamente o agrupamento — desagrupa
  (`cxvItensNVLGIR.GroupIndex := -1`) **antes** de excluir os itens marcados em laço, e reagrupa
  (`GroupIndex := 0` + `cxvItens.DataController.Groups.FullExpand`) **depois**.
- **Exclusão de item único** (ramo `Else`, usado pelo fluxo TAB → Excluir dentro de `frmPedidoCompraItem`):
  chamava `pApagaItem` **diretamente**, sem nenhum tratamento de `GroupIndex`.

Com o grid agrupado, `cxvItens.DataController.DeleteFocused` (chamado dentro de `pApagaItem`) tem o
comportamento — da própria `TcxGridDBDataController` da DevExpress — de apagar **todos os registros do grupo
atualmente focado**, e não apenas o registro focado, quando `GroupIndex >= 0` no momento da chamada.

Ou seja: a proteção contra esse problema **já existia no código** (caminho de exclusão múltipla), mas nunca foi
replicada para o caminho de exclusão de item único — que é exatamente o fluxo padrão usado pela tela "Complete
as informações do item" (TAB → Excluir).

## 3. Investigação realizada

1. Mapeado o fluxo completo do sintoma relatado: `untPedidoCompra → btnTodIte → untConsultaCxGridNova (TAB) →
   fCompraItem → untPedidoCompraItem (botão Excluir)`.
2. Levantadas 3 hipóteses de causa raiz a partir do relato original: (a) estado do dataset `cdsItensPedido`
   durante a exclusão; (b) comparação por substring na marcação "já no pedido" da consulta por Giro; (c)
   `GroupIndex` do grid na exclusão de item único.
3. Como o ambiente do usuário não tinha o **DebugView** disponível para capturar `OutputDebugString`, foi
   implementada instrumentação temporária de **log em arquivo local** (`pLogReq461267`/`pLogReq461267Giro`),
   gravando em `<pasta do executável>\temp\logerr\req461267.log`, com criação automática da pasta se não
   existisse e identificação de versão do log (`V1.1`) para rastreabilidade.
4. Usuário reproduziu o cenário relatado e enviou o log: excluir o item 05949 (grupo B, 20 itens) reduziu
   `cdsItensPedido.RecordCount` de 149 para exatamente 129 — confirmando quantitativamente que **20 registros**
   (o grupo inteiro) foram apagados por uma única ação de exclusão de item.
5. Usuário enviou print da tela confirmando visualmente: grid agrupado por Nível de Giro, exclusão do item
   05949 removeu todo o grupo B; destacou explicitamente que **com o grid desagrupado (itens expandidos), o
   problema não ocorre** — pista decisiva que apontou diretamente para o mecanismo de agrupamento do
   `TcxGridDBTableView` como causa, descartando a hipótese inicial de limpeza em tempo de gravação
   (`pFiltraQuantidadeZero`, que só roda ao salvar o pedido — não houve gravação neste teste).
6. Lida a implementação de `btnApagaClick` e comparados os dois ramos (exclusão múltipla vs. exclusão única) —
   identificada a assimetria: o ramo múltiplo desagrupa/reagrupa ao redor do delete, o ramo único não.
7. Usuário reproduziu novamente com um segundo print (pesquisa do item 05609 após excluir 05949): confirmou que
   o botão "Excluir" não aparecia para 05609 (efeito colateral correto, pois o item já não existia mais em
   `cdsItensPedido`) e que um item de outro nível de Giro continuava mostrando o botão normalmente — validação
   cruzada de que a causa era a exclusão em massa, e o próprio usuário direcionou a aplicação do fix já
   identificado.
8. Durante a mesma investigação (instrumentação nos mesmos pontos), identificados e aprovados pelo usuário **dois
   defeitos correlatos adicionais**, cobertos pelo mesmo escopo de correção:
   - Comparação por substring (`Pos()`) em vez de exata (`Find`) no marcador "já no pedido" da consulta por
     Giro (`untConsultaItensGiro.pas`).
   - Ausência de garantia de estado limpo (`dsBrowse`) do `cdsItensPedido` antes do `DeleteFocused` em
     `pApagaItem` — ajuste defensivo, sem evidência de ter causado o bug relatado (ver Nota 3).
9. Gerados os artefatos de análise (`spec.md`, `plan.md`, `tasks.md`) em `IA\specs\461267\` (working copy
   `74.150.45`), seguindo o fluxo da skill `citel-IAArquitectDesenv`.
10. Aplicados os 3 fixes via Python (encoding `cp1252`, `newline=''`), validada a correção via nova rodada de
    log: três exclusões de item único consecutivas (05949, 05780, 07136), cada uma reduzindo `RecordCount` em
    exatamente 1 (149→148→147), com `State=1` (`dsBrowse`) capturado em cada delete.
11. Removida por completo a instrumentação temporária de ambas as units, validado via grep (zero ocorrências
    remanescentes) e revalidada a decodificação `cp1252`/ausência de `\xef\xbf\xbd`.
12. A pedido do usuário, os mesmos 3 fixes foram replicados nas working copies irmãs `379.48.2.30.74.150.100`
    e `379.48.2.30.74.150`, após confirmar que a estrutura de código (`btnApagaClick`, `pApagaItem`,
    `dbgConsultaDrawColumnCell`) era idêntica nas três cópias.

### Abordagens consideradas e descartadas

- **Hipótese inicial de limpeza em tempo de gravação** (`pFiltraQuantidadeZero`/`objItensExcluidos.fApagaExcluidos`,
  que filtra `cdsItensPedido` por `ITE_QTDITE > 0` durante a gravação do pedido): descartada porque o usuário
  confirmou explicitamente que **não houve gravação** entre a exclusão do item e a constatação do sumiço dos 20
  registros — o teste foi feito sem clicar em salvar/gravar o pedido.
- **`objTransfere.pExcluiItem` (`TPreparaTEPedidoCompra`) como causa do sumiço em massa**: descartada porque essa
  chamada opera sobre um dataset **separado** (`cdsItens: TZClient`, usado para itens de transferência
  entre-empresas), não sobre `cdsItensPedido` — não tem relação com o `RecordCount` de `cdsItensPedido`.

## 4. Correção aplicada

### Fix principal — `GroupIndex` no ramo de exclusão de item único (`untPedidoCompra.pas`)

No ramo `Else` de `btnApagaClick` (exclusão de item único), foi replicado o mesmo padrão de desagrupar antes /
reagrupar depois já usado no ramo de exclusão múltipla:

```pascal
      Else If (Not blnConDel) Or
              fPerguntaExclusaoColeta(cdsItensPedido.FieldByName('ITE_CODITE').AsString) Then
      Begin
        {Desagrupa antes de excluir item unico com o grid agrupado por Nivel de Giro,
         senao o DeleteFocused apaga todo o grupo em vez de so o item focado.
         Verificar Nota 1 - Req. 461267}
        blnAgrupado := False;
        If cxvItensNVLGIR.GroupIndex > -1 Then
        Begin
          blnAgrupado := True;
          cxvItensNVLGIR.GroupIndex := -1;
        End;

        cdsItensPedido.AfterScroll := Nil;

        pApagaItem;

        pFechaCompraItem;

        cdsItensPedido.AfterScroll := pAferScroll;
        pAferScroll(cdsItensPedido);
        pAtualizaGridRodape(False, strCodIteProcessadoRodape);

        If blnAgrupado Then
        Begin
          cxvItensNVLGIR.GroupIndex := 0;
          cxvItens.DataController.Groups.FullExpand;
        End;
      End;
```

A variável local `blnAgrupado` já existia na declaração de `btnApagaClick` (reaproveitada do ramo de exclusão
múltipla), evitando declarar uma segunda variável equivalente.

### Fix correlato 1 — comparação exata na consulta por Giro (`untConsultaItensGiro.pas`)

Em `TfrmConsultaItensGiro.dbgConsultaDrawColumnCell`, a verificação de "produto já no pedido" (usada para
desenhar o marcador na coluna `TAB`) trocou de comparação por substring para comparação exata:

```pascal
procedure TfrmConsultaItensGiro.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  Var
    intIndice: Integer;
begin
  inherited;
  If Column.Field.FieldName = 'TAB' Then
  Begin
    {Comparacao exata (nao substring) do codigo do item contra a lista de itens
     ja incluidos no pedido. Verificar Nota 2 - Req. 461267}
    If sltItems.Find(QuotedStr(cdsConsulta.FieldByName('ITE_CODITE').AsString), intIndice) Then
    Begin
      TDBGridCitel(Sender).Canvas.FillRect(Rect);
      imglImageList.Draw(TDBGridCitel(Sender).Canvas, Rect.Left + 1, Rect.Top + 1,1);
    End;
  End;
end;
```

Antes: `If Pos(cdsConsulta.FieldByName('ITE_CODITE').AsString, sltItems.CommaText) > 0 Then`.

A variável de índice foi nomeada `intIndice` (sem referência ao número do requisito no nome), mantendo o padrão
de nomenclatura do projeto — apenas o comentário carrega a referência cruzada à Nota 2.

### Fix correlato 2 — estado defensivo do dataset antes do delete (`untPedidoCompra.pas`)

Em `TfrmPedidoDeCompra.pApagaItem`, antes de `cxvItens.DataController.DeleteFocused`:

```pascal
    {Descarta edicao/insercao pendente antes do delete (Cancel, nao Post): a rotina
     esta excluindo o registro, entao nao faz sentido tentar gravar um estado sujo,
     que ainda pode falhar por validacao e abortar a exclusao. Verificar Nota 3 - Req. 461267}
    If cdsItensPedido.State In [dsEdit, dsInsert] Then
      cdsItensPedido.Cancel;

    cxvItens.DataController.DeleteFocused;
```

**Revisão de código (2026-09-14):** a versão inicial deste fix usava `cdsItensPedido.Post` em vez de `Cancel`.
Achado de revisão: `Post` é semanticamente o oposto do que uma rotina de exclusão deveria fazer — se o registro em
`dsInsert`/`dsEdit` tivesse campo obrigatório vazio ou regra de negócio em `OnBeforePost` que reprovasse o estado
atual, `Post` lançaria exceção antes de chegar ao `DeleteFocused`, abortando a exclusão e deixando o registro com
edição pendente na base — exatamente o cenário que a guarda deveria evitar. Corrigido para `Cancel`, que descarta
a edição pendente sem executar nenhuma validação.

### Fix de revisão — `Try/Finally` no ramo de exclusão de item único (`untPedidoCompra.pas`)

Também identificado em revisão de código (2026-09-14): o desagrupar (`GroupIndex := -1`) e a suspensão do
`AfterScroll` (`:= Nil`) do Fix principal não tinham proteção contra exceção — se `pApagaItem`/`pFechaCompraItem`
lançassem, o `Try/Except` externo de `btnApagaClick` só decrementa `intConfirma`, sem restaurar `AfterScroll` nem
reagrupar o grid, deixando-o permanentemente desagrupado até a próxima ação do usuário. Corrigido envolvendo as
duas chamadas em `Try/Finally`:

```pascal
        cdsItensPedido.AfterScroll := Nil;
        Try
          pApagaItem;

          pFechaCompraItem;
        Finally
          {Restaura AfterScroll e reagrupa mesmo se pApagaItem/pFechaCompraItem lancarem
           excecao, evitando grid permanentemente desagrupado. Verificar Nota 4 - Req. 461267}
          cdsItensPedido.AfterScroll := pAferScroll;
          If blnAgrupado Then
          Begin
            cxvItensNVLGIR.GroupIndex := 0;
            cxvItens.DataController.Groups.FullExpand;
          End;
        End;

        pAferScroll(cdsItensPedido);
        pAtualizaGridRodape(False, strCodIteProcessadoRodape);
```

`pAferScroll`/`pAtualizaGridRodape` permanecem fora do `Finally` (só rodam no caminho feliz), preservando o
comportamento original em caso de sucesso.

**Atualização (2026-09-14):** por decisão do usuário, os dois pontos abaixo — inicialmente registrados como
achados fora de escopo — foram tratados na mesma sessão.

### Fix de revisão 2 — `Try/Finally` também no ramo de exclusão múltipla (`untPedidoCompra.pas`)

O ramo de exclusão múltipla (`stlProdutosMarcados.Count > 0`) tinha exatamente o mesmo defeito do ramo único
antes do Fix de revisão: `GroupIndex := -1` e `AfterScroll := Nil` sem proteção contra exceção. Corrigido com
dois níveis de `Try/Finally` aninhados (a estrutura desse ramo é mais aninhada — `AfterScroll := Nil` só ocorre
dentro de `If fPerguntaExclusaoColetaMarcados`, enquanto `GroupIndex := -1` ocorre antes desse condicional):

```pascal
        Try
          If fPerguntaExclusaoColetaMarcados Then
          Begin

            cdsItensPedido.AfterScroll := Nil;
            Try
              For intContador := 0 To stlProdutosMarcados.Count - 1 Do
              If cdsItensPedido.Locate('ITE_CODITE', stlProdutosMarcados[intContador], []) Then
                pApagaItem;

              pFechaCompraItem;
            Finally
              {Restaura AfterScroll mesmo se pApagaItem/pFechaCompraItem lancarem
               excecao. Verificar Nota 4 - Req. 461267}
              cdsItensPedido.AfterScroll := pAferScroll;
            End;
            pAferScroll(cdsItensPedido);
            pAtualizaGridRodape(False, strCodIteProcessadoRodape);

          End;

          stlProdutosMarcados.Clear;
          cxvItens.DataController.Refresh;
        Finally
          {Reagrupa mesmo se a exclusao multipla lancar excecao, evitando grid
           permanentemente desagrupado. Verificar Nota 4 - Req. 461267}
          If blnAgrupado Then
          Begin
            cxvItensNVLGIR.GroupIndex := 0;
            cxvItens.DataController.Groups.FullExpand;
          End;
        End;

        If blnAgrupado Then
          cdsItensPedido.Locate('ITE_CODITE', strCodIte, []);
```

O reposicionamento do cursor (`Locate('ITE_CODITE', strCodIte, [])`) foi mantido fora do `Finally`, pois só faz
sentido após o regroup ter ocorrido com sucesso — mesmo comportamento do caminho feliz original. Com essa
mudança, os dois ramos de `btnApagaClick` ficam simétricos quanto à proteção contra exceção.

### Fix de revisão 3 — log de exceção no `Except` externo de `btnApagaClick` (`untPedidoCompra.pas`)

O `Except InterlockedDecrement(intConfirma); End;` que envolve todo o corpo de `btnApagaClick` engolia qualquer
exceção silenciosamente. Como esta correção adicionou novos caminhos de exceção possíveis dentro desse escopo
(`Cancel` em `pApagaItem`, troca de `GroupIndex`, `FullExpand`), falhas nessas operações específicas passariam a
ser invisíveis também. Corrigido reaproveitando o padrão já usado em mais de 30 outros pontos desta mesma unit:

```pascal
      InterlockedDecrement(intConfirma);
    Except
      {Registra a excecao (padrao pMensagensErro ja usado nesta unit) em vez de
       silenciar completamente a falha. Verificar Nota 5 - Req. 461267}
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmPedidoDeCompra.btnApagaClick]');
        InterlockedDecrement(intConfirma);
      End;
    End;
```

**Mudança de comportamento observável:** antes, uma falha durante a exclusão era completamente silenciosa; após
esta correção, o usuário passa a ver uma mensagem de erro (via `pErro`/`fMensagem`, conforme o tipo de erro
identificado por `pMensagensErro`) quando ocorrer uma exceção em `btnApagaClick`. Avaliado como desejável e
consistente com o padrão já usado no restante da unit.

Ambos os fixes de revisão foram aplicados e validados (cp1252, sem `\xef\xbf\xbd`) nas 3 working copies
(`74.150.45`, `74.150.100`, `74.150`).

### Fix de revisão 4 — `GroupIndex` também dentro do `Try` (ambos os ramos)

Identificado que `blnAgrupado := True; cxvItensNVLGIR.GroupIndex := -1;` continuava **fora** do `Try/Finally`
introduzido pelos fixes de revisão 1/2, em ambos os ramos. Se a própria atribuição de `GroupIndex` lançasse
exceção, a execução nunca chegaria a entrar no `Try`, e o `Finally` (que reagruparia) jamais seria instalado.
Corrigido movendo a detecção/desagrupamento para dentro do `Try`, garantindo que `blnAgrupado` já esteja `True`
antes de qualquer ponto de falha possível, de modo que o `Finally` sempre tente reagrupar.

### Fix de revisão 5 — `pAferScroll`/`pAtualizaGridRodape` também dentro do `Finally` (ambos os ramos)

Identificado que `pAferScroll(cdsItensPedido)` e `pAtualizaGridRodape(...)` ficavam fora do `Try/Finally`, então
uma exceção em `pFechaCompraItem` os pulava, deixando rodapé/dados do item desatualizados na tela até o próximo
scroll manual. Corrigido movendo as duas chamadas para dentro do `Finally`, **preservando a ordem original do
caminho feliz** (restaura `AfterScroll` → reagrupa → `pAferScroll` → `pAtualizaGridRodape`).

### Fix de revisão 6 — ordem `InterlockedDecrement`/`pMensagensErro` no `Except`

A primeira versão do Fix de revisão 3 chamava `pMensagensErro` **antes** de `InterlockedDecrement(intConfirma)`.
Identificado que isso é incorreto: `pMensagensErro` pode ela mesma lançar exceção (incondicionalmente se
`VS_TentativaFaturamentoAutomatico = True`; potencialmente em outros casos, pois seu corpo só tem `Try/Finally`,
não `Try/Except`). Se lançasse, `InterlockedDecrement` nunca executaria e `intConfirma` ficaria travado acima de
zero — desabilitando permanentemente o botão "Excluir" até o form ser recriado. Corrigido invertendo a ordem
(decrement primeiro), o mesmo padrão já usado em `TfrmPedidoDeCompra.btnConfirmaClick` na mesma unit.

### Incidente de corrupção durante a correção e recuperação

Ao aplicar o Fix de revisão 5, a ferramenta `Edit` foi usada **por engano** diretamente em `untPedidoCompra.pas`
(cópia `74.150.45`) — violação da regra do projeto de nunca usar `Edit` em arquivos `.pas`/`.dfm` (`cp1252`), já
que ela resalva o arquivo inteiro e pode corromper acentuação em qualquer parte do arquivo, mesmo sem relação
com o texto editado. Isso corrompeu silenciosamente um acento não relacionado (`Carência` → bytes
`\xef\xbf\xbd`) em uma região do código totalmente distante de qualquer alteração deste requisito.

Detectado pela validação padrão pós-edição (checagem de `\xef\xbf\xbd`). Recuperado assim:

1. `svn cat -r BASE padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untPedidoCompra.pas` — revisão
   limpa (494469), anterior a toda a investigação do Req. 461267.
2. Extraídas as procedures `pApagaItem` e `btnApagaClick`, já corretas, da cópia irmã `74.150.100` (nunca
   tocada pela ferramenta `Edit` nesta sessão — só por Python).
3. Reconstruído `untPedidoCompra.pas` (74.150.45) a partir do BASE, substituindo essas duas procedures pelas
   versões corretas, e reaplicado por cima o Fix de revisão 6 (ordem do decrement) via Python.
4. Validado via `svn diff` que **apenas 3 regiões** aparecem como alteradas em relação ao BASE (Nota 3 em
   `pApagaItem`; ramo múltiplo; ramo único + `Except`) — nenhum resquício da corrupção.
5. Confirmado que as 3 working copies (`74.150.45`, `74.150.100`, `74.150`) têm `pApagaItem`/`btnApagaClick`
   **byte-a-byte idênticos** após a recuperação, todas limpas.

**Lição para o futuro:** mesmo dentro de uma sessão de correções incrementais rápidas, cada edição em arquivo
`.pas`/`.dfm` deve continuar passando exclusivamente por script Python com `encoding='cp1252'` — nunca pela
ferramenta de edição de texto genérica, nem mesmo para uma troca pontual de 2-3 linhas.

### Método de edição

Ambos os arquivos usam encoding legado `cp1252` (Windows-1252), conforme `.editorconfig` do projeto. Toda edição
foi feita via **Python**, lendo e gravando com `encoding='cp1252', newline=''` explícito — nunca com a ferramenta
de edição direta de texto — para não corromper acentuação do restante do arquivo.

Validação pós-edição em cada arquivo, em cada uma das 3 working copies:
- Decodifica sem erro em `cp1252`.
- Não contém a sequência de bytes `\xef\xbf\xbd` (indício de corrupção UTF-8 gravada por engano dentro de um
  arquivo cp1252).

### Working copies alteradas

| Fix | `untPedidoCompra.pas` | `untConsultaItensGiro.pas` |
|---|---|---|
| Fix principal (GroupIndex) | `379.48.2.30.74.150.45`, `.100`, `.150` | — |
| Fix correlato 1 (Pos → Find) | — | `379.48.2.30.74.150.45`, `.100`, `.150` |
| Fix correlato 2 (estado dataset) | `379.48.2.30.74.150.45`, `.100`, `.150` | — |

Confirmada previamente, antes de aplicar nas cópias irmãs `.100` e `.150`, a identidade estrutural do código
(`btnApagaClick`, `pApagaItem`, `dbgConsultaDrawColumnCell`) entre as 3 cópias — mesmo texto, mesma indentação,
apenas pequena variação de número de linha.

## 5. Escopo e decisões

- **Escopo ampliado deliberadamente**, com aprovação do usuário: o ticket relatava um problema único
  (sumiço de itens ao excluir), mas a investigação identificou 2 defeitos correlatos (substring na consulta por
  Giro; falta de guarda de estado do dataset), incorporados ao mesmo requisito por decisão do usuário.
- **Fix correlato 2 é preventivo, não corretivo do bug relatado**: a instrumentação de log nunca capturou o
  dataset fora de `dsBrowse` no momento do delete durante os testes reais — a causa raiz do ticket é
  exclusivamente o Fix principal (`GroupIndex`). O Fix correlato 2 foi mantido no escopo por decisão explícita
  do usuário, como defesa em profundidade (ver Nota 3).
- **Aplicação retroativa em 2 working copies irmãs**, a pedido do usuário: `379.48.2.30.74.150.100` e
  `379.48.2.30.74.150`, após a validação funcional na cópia original `74.150.45`.
- **Não alterado** o caminho de exclusão múltipla (`stlProdutosMarcados.Count > 0`) — já estava correto e serviu
  de referência/padrão para o Fix principal.
- **Fora de escopo:** qualquer refatoração do mecanismo de agrupamento/exclusão do `TcxGridDBTableView` além do
  necessário para corrigir a assimetria identificada; migração de `sltItems` para outro mecanismo de
  armazenamento (mantido `TStringList` Sorted, apenas corrigida a comparação).

## 6. Ressalvas e achados colaterais

- **Instrumentação de diagnóstico**: como o ambiente do usuário não tinha o DebugView disponível, foi usado um
  logger de arquivo local (`pLogReq461267`/`pLogReq461267Giro`, versão `V1.1`, gravando em `<pasta do
  exe>\temp\logerr\req461267.log` com criação automática de pasta) em vez do padrão usual de `OutputDebugString`
  + Event Log do Delphi. Essa instrumentação foi **totalmente removida** ao final da sessão — não deve restar
  nenhuma referência a `pLogReq461267`/`pLogReq461267Giro`/`blnLocOk461267` no código-fonte final.
- **Risco de recorrência (Nota 1)**: se o desagrupar/reagrupar do Fix principal for removido futuramente por
  parecer "redundante" (efeito só visível com o grid agrupado), o bug volta a se manifestar — esse é justamente
  o modo de operação padrão do cliente KUSMA.
- **Validação funcional pendente**: os fixes correlatos 1 e 2 foram aplicados e validados quanto a
  encoding/ausência de corrupção, mas ainda **não têm teste manual funcional dedicado** pelo usuário (ex.:
  confirmar que um código de produto substring de outro não gera falso positivo na consulta por Giro). O
  cenário completo original do chamado (produto 04025, itens de Giro B, produtos 05609/05384/04888) também
  ainda não foi repetido de ponta a ponta como validação final.
- **`TRelGeraOR`-like risco não aplicável aqui**: diferente de outros requisitos desta base que reaproveitam
  motores compartilhados entre várias telas, `dbgConsultaDrawColumnCell` e `btnApagaClick` são específicos das
  telas de Pedido de Compra/Consulta por Giro — sem exposição a outros fluxos do sistema.
- **Achados de revisão de código (2026-09-14) corrigidos**: `Post` trocado por `Cancel` na guarda defensiva de
  `pApagaItem` (Nota 3 revisada); adicionado `Try/Finally` no ramo de exclusão de item único para restaurar
  `AfterScroll`/`GroupIndex` em caso de exceção (Nota 4, nova). Ambos aplicados nas 3 working copies.
- **Achados de revisão de código (2026-09-14) — tratados na mesma sessão, por decisão do usuário** (ver Fix de
  revisão 2 e Fix de revisão 3 na seção 4): o ramo de exclusão múltipla recebeu o mesmo `Try/Finally` do ramo
  único, e o `Except` externo de `btnApagaClick` passou a registrar a exceção via `pMensagensErro` em vez de
  silenciá-la. Ambos eram comportamento pré-existente (não introduzidos por este requisito), mas o escopo foi
  ampliado deliberadamente para incluí-los, já que a correção original já mexia no mesmo bloco de código.

## 7. Notas Referenciadas no Código-Fonte

### Nota 1

**Local:** `untPedidoCompra.pas`, `TfrmPedidoDeCompra.btnApagaClick`, ramo de exclusão de item único (comentário:
"Verificar Nota 1 - Req. 461267").

**Explicação completa:** o `TcxGridDBTableView` (`cxvItens`) pode estar agrupado pela coluna de Nível de Giro
(`cxvItensNVLGIR.GroupIndex >= 0`). Quando agrupado, chamar `cxvItens.DataController.DeleteFocused`
(indiretamente, via `pApagaItem`) sobre um único registro focado resulta, na prática, na exclusão de **todos os
registros do grupo atualmente focado/selecionado**, não apenas do registro focado — comportamento do
`TcxGridDBDataController` da DevExpress quando o agrupamento está ativo no momento da chamada de exclusão.

O caminho de exclusão múltipla desta mesma função (`btnApagaClick`, ramo `stlProdutosMarcados.Count > 0`) já
continha a proteção correta para esse cenário: desagrupar (`cxvItensNVLGIR.GroupIndex := -1`) antes do laço de
exclusão, e reagrupar (`GroupIndex := 0` + `cxvItens.DataController.Groups.FullExpand`) depois. Essa proteção
nunca foi replicada para o ramo de exclusão de item único (usado pelo fluxo padrão de pesquisa: TAB → botão
"Excluir" dentro de `frmPedidoCompraItem`), o que permitiu que uma exclusão aparentemente trivial de um único
produto apagasse, por efeito colateral, todo o grupo de Giro ao qual ele pertencia.

Se esse desagrupar/reagrupar for removido futuramente por parecer "redundante" ou "só uma chamada a mais sem
efeito visível em teste com grid não agrupado", o bug volta a se manifestar sempre que o usuário estiver com o
grid agrupado por Giro — que é o modo de operação padrão do cliente KUSMA (e potencialmente de outros clientes
que usam a consulta por Giro). Por isso a chamada deve ser mantida mesmo que pareça não fazer diferença em
testes com o grid desagrupado.

### Nota 2

**Local:** `untConsultaItensGiro.pas`, `TfrmConsultaItensGiro.dbgConsultaDrawColumnCell` (comentário: "Verificar
Nota 2 - Req. 461267").

**Explicação completa:** o marcador visual "já incluído no pedido" (coluna `TAB` da grid de consulta por Giro)
originalmente usava `Pos(codigo, sltItems.CommaText) > 0` para verificar se o código do produto em exibição
estava na lista `sltItems` (uma `TStringList` **Sorted**, cujos itens são armazenados como `QuotedStr(codigo)`,
ex.: `'04025'`). `Pos()` faz busca de **substring dentro do texto inteiro** retornado por `sltItems.CommaText`
(todos os códigos concatenados por vírgula), e não uma busca de item exato na lista.

Isso é estruturalmente frágil: um código de produto que seja substring de outro código presente na lista (ex.:
"025" aparecendo dentro de "10025", ou qualquer padrão de dígitos coincidente entre dois códigos vizinhos na
string concatenada) pode gerar falso positivo — o produto é marcado como "já no pedido" mesmo sem estar lá. Da
mesma forma, colisões improváveis mas possíveis podem mascarar itens realmente presentes.

A correção usa `sltItems.Find(QuotedStr(codigo), intIndice)`, que faz busca binária exata (a lista é `Sorted`)
pelo item literal `'codigo'` — o mesmo padrão de comparação já usado corretamente em `pRetiraDaListaConsulta`
(`untPedidoCompra.pas`), garantindo consistência entre os dois pontos do código que consultam `sltItems`. A
variável de índice foi nomeada apenas `intIndice` (sem sufixo do número do requisito), por não haver necessidade
de diferenciá-la de nenhuma outra no escopo da função.

Se esta comparação for revertida para `Pos()` no futuro (por exemplo, ao copiar o padrão de outro trecho de
código legado que ainda usa substring), o defeito de falso positivo/negativo no marcador "já no pedido" volta a
existir, de forma silenciosa e difícil de perceber em teste manual casual (só aparece com combinações
específicas de códigos).

### Nota 3

**Local:** `untPedidoCompra.pas`, `TfrmPedidoDeCompra.pApagaItem` (comentário: "Verificar Nota 3 - Req.
461267").

**Explicação completa:** antes de chamar `cxvItens.DataController.DeleteFocused`, foi adicionada uma guarda
defensiva: `If cdsItensPedido.State In [dsEdit, dsInsert] Then cdsItensPedido.Post;`. O fluxo de cancelamento de
item em edição (`btnCancelaItemClick`/`pLimpaDadosItem`) nunca chama `cdsItensPedido.Cancel`/`.Post`
explicitamente — ele apenas limpa os campos de UI (`Edit`/`Clear` dos componentes visuais), deixando uma janela
teórica em que `cdsItensPedido` poderia permanecer em `dsEdit`/`dsInsert` no momento em que o usuário aciona a
exclusão de um item.

Chamar `DeleteFocused`/`Delete` sobre um dataset em `dsEdit`/`dsInsert` tem semântica ambígua dependendo do
driver/provider (pode descartar a edição pendente de forma implícita, gerar exceção, ou em casos raros
corromper o registro focado) — por isso a garantia de estado limpo antes do delete é uma prática defensiva
padrão ao lidar com `TDataSet`/`TUniClientDataSet`.

**Importante:** a instrumentação de log rodada em 2026-09-14, em múltiplas exclusões de item único reproduzindo
o cenário do chamado, sempre capturou `State=1` (`dsBrowse`, estado limpo) no momento do delete — ou seja,
**este ajuste não foi o causador do bug relatado** (a causa raiz real foi a Nota 1, `GroupIndex`). Este ajuste é
mantido como camada de segurança adicional (defesa em profundidade), aprovada explicitamente pelo usuário como
parte do escopo de correção, e não deve ser removido por parecer "código morto" ou "nunca executa" — ele existe
para cobrir um cenário que a investigação não conseguiu reproduzir, mas que continua teoricamente possível dado
que `pLimpaDadosItem` nunca sincroniza o estado do dataset.

## 8. Texto de análise de requisito (registro formal — baixa)

```text
NO MÓDULO DE PEDIDO DE COMPRA, AO EXCLUIR UM ÚNICO PRODUTO PELA TELA "COMPLETE AS INFORMAÇÕES DO ITEM" (TAB +
BOTÃO "EXCLUIR"), COM O GRID DE ITENS AGRUPADO POR NÍVEL DE GIRO, O SISTEMA ESTAVA REMOVENDO TODOS OS ITENS DO
GRUPO INTEIRO EM VEZ DE APENAS O ITEM SELECIONADO. COMO EFEITO COLATERAL, ITENS DO MESMO GRUPO PESQUISADOS EM
SEGUIDA DEIXAVAM DE APRESENTAR O BOTÃO "EXCLUIR" (POR NÃO ESTAREM MAIS NO PEDIDO) E DEIXAVAM DE SER MARCADOS
COMO "JÁ INCLUÍDOS" NA CONSULTA DE ITENS POR GIRO.

FOI CORRIGIDO O MECANISMO DE EXCLUSÃO DE ITEM ÚNICO PARA DESAGRUPAR TEMPORARIAMENTE O GRID ANTES DE REMOVER O
REGISTRO E REAGRUPÁ-LO LOGO EM SEGUIDA, REPLICANDO A MESMA PROTEÇÃO JÁ EXISTENTE NA EXCLUSÃO MÚLTIPLA DE ITENS
(POR MARCAÇÃO), QUE NUNCA HAVIA SIDO APLICADA AO FLUXO PADRÃO DE EXCLUSÃO DE UM ÚNICO ITEM.

TAMBÉM FOI CORRIGIDA A VERIFICAÇÃO DE "PRODUTO JÁ INCLUÍDO NO PEDIDO" NA TELA DE CONSULTA DE ITENS POR GIRO,
QUE ANTES COMPARAVA O CÓDIGO DO PRODUTO POR TRECHO DE TEXTO (SUBSTRING) DENTRO DA LISTA DE CÓDIGOS JÁ
INCLUÍDOS, PODENDO GERAR MARCAÇÃO INCORRETA QUANDO UM CÓDIGO DE PRODUTO É PARTE DO TEXTO DE OUTRO CÓDIGO. A
COMPARAÇÃO PASSOU A SER FEITA POR IGUALDADE EXATA DE CÓDIGO.

POR FIM, FOI ADICIONADA UMA GARANTIA DEFENSIVA PARA QUE O REGISTRO DO ITEM ESTEJA SEMPRE EM ESTADO CONSISTENTE
(SEM EDIÇÃO PENDENTE) NO MOMENTO DA EXCLUSÃO, PREVENINDO UM CENÁRIO TEÓRICO DE INCONSISTÊNCIA AINDA NÃO
OBSERVADO EM TESTES, MAS TECNICAMENTE POSSÍVEL DEVIDO AO FLUXO DE CANCELAMENTO DE ITEM NÃO LIMPAR EXPLICITAMENTE
O ESTADO DO REGISTRO EM EDIÇÃO.

EM REVISÃO DE CÓDIGO POSTERIOR, FORAM IDENTIFICADOS E CORRIGIDOS MAIS TRÊS PONTOS DE ROBUSTEZ NA MESMA ROTINA DE
EXCLUSÃO: (1) A GARANTIA DEFENSIVA CITADA ACIMA FOI AJUSTADA PARA DESCARTAR A EDIÇÃO PENDENTE EM VEZ DE TENTAR
GRAVÁ-LA, EVITANDO QUE UMA FALHA DE VALIDAÇÃO INTERROMPESSE A PRÓPRIA EXCLUSÃO; (2) FOI GARANTIDO QUE O
AGRUPAMENTO DA TELA SEJA SEMPRE RESTAURADO, MESMO SE OCORRER ALGUMA FALHA DURANTE A EXCLUSÃO DE UM ITEM ÚNICO OU
DE VÁRIOS ITENS SELECIONADOS; E (3) O SISTEMA PASSA A EXIBIR UMA MENSAGEM DE ERRO AO USUÁRIO CASO OCORRA ALGUMA
FALHA DURANTE O PROCESSO DE EXCLUSÃO, EM VEZ DE FALHAR SILENCIOSAMENTE.

COM AS ALTERAÇÕES, A EXCLUSÃO DE UM ÚNICO ITEM NO PEDIDO DE COMPRA PASSA A REMOVER APENAS O ITEM SELECIONADO,
INDEPENDENTEMENTE DO GRID ESTAR AGRUPADO OU NÃO POR NÍVEL DE GIRO, O MARCADOR DE "ITEM JÁ NO PEDIDO" NA CONSULTA
POR GIRO PASSA A REFLETIR CORRETAMENTE O CONTEÚDO REAL DO PEDIDO, E O PROCESSO DE EXCLUSÃO (ÚNICA OU MÚLTIPLA)
FICA MAIS RESILIENTE A FALHAS INESPERADAS, SEMPRE INFORMANDO O USUÁRIO E MANTENDO A TELA EM ESTADO CONSISTENTE.

NOTAS NO FONTE:
  NOTA 1 - O TcxGridDBTableView (cxvItens) pode estar agrupado pela coluna de Nível de Giro
  (cxvItensNVLGIR.GroupIndex >= 0). Com o grid agrupado, DeleteFocused (chamado dentro de pApagaItem) apaga
  todos os registros do grupo focado, não apenas o registro focado — comportamento do TcxGridDBDataController
  da DevExpress quando há agrupamento ativo. O ramo de exclusão múltipla de btnApagaClick já desagrupava antes
  e reagrupava depois do laço de exclusão; essa proteção nunca havia sido replicada no ramo de exclusão de
  item único (fluxo TAB + botão Excluir), causando a perda de todo o grupo ao excluir um único item. Corrigido
  aplicando o mesmo padrão desagrupar/reagrupar nesse ramo. Se removido futuramente por parecer redundante em
  teste com grid desagrupado, o bug volta a ocorrer sempre que o grid estiver agrupado por Giro — modo padrão
  de operação do cliente KUSMA.

  NOTA 2 - A verificação de "produto já no pedido" na consulta por Giro (dbgConsultaDrawColumnCell) usava
  Pos(codigo, sltItems.CommaText) > 0, uma busca por substring dentro do texto de todos os códigos concatenados
  por vírgula, em vez de busca exata na lista. Isso permite falso positivo quando um código é substring de
  outro código presente na lista. Corrigido para sltItems.Find(QuotedStr(codigo), intIndice), busca binária
  exata (lista é Sorted) — mesmo padrão já usado em pRetiraDaListaConsulta. Se revertido para Pos() no futuro,
  o defeito de marcação incorreta volta a existir de forma silenciosa.

  NOTA 3 - Adicionada guarda defensiva (State In [dsEdit, dsInsert]) antes de DeleteFocused em pApagaItem, pois o
  fluxo de cancelamento de item (btnCancelaItemClick/pLimpaDadosItem) nunca chama cdsItensPedido.Cancel/Post
  explicitamente, deixando uma janela teórica para o dataset estar em edição pendente no momento do delete.
  Versão inicial usava Post; revisão de código apontou que Post e semanticamente o oposto do que uma exclusao
  deveria fazer (podia falhar por validacao/OnBeforePost e abortar a propria exclusao), corrigido para Cancel
  (descarta sem validar). Instrumentacao de log em multiplos testes reais sempre capturou State=1 (dsBrowse) no
  momento do delete — este ajuste NAO foi o causador do bug relatado (causa raiz real e a Nota 1). Mantido como
  defesa em profundidade, aprovado explicitamente pelo usuario, e nao deve ser removido por parecer codigo
  morto/nunca executado.

  NOTA 4 - GroupIndex := -1 e AfterScroll := Nil (ramos unico e multiplo de btnApagaClick) nao tinham protecao
  contra excecao: se pApagaItem/pFechaCompraItem lancassem, o Except externo so decrementava intConfirma, sem
  restaurar AfterScroll nem reagrupar o grid. Corrigido com Try/Finally em ambos os ramos (o ramo multiplo exige
  dois niveis aninhados). Revisao adicional moveu a propria atribuicao de GroupIndex para dentro do Try (se ela
  mesma lancar, blnAgrupado ja esta True e o Finally tenta reagrupar) e moveu pAferScroll/pAtualizaGridRodape
  para dentro do Finally (evitando tela/rodape desatualizados em caso de excecao), preservando a ordem original
  do caminho feliz. Aplicado nos dois ramos por decisao do usuario.

  NOTA 5 - O Except generico de btnApagaClick engolia qualquer excecao sem log. Corrigido chamando
  pMensagensErro(E.Message, '[...]'), reaproveitando padrao ja usado em 30+ pontos da unit. Revisao adicional
  corrigiu a ORDEM: InterlockedDecrement(intConfirma) deve vir ANTES de pMensagensErro, nao depois - pMensagensErro
  pode ela mesma lancar (VS_TentativaFaturamentoAutomatico re-lanca; demais caminhos so tem Try/Finally), e se o
  decrement viesse depois, intConfirma ficaria travado, desabilitando o botao Apagar permanentemente. Mesmo
  padrao (decrement antes) ja usado em btnConfirmaClick na mesma unit.

  INCIDENTE - durante os ajustes acima, a ferramenta Edit foi usada por engano em untPedidoCompra.pas (74.150.45),
  corrompendo um acento nao relacionado em outra parte do arquivo (violacao da regra de so editar .pas via
  Python/cp1252). Recuperado via svn cat -r BASE + reconstrucao das procedures a partir da copia 74.150.100
  (nunca tocada pelo Edit). Validado via svn diff que so as 3 regioes pretendidas mudaram; as 3 copias ficaram
  byte-a-byte identicas.

CONTEXTO TÉCNICO (IA):
- Causa raiz confirmada por reprodução direta (print do usuário, 2026-09-14) e por instrumentação de log
  temporária (arquivo local, pois o ambiente não tinha DebugView disponível): excluir 1 item do grupo B (20
  itens) via TAB + Excluir, com grid agrupado por cxvItensNVLGIR, derrubou cdsItensPedido.RecordCount de 149
  para 129 (diferença de 20 = tamanho do grupo).
- Arquivo/função: padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untPedidoCompra.pas,
  TfrmPedidoDeCompra.btnApagaClick, ramo Else (exclusão de item único, fPerguntaExclusaoColeta). Variável
  blnAgrupado já existia na declaração da função (reaproveitada do ramo de exclusão múltipla, que já tratava o
  agrupamento corretamente) — não foi declarada nova variável.
- Mecanismo aplicado (Fix principal): cxvItensNVLGIR.GroupIndex := -1 antes de pApagaItem (dentro do bloco
  AfterScroll := Nil ... pFechaCompraItem ... AfterScroll := pAferScroll já existente), e GroupIndex := 0 +
  cxvItens.DataController.Groups.FullExpand depois — mesmo padrão já usado no ramo
  stlProdutosMarcados.Count > 0 da mesma função, poucas linhas acima.
- Descartada a hipótese inicial de que a causa era pFiltraQuantidadeZero/objItensExcluidos.fApagaExcluidos
  (untPedidoCompra.pas), que só roda durante a gravação do pedido — usuário confirmou que não houve gravação
  entre a exclusão e a observação do sumiço dos 20 registros.
- Descartada também objTransfere.pExcluiItem (TPreparaTEPedidoCompra) como causa — opera sobre cdsItens
  (TZClient, itens de transferência entre empresas), dataset diferente de cdsItensPedido, sem relação com o
  RecordCount observado.
- Fix correlato 1: padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untConsultaItensGiro.pas,
  TfrmConsultaItensGiro.dbgConsultaDrawColumnCell. Trocado Pos(cdsConsulta.FieldByName('ITE_CODITE').AsString,
  sltItems.CommaText) > 0 por sltItems.Find(QuotedStr(cdsConsulta.FieldByName('ITE_CODITE').AsString),
  intIndice). sltItems é TStringList Sorted compartilhada com TfrmPedidoDeCompra, itens armazenados como
  QuotedStr(codigo); Find faz busca binária exata. Variável local nomeada intIndice (sem sufixo de requisito no
  nome, por solicitação explícita do usuário durante revisão).
- Fix correlato 2: mesma unit untPedidoCompra.pas, TfrmPedidoDeCompra.pApagaItem, imediatamente antes de
  cxvItens.DataController.DeleteFocused. Guarda: If cdsItensPedido.State In [dsEdit, dsInsert] Then
  cdsItensPedido.Post. Puramente defensivo — instrumentação de log em produção não capturou esse estado sujo em
  nenhum dos testes realizados; mantido por decisão explícita do usuário como parte do escopo aprovado.
- Instrumentação temporária usada durante a investigação (não permanece no código final): procedures
  pLogReq461267/pLogReq461267Giro, gravando em <ExtractFilePath(Application.ExeName)>temp\logerr\req461267.log
  via AssignFile/Append/Rewrite/WriteLn/CloseFile em Try/Except silencioso, timestamp via fNow() (nunca Now()
  puro, por regra do projeto), tag de versão LOG_VERSION_461267 = 'V1.1'. Também usada variável temporária
  blnLocOk461267 em fCompraItem para logar o resultado do Locate. Toda essa instrumentação foi completamente
  removida ao final da sessão (validado via grep — zero ocorrências remanescentes em ambas as units).
- Edição via Python com encoding='cp1252', newline='' explícito em todos os arquivos — nunca via ferramenta de
  edição direta de texto, para não corromper acentuação do restante do arquivo. Validação pós-edição em cada
  arquivo: decodifica sem erro em cp1252; sem sequência de bytes \xef\xbf\xbd.
- Os 3 fixes foram replicados, a pedido do usuário, nas working copies irmãs 379.48.2.30.74.150.100 e
  379.48.2.30.74.150, após confirmar (via leitura/grep) que a estrutura de código de btnApagaClick, pApagaItem
  e dbgConsultaDrawColumnCell era idêntica (mesmo texto/indentação, pequena variação de número de linha) nas
  3 cópias.
- Artefatos de análise (spec.md/plan.md/tasks.md) gerados em IA\specs\461267\ (cópia 74.150.45), seguindo o
  fluxo da skill citel-IAArquitectDesenv — não incluem fase de revisão/commit (/review + gate DelphAI) como
  ação automática; por preferência salva do usuário, essas etapas só são executadas mediante pedido explícito
  no momento, mesmo que listadas como fase pendente no checklist.
- Pendências de validação funcional (ainda não testadas manualmente pelo usuário, apenas via encoding/diff):
  Fix correlato 1 (ausência de falso positivo com códigos substring) e Fix correlato 2 (sem cenário de teste
  direto, pois nunca foi observado o estado sujo). Repetição do cenário completo original do chamado (produto
  04025, itens de Giro B, produtos 05609/05384/04888) também pendente como validação final de ponta a ponta.
- Fixes de revisão adicionais (Notas 4 e 5): não têm cenário de reprodução real (exigiriam forçar uma exceção
  dentro de pApagaItem/pFechaCompraItem), validados apenas por leitura de código e encoding — sem teste manual
  dedicado.
```

## Referências

- Requisito: 461267
- Artefatos de análise (specs/plans/tasks aprovados antes da implementação):
  `379.48.2.30.74.150.45\IA\specs\461267\spec.md`, `plan.md`, `tasks.md`
- Componente/coluna de agrupamento: `cxvItens` (`TcxGridDBTableView`) / `cxvItensNVLGIR`
- Dataset/lista: `cdsItensPedido` (`TUniClientDataSet`), `sltItems` (`TStringList` Sorted)
- Units alteradas: `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untPedidoCompra.pas`,
  `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untConsultaItensGiro.pas`
- Working copies alteradas: `379.48.2.30.74.150.45`, `379.48.2.30.74.150.100`, `379.48.2.30.74.150`
