# Req. 462062 — registro de sessão

## 15/09/2026 — levantamento e implementação

### O que o dump da LOGERR escondia

Os nove registros trazidos pelo Ronaldo (394–400) têm todos o mesmo
`LOG_DESCRI = 'Não foi possível faturar o documento.'`. Isso **não** é coincidência
nem repetição do mesmo pedido: é a constante `MSG_ERRO_NA_GRAVACAO`, levantada em
`TFaturadorBase.GravarFaturamento` (`Faturamento.Classes.TFaturador.Base.pas:322`)
sempre que `fChamaTelaGravando` devolve `False`.

E `fChamaTelaGravando` chama `fGravaArquivos`, que tem **7.667 linhas e 255 pontos de
`Result := False`**. Toda validação que barra o faturamento — caixa fechado, trava de
venda presencial, item sem lote, o que for — sai por um desses, mostra `fMensagem` e
devolve `False`. O motivo morre ali: 255 caminhos colapsam num booleano.

Ou seja, `MSG_ERRO_NA_GRAVACAO` não é a exceção *do caixa fechado*. É a exceção **da
ausência de motivo**. Os nove registros podem ter vindo de nove validações diferentes.

O motivo só sobrevive por um canal paralelo: `untPrincipal.pas:8156` liga
`VS_OnMensagemAoUsuario := TFaturamentoAutomaticoMonitor.AddLog` antes de rodar o robô,
então o `fMensagem` da validação vira linha em `Mensagens` (daí o `[ OK ]` no
`FAT_LOGMSG`). Esse canal não chega à exceção.

### Hipóteses descartadas

**Classe de exceção `EFaturamentoNaoRealizado`** (primeira proposta). Descartada porque
marca o balde genérico, não o motivo: suprimiria os 255 caminhos de uma vez.

**`ECaixaJaFechado`** (levantada pelo João, e correta em princípio). Inviável sem
reescrever o fluxo: a validação do caixa não levanta exceção no Windows — faz
`fMensagem` + `Result := False` + `Exit` (`TFatVendaBase.pas:127373`). Convertê-la em
`raise` mudaria o comportamento da tela interativa para todo operador do autcom, e ainda
deixaria os outros 253 caminhos genéricos.

**Comparar `E.Message` com a constante** (proposta do João). É o caminho certo, mas o
alvo estava errado: comparar contra `MSG_ERRO_NA_GRAVACAO` é comparar contra o balde.
A correção foi comparar contra o texto da **trava de caixa**.

### O critério, que só apareceu no fim

O João enunciou a regra que faltava: *"uma coisa é não conseguir calcular o total, nunca
deveria ocorrer por isso erro; mas caixa fechado é normal todo final de tarde"*.

O eixo não é **regra de negócio vs. erro técnico** — é **rotineiro vs. nunca deveria
acontecer**. `MSG_ERRO_CALCULAR_TOTAL` nasce do mesmo padrão de `Result := False` que o
caixa fechado, mas fica de fora da lista. Vale registrar porque as duas primeiras
propostas erraram justamente por adotar o eixo errado.

### Furo encontrado depois de implementar

A guarda testava só `Mensagens.Text`. Funciona no Windows, mas **não** no Linux: lá a
trava sobe por `pRaiseExceptionAutCom` (`TFatVendaBase.pas:127378`), que levanta
`EInvalidParams` com o texto da trava **sem** passar pelo `fMensagem` — então
`Mensagens` pode estar vazia quando a guarda roda, e o motivo só existe em `E.Message`.
A guarda passou a receber `E.Message` e avaliar as duas fontes concatenadas.

### Decisão de implementação

`MSG_CAIXA_FECHADO_OU_ANTERIOR_EM_ABERTO` foi extraída em `untTravaCaixa.pas` a partir
da linha que já estava triplicada nas três constantes compostas. Não é cosmética: é a
única âncora das três **sem quebra de linha**, e comparar substring com `#13` embutido
dentro de um `TStringList.Text` é frágil. O texto final das três é idêntico ao anterior.

