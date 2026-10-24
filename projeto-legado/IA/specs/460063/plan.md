# Plano de Execução — Req. 460063

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Três ajustes aplicados juntos, sem alterar a lógica de cálculo de preço/margem em si:

1. **Busca de itens marcados O(1)/O(log n)** — tornar `objPreLotes.stlListSelecao` (`TStringList`) ordenada (`Sorted := True`, `Duplicates := dupIgnore`), de forma que `IndexOf` passe a usar busca binária em vez de busca linear.
2. **Acesso direto aos itens marcados** — reescrever `pAtualizarValorDoPrecoDeVendaDosItensSelecionados` para iterar sobre `stlListSelecao` (só os itens marcados, tipicamente um subconjunto pequeno) e posicionar o dataset diretamente via `Locate` em vez de percorrer `First..Eof` todo o grid checando `IndexOf` linha a linha. A extração do `AUTOINCREM` de dentro de `stlListSelecao` segue o padrão já usado em `fSenhaSeItensAlteradoOPreDefinido`/`pConfirmaBaixa` no mesmo arquivo (`Copy(stlListSelecao[i], 2, 20)`), em vez de introduzir uma técnica nova.
3. **Acúmulo de mensagens de Preço de Venda inválido + desmarcação automática** — em `TLotePrecos.pBeforePost`, a mensagem "Preço de Venda ... deve ser (maior/maior ou igual a) zero" passa a ser **acumulada** em `stlMsgPrecoInvalido` (em vez de popup imediato) quando um novo flag `blnValidandoPrecoEmLote` estiver ativo. `pAtualizarValorDoPrecoDeVendaDosItensSelecionados` liga esse flag durante o laço, identifica quais itens geraram mensagem (comparando a contagem de `stlMsgPrecoInvalido` antes/depois de cada item), remove esses itens de `stlListSelecao` ao final e exibe a lista de mensagens consolidada uma única vez.

