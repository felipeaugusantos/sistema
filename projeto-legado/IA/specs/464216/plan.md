# Plano de Execução — Req. 464216

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

`TLotePrecos` (classe de negócio, `TComponent`, sem acesso a componentes visuais) não pode manipular o grid diretamente. A solução expõe um evento novo — `OnPosicionaCampoComErro: TProc<String>` — que `pBeforePost` dispara imediatamente antes de cada `Abort`, passando o nome do campo (`DataBinding.FieldName`) da coluna que deve ser focada. A tela (`untLotePrecosEfetivacaoCx.pas`) assina esse evento no momento em que cria `objPreLotes`.

Não é necessário nenhum `Locate`/navegação adicional no dataset do grid principal: `cdsConsulta` já está posicionado no registro correto no momento do `Abort` (o `Post` ocorre sobre o registro atual sendo editado), e `cxbItens` já segue `cdsConsulta` via `DataSource` (`cxbItens.DataController.DataSource := objPreLotes.cdsConsulta.dtsSource`).

### 1.1. Adiamento do foco — mensagem Windows customizada (`WM_POSFOCO464216`)

O handler de `OnPosicionaCampoComErro` dispara **dentro** de `dbgPrecosKeyDown` (evento `OnKeyDown` do grid, tratando `VK_RETURN`), antes do `Finally` que reabilita os controles (`EnableControls`) e restaura o estado do grid. Se o foco fosse aplicado de forma síncrona nesse ponto, o próprio `Finally` o desfaria logo em seguida. `TThread.Queue` foi tentado primeiro e **não funcionou** — evidência de log mostrou o procedimento executando de forma síncrona quando chamado a partir da main thread, não adiado.

A solução usa uma mensagem Windows customizada (`WM_POSFOCO464216 = WM_USER + 464`, tratada via `procedure wmPosFoco464216(var Msg: TMessage); message WM_POSFOCO464216;`) postada com `PostMessage(Handle, WM_POSFOCO464216, 0, 0)` — isso garante que o código só executa quando a pilha de chamadas atual retornar ao loop de mensagens do Windows.

**Risco identificado e tratado (ver §6):** quando a validação falha durante a replicação em lote ("Replicar para todos os itens"), a mensagem postada é processada **cedo demais** — dentro do loop de mensagens aninhado que o próprio `TfrmGravando.ShowModal` (tela de progresso da replicação, `untLotePrecos.pas`) abre via `Application.ProcessMessages` a cada item. Nesse momento os datasets ainda estão com `DisableControls` ativo e o `TfrmGravando` ainda é o form modal ativo, então o `Locate` funciona (reposiciona o cursor) mas a grade não repinta e `pSetFocus` não consegue foco real. A mitigação foi reenviar `WM_POSFOCO464216` uma segunda vez, no `Finally` de `dbgPrecosKeyDown`, logo após os `EnableControls` — nesse ponto o modal já fechou e os controles já estão habilitados.

### 1.2. Foco no grid de detalhamento correto (`dbgPrecos`/`dbgPrecos2`/`dbgPrecos3`)

O campo que causou o erro também é exibido no grid de detalhamento (painel "Preços do Produto"), que é fisicamente 1 a 3 grids diferentes (`dbgPrecos`/`dbgPrecos2`/`dbgPrecos3`, conforme a opção "Qtd. Grid"), cada um ligado a um `TUniClientDataSet` filtrado (`cdsPrecos1`/`cdsPrecos2`/`cdsPrecos3`) por `USGRID`. Focar apenas `cxgItens` não move a seleção desse painel, que ficava parado no campo anterior.

`wmPosFoco464216` localiza o grid correto fazendo `objPreLotes.cdsPrecos.Locate('NOMCAM', <campo com erro>, [])` e lendo o campo `USGRID` do registro encontrado (1/2/3 → `dbgPrecos`/`dbgPrecos2`/`dbgPrecos3`). No modo "Qtd. Grid = 1", `dbgPrecos2`/`dbgPrecos3` ficam sempre `Visible = False`, então cai sempre em `dbgPrecos`.

Dentro do grid de detalhamento identificado, a ordem das chamadas é crítica: **`pSetFocus` deve vir antes do `Locate`** no dataset do grid — o evento `OnEnter` desses grids (`dbgPrecosEnter`) chama `.DataSet.First` ao ganhar foco, o que desfaz um `Locate` feito antes do `pSetFocus` (evidência de log: `Locate` retornava `True`, mas o cursor acabava sempre na primeira linha/cabeçalho da seção).

