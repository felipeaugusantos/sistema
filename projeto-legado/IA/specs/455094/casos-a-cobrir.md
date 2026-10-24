# Req. 455094 — contrato das rotas e casos a cobrir

Entregue por quem implementou. **Os casos de teste em si são escritos pelo analista** — o que está
aqui é o contrato das três rotas e a lista do que precisa ser coberto, com o que preparar, o que
executar e o que conferir em cada item.

Origem dos itens: seção 6 da `spec.md`. Numeração idêntica, para os dois documentos poderem ser
lidos lado a lado.

---

## 1. Contrato

Todas as rotas exigem JWT (`MVCRequiresAuthentication`) e o header `Empresa`.

### 1.1 `POST /cotacao/exportacao/gerar`

Enfileira e responde **202 em milissegundos**. Não gera nada durante a requisição.

**Headers:** `Empresa` (obrigatório), `OperadorLogado` (obrigatório, código de `CADOPE.OPE_CODOPE`).

**Corpo:**

| Campo | Tipo | Obrigatório | Observação |
|---|---|---|---|
| `sequencialCotacao` | string | sim | `AUTOINCREM` da capa em **COTGER** — tabela oficial, não o rascunho `COTGER_RES` |
| `fornecedores` | array de string | sim | Um arquivo por código. Lista vazia é recusada com 400 |
| `enviarEmail` | boolean | não | Falso por omissão |
| `destinatarios` | array de string | não | Substituem os e-mails do cadastro. Vazio usa os do fornecedor |
| `opcoes` | objeto | não | Ausente equivale a todos os booleanos falsos |

**`opcoes`** — doze booleanos, todos opcionais, todos falsos por omissão:

`exibirAplicacaoProduto`, `exibirMensagemLivre`, `todosOsItens`, `exibirMarca`,
`exibirSemelhantes`, `exibirCNA`, `exibirReferencia`, `similaresAgrupados`,
`exibirCodigosFabrica`, `exibirCodigosFabricaFornecedor`, `exportarSemPreco`, `embalagemCompra`.

Os dez primeiros espelham, na ordem, os booleanos de `pExportarExcelNovo` no autcom. `todosOsItens`
falso exporta só os itens relacionados àquele fornecedor; verdadeiro exporta todos.
`exportarSemPreco` zera preço unitário e total. `embalagemCompra` verdadeiro usa a unidade de
compra, falso a de venda.

**Respostas:**

| Código | Corpo | O que dispara |
|---|---|---|
| 202 | `{ "idProcessamento": "..." }` | Aceito e enfileirado |
| 400 | mensagem | `OperadorLogado` ausente ou inexistente em `CADOPE`; `sequencialCotacao` vazio; `fornecedores` vazio; cotação inexistente na empresa |
| 401 | — | JWT ausente ou inválido |
| 409 | mensagem | Já existe exportação em andamento para a **mesma cotação** |
| 429 | mensagem | Teto de exportações simultâneas atingido (`CFGSIS` `EXPMAX`, default 3) |

### 1.2 `GET /cotacao/exportacao/{idProcessamento}`

**Resposta 200 — a forma é a do Req. 459763**, que padronizou o JSON de status dos endpoints
assíncronos deste serviço para o frontend ter um parser só. Alinhado em 04/09/2026, antes de existir
consumidor; o desenho anterior deste requisito tinha `etapa` como string, `progresso` como irmão
dela e campos vazios em vez de nulos.

| Campo | Tipo | Observação |
|---|---|---|
| `status` | string | `PENDENTE`, `PROCESSANDO`, `CONCLUIDO` ou `ERRO` |
| `etapa` | objeto | `null` enquanto `PENDENTE` e em `CONCLUIDO`. Ver abaixo |
| `dataInicio` / `dataFim` | string | ISO 8601. `null` enquanto não houver — nunca `""` |
| `qtdItensGerados` | inteiro | Planilhas geradas. Só em `CONCLUIDO`, onde **zero é valor válido**. `null` nos demais |
| `mensagem` | string | Em `CONCLUIDO`, o desfecho; em `ERRO`, a causa. `null` nos demais |
| `fornecedores` | array | Um item por fornecedor pedido; preenchido em `CONCLUIDO`. **Único acréscimo ao envelope** — o giro não tem análogo |