Nenhuma alteração em `pPercorreGridDePreco`, `pAlterarPrecoMargem`, `pAjustaPrecos`, `pCalculaPrecoIdeal`, nem nas demais validações de `pBeforePost` (margem entre 0-100, margem ≥ 100, margem ideal) — só o bloco de validação de Preço de Venda é afetado pelo item 3.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untLotePrecos.pas` | `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas` | alterar |
| `untLotePrecosEfetivacaoCx.pas` | `padra_atualizado/fontes/movimentacaoitens/untLotePrecosEfetivacaoCx.pas` | alterar |

## 3. Sequência de implementação

1. **Revisão prévia (obrigatória antes de qualquer edição):** ler todos os usos de `stlListSelecao` dentro de `untLotePrecos.pas` (criação, `.Add`, `.Delete`, `.IndexOf`, `.Clear`, e o laço que monta `strFilter` a partir dela, por volta das linhas 4040-4046) e confirmar que nenhum depende da ordem de inserção. Só prosseguir para o passo 2 após essa confirmação.
2. Em `untLotePrecos.pas`, no ponto de criação de `stlListSelecao` (`stlListSelecao := TStringList.Create;`), adicionar:
   ```pascal
   stlListSelecao.Sorted     := True;
   stlListSelecao.Duplicates := dupIgnore;
   ```
3. Em `untLotePrecos.pas`, adicionar os campos `blnValidandoPrecoEmLote: Boolean` e `stlMsgPrecoInvalido: TStringList` à classe `TLotePrecos` (junto de `stlListSelecao`), criar/destruir `stlMsgPrecoInvalido` no construtor/destrutor (mesmo ciclo de vida de `stlListSelecao`), e em `pBeforePost` — só no bloco de validação de Preço de Venda — acumular a mensagem em `stlMsgPrecoInvalido` quando `blnValidandoPrecoEmLote` estiver `True`, em vez de chamar `pMensagemOk` imediatamente (o `DataSet.Cancel; Abort;` permanece igual nos dois casos).
4. Em `untLotePrecosEfetivacaoCx.pas`, reescrever `pAtualizarValorDoPrecoDeVendaDosItensSelecionados`:
   - Manter `cxbItens.BeginUpdate` / `EndUpdate` e o bookmark do dataset.
   - Substituir o laço `First`/`while not Eof do ... Next` (que varre todo o dataset checando `IndexOf`) por um laço `For intIndice := 0 To objPreLotes.stlListSelecao.Count - 1 Do`, extraindo o `AUTOINCREM` de cada item marcado via `Copy(stlListSelecao[i], 2, 20)` (mesmo padrão já usado em `fSenhaSeItensAlteradoOPreDefinido`) e usando `cdsGrid.Locate('AUTOINCREM', <valor>, [])` para posicionar o dataset diretamente antes de chamar `pPercorreGridDePreco`.
   - Se `Locate` não encontrar o item (registro removido/filtrado), pular esse item sem abortar o restante do laço.
   - Ligar `objPreLotes.blnValidandoPrecoEmLote := True` antes do laço e `False` no `finally`; limpar `objPreLotes.stlMsgPrecoInvalido` antes de começar.
   - Para cada item, comparar `stlMsgPrecoInvalido.Count` antes/depois do processamento; se aumentou, marcar esse item para desmarcação.
   - Ao final do laço, remover da `stlListSelecao` todos os itens marcados para desmarcação, chamar `pAlimentaVisaoSelecionados` (atualiza `edtQtdSel`), e — se houver mensagens acumuladas — exibir uma única `fMensagem` com a lista consolidada.
5. Compilar (`autcom.groupproj`) e validar manualmente com um lote de teste (ver spec.md, seção 6) comparando tempo e valores finais antes/depois da mudança, incluindo o cenário de itens com Preço de Venda inválido.

## 4. Conformidade com padrões do projeto

- Zona Legado: manter Hungarian style (`stlListSelecao`, `intIndice`, `strAutoIncrem`), sem introduzir interfaces/arquitetura moderna.
- Nenhum componente proibido envolvido (`TDBGridCitel`/`TcxGrid` já em uso, sem alteração de componentes).
- Nenhuma chamada proibida introduzida — não há `SetFocus`, `StrToFloat`, `Now`, `Application.CreateForm` neste trecho.
- Sem SQL novo — não há alteração de acesso a banco.
- Edição de arquivos `.pas` (encoding Windows-1252/CRLF) feita sempre via Python com encoding explícito (`cp1252`), nunca via resave genérico de editor.

## 5. Estratégia de testes

- Sem suite DUnit cobrindo esta tela — validação manual/funcional.
- Casos a cobrir:
  1. Lote pequeno (poucos itens) — comportamento e valores finais idênticos ao atual.
  2. Lote médio (~200-300 itens) com ~50 marcados — medir tempo antes/depois e comparar valores finais (`PREVE`/`MARBR` de todas as tabelas de preço visíveis) item a item com uma execução de referência (antes da alteração).
  3. Nenhum item marcado (`stlListSelecao.Count = 0`) — operação não deve alterar nada e não deve gerar erro.
  4. Um item marcado que não existe mais no dataset corrente (ex.: filtrado) — `Locate` deve falhar de forma controlada, sem abortar os demais itens.
  5. Regressão nas demais operações que usam `stlListSelecao` em `untLotePrecos.pas` (marcar/desmarcar item, filtro por seleção).

## 6. Riscos e mitigação

- **Risco:** `Sorted := True` expõe dependência de ordem de inserção não identificada → **Mitigação:** revisão de código no passo 1, antes de qualquer edição.
- **Risco:** `Locate` não encontra o item por diferença de tipo/formatação do campo `AUTOINCREM` → **Mitigação:** testar isoladamente o `Locate` com o mesmo formato de valor hoje comparado via `AsString`/`QuotedStr`, ajustando conversão se necessário.
- **Risco:** regressão silenciosa no resultado numérico do preço/margem → **Mitigação:** comparação item a item (critério de aceitação da spec.md) antes de considerar concluído.
