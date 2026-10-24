# REQ 464216 — Reposicionamento automático no item/campo com erro na Ativação de Lote de Preços

## 1. Contexto do problema

Chamado 464216 (Zendesk 1655410, cliente Moto Mais). Na tela "Ativar Lote de Preços da Entrada de Mercadorias"
(`TfrmLotePrecosEfetivacaoCx`, `untLotePrecosEfetivacaoCx.pas`), o método `TLotePrecos.pBeforePost`
(`untLotePrecos.pas`) valida preço de compra, margem bruta, margem ideal e preço de venda de cada tabela de
preço antes de gravar o item. Quando alguma validação falhava (ex.: preço de venda zerado após arredondamento —
caso relatado no ticket), o sistema exibia a mensagem de erro e cancelava a gravação (`DataSet.Cancel; Abort;`),
mas **nunca teve lógica de reposicionamento visual**: nem o grid principal de itens (`cxgItens`) nem o painel de
detalhamento onde o operador efetivamente edita os valores (`dbgPrecos`/`dbgPrecos2`/`dbgPrecos3`, conforme a
configuração "Qtd. Grid") eram focados na linha/coluna problemática. O operador precisava localizar manualmente
o item, o que é especialmente custoso em lotes grandes.

O dataset validado (`cdsConsulta`) já ficava posicionado corretamente no registro que falhou no momento do erro
(`Post` ocorre sobre o registro atual; `Cancel` não move o cursor) — faltava apenas conduzir o foco/scroll visual
da UI até lá.

## 2. Escopo original vs. escopo final (revisão de escopo durante a Fase 3 de testes)

A análise inicial (`spec.md`/`plan.md` gerados via `citel-IAArquitectDesenv`) cobria apenas o reposicionamento no
grid principal `cxgItens` (foco de linha + `Controller.FocusedColumn`). Essa implementação básica foi testada
manualmente pelo usuário e mostrou-se **insuficiente**: o grid principal focava corretamente, mas o painel de
detalhamento (`dbgPrecos`/`dbgPrecos2`/`dbgPrecos3`) — onde o valor de preço/margem realmente é editado —
permanecia parado no campo anterior, exigindo busca manual mesmo assim. Isso levou a uma segunda rodada de
investigação (detalhada na seção 3) que expandiu o escopo para cobrir também esse painel e o cenário de
replicação em lote ("Replicar para todos os itens").

## 3. Investigação e causas raiz identificadas

### 3.1 Mecanismo de adiamento do foco — por que `PostMessage`/`WM_POSFOCOERRO` em vez de `TThread.Queue`

A primeira tentativa de implementação usou `TThread.Queue` para adiar a chamada de reposicionamento até depois do
`Abort`/da pilha de chamadas atual retornar ao loop de mensagens do Windows. Evidência via log de diagnóstico
temporário (arquivo texto gravado a cada chamada relevante, removido ao final da sessão) mostrou que
`TThread.Queue`, quando chamado a partir da própria main thread (que é o caso aqui — não há thread secundária
envolvida), **executa de forma síncrona/imediata**, não adiada. Ou seja, o reposicionamento continuava rodando
antes do `Finally` de `dbgPrecosKeyDown` terminar de reverter a posição do grid, sendo imediatamente desfeito.

Corrigido trocando o mecanismo para uma mensagem Windows customizada, adiada de fato pelo loop de mensagens
nativo do SO:

```pascal
const
  WM_POSFOCOERRO = WM_USER + 464;
...
procedure wmPosFocoErro(var Msg: TMessage); message WM_POSFOCOERRO;
```

Disparada via `PostMessage(Handle, WM_POSFOCOERRO, 0, 0)` no callback `OnPosicionaCampoComErro`, atribuído pela
tela na criação de `objPreLotes` (`FormCreate`).

### 3.2 Grid de detalhamento correto — lookup por `USGRID`/`NOMCAM`

O campo com erro (ex.: `LTP_PREVE3`) é exibido tanto em `cxgItens` (grid principal, uma coluna por campo) quanto
em um dos três grids de detalhamento (`dbgPrecos`/`dbgPrecos2`/`dbgPrecos3`), que mostram os campos de uma
tabela de preço por vez, conforme a configuração "Qtd. Grid" (1, 2 ou 3) escolhida pelo usuário. Para focar o
grid de detalhamento certo, `wmPosFocoErro` localiza o registro correspondente em `objPreLotes.cdsPrecos` via
`Locate('NOMCAM', <campo com erro>, [])` e lê o campo `USGRID` (1, 2 ou 3), que indica em qual dos três grids
físicos aquele campo aparece:

```pascal
Case intUsGrid of
  1: dbgGridComErro := dbgPrecos;
  2: dbgGridComErro := dbgPrecos2;
  3: dbgGridComErro := dbgPrecos3;
End;
```