**Objeto `etapa`:** `numero`, `totalEtapas`, `descricao`, `progresso`.

`numero` e `totalEtapas` são **sempre `null` na exportação**. O giro tem catálogo fechado de oito
etapas; aqui o trabalho é um laço por fornecedor, e o que há de mensurável é a posição nesse laço —
que é o `progresso`, não a sequência. Os campos existem para a forma ser a mesma.

`progresso` é `{posicao, total, percentual}`, contado em **fornecedores**, e é `null` quando não há
medição. Objeto zerado seria indistinguível de "parado no começo".

**Não existe mais `idProcessamento` no corpo** — o consumidor acabou de informá-lo na URL. Ele
permanece na resposta do POST, que é onde tem função.

**Diferença entre `CONCLUIDO` e `ERRO` na etapa:** em `CONCLUIDO` ela vira `null` inteira, porque
sem sequência publicada sobraria um objeto de quatro campos nulos. Em `ERRO` ela fica **intacta** —
`descricao` e `progresso` mostram onde travou.

**Item de `fornecedores`:** `codigoFornecedor`, `nomeFornecedor`, `arquivoGerado` (boolean),
`quantidadeItens` (inteiro), `emailEnviado` (boolean), `destinatario`, `mensagem`.

`arquivoGerado` e `emailEnviado` são **independentes**: planilha pronta com e-mail falho é estado
real e esperado.

**404** quando o identificador não existe, é de outra empresa, ou é de uma tarefa que não é de
exportação.

### 1.3 `GET /cotacao/exportacao/{idProcessamento}/{codigoFornecedor}`

Devolve o arquivo. `Content-Type:
application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`, `Content-Disposition:
attachment`, nome no padrão `COT<numero>_<empresa>_<fornecedor>.xlsx`.

**404** em quatro casos, com mensagens que os distinguem: identificador inexistente ou de outra
empresa; fornecedor fora da lista daquele processamento; retenção vencida; geração daquele
fornecedor falhou.

Disponível por **48 horas** após a geração.

---

## 2. Casos a cobrir

**Legenda:** *Auto* = cabe na suíte automatizada do projeto. *Manual* = precisa de roteiro humano,
por exigir reinício de serviço, matar processo, medir tempo ou abrir arquivo em aplicativo.

### Fluxo principal

**01 — POST responde 202 em milissegundos.** *Auto.*
Preparar: cotação com pelo menos um fornecedor. Executar: POST válido. Conferir: 202, corpo com
`idProcessamento` não vazio, e que a resposta não demorou o tempo da geração.

**02 — GET acompanha do início ao fim.** *Auto.*
Executar: GET logo após o POST, e de novo após a conclusão. Conferir: primeiro `PENDENTE` ou
`PROCESSANDO`; ao final `CONCLUIDO`, com **um item em `fornecedores` por fornecedor pedido**.

Conferir também o que o Req. 459763 tornou contrato, porque é onde a implementação erra calado:
em `PENDENTE`, `etapa` é `null` e não objeto zerado; em `CONCLUIDO`, `etapa` é `null` e
`qtdItensGerados` traz a contagem — **zero é valor válido ali**, e distingui-lo de `null` é a razão
de existir daquele requisito.

**03 — N fornecedores, N arquivos.** *Auto* para nome e contagem, *Manual* para o conteúdo.
Preparar: cotação com pelo menos três fornecedores, com preços diferentes entre eles. Conferir: três
arquivos, nomes no padrão do autcom, e **cada um só com os itens e preços do seu fornecedor**.