A lista de mensagens ficou na unit do monitor, não em `untTravaCaixa` — a política
"isto não polui a LOGERR" é do faturador automático; a trava de caixa não tem por que
saber que existe um robô. O vínculo é pela constante, então o compilador cobra se
alguém renomear.

### Pendente

Compilação (autcom e serviço Linux) e validação conjunta com o João — combinado na
sessão. Nada foi compilado nem executado.

## 16/09/2026 — a solução de ontem foi descartada

### O que o João viu

*"A função `TFatVendaBase.fCaixaJaFoiFechado` é chamada dentro da gravação; não seria
melhor lá no faturador chamar a validação antes de tentar mandar gravar, como já faz
com outras validações?"*

Está certo, e por um motivo mais forte do que a economia de código. `pExecute` já trata
`EAbort` separadamente, **antes** do `On E: Exception`:

```pascal
On E: EAbort Do
  Raise;
```

Ou seja: **validação prévia com `Abort` já é o mecanismo que o faturador tem para dizer
"isto não é erro"**, e ele já não grava na LOGERR. `TFaturadorBase.Validar` e
`ValidarFaturamento` usam esse padrão para todas as outras validações. A trava de caixa
era a exceção, não a regra.

De quebra o `Raise` do `EAbort` sai do `For LTentativa := 1 To 5`, resolvendo as cinco
retentativas inúteis que eu tinha classificado como fora de escopo.

A guarda textual de ontem (`fImpedimentoRotineiro`) era um remendo do lado errado:
filtrava o log em vez de corrigir por que a informação chegava genérica. Revertida por
inteiro, junto com a extração de `MSG_CAIXA_FECHADO_OU_ANTERIOR_EM_ABERTO`, que só
existia para servir a comparação de texto.

### Quatro verificações que poderiam ter derrubado a ideia

Antecipar validação só é seguro se o estado avaliado for o mesmo nos dois momentos.
Cada uma destas, se fosse negativa, teria causado regressão:

| Verificação | Resultado |
|---|---|
| `blnExecutandoFaturadorAutomatico` já ligado ao validar? | Sim — `SetarVariaveisAposCarregarPedido` (`TFaturador.Base.pas:509`) roda dentro de `CarregarDocumento`. **Se fosse não**, pedido com adiantamento passaria a ser bloqueado indevidamente |
| `fltValAdt` já calculado? | Sim — `CalcularTotais` também roda em `CarregarDocumento` |
| `strCodigoCaixa` difere entre validar e gravar? | Não no robô. Quem o preenche é `fPedeDadosDoCaixa`, chamado só pelas telas (`untFatVendas.pas:43975`, `untFatExpedicaoItens.pas:6543`). No faturador fica vazio nos dois momentos — e `TTravaCaixa` usa vazio para decidir entre `SQL_CAIXA` e `SQL_CAIXAS`, então não fosse assim a prévia avaliaria outra regra |
| A mensagem continua chegando ao `FAT_LOGMSG`? | Sim — `pMensagemOk` alimenta `VS_OnMensagemAoUsuario` nos dois SOs (`untFuncoesSimples.pas:6718` → `fMensagem`; `Shared.Core.pas:487` direto) |

### Por que a condição foi extraída

O call site de `fGravaArquivos` não é `fCaixaJaFoiFechado` sozinho: é
`fCaixaJaFoiFechado And (Not fPermiteFaturamentoComCaixaFechado)`. E
`fPermiteFaturamentoComCaixaFechado` encadeia três exceções — expedição à vista,
entrega futura e **faturador automático com adiantamento**. Replicar essa composição na
validação prévia criaria duas cópias da mesma regra em pontos distantes, que é
precisamente como se produz divergência silenciosa.

Extraída para `fTravaDeCaixaImpedeFaturamento`, usada nos dois pontos.

### Alcance maior do que parecia

