# Plano de Execução — Req. 461267

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Correção pontual de manutenção em código legado VCL, em três frentes independentes, todas dentro do mesmo par de units (`untPedidoCompra.pas` e `untConsultaItensGiro.pas`):

1. **Fix principal (causa raiz confirmada):** replicar, no ramo de exclusão de item único de `btnApagaClick`, o mesmo padrão de desagrupar (`cxvItensNVLGIR.GroupIndex := -1`) antes e reagrupar (`GroupIndex := 0` + `Groups.FullExpand`) depois da exclusão, já usado no ramo de exclusão múltipla. **Já implementado e validado (encoding) em 2026-09-14** — pendente apenas validação funcional pelo usuário.
2. **Fix correlato 1:** substituir a comparação por substring (`Pos(...) > 0`) por comparação exata (`sltItems.IndexOf`/`Find`) em `dbgConsultaDrawColumnCell` (`untConsultaItensGiro.pas`).
3. **Fix correlato 2 (defensivo):** garantir que `cdsItensPedido` esteja em `dsBrowse` antes do `DeleteFocused` em `pApagaItem`, com `Post`/`Cancel` condicional caso esteja em `dsEdit`/`dsInsert`.

Todas as edições são feitas via **script Python**, lendo e gravando os arquivos com `encoding='cp1252'` e `newline=''` (arquivos Delphi legados em Windows-1252), conforme regra do projeto para evitar corrupção de acentuação ao resalvar o arquivo inteiro.