No modo "Qtd. Grid = 1", `dbgPrecos2`/`dbgPrecos3` ficam sempre `Visible = False` e `dbgPrecos` exibe
`cdsPrecos` sem filtro (todos os `USGRID` juntos) — por isso há um fallback explícito para `dbgPrecos` sempre
que o grid indicado por `USGRID` não estiver visível.

### 3.3 Ordem `pSetFocus` → `Locate` (não o inverso)

Testado inicialmente na ordem `Locate` seguido de `pSetFocus`. Resultado observado (log + evidência visual em
print de tela): o `Locate` funcionava (cursor ia para o registro certo), mas a seleção visual do grid de
detalhamento voltava para o primeiro registro. Causa raiz: o evento `OnEnter` desses grids
(`dbgPrecosEnter`) chama incondicionalmente `.DataSet.First` ao ganhar foco — ou seja, o `pSetFocus` (que
dispara o `OnEnter`) desfazia um `Locate` feito antes dele. Corrigido invertendo a ordem: `pSetFocus` primeiro,
`Locate` depois.

### 3.4 Destaque residual — `dgAlwaysShowSelection`

Somente `dbgPrecos` tem a opção `dgAlwaysShowSelection` habilitada (os outros dois grids não têm), o que faz com
que ele continue mostrando visualmente a linha selecionada mesmo sem foco real de teclado. Isso gerava um
destaque confuso quando o reposicionamento movia o foco de erro para `dbgPrecos2`/`dbgPrecos3`: o usuário via
duas linhas "selecionadas" simultaneamente (a residual em `dbgPrecos` e a real no grid de destino). Corrigido
suprimindo a opção em `dbgPrecos` apenas quando o grid de destino é outro, e restaurando-a em `dbgPrecosEnter`
quando o usuário retorna manualmente (Tab/clique) a `dbgPrecos`.

### 3.5 Reposicionamento incorreto durante "Replicar para todos os itens"

Ao testar com o checkbox "Replicar para todos os itens" marcado e um erro ocorrendo num item diferente daquele
onde a edição começou, o reposicionamento inicialmente focava sempre o item onde a edição começou, não o item
que realmente falhou. Causa raiz: o bloco `Finally` de `dbgPrecosKeyDown` sempre revertia `cdsConsulta` (e o
`RecNo` do grid de detalhamento) para o item original (`strAutInc`) antes que o reposicionamento pudesse agir,
mesmo quando o erro havia ocorrido em outro item durante a replicação. Corrigido com uma flag
(`FblnErroPosicionamento`, setada em `OnPosicionaCampoComErro` e resetada no início de cada operação de
`dbgPrecosKeyDown`) que condiciona as duas reversões de posição do `Finally` — se houve erro, `cdsConsulta` e o
grid de detalhamento **não** são revertidos, permanecendo no item que efetivamente falhou.

### 3.6 Mensagem processada cedo demais dentro do modal de replicação

Mesmo após a correção da seção 3.5, o reposicionamento ainda falhava especificamente durante a replicação em
lote: o `Locate` no grid de detalhamento funcionava (cursor ia para o item certo), mas o grid não repintava e
`pSetFocus` não conseguia foco real (`Focused = False`). Causa raiz: "Replicar para todos os itens"
(`pReplicaPrecoParaItens`, `untLotePrecos.pas`) roda dentro de `TfrmGravando.ShowModal` — um diálogo modal
verdadeiro que bombeia seu próprio loop de mensagens aninhado — e chama `Application.ProcessMessages` uma vez
por item processado. A mensagem `WM_POSFOCOERRO`, originalmente postada em `OnPosicionaCampoComErro`, acabava
sendo processada **dentro** desse loop aninhado, antes do `Finally` de `dbgPrecosKeyDown` rodar — nesse instante
`cdsConsulta`/o dataset do grid de detalhamento ainda estavam em `DisableControls`, e `TfrmGravando` ainda era o
form modal ativo, impedindo o foco real. Corrigido reenviando `WM_POSFOCOERRO` uma segunda vez, dentro do
`Finally` de `dbgPrecosKeyDown`, logo após os `EnableControls` — nesse ponto o modal de replicação já fechou e
os controles já estão habilitados, e o segundo disparo é processado com sucesso (confirmado via log: `Focused =
True` e `Locate` no campo/registro correto).

## 4. Correção aplicada

Resumo da solução final (`untLotePrecos.pas` + `untLotePrecosEfetivacaoCx.pas`):