Este é o caso que pega a falha mais provável: se o `AfterScroll` do dataset não estiver instalado, a
planilha sai com o preço de um item só repetido em todas as linhas, sem erro nenhum.

**04 — Equivalência com a tela.** *Manual.*
Exportar o **mesmo** fornecedor da **mesma** cotação pelos dois caminhos, com as mesmas opções.
Conferir: mesmos itens, mesma ordem, mesmos valores, mesmas colunas, mesmo cabeçalho.
**Divergência só de largura de coluna não reprova** — a largura é estimada no Linux, onde não há
como medir texto em tela (RN15).

**05 — Download abre.** *Manual.*
Conferir: o arquivo baixa e abre no Excel e no LibreOffice.

**06 — Download recusado.** *Auto.*
Executar: download de fornecedor fora da lista do processamento, e de identificador inexistente.
Conferir: 404 nos dois, com mensagem clara — não erro genérico.

### E-mail

**07 — Envio pedido no POST.** *Manual* (precisa de caixa real).
Conferir: cada fornecedor recebe a mensagem com **sua** planilha anexada, e o GET reflete
`emailEnviado`.

**08 — Falha de envio isolada.** *Auto* se der para forçar a falha; *Manual* caso contrário.
Preparar: um fornecedor sem e-mail cadastrado, junto de outros com e-mail. Conferir: a tarefa
**não** termina em erro; os bons aparecem com `emailEnviado: true`, o ruim com `false` e a razão em
`mensagem`; e `arquivoGerado` continua `true` para todos.

**09 — Precedência dos destinatários.** *Manual.*
Com `destinatarios` preenchido, o e-mail vai **para eles e não para os fornecedores**. Sem ele, vai
para os do cadastro. Os dois conjuntos nunca se misturam.

**19 — `EMACOT` gravada como no autcom.** *Auto.*
Conferir: linha em `EMACOT` após envio bem-sucedido, e a mensagem aparecendo na consulta de
mensagens do autcom.

Ponto de atenção: a gravação depende de `strSeqGerOriginal` estar preenchido. Se esse caso falhar
com o envio funcionando, é aí que se olha primeiro.

### Assíncrono, concorrência e falha

**10 — Exportação longa não sofre timeout.** *Manual.*
Preparar: cotação grande o bastante para passar de 120 segundos. Conferir: conclui normalmente.

**11 — Reinício do serviço não interrompe.** *Manual.*
Reiniciar a API com uma exportação em andamento. Conferir: a exportação conclui — ela roda em
processo separado.

**12 — Processo morto vira órfã.** *Manual.*
Matar o processo à força. Conferir: a tarefa é detectada como órfã, o GET passa a responder `ERRO`,
uma notificação de erro é gerada, e a cotação fica liberada para nova exportação **sem intervenção
manual**. A detecção acontece no POST seguinte.

**13 — Segundo POST na mesma cotação.** *Auto.*
Conferir: 409 enquanto o primeiro está em andamento.

**14 — Teto de simultâneos.** *Manual* (precisa de N processos vivos ao mesmo tempo).
Conferir: 429, **sem disparar processo**.

**15 — Outras rotas não degradam.** *Manual.*
Durante uma exportação, `/pedido-compra/calcular-impostos`, `/pedido-compra/pdf` e `/cotacao/giro/*`
respondem no tempo normal.

**16 — Falha no meio da geração.** *Auto* se der para forçar.
Conferir: GET responde `ERRO` com a mensagem da exceção — **não** `CONCLUIDO` com zero arquivos.

Implementado em 04/09/2026 como guarda explícita no fim do laço: `arquivos = 0` com pelo menos um
fornecedor pedido levanta `ECotacaoExportacaoSemArquivo`, e a mensagem carrega a **primeira** falha
do laço — levantar descarta o resultado parcial, então a razão precisa viajar no texto.