`ValidarFaturamento` não é exclusivo do robô: serve também autoatendimento PagueFácil e
os dois desmembramentos (PIX e link de pagamento). Nenhuma tela manual passa por ele —
as telas gravam por outro caminho. Como a condição avaliada é a mesma, o desfecho não
muda para nenhum dos quatro; muda só o momento. Mas os três consumidores além do robô
entraram nos critérios de aceitação: não dá para afirmar que estão cobertos só porque a
lógica é idêntica.

Foi cogitado condicionar a validação a `blnFaturadorAutomatico` para risco zero fora do
robô. Descartado: criaria um caminho por consumidor, que é como `fGravaArquivos` chegou
a 7.667 linhas.

### Comentário errado que escrevi e corrigi

Na declaração de `fTravaDeCaixaImpedeFaturamento` escrevi *"AMensagem só é preenchida
quando o resultado é True"*. Falso: se o caixa está fechado mas há permissão, o
resultado é `False` e `AMensagem` já veio preenchida por `fCaixaJaFoiFechado`. Removido
em vez de reescrito — a assinatura já diz o suficiente.

### Pendente

Compilação (autcom e serviço Linux) e validação conjunta. Nada foi compilado nem
executado.

## 16/09/2026 — propagação para as 5 versões

Aplicado em todas: `150` (original), `150.100`, `111`, `111.184`, `150.45`.

### Um erro meu que quase virou decisão errada

O primeiro applyPatch falhou em três das quatro versões e eu reportei a causa como
*"`fPermiteFaturamentoComCaixaFechado` não existe nessas versões — arquitetura
diferente, requisito pode não se aplicar"*.

**Estava errado.** Eu havia procurado a função apenas dentro de
`Faturamento.Classes.TFatVendaBase.pas`, porque era lá que ela estava na versão em que
trabalhei. Nas versões mais antigas ela mora em `untFuncFat.pas`, classe `TFatVenda` —
com o corpo idêntico, as mesmas três exceções e o mesmo call site composto, byte a byte.

O que salvou foi o João pedir a investigação (opção 1) em vez de aceitar a opção 3
("aplicar só onde a base existe"), que eu havia apresentado como alternativa legítima.
Se ele tivesse escolhido a 3, três versões ficariam sem a correção por causa de um grep
mal escopado.

**Lição:** "função X não existe nesta versão" exige busca no módulo inteiro, não no
arquivo homólogo. Código legado migra de unit entre gerações sem mudar de conteúdo.

### Duas gerações, uma correção

| | 150, 150.100 | 111, 111.184, 150.45 |
|---|---|---|
| Classe | `TFatVendaBase` | `TFatVenda` |
| Arquivo | `Faturamento.Classes.TFatVendaBase.pas` (~136k linhas) | `untFuncFat.pas` |
| Robô | `Faturamento.Classes.TFaturamentoAutomatico.pas`, `TFaturamentoAutomaticoMonitor` | `untTFaturamentoAutomatico.pas`, `TFaturamentoAutomatico` |

Idêntico nas duas: condição composta, três exceções, `CarregarDocumento →
ValidarFaturamento → GravarFaturamento`, `On E: EAbort Do Raise` antes do
`On E: Exception`, e `pGravarErro` na 5ª tentativa.

O hunk que de fato divergiu foi só um: `ValidarFaturamento` nas antigas tem corpo curto
(sem `VALIDAR_ESTOQUE`). Não era divergência de arquitetura — era o corpo mais enxuto.

### Verificações refeitas por geração

As quatro checagens de risco foram repetidas nas versões antigas, não presumidas:
`blnExecutandoFaturadorAutomatico` setado dentro de `CarregarDocumento` (111:196,
150.45:271); `fltTotGer` carregado por `pCarregarClientePedidoOrcamento` e `fltValAdt`
logo depois, ambos dentro de `fCarregarPedido`; `EAbort` tratado à parte no robô.

### Divergência pré-existente que muda o teste

`fPermiteFaturamentoAutomaticoComCaixaFechado` não é igual entre as gerações: nas novas
basta `fltValAdt > 0.00`, nas antigas exige `fltValAdt >= fltTotGer` (adiantamento
total). Nenhuma foi alterada — registrado no spec para que o critério 4 use o caso certo
em cada versão.