- `TLotePrecos` (classe de lógica, sem acesso a UI) ganhou um campo público `OnPosicionaCampoComErro:
  TProc<String>`, disparado por uma função local `pDispararReposicionamento` em `pBeforePost`, chamada
  imediatamente antes de cada um dos 6 pontos de `Abort` (preço de compra, margem bruta ≥100/entre 0-100, margem
  ideal ≥100, preço de venda), passando o nome do campo (`LTP_PRECOM_ATU`, `LTP_MARBRn`, `LTP_MARIDn`,
  `LTP_PREVEn`). Não dispara quando `blnValidandoPrecoEmLote = True` (fluxo de pré-checagem em lote, Req.
  460063 — comportamento existente de acumular mensagens permanece inalterado).
- A tela atribui esse callback na criação de `objPreLotes` (`FormCreate`), armazenando o campo em
  `FstrCampoComErro`, marcando `FblnErroPosicionamento := True` e postando `WM_POSFOCOERRO`.
- `wmPosFocoErro` (handler da mensagem) foca `cxgItens` + a coluna correspondente, localiza o registro em
  `cdsPrecos` via `NOMCAM`, resolve o grid de detalhamento certo via `USGRID` (com fallback para `dbgPrecos` no
  modo "Qtd. Grid = 1"), suprime/foca/`Locate` na ordem correta (seção 3.3/3.4).
- `dbgPrecosKeyDown` (tratamento do Enter no grid de detalhamento) passou a: suprimir o processamento padrão do
  Enter (`Key := 0`) antes de chamar a validação (necessário porque `pBeforePost` pode levantar `EAbort`,
  pulando código após o `Try`); resetar `FblnErroPosicionamento := False` no início de cada operação;
  condicionar as duas reversões de posição do `Finally` a essa flag (seção 3.5); reenviar `WM_POSFOCOERRO`
  após `EnableControls` quando houve erro (seção 3.6).
- `dbgPrecosEnter` restaura `dgAlwaysShowSelection` em `dbgPrecos` quando o usuário retorna manualmente a ele.

## 5. Verificação

Validação manual (UI VCL desktop, sem suite automatizada cobrindo este fluxo):

| Cenário | Status |
|---|---|
| Edição isolada de preço de venda zerando por arredondamento — Qtd. Grid = 1, 2 e 3 | ✅ Validado pelo usuário |
| "Replicar para todos os itens" com erro em item anterior ao item onde a edição começou — Qtd. Grid = 3 | ✅ Validado pelo usuário |
| Margem bruta (0-100 e ≥100), margem ideal, preço de compra, isoladamente | ⏳ Não testado |
| Validação em lote de itens marcados (Req. 460063, `blnValidandoPrecoEmLote = True`) — confirmar que NÃO há reposicionamento | ⏳ Não testado |

Todo o código de diagnóstico temporário usado durante a investigação (log em arquivo texto, handler
`cxbItensFocusedItemChanged`, helper `fFocusedColumnNome464216`) foi removido após a confirmação dos testes
acima, por pedido explícito do usuário.

## 6. Incidente de corrupção de encoding e recuperação

Durante a limpeza do código de diagnóstico em `untLotePrecosEfetivacaoCx.pas`, a ferramenta `Edit` foi usada por
engano numa pequena edição de comentário — violação da regra do projeto de nunca usar `Edit` em arquivos `.pas`
(Windows-1252/cp1252; `Edit` resalva o arquivo inteiro e pode corromper silenciosamente todo o conteúdo se
houver qualquer divergência de encoding na leitura/gravação). Validação imediata após o `Edit` confirmou
corrupção: 112 ocorrências da sequência `\xef\xbf\xbd` (U+FFFD, caractere de substituição — indicador de perda
de dados irrecuperável), espalhadas por praticamente o arquivo inteiro, não apenas perto da edição feita.

Recuperação seguiu o protocolo documentado no `CLAUDE.md` global do usuário: `svn cat -r BASE
untLotePrecosEfetivacaoCx.pas` para obter a revisão pré-sessão limpa; validação de que essa base decodifica sem
erro em cp1252 e não contém `\xef\xbf\xbd`; localização do texto exato de cada ponto a alterar usando essa base
limpa; reconstrução completa do arquivo em um único script Python, aplicando todas as 7 mudanças pretendidas
(state final da seção 4, já sem o código de diagnóstico) via `content.count(old) == 1` + replace; validação
final de encoding; e conferência de `svn diff` completo, linha a linha, confirmando que o resultado contém
exatamente as mudanças pretendidas e nada mais. Nenhuma perda de trabalho ocorreu — a reconstrução recuperou
integralmente o estado funcional pretendido.

## 7. Cópias alteradas