Uma instrumentação temporária de log (`pLogReq461267`/`pLogReq461267Giro`) foi usada durante a investigação para confirmar/descartar hipóteses antes de codificar o fix definitivo — ela **não faz parte da correção** e deve ser removida antes do fechamento do requisito.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untPedidoCompra.pas` | `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untPedidoCompra.pas` | alterar (fix principal já aplicado; fix defensivo pendente; remoção de instrumentação pendente) |
| `untConsultaItensGiro.pas` | `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untConsultaItensGiro.pas` | alterar (fix correlato 1 pendente; remoção de instrumentação pendente) |

## 3. Sequência de implementação

### Etapa 1 — Fix principal (CONCLUÍDA em 2026-09-14)

1. ~~Em `btnApagaClick`, ramo `Else` (exclusão de item único), adicionar bloco de desagrupar antes / reagrupar depois de `pApagaItem`, com comentário curto + "Verificar Nota 1 - Req. 461267".~~ ✅ Aplicado em `untPedidoCompra.pas` (linhas ~11318-11346).
2. ~~Validar decodificação `cp1252` sem erro e ausência de `\xef\xbf\xbd` após a gravação.~~ ✅ Validado.
3. **Pendente:** validação funcional pelo usuário — reproduzir o cenário exato (grid agrupado por Giro, excluir item único, confirmar que só o item some e o grupo permanece).

### Etapa 2 — Fix correlato 1 (comparação exata na consulta por Giro)

1. Em `untConsultaItensGiro.pas`, `dbgConsultaDrawColumnCell`, substituir:
   ```pascal
   If Pos(cdsConsulta.FieldByName('ITE_CODITE').AsString, sltItems.CommaText) > 0 Then
   ```
   por uma busca exata, reaproveitando o padrão já usado em `pRetiraDaListaConsulta` (`sltItems.Find(QuotedStr(strCodIte), intIndice)`), já que `sltItems` é uma `TStringList` **Sorted** com itens armazenados como strings quotadas (`CommaText`).
2. Remover, no mesmo passo, a chamada de instrumentação `pLogReq461267Giro(...)` e o helper `pLogReq461267Giro`, e o `uses`/dependências que só existiam para o log (se houver).
3. Validar decodificação `cp1252` e ausência de `\xef\xbf\xbd`.

### Etapa 3 — Fix correlato 2 (estado defensivo do dataset)

1. Em `pApagaItem` (`untPedidoCompra.pas`), antes de `cxvItens.DataController.DeleteFocused`, adicionar:
   ```pascal
   If cdsItensPedido.State In [dsEdit, dsInsert] Then
     cdsItensPedido.Post;
   ```
   com comentário curto + "Verificar Nota 2 - Req. 461267" (nota a ser adicionada ao spec.md nesta etapa, documentando que a instrumentação não reproduziu o estado sujo no cenário testado, mas o ajuste é mantido por segurança/defesa em profundidade).
2. Remover, no mesmo passo, a chamada de instrumentação `pLogReq461267(...)` deste ponto específico.
3. Validar decodificação `cp1252` e ausência de `\xef\xbf\xbd`.

### Etapa 4 — Remoção completa da instrumentação temporária

1. Remover todas as chamadas remanescentes a `pLogReq461267`/`pLogReq461267Giro` em `untPedidoCompra.pas` (`fCompraItem`, `pRetiraDaListaConsulta`) e `untConsultaItensGiro.pas`.
2. Remover as procedures helper `pLogReq461267` e `pLogReq461267Giro` (declaradas após `{$R *.dfm}` em cada unit).
3. Validar, via `svn diff`, que as únicas alterações remanescentes nos arquivos são os três fixes definitivos (Etapas 1-3) — nenhum resquício de log/instrumentação.
4. Validar decodificação `cp1252` e ausência de `\xef\xbf\xbd` em ambos os arquivos, na versão final.

## 4. Conformidade com padrões do projeto

- Zona Legado: mantido o padrão existente de Hungarian style, estrutura de `TcxGridDBTableView`/`DataController`, sem introdução de interfaces ou refatoração de arquitetura.
- Comentário curto no fonte + "Nota N - Req. 461267" para as duas justificativas não óbvias (GroupIndex e estado do dataset), com explicação completa registrada em `spec.md` (seção "Notas Referenciadas no Código-Fonte").
- Edição de arquivos `cp1252`: **nunca usar a ferramenta `Edit`** nestes arquivos — toda alteração via Python com encoding explícito.
- Pre-commit: nenhuma das alterações introduz componente/chamada proibidos (não há `TButton`, `TDBGrid`, `StrToFloat`, `Now()`, `ActiveControl :=`, concatenação de parâmetro de usuário em SQL, `FOREIGN_KEY_CHECKS`, etc.).

## 5. Estratégia de testes

- **Suite:** não há suite DUnit cobrindo esta tela (`TfrmPedidoDeCompra`/`TfrmConsultaItensGiro`) — teste manual funcional.
- **Casos a cobrir:**
  1. Com o grid `cxvItens` **agrupado** por Nível de Giro: pesquisar um item de um grupo com múltiplos itens (ex.: Nível B), TAB, clicar "Excluir" no popup — apenas o item excluído deve sumir; os demais itens do grupo devem permanecer.
  2. Repetir o teste acima com o grid **desagrupado** (sem alteração de comportamento esperada — já funcionava corretamente).
  3. Após excluir um item único, pesquisar (TAB) outro item que ainda está no pedido — botão "Excluir" deve aparecer e o item deve ser marcado como "já no pedido" na consulta por Giro.
  4. Testar a comparação exata da coluna `TAB`: pesquisar um código que seja substring de outro código já no pedido (ex.: "025" vs "10025") e confirmar que o marcador aparece **somente** para o código realmente presente em `sltItems`.
  5. Repetir o cenário completo do chamado original: excluir produto 04025, pesquisar itens do Giro B, pesquisar 05609/05384/04888 — confirmar que nenhum desses sintomas se repete.
  6. Conferir, via `svn diff`, que a instrumentação temporária foi completamente removida antes do fechamento.

## 6. Riscos e mitigação

- **Risco:** o desagrupar/reagrupar no caminho de item único poderia, em teoria, gerar uma perda de posição de foco/scroll perceptível. → **Mitigação:** mesmo padrão já usado e validado no caminho de exclusão múltipla; sem relato de problema nesse caminho.
- **Risco:** a comparação exata em `dbgConsultaDrawColumnCell` poderia deixar de marcar algum item que "por acaso" funcionava com a busca por substring. → **Mitigação:** comportamento correto é comparação exata; qualquer caso que dependia do bug de substring era, por definição, um falso positivo/negativo indevido.
- **Risco:** esquecer de remover a instrumentação temporária antes do commit. → **Mitigação:** Etapa 4 dedicada exclusivamente a isso, com validação via `svn diff` antes do fechamento.
- **Risco:** corrupção de encoding ao salvar os arquivos `.pas` (cp1252). → **Mitigação:** edição exclusivamente via Python com encoding explícito `cp1252`, validação pós-gravação (decodificação sem erro, ausência de `\xef\xbf\xbd`) em cada etapa.