`dbgPrecos` tem a opção `dgAlwaysShowSelection` (os outros dois não têm), o que mantém a linha selecionada destacada mesmo sem foco real — gerando um destaque residual confuso quando o foco do erro vai para `dbgPrecos2`/`dbgPrecos3`. A opção é suprimida em `dbgPrecos` só quando o grid-alvo não é o próprio `dbgPrecos`, e restaurada em `dbgPrecosEnter` quando o usuário retorna manualmente a ele.

### 1.3. Posição correta durante a replicação em lote

`dbgPrecosKeyDown` capturava o item onde o usuário começou a editar (`strAutInc`) e, no `Finally`, **sempre** revertia `cdsConsulta` (e o `RecNo` do dataset do grid `Sender`) para esse item original — inclusive quando a replicação em lote (`pReplicaPrecoParaItens`, que percorre a partir de `Dataset.First`) parava num item **anterior** ao original por falha de validação. Isso sobrescrevia a posição do item que realmente falhou antes que o reposicionamento pudesse agir.

A correção usa uma flag nova, `FblnErroPosicionamento464216`, marcada em `OnPosicionaCampoComErro` e resetada a cada operação de `dbgPrecosKeyDown`. As duas reversões de posição no `Finally` (`cdsConsulta.Locate('AUTOINCREM', strAutInc, [])` e `TDbGridCitel(Sender).DataSource.DataSet.RecNo := intRecNoCns`) passam a ser condicionadas a `Not FblnErroPosicionamento464216`.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untLotePrecos.pas` | `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas` | alterar |
| `untLotePrecosEfetivacaoCx.pas` | `padra_atualizado/fontes/movimentacaoitens/untLotePrecosEfetivacaoCx.pas` | alterar |

## 3. Sequência de implementação

1. Em `untLotePrecos.pas`, na seção `private` da classe `TLotePrecos`: declarar campo público `OnPosicionaCampoComErro: TProc<String>` (segue o padrão já usado pela classe para `blnValidandoPrecoEmLote`/`stlListSelecao` — campo público, sem `property`).
2. Em `pBeforePost`, declarar a função local `pDispararReposicionamento(Const strCampoFoco: String)` que centraliza `If Assigned(OnPosicionaCampoComErro) And Not blnValidandoPrecoEmLote Then OnPosicionaCampoComErro(strCampoFoco);` e chamá-la antes de cada um dos 6 pontos de `Abort` do ramo não-lote, passando o campo mapeado em spec.md RN01.
3. Em `untLotePrecosEfetivacaoCx.pas`:
   - Declarar a constante `WM_POSFOCO464216 = WM_USER + 464` (seção `const` da unit, antes do `type`).
   - Na classe do form, declarar os campos privados `FstrCampoComErro464216: String` e `FblnErroPosicionamento464216: Boolean`, e o handler de mensagem `procedure wmPosFoco464216(var Msg: TMessage); message WM_POSFOCO464216;`.
   - No ponto de criação de `objPreLotes` (`FormCreate`), atribuir `objPreLotes.OnPosicionaCampoComErro` a um procedimento anônimo que grava `FstrCampoComErro464216`, marca `FblnErroPosicionamento464216 := True` e chama `PostMessage(Handle, WM_POSFOCO464216, 0, 0)`.
   - Implementar `wmPosFoco464216` conforme §1.1/§1.2: foca `cxgItens` e sua coluna, localiza o grid de detalhamento via `USGRID`/`NOMCAM` (§1.2), suprime `dgAlwaysShowSelection` em `dbgPrecos` quando o alvo é outro grid, aplica `pSetFocus` antes do `Locate` no dataset do grid de detalhamento.
   - Em `dbgPrecosEnter`, restaurar `dgAlwaysShowSelection` em `dbgPrecos` quando o usuário retorna manualmente a ele.
   - Em `dbgPrecosKeyDown` (`VK_RETURN`): mover `Key := 0` para antes do `Try/Finally` (suprime a navegação padrão do Enter mesmo quando `pBeforePost` levanta `EAbort`, que impede código após o `Finally` de executar); resetar `FblnErroPosicionamento464216 := False` no mesmo ponto; condicionar as duas reversões de posição no `Finally` a `Not FblnErroPosicionamento464216` (§1.3); reenviar `PostMessage(Handle, WM_POSFOCO464216, 0, 0)` no `Finally`, após os `EnableControls`, quando `FblnErroPosicionamento464216` for `True` (§1.1).
4. Validar manualmente os cenários de critério de aceitação (spec.md seção 6).

## 4. Conformidade com padrões do projeto

- Zona Legado: mantém Hungarian style, prefixo `F` em campo privado, `p`/`f` em métodos — não se aplica pois o novo membro é uma `property`/evento, não um método de negócio adicional.
- Sem uso de componentes/chamadas proibidos pelo pre-commit.
- Reaproveita helper padrão do projeto (`GetColumnByFieldName` + `Controller.FocusedColumn`), já usado em `libFuncoes/untFuncoesCXGrid.pas` e em `untCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pas`.
- `pSetFocus` (não `.SetFocus` direto) conforme padrão obrigatório do projeto.

## 5. Estratégia de testes

- Não há suite DUnit para esta tela — validação manual na tela "Ativar Lote de Preços da Entrada de Mercadorias", nos 3 modos de "Qtd. Grid" (1, 2 e 3).
- Casos a cobrir:
  1. Editar preço de venda de um item para um valor que arredonde a zero → confirmar foco automático na linha/coluna do grid principal **e** no campo correspondente do grid de detalhamento (`dbgPrecos`/`dbgPrecos2`/`dbgPrecos3`, conforme "Qtd. Grid"). **Validado** em Qtd. Grid = 1, 2 e 3.
  2. Repetir para margem bruta (0-100 e ≥100), margem ideal e preço de compra, isoladamente (fora do fluxo de replicação).
  3. Marcar "Replicar para todos os itens", editando um item e deixando um item **anterior** a ele (a replicação percorre a partir de `Dataset.First`) inválido → confirmar que o grid principal e o grid de detalhamento focam no item que realmente falhou, não no item onde a edição começou. **Validado** em Qtd. Grid = 3.
  4. Rodar a validação em lote de itens marcados (Req. 460063) com item inválido → confirmar que **não** há reposicionamento (mensagens continuam sendo acumuladas e exibidas ao final).
- Um log de diagnóstico temporário (`pLogFoco464216`/`pLogFoco464216Cx`, escrevendo em `log_foco_464216.txt`) foi usado durante o desenvolvimento para capturar `Screen.ActiveControl`, resultado de `Locate` e o estado da flag `FblnErroPosicionamento464216` em cada ponto crítico — removido ao final, após confirmação dos cenários testados.

## 6. Riscos e mitigação

- Risco: `TProc<String>` pode exigir ajuste no `uses` da unit (`System.SysUtils`) → mitigação: verificar compilação antes de considerar concluído.
- Risco: coluna não encontrada por nome de campo divergente (ex.: `LTP_PRECOM` vs `LTP_PRECOM_ATU`) → mitigação: mapeamento explícito documentado em spec.md RN01, revisado contra o `.dfm` antes da implementação.
- Risco (confirmado, corrigido): `PostMessage` não adia até o retorno completo ao loop de mensagens quando um `ShowModal` aninhado (`TfrmGravando`, na replicação em lote) chama `Application.ProcessMessages` internamente — a mensagem é processada dentro desse modal, cedo demais, com os controles ainda desabilitados → mitigação: reenvio de `WM_POSFOCO464216` no `Finally` de `dbgPrecosKeyDown`, após `EnableControls` (§1.1).
- Risco (confirmado, corrigido): o `OnEnter` dos grids de detalhamento (`dbgPrecosEnter`) chama `.DataSet.First`, desfazendo um `Locate` feito antes do `pSetFocus` → mitigação: ordem fixa (`pSetFocus` sempre antes do `Locate`) documentada em §1.2.
- Risco crítico ao editar `untLotePrecosEfetivacaoCx.pas`/`untLotePrecos.pas` (cp1252/Latin-1): a ferramenta de edição padrão do Claude Code não deve ser usada nesses arquivos — resalva o arquivo inteiro e pode corromper todos os caracteres acentuados mesmo em edições sem acento. **Ocorreu uma vez durante este requisito** (edição de comentário em `untLotePrecosEfetivacaoCx.pas`) e foi recuperado via `svn cat -r BASE` + reconstrução via Python em cima da revisão limpa. Toda edição nesses arquivos deve ser feita via Python (`io.open(..., encoding='cp1252', newline='')`), validando ausência da sequência `\xef\xbf\xbd` após cada edição.