| Cópia | Situação encontrada | Ação |
|---|---|---|
| `379.48.2.30.74.150.45` | Implementação original desta sessão (toda a investigação das seções 3-6 ocorreu aqui) | Implementado, testado e validado pelo usuário (seção 5) |
| `379.48.2.30.74.150.100` | Continha implementação parcial/antiga do mesmo requisito, não commitada (só chamadas inline a `OnPosicionaCampoComErro` em `pBeforePost`, sem `WM_POSFOCOERRO` nem lógica de grid de detalhamento) | `svn revert` (autorizado pelo usuário) + reaplicação completa do fix validado |
| `379.48.2.30.74.150` | Mesma situação — implementação parcial/antiga não commitada | `svn revert` (autorizado pelo usuário) + reaplicação completa do fix validado |
| `74.Fechadas\74.150.45.Fechadas\379.48.2.30.74.150.45.68` | Mesma situação — implementação parcial/antiga não commitada | `svn revert` (autorizado pelo usuário) + reaplicação completa do fix validado |

Em todas as cópias, a implementação parcial pré-existente foi identificada como resíduo de uma sessão anterior
que aplicou apenas a versão básica do fix (só `cxgItens`, sem os grids de detalhamento nem a correção de
replicação em lote) — documentada como desatualizada no `tasks.md` deste requisito antes desta sessão de
replicação. Optou-se por reverter e reaplicar do zero em vez de reconciliar as duas versões, para evitar
misturar implementações parcialmente conflitantes do mesmo requisito.

Todas as edições, em todas as cópias, foram feitas via script Python com encoding explícito `cp1252`
(`io.open` com `encoding='cp1252', newline=''`, com as strings de busca/substituição convertidas para CRLF antes
da comparação — os arquivos usam quebra de linha `\r\n`), nunca pela ferramenta `Edit`. Validado após cada
gravação: decodificação sem erro em `cp1252` e ausência de `\xef\xbf\xbd`. Cada cópia teve seu `svn diff`
conferido integralmente antes de prosseguir, e os pontos de inserção foram localizados a partir do texto real de
cada cópia (não copiados cegamente do diff de referência), já que as cópias divergem ligeiramente entre si em
formatação/uses/ordem de declarações.

## 8. Escopo e pendências

- **Testes pendentes** (seção 5): margem bruta (0-100 e ≥100), margem ideal e preço de compra isoladamente
  (fora do fluxo de replicação); validação em lote de itens marcados (Req. 460063) confirmando ausência de
  reposicionamento.
- **Fora de escopo**: qualquer alteração no texto ou lógica das mensagens de validação existentes; alteração no
  comportamento de `blnValidandoPrecoEmLote = True`.
- **Nenhum commit SVN realizado** até o momento desta análise, em nenhuma das 4 cópias.

## 9. Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivos/Units:** `untLotePrecos.pas` (`TLotePrecos.OnPosicionaCampoComErro`, `pBeforePost`) e
`untLotePrecosEfetivacaoCx.pas` (`FstrCampoComErro`, `FblnErroPosicionamento`, `FormCreate`,
`wmPosFocoErro`, `dbgPrecosEnter`, `dbgPrecosKeyDown`)

Cobre o mecanismo completo descrito nas seções 3.1 a 3.5: por que o reposicionamento usa `PostMessage`/
`WM_POSFOCOERRO` em vez de `TThread.Queue` (que executa de forma síncrona quando chamado da main thread, não
adiada — comprovado por log durante a investigação); por que `wmPosFocoErro` precisa localizar o grid de
detalhamento correto via `USGRID`/`NOMCAM` em `cdsPrecos`, com fallback para `dbgPrecos` no modo "Qtd. Grid = 1";
por que a ordem precisa ser `pSetFocus` antes de `Locate` (o `OnEnter` desses grids dá `.DataSet.First`,
desfazendo um `Locate` anterior); por que `dgAlwaysShowSelection` precisa ser suprimido/restaurado em `dbgPrecos`
especificamente quando o foco de erro vai para outro grid; e por que as duas reversões de posição no `Finally`
de `dbgPrecosKeyDown` (volta de `cdsConsulta` para o item original, volta do `RecNo` do grid de detalhamento)
precisam ser condicionadas a `FblnErroPosicionamento` — sem essa guarda, o próprio `Finally` desfaz o
reposicionamento durante a replicação em lote sempre que o erro ocorre num item diferente daquele onde a edição
começou. Se algum desses pontos for "limpo" numa revisão futura por parecer redundante ou defensivo demais, o
sintoma original (grid de detalhamento não acompanha o item/campo com erro) volta a se manifestar.

### Nota 2

**Arquivo/Unit:** `untLotePrecosEfetivacaoCx.pas`, `TfrmLotePrecosEfetivacaoCx.dbgPrecosKeyDown` (bloco
`Finally`)