Sucesso **parcial** continua sucesso, e isso é a RN03: o `try` por fornecedor existe para que a
falha de um não custe os outros. O que a guarda impede é a tarefa chamar de concluído aquilo em que
nada foi produzido — um GET que responde `CONCLUIDO` é lido como "deu certo", e obrigar o consumidor
a somar o array para descobrir o contrário é armadilha.

**18 — Operador inválido.** *Auto.*
Header ausente, e header com código inexistente em `CADOPE`. Conferir: 400 nos dois, **antes** de
disparar o processo — nenhuma linha nova em `SSATSK`.

### Notificação e retenção

**17 — Linha em `MENREP`.** *Auto.*
Conferir: `MEN_CODOPE` igual ao header `OperadorLogado`, `MEN_WORKID` igual ao `idProcessamento`,
`MEN_NUMDOC` igual a `COT_` + sequencial, `MEN_LIDA__` = `'N'`, `MEN_DTALEI` nulo.

`MEN_MENSAG` cita o **número** da cotação (`COTGER.COT_NUMCOT`) e a quantidade de planilhas — o
número, e não a descrição, porque a descrição da cotação oficial costuma ser texto gerado que não
identifica nada. O giro usa a descrição porque rascunho não tem número. Sem o identificador no
texto, duas exportações rendem avisos indistinguíveis na tela do REPOR+, que foi o defeito que o
Req. 459763 corrigiu no giro.

**20 — Retenção vencida.** *Manual* (48 horas, ou adiantar o relógio do arquivo).
Conferir: o diretório não existe mais e o download responde 404 com mensagem clara.

### Formato do arquivo

**21 — Swagger declara XLSX.** *Auto* (inspeção do JSON do Swagger).
Conferir: o MIME declarado é `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`.

**22 — Comportamento no Microsoft Excel.** *Manual, e obrigatório.*
Conferir, na planilha **real** gerada pela API:

- abre sem aviso de formato ou de arquivo corrompido;
- código e descrição **recusam** edição;
- preço e IPI **aceitam**;
- valor fora da faixa é recusado, com a mensagem declarada;
- desproteger pede a senha;
- célula travada continua **selecionável e copiável**.

Este caso não foi coberto no desenvolvimento: **não há Excel na máquina onde o requisito foi
implementado**, e a verificação do formato foi feita só no LibreOffice. É o maior risco residual da
entrega.

**23 — O mesmo, no LibreOffice Calc.** *Manual.*
Foi verificado em 31/08/2026 sobre um arquivo de amostra. Repetir sobre a planilha real, que tem
colunas, larguras e volume de linhas que a amostra não tinha.

**24 — Caractere especial na descrição.** *Auto.*
Preparar: item cuja descrição contenha `&`, `<` ou `>`. Conferir: a planilha abre normalmente e o
caractere aparece na célula.

Falha aqui produz **arquivo corrompido**, não célula errada — o `.xlsx` é XML, e um `&` sem escape
quebra o documento inteiro.

---

## 3. O que a suíte automatizada consegue afirmar

A suíte do projeto afirma **resposta e estado de banco**. Para os casos de 202, o assert de banco é
o que dá valor ao teste: a resposta 202 só diz que a tarefa foi aceita.

Tabelas com assert por caso:

| Caso | Tabelas |
|---|---|
| 01, 18 | `SSATSK` |
| 02, 16 | `SSATSK` |
| 07, 19 | `SSATSK`, `EMACOT` |
| 17 | `SSATSK`, `MENREP` |

**Usar `pTesteMontarJsonTabela`, um bloco por tabela** — não JSON montado à mão. O helper lista as
colunas pelo `information_schema`, então coluna nova entra no dump sozinha, e o teste não passa a
mentir quando a tabela cresce.

Duas colunas de `SSATSK` merecem assert explícito nos casos de conclusão: `SST_SUCESS` e
`SST_TYPERR`. O status que o GET devolve é **derivado** delas junto com `SST_DTAINI` e `SST_DTAFIN`,
e é a combinação — não `SST_SUCESS` sozinho — que distingue tarefa concluída de tarefa cujo disparo
falhou.