Cobre especificamente a causa raiz da seção 3.6: durante "Replicar para todos os itens", a replicação roda
dentro de `TfrmGravando.ShowModal` (`untLotePrecos.pas`, `pReplicaPrecoParaItens`), que é um diálogo modal
verdadeiro com loop de mensagens próprio, e chama `Application.ProcessMessages` a cada item processado. Isso faz
com que a mensagem `WM_POSFOCOERRO` original (postada em `OnPosicionaCampoComErro`, assim que o erro ocorre)
seja processada **dentro** desse loop aninhado, antes do `Finally` de `dbgPrecosKeyDown` rodar — nesse instante
`cdsConsulta` e o dataset do grid de detalhamento ainda estão em `DisableControls`, e `TfrmGravando` ainda é o
form modal ativo, o que impede `pSetFocus` de obter foco real de janela (`Focused` permanece `False`) mesmo que
o `Locate` interno tenha funcionado. A correção reenvia `WM_POSFOCOERRO` uma segunda vez, agora dentro do
próprio `Finally`, logo após `EnableControls` — nesse ponto o modal de replicação já fechou e os controles já
estão habilitados, permitindo que o segundo disparo obtenha foco real e reaplique o `Locate` com sucesso. Se essa
chamada duplicada parecer redundante numa limpeza futura e for removida, o reposicionamento no grid de
detalhamento volta a falhar silenciosamente (sem erro, sem exceção) especificamente durante replicação em lote —
o `Locate` roda e "funciona" logicamente, mas a UI não reflete isso porque processado cedo demais, dentro do
modal.

### Nota 3

**Arquivo/Unit:** `untLotePrecosEfetivacaoCx.pas`, `TfrmLotePrecosEfetivacaoCx.wmPosFocoErro`

Endurecimento defensivo adicionado numa revisão de código posterior à validação inicial (não motivado por um bug
observado em teste, e sim por uma revisão manual do diff). `FstrCampoComErro` só é preenchido em
`OnPosicionaCampoComErro` (`FormCreate`), sempre imediatamente antes de qualquer `PostMessage(WM_POSFOCOERRO)`
— verificado que essa é, hoje, a única origem de preenchimento do campo e que ambos os pontos que postam a
mensagem (`OnPosicionaCampoComErro` e o reenvio no `Finally` de `dbgPrecosKeyDown`, este último condicionado a
`FblnErroPosicionamento`) só o fazem depois de o campo já estar preenchido. Ou seja, não há hoje nenhum
caminho de código que dispare `WM_POSFOCOERRO` com `FstrCampoComErro` vazio. A guarda `If
FstrCampoComErro = '' Then Exit;` foi adicionada mesmo assim como proteção contra uma mensagem
indevida/duplicada (ex.: reentrância futura, um novo ponto de código que passe a postar essa mensagem sem seguir
o mesmo contrato) mover o foco para `cxgItens` sem necessidade. Sem essa guarda, `cxbItens.GetColumnByFieldName('')`
retornaria `Nil` (já protegido pelo `Assigned` existente) mas `pSetFocus(cxgItens)` ainda seria executado,
causando um salto de foco visualmente incorreto sem nenhum erro de validação de fato ocorrido.

### Nota 4

**Arquivo/Unit:** `untLotePrecosEfetivacaoCx.pas`, `TfrmLotePrecosEfetivacaoCx.dbgPrecosKeyDown` (bloco
`Finally`)

Endurecimento defensivo adicionado na mesma revisão de código da Nota 3. Antes desta mudança,
`FblnErroPosicionamento` só era resetada para `False` no início da próxima execução de `dbgPrecosKeyDown`
(ao pressionar Enter novamente), nunca imediatamente após seu uso no `Finally` da execução atual. Hoje isso não
tem efeito prático porque a flag só é lida dentro desse mesmo `Finally` (as duas guardas de reversão de posição
mais o reenvio de `WM_POSFOCOERRO`, seção 3.5/3.6) — verificado que não existe nenhum outro ponto de código
que leia essa flag fora desse handler. O risco identificado é de fragilidade para manutenção futura: se
`pBeforePost` viesse a ser disparado por outro caminho que não o Enter em `dbgPrecosKeyDown` (ex.: um clique em
botão "Confirmar"/"Sair" que também force o `Post` do registro atual), `OnPosicionaCampoComErro` dispararia
normalmente e deixaria a flag em `True` até o próximo Enter, criando uma dependência implícita e frágil para
qualquer código futuro que viesse a consultar essa flag fora do escopo atual. Corrigido resetando a flag para
`False` imediatamente após seu último uso no `Finally` (logo após o `PostMessage` de reenvio), confinando seu
tempo de vida a uma única execução do handler.

### Nota 5

**Arquivo/Unit:** `untLotePrecosEfetivacaoCx.pas`, `TfrmLotePrecosEfetivacaoCx.wmPosFocoErro`

Endurecimento defensivo adicionado na mesma rodada de revisão de código das Notas 3 e 4, e que passou por **duas
iterações** antes da forma final — a primeira introduziu uma regressão real, detectada por revisão de código
antes de qualquer teste manual (seção 12).

**Motivação original:** `FstrCampoComErro` era preenchido em `OnPosicionaCampoComErro` mas nunca limpo —
permanecendo com o último valor processado indefinidamente após `wmPosFocoErro` terminar. Sem efeito prático
imediato (nenhum outro ponto do código lia essa variável fora do próprio handler), mas criava uma dependência
implícita frágil para código futuro, no mesmo espírito da Nota 4.

**1ª tentativa (revertida — regressão):** limpar `FstrCampoComErro := ''` incondicionalmente ao final de
`wmPosFocoErro`. Isso quebrava diretamente o mecanismo da Nota 2 no cenário de replicação em lote com erro: a
1ª execução do handler (processada prematuramente, DENTRO do modal `TfrmGravando.ShowModal`, conforme Nota 2)
chega ao fim sem lançar exceção — `pSetFocus` (`untFuncoesGen.pas`, `pSetFocus`) apenas verifica `Screen.ActiveForm
= Form` e, se falso (é o caso: o form ativo é `TfrmGravando`, não `TfrmLotePrecosEfetivacaoCx`), **sai
silenciosamente sem focar e sem erro** — então o handler roda até o fim e limpava o campo. Quando a 2ª mensagem
(reenviada pelo `Finally`, Nota 2, já com o modal fechado) era processada, `FstrCampoComErro` já estava
vazio e caía no guard da Nota 3 (`If FstrCampoComErro = '' Then Exit`), saindo sem aplicar o foco — o
reposicionamento no fluxo de replicação em lote deixava de funcionar silenciosamente (sem exceção, sem erro
visível; sintoma seria "às vezes o foco não vai para o item que falhou" especificamente nesse fluxo). Essa
regressão foi apontada em revisão de código antes de qualquer teste manual ter sido feito com o código já
alterado.

**Correção intermediária (também descartada):** mover a limpeza para dentro do `Finally` de `dbgPrecosKeyDown`,
logo após o `PostMessage` do reenvio (Nota 2) e o reset de `FblnErroPosicionamento` (Nota 4). Essa versão
tem o mesmo defeito de fundo: `PostMessage` apenas enfileira a mensagem — ela só é processada quando o handler
`dbgPrecosKeyDown` retorna ao loop de mensagens do Windows. Limpar `FstrCampoComErro` no `Finally`
acontece ANTES dessa segunda mensagem ser efetivamente processada por `wmPosFocoErro`, então o mesmo guard da
Nota 3 a interceptava e o reposicionamento voltava a falhar — mesma regressão, só que originada em outro ponto
do código.

**Correção final aplicada:** manter a limpeza **apenas** dentro de `wmPosFocoErro`, mas **condicionada** a
`FblnErroPosicionamento`:

```pascal
If Not FblnErroPosicionamento Then
  FstrCampoComErro := '';
```

Essa flag já funciona como o discriminador correto entre as duas execuções possíveis do handler, sem precisar de
nenhum estado novo (avaliada e descartada a alternativa de uma variável de backup local capturada no callback,
por ser equivalente em resultado e mais complexa): na 1ª execução (prematura, dentro do modal), a flag ainda
está `True` — o `Finally` só a zera depois que essa 1ª execução já terminou — então o campo NÃO é limpo. Na 2ª
execução (real, após `EnableControls`), a flag já foi zerada pelo `Finally` antes de essa mensagem ser
processada — o campo É limpo, com segurança, pois o valor já foi consumido. No fluxo não-lote (sem modal), a
mesma lógica resolve elegantemente a redundância notada na seção 12 (achado descartado sobre o reenvio
duplicado): a 1ª mensagem processada já encontra a flag `False` (reset síncrono ocorrido antes do handler
retornar) e limpa o campo normalmente; a 2ª mensagem (ainda enfileirada, redundante) encontra o campo vazio e
sai pelo guard da Nota 3 sem custo, em vez de repetir `pSetFocus`/`Locate` à toa.

## 10. Contexto técnico adicional (mapeamento cópia a cópia)

- Diff de referência final (74.150.45, revisão base 497328) tocou: `untLotePrecos.pas` — campo
  `OnPosicionaCampoComErro: TProc<String>` na classe `TLotePrecos`; procedure local `pDispararReposicionamento`
  dentro de `pBeforePost`; 6 chamadas a `pDispararReposicionamento` imediatamente antes de cada `Abort`.
  `untLotePrecosEfetivacaoCx.pas` — `const WM_POSFOCOERRO = WM_USER + 464`; campos `FstrCampoComErro:
  String` e `FblnErroPosicionamento: Boolean`; declaração `procedure wmPosFocoErro(var Msg: TMessage);
  message WM_POSFOCOERRO;`; bloco em `dbgPrecosEnter` restaurando `dgAlwaysShowSelection`; bloco em
  `dbgPrecosKeyDown` (antes do `Try`) com `Key := 0` + reset da flag; bloco no `Finally` de `dbgPrecosKeyDown`
  com as duas guardas condicionais + o reenvio de `WM_POSFOCOERRO`; atribuição de
  `objPreLotes.OnPosicionaCampoComErro` em `FormCreate`; implementação completa de `wmPosFocoErro`.
- Em `379.48.2.30.74.150` (revisão base 497328, mesma base), a única divergência estrutural relevante foi a
  ordem/composição do `uses` (inclui `cxProgressBar`) e a posição de `pTrataFocoDbgPrecos`/`CMDialogKey` na
  declaração da classe — sem impacto funcional, apenas offsets de linha diferentes.
- Em `74.Fechadas\74.150.45.Fechadas\379.48.2.30.74.150.45.68` (revisão base 497234, anterior à 497328), o
  texto-base bateu quase integralmente com o diff de referência, sem divergência de formatação relevante — só
  offset de linha por causa da revisão diferente.
- Em `379.48.2.30.74.150.100`, aplicado pelo mesmo padrão (script Python dedicado, localizando o texto real
  desta cópia antes de cada substituição); nenhuma divergência estrutural relevante além de offsets de linha.
- Em todas as cópias, os comentários "Verificar Nota N - Req. 464216" foram mantidos idênticos aos da cópia de
  referência, para preservar a rastreabilidade cruzada até este documento.

## 11. Endurecimento defensivo pós-implementação (Notas 3 e 4)

Após a validação e replicação descritas nas seções 5 e 7, uma revisão manual de código sobre o diff apontou dois
pontos de fragilidade não relacionados a nenhum bug observado em teste (ver Notas 3 e 4, seção 9):

- `wmPosFocoErro` não validava `FstrCampoComErro` vazio antes de mover o foco (Nota 3).
- `FblnErroPosicionamento` só era resetada no início da próxima execução de `dbgPrecosKeyDown`, não
  imediatamente após seu uso (Nota 4).

Ambos os pontos foram investigados e confirmados como **não exploráveis pelos caminhos de código existentes
hoje** (rastreados todos os pontos que preenchem/leem essas duas variáveis) — as correções foram aplicadas como
endurecimento preventivo para manutenção futura, não como correção de bug ativo. Um terceiro ponto levantado na
mesma revisão — a constante `WM_POSFOCOERRO = WM_USER + 464` poder colidir com outra mensagem customizada
definida em algum ancestral de `TfrmLotePrecosEfetivacaoCx` — foi avaliado e **descartado**: mensagens postadas
via `PostMessage(Handle, ...)` só são despachadas dentro da cadeia de herança do próprio form (não afetam outros
forms), e uma busca por `WM_USER +` em todo `padra_atualizado/fontes` não encontrou nenhuma outra definição de
`WM_USER + 464`, nem em `TfrmPaiConfirma` nem em qualquer ancestral relevante. `RegisterWindowMessage` (unicidade
entre processos do SO) não se aplica a esse caso — a constante local segue o mesmo padrão já usado em pelo menos
11 outros pontos desta base (`untConstantes.pas`, `Romaneio.Constantes.pas`, etc.).

As duas correções (Notas 3 e 4) foram aplicadas e replicadas nas 4 cópias (mesmo processo de verificação de
texto real por cópia antes de cada substituição, validação de encoding cp1252 e checagem de ruído de EOL via
`corrigeUnitFlipCRLF-LF` — todas limpas), mantendo a paridade entre `379.48.2.30.74.150.45`,
`379.48.2.30.74.150.100`, `379.48.2.30.74.150` e `74.Fechadas\74.150.45.Fechadas\379.48.2.30.74.150.45.68`.

## 12. Segunda rodada de revisão de código (Nota 5 e itens descartados)

Uma segunda revisão manual sobre o diff, focada em `wmPosFocoErro` e `dbgPrecosKeyDown`, levantou quatro
pontos. Dois foram aceitos e aplicados (replicados nas 4 cópias, mesmo processo de verificação/validação das
seções anteriores); dois foram avaliados e descartados, com justificativa registrada abaixo para não serem
reabertos sem novo motivo:

**Aplicado — cache do resultado de `GetColumnByFieldName`:** a busca linear pela coluna
(`cxbItens.GetColumnByFieldName(FstrCampoComErro)`) era chamada duas vezes seguidas (uma no `If Assigned`,
outra na atribuição) dentro do mesmo trecho — e, como `wmPosFocoErro` pode rodar 2× por erro (ver Nota 5 e
seção 6.3), a busca ocorria efetivamente até 4× por evento de erro. Corrigido armazenando o resultado numa
variável local (`colFoco: TcxGridDBColumn`) e reutilizando-a. Melhoria de eficiência pura, sem mudança de
comportamento.

**Aplicado — Nota 5:** ver seção 9. Mesma lógica de endurecimento defensivo das Notas 3/4, aplicada a
`FstrCampoComErro`.

**Descartado — condicionar o reenvio de `WM_POSFOCOERRO` no `Finally` apenas ao fluxo de replicação em
lote:** a sugestão apontava que, no fluxo não-lote (edição de um único item), o primeiro `PostMessage` (feito em
`OnPosicionaCampoComErro`) já é suficiente — o modal `TfrmGravando` só existe durante "Replicar para todos os
itens" (seção 3.6), então fora desse fluxo o reenvio do `Finally` seria redundante, fazendo `wmPosFocoErro`
rodar 2× (idempotente, mas com potencial *flicker* de `pSetFocus`/`Locate` duplicados). Avaliado e **não
aplicado**: a condição sugerida pelo revisor (`objPreLotes.blnArredondaPrecoEmLote`) está incorreta — esse campo
controla arredondamento de valor replicado, não se a operação atual está dentro do loop de replicação. O estado
real que determina isso (`FblnReplicaValorItens`/o `ShowModal` de `TfrmGravando`) vive inteiramente dentro de
`TLotePrecos` (`untLotePrecos.pas`, `pAlterarPrecoMargem`/`pReplicaPrecoParaItens`) e não é hoje exposto para
`untLotePrecosEfetivacaoCx.pas` de forma confiável no momento em que o `Finally` de `dbgPrecosKeyDown` roda.
Implementar esse gate corretamente exigiria expor um novo estado público em `TLotePrecos` (nova superfície de
API, com risco de nova causa raiz se mal sincronizado) só para eliminar uma redundância idempotente sem sintoma
relatado por usuário — trade-off considerado desfavorável frente ao risco de regressão no cenário já validado
(Fase 3, seção 5: "Replicar para todos os itens", Qtd. Grid = 3). Redundância aceita e documentada como
comportamento conhecido.

**Descartado — `Key := 0` também suprime o Enter no caminho de sucesso:** observação correta (mudança de
comportamento intencional, necessária porque `pBeforePost` pode levantar `EAbort` de forma síncrona, exigindo
que a supressão do Enter padrão ocorra ANTES do `Try`, não apenas no ramo de erro), mas não é uma sugestão de
alteração de código — é um pedido de confirmação em teste manual com o operador (se o Enter deixou de avançar de
linha após um post bem-sucedido, é uma regressão de UX a validar, não algo detectável/corrigível estaticamente
no código). Não há mudança de código para este item; fica registrado como item de teste manual adicional,
complementar aos já pendentes na seção 8 (Fase 3 do `tasks.md`).

## 13. Regressão detectada e corrigida na implementação da Nota 5

Ver detalhamento completo na Nota 5 (seção 9). Resumo do incidente: a implementação inicial de Nota 5 (limpar
`FstrCampoComErro` de forma incondicional) quebrava silenciosamente o mecanismo da Nota 2 no fluxo
"Replicar para todos os itens" — a mensagem `WM_POSFOCOERRO` reenviada pelo `Finally` (a que efetivamente
aplica o foco, após o modal `TfrmGravando` fechar) chegava a `wmPosFocoErro` com o campo já vazio, caindo no
guard da Nota 3 e não aplicando o foco. Uma correção intermediária (mover a limpeza para o `Finally`, logo após
o reenvio) tinha o mesmo defeito por outro caminho — `PostMessage` apenas enfileira, não processa
imediatamente. Nenhuma das duas versões chegou a ser testada manualmente pelo usuário antes de a regressão ser
identificada em revisão de código; a correção final (limpeza condicionada a `FblnErroPosicionamento`,
dentro do próprio `wmPosFocoErro`) foi aplicada e replicada nas 4 cópias antes de qualquer teste.

**Consequência para a seção 5 (verificação):** o cenário "Replicar para todos os itens com erro em item anterior
— Qtd. Grid = 3", antes marcado ✅ validado pelo usuário, teve o código-fonte alterado três vezes desde essa
validação (Notas 3/4/5 e as duas correções da regressão). Embora a lógica final tenha sido revisada
cuidadosamente por trace manual completo dos dois fluxos (lote e não-lote), **esse cenário precisa ser
revalidado manualmente antes de qualquer commit**, já que a última validação efetiva do usuário foi sobre uma
versão do código anterior a todas essas mudanças.
