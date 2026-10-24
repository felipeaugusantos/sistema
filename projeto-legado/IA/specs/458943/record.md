# Retrospectiva — Req. 458943

Estorno de duplicatas recebidas: endpoint REST compartilhando a regra com a tela.

Sessões de 28/08/2026 a 03/09/2026.

---

## 1. Onde está

| Fase | Estado |
|---|---|
| 1 — Inventário | concluída |
| 2 — Classes compartilhadas | concluída, **compila no Windows** |
| 3 — Desktop | concluída, compila; **validada na tela em 03/09** |
| 4 — Serviço e API | escrita; **nunca compilada para Linux** |
| 5 — Testes | não iniciada |
| 6 — Revisão e commit | não iniciada |

**Nada foi commitado ainda.** Arquivos novos precisam de `svn add`.

### Arquivos

**Criados** (`padra_atualizado/fontes/financeiro/contasareceber/`):
`Financeiro.ContasReceber.EstornoTypes.pas`, `.ValidacaoEstorno.pas`,
`.DevolucaoPix.pas`, `.FiltroEstorno.pas`, `.EstornoDuplicatas.pas`

**Criados** (`padra_atualizado/Services/`):
`Core/financeiro/services/types/Financeiro.Services.Cobranca.Estorno.Types.pas`,
`Core/financeiro/services/Financeiro.Services.Cobranca.Estorno.pas`,
`Financeiro.Services.API/Source/api/controller/api.controller.cobranca.estorno.pas`

**Alterados:** `untEstornoReceber.pas` (8.693 → 3.416 linhas, −61%),
`untBaixaReceber.pas` (só formatação), `untCfgRepositorio.pas` (+4 linhas),
`autcom.dpr`, `Financeiro.Services.Workers.pas`, `FinanceiroServicesAPI.dpr`

---

## 2. Decisões que não estão no spec

### Padrão A (classe + record), decidido por medição

A escolha entre "classe + record de parâmetros" (`BaixaDuplicatas`) e
"Controller + View headless" (`untRcxDigCartoesController`) foi feita contando
pontos de UI no código **pré-extração**: `fMensagem` + `pMensagemOk` +
`pEmitirMensagem` + `pSetFocus` + `ShowModal` + `pCriarFormularios`.

- `untBaixaReceber` (antes da extração dele): **231**
- `untEstornoReceber`: **138**

A contagem inverteu minha recomendação inicial, que era Padrão B. O estorno tem
menos UI entranhada do que a baixa tinha, e a baixa foi extraída com sucesso no
Padrão A — logo o estorno também cabe.

### Escopo: só cartão e PIX, decidido por evidência no banco

- `CTR_CREDIT` é **zero nas 98.484 baixas** da base — a coluna não é usada.
- `untCadRec.pas:1711` compara o valor do crédito contra `CTR_DINHEI`.
- `TBaixaMovimentos` (endpoint de baixa) só expõe `cartao`.

Conclusão: **`CTR_DINHEI` numa baixa criada pelo endpoint é sempre crédito**, e
`CTR_ORDPAG` é onde o PIX cai (`untEstornoReceber.pas:881` rotula ORDPAG como
"Pix" quando `RECPIX='S'`). Por isso a RN02 recusa **só cheque** — recusar
dinheiro ou ordem de pagamento cortaria justamente o que o endpoint baixa.

> Erro meu no caminho: contei baixas mistas em 51% antes de qualificar por
> `CTR_RECPIX`. O número real é 24%.

---

## 3. Achados que mudaram o rumo

### 3.1 `pSelecionaDuplicata` escondia 9 validações de negócio

Parecia UI — é o handler que marca linhas no grid. Mas roda uma camada inteira
de validação **enquanto** o operador marca. No serviço as duplicatas chegam todas
marcadas de uma vez, então nenhuma rodaria: o endpoint estornaria título
conciliado, título com Pix ativo e parcial fora de ordem, **em silêncio**.

Virou `TValidacaoEstorno.fValidarDuplicatas` e **RN11**.

Detalhe: `DuplicataCreditoEmAbertoPossuiChavePix` e
`DuplicataEmAbertoDaParcialPossuiChavePix` abriam com
`If CTR_MARDES = 'M' Then Exit` porque rodavam *antes* da marcação. Mantido o
guarda, virariam código morto no caminho headless. Ele saiu.

### 3.2 `FiltroEstorno` era órfã **e** porte parcial

Encontrado pelo requisitante: *"o estorno não vai usar a class de filtro?"*.

Duas coisas erradas ao mesmo tempo: a classe não tinha consumidor (a tela seguia
no `pCriaTemporaria`), e faltavam nela ~400 linhas — fallback `MOVGER` →
`CTR_SEQFCO`, `pCarregaDadosCredito`, `fTabelaCredito`,
`RegistroCreditoAdiantamentoEstornado`, `FiltroPossuiBaixaDeDuplicatasComTotalEParcial`.

**A consequência era invertida:** não era a tela que ficaria com regra própria,
era o **serviço** que carregaria menos duplicatas do que a tela.

### 3.3 Regressão de dado: 47 literais perderam acento

Comparando os literais das classes com o form original, 47 tinham perdido
acentuação na extração — e vários são **gravados em banco**, não exibidos:
`CRÉDITO GERADO POR ESTORNO DE RECEBIMENTO PIX` (histórico da duplicata),
`ESTORNO DE VÍNCULO CC -` (LOGMCA), `EXCLUSÃO - ESTORNO RECEBER` (LOGMPX),
`INCLUSÃO`, `ALTERAÇÃO DE ESTORNO`.

Eu tinha tratado certo o caso de *comparação* (`CRÉDITO CONSIG`) e deixado cair
nos valores *gravados*. Restaurados usando o form pré-extração como fonte da
verdade.

> A validação de 03/09 confirmou a correção: o log gravou `ALTERAÇÃO DE ESTORNO LD`
> **com acento**.

### 3.4 `fTipDtaEstBai` era `ShowModal`, não regra

O `plan.md` §4 a listava como "função genérica de negócio a portar para Linux".
`untFuncoesSimples.pas:40631` abre `TfrmDtaEstorno`.

Levou à **RN12**: a decisão de data saiu inteira do motor. Não só o diálogo — as
três etapas da origem (direitos `DTAOER`/`DTESTR`, `CFG_RDTEMB`, diálogo) são
inseparáveis e foram todas para o chamador. O endpoint sempre usa a data do dia,
que é o que a origem já fazia no caminho `blnEstornoAutomatico`.

### 3.5 As "10 genéricas Linux" não existiam

O `plan.md` §4 estimava ~414 linhas em `untFuncoesGenerica`/`untFuncoesSimples`/
`untFuncoes`, pelo precedente do Req. 454631. **Nenhuma linha dessas units foi
tocada.** Cinco vieram para `ValidacaoEstorno` só no ramo `CADREC`, duas foram
absorvidas, uma (`pGeraLogLiberacao`) já era wrapper de uma função que existe nas
duas plataformas, e `fTipDtaEstBai` era diálogo.

---

## 4. Armadilhas do código-fonte

Coisas que quebram em silêncio se ignoradas.

| Armadilha | Onde |
|---|---|
| `Pos('CRÉDITO CONSIG', CTR_HIST01)` compara contra texto gravado **acentuado** por `Faturamento.Classes.TFatVendaBase:129819`. Sem acento, o ramo do crédito consignado nunca casa e cai em `pEstornaDuplicataSimples` no lugar de `pEstornaDuplicataParcial` | `EstornoDuplicatas` |
| `UNION` e **não** `UNION ALL` em dois pontos — a origem marca isso em caixa alta | `fTabelaCredito`, `MontarSelectDuplicatas` |
| `CTR_DTAREC` **não** é copiado no `pCarregaDadosCredito` — a origem tem a linha comentada; preencher marcaria o crédito como recebido | `FiltroEstorno.CarregarDadosDeCredito` |
| `fncExecutaRelatorio(180, 7438, …)` é impressão, não validação. Não foi para a classe; o wrapper de `fVerificaDocumentosBaixados` no form **precisa** continuar chamando | `untEstornoReceber` |
| `ORDER BY ORDBAI` = `999 - CTR_SEQBAI`: estorna parcial da última baixa para trás. Confirmado na validação de 03/09 (5→4→3→2→1) | `MontarSelectDuplicatas` |
| No serviço, `fCriaQuery` devolve **`IQuery`**, não `TUniQuery` — funções homônimas de units diferentes. O lado serviço usa `fCriarQuery(SQL)` + `PrepareQueryFinalSQL` + `TUniQuery(GetObject)` | `Financeiro.Services.*` |
| Unit que chama `fCriaQuery` e roda no Linux precisa de `Shared.Core` no ramo `{$IFDEF LINUX}`, senão pega a versão `IQuery` | as 5 classes |

---

## 5. Armadilhas de ferramenta

Errei o mesmo tipo de coisa quatro vezes ao editar Pascal com regex. Vale para
quem continuar.

1. **`re.I` obrigatório.** O arquivo mistura `function`/`Function` e
   `procedure`/`Procedure`. Sem o flag, o span de um método deu 510 linhas em vez
   de 36 e **engolia outros três métodos vivos**.
2. **`class procedure` existe.** Um único caso em 111 cabeçalhos
   (`pEstornoReceberAutomatico`). A regex sem `(?:class\s+)?` não o reconheceu
   como fronteira e ele foi engolido → `E2065`.
3. **`;` separa parâmetros.** Cortar a declaração no primeiro `;` deixa a cauda
   da assinatura órfã, que o compilador lê como campo → `E2169` + `E2004`.
   Precisa contar profundidade de parênteses.
4. **O span do último método do arquivo** vai até o fim do texto e leva o `end.`
   da unit junto.

**A lição maior:** meu verificador usava a *mesma* regex incompleta que a
ferramenta. `68 implementações / 68 declarações` dava certo porque o símbolo
sumia dos dois lados e o descasamento se cancelava. **Verificador e ferramenta
com o mesmo ponto cego não verificam nada** — o verificador precisa de caminho
independente. E antes de varrer Pascal com regex, **enumerar as formas reais no
arquivo** (`grep -oiE`) em vez de assumir.

Outras, menores:
- A ferramenta de escrita gera **LF**; fonte Delphi exige CRLF. Converter sempre.
- Heredoc do bash destrói `\n` dentro de literal Python. Escrever script em
  arquivo, não em heredoc.
- `dcc32 -M` entra em laço na referência circular `untFuncoesSimples` ↔
  `untMsgLiberacao` (gerou log de 3,6 GB). Não usar `-M`.

---

## 6. Defeitos da origem corrigidos

Sem mudar comportamento pretendido.

- **12 vazamentos de memória**, todos o mesmo padrão: objeto criado dentro do
  laço e liberado fora, ou liberado só no caminho feliz com `Except` re-raise.
- **11 acumuladores somados sem inicialização** em `fEstornaDuplicataConjugadas`
  (`fltValDin`, `fltValCar`, `fltChqVis`, `fltChqPre`, `fltOrdRec`, `fltValFin`,
  `fltTotGua`, `fltTotDol`, `fltTotEur`, `fltTotPes`, `fltTotRea`). Variável
  local do Delphi não é zerada — o valor de partida era lixo de pilha.
- **`cdsAux` e `stlConjugadas` vazavam** em todo `Exit` antecipado.
- **10+ SQL por concatenação** parametrizados. Só 4 apareceram na varredura de
  linha única da Fase 1; o resto era multi-linha. Um deles (`fDocsBaixaComLCK`)
  era trava de pre-commit e foi corrigido de brinde ao delegar.

---

## 7. Divergências assumidas tela × API

| RN | Divergência |
|---|---|
| RN08 | Com `CFG_RMOTES` ligado, a tela grava a ocorrência do estorno; a API grava `CTR_MOTEST` em branco. Consultas por ocorrência não enxergarão estornos da API |
| RN12 | Com `CFG_RDTEMB = 2`, a tela grava com a data do documento; a API grava com a data do dia |
| — | `fBloquearEstornoPedidoJaFaturado` é `{$IFNDEF LINUX}` (depende de `TAdiantamento`). Vale para espécie `PD`, que **está** no escopo — o serviço não tem essa validação |
| — | `fValidaEstornoAdiantamento` fica no form (usa `fGetMenu`). Não é divergência: adiantamento é recusado pela RN02 |

**Comunicar ao suporte** as duas primeiras antes de liberar.

---

## 8. Riscos abertos

0. **`LINK_PAGAMENTO` não existe no serviço — divergência funcional a comunicar.**
   Pelo endpoint, uma duplicata com link de pagamento ativo **não é recusada**;
   a tela recusa. Consequência prática: o link de um título estornado pela API
   continua pagável. Motivo e como fechar em §8.9. Vai para o suporte junto das
   divergências da §7.

1. ~~Nada foi compilado para Linux.~~ **RESOLVIDO em 03/09** — build `Success`,
   ver §8.11. Os suspeitos que eu listava (`TUniClientDataSet` no ramo Linux,
   `fCriaClientDatset`, `CarregarDadosDeCredito`) **não deram um erro sequer**;
   os problemas vieram todos de dependências Windows-only do legado.
2. **PIX não foi validado.** A rodada de 03/09 teve `CTR_RECPIX = 'N'` nas cinco
   parciais. Devolução automática, geração de crédito e `CFG_PCTRPX` continuam
   sem prova.
3. **`CTB_ORILAN` sem prova.** Estava nulo antes do estorno (baixa feita pelo
   endpoint), então não dá para distinguir "foi limpo por
   `LimparOrigemPrincipalSeqlan`" de "nunca foi preenchido".
4. **Modo caixa, adiantamento, vale-presente e contas a pagar** — fora do escopo
   do endpoint, mas a tela os usa e a extração pode tê-los quebrado. Sem
   validação ainda.
5. **`untBaixaReceber.pas` entrou no diff** só por formatação (remoção de espaço
   antes do ponto, a pedido). É de outro requisito — considerar deixar fora do
   commit.
6. **Timeout da devolução de Pix — encerrado, não é risco.** Pior caso no
   endpoint é 28 s contra 120 s de teto, porque a baixa que chega aqui tem
   sempre um único Pix (§8.1). O que sobra é comportamento conhecido do
   manager, não desta entrega: no timeout o worker não é cancelado.

### 8.1 A conta do timeout — medida em 03/09/2026

O teto é de **120 s**, em `Services.Core.Worker.pas:1098`
(`If SecondsBetween(fNow, LStart) >= 120`). O relógio começa **antes** do
`DispatchTask`, e o `DispatchTask` sozinho pode gastar até 60 s esperando um
worker livre — então o orçamento real para o trabalho pode cair para ~60 s.

O gasto da devolução, por registro da `MOVPIX`
(`TDevolucaoPix.SolicitarDevolucaoDoPix`, laço de 4 tentativas):

| Chave | Espera por tentativa | Pior caso de espera | Chamadas REST |
|-------|---------------------|---------------------|---------------|
| Shipay ou Pix SCP | 7 s | 28 s | 6 |
| Demais | 3 s | 12 s | 6 |

`ApagaRegistroPix` chama isso **uma vez por registro da MOVPIX**, em laço. O
filtro é `MPX_SEQCON + MPX_CODEMP + MPX_DTAREC` — exatamente o de
`fCarregarRegistrosPix`, então a medição abaixo é o que a função devolve, não
uma aproximação.

**Quantos registros por baixa** (base `financeiro-dev`, 1.319 baixas com Pix):

| Registros Pix | Baixas | Alguma com Shipay | Pior caso |
|---------------|--------|-------------------|-----------|
| 1 | 1.303 (98,8 %) | 73 | 28 s |
| 2 | 15 | **nenhuma** | 24 s |
| 4 | 1 | **nenhuma** | 48 s |

**Conclusão: cabe, e no endpoint a conta é ainda menor.** O caso de 112 s
exigiria 4 registros *e* Shipay, e essas duas coisas nunca aparecem juntas — os
73 registros por Shipay estão todos em baixas de um único Pix. A espera só
acontece quando o banco não confirma de primeira; confirmando, são zero sleeps.

**Escopo fechado pelo requisitante em 03/09:** quem consome este endpoint cria
Pix exclusivamente pela API de Pix do projeto, que gera **um** Pix e o vincula.
No caminho do endpoint, portanto, `fCarregarRegistrosPix` devolve sempre um
registro, e o pior caso é **28 s** — as demais rotinas de geração de Pix não
alcançam esta rota. Consequência para os testes: não há caso de múltiplos Pix
na suíte do endpoint.

O laço de `ApagaRegistroPix` continua necessário mesmo assim, porque a classe é
compartilhada com a tela — e ali mais de um Pix por baixa existe e é legítimo:
a baixa `CTR_SEQCON` 60002451, empresa 006, é a duplicata `000000066707` de
R$ 361,05 paga em quatro Pix (51,05 + 100 + 60 + 150), abril/2026. São 16
baixas assim na `financeiro-dev`, sete delas em 2026. Não é código morto.

**O que continua valendo, independente da conta.** No timeout o `fExecuteTask`
grava `Timeout` no `_RESULT`, levanta exceção e devolve erro ao cliente — mas
**não cancela o worker**. O worker segue executando o estorno, e o cliente
recebe falha enquanto a operação pode estar sendo concluída. Isso vale para todo
endpoint do manager, inclusive a baixa do Req. 458327: não foi introduzido aqui
e não se corrige aqui — mexer nos 120 s afeta faturamento, suprimento e os
demais. Fica como comportamento conhecido do serviço, não como risco desta
entrega.

### 8.2 A conta de `MOVBAN` no assert de teste — 03/09/2026

A `008` filtra `MOVBAN` por duas vias: a chave da duplicata (`CTB_NUMDUP`,
`CTB_PARCEL`, `CTB_EMPDUP`) e o `CTB_SEQLAN` da `BANCTR`. A primeira via existe
porque a segunda deixa de funcionar se o estorno remover a linha da `BANCTR`.

Só que **`CTB_NUMDUP` não tem índice útil** — o `IDX_MOVBAN_74` começa por
`CTB_CODFOR`. Com um `OR` entre a chave e a subconsulta, o MySQL varre as 702 mil
linhas da tabela. Medido:

| Forma do filtro | Tempo |
|-----------------|-------|
| `(chave) OR (subconsulta)` | **7.711 ms** |
| `AUTOINCREM IN (... UNION ...)` | 10.634 ms — pior |
| `CTB_CODCLI = x AND ((chave) OR (subconsulta))` | **2 ms** |
| idem, com `OR CTB_CODCLI IS NULL` | 589 ms |

O prefixo por `CTB_CODCLI` usa o `IDX_MOVBAN_01` e vale 3.200× — e são três
consultas por caso de teste. **Não perde linha:** das 130.299 linhas de `MOVBAN`
alcançáveis pela `BANCTR`, zero têm `CTB_CODCLI` diferente do da `BANCTR`, e uma
única não tem `CTB_CODCLI` — um `TF CAIXA (ORD) PIX - TESTE PIX` da empresa 062
com `CTB_NUMDUP` vazio, que nenhuma das duas vias alcançaria.

Os totais também foram juntados numa passada só (`CASE WHEN` no lugar de três
`SELECT`).

### 8.3 A versão 1 da `008` só enxergava cartão — 03/09/2026

Escrevi a lista de tabelas do assert lendo o código do estorno. Um `grep` por
`INSERT`/`UPDATE`/`DELETE` em `EstornoDuplicatas.pas` acha **quatro** comandos:
dois `UPDATE MOVCAR`, um `UPDATE CADREC` e um `DELETE FROM CADREC`. Todo o resto
é gravado por `Post` de dataset, sem texto SQL para procurar.

O requisitante perguntou "só tá conferindo estorno de cartão?" e estava certo.

**O jeito certo é a `LOGREP`**, que registra todo comando de escrita com tabela,
hora e operador — o mesmo método que o cabeçalho da `004` já documentava, e que
eu não segui. Recorte: empresa 592, operador 998, 02/09/2026 entre 16:50:20 e
16:51:10 (a janela do estorno da baixa desmembrada em cinco modalidades).

Resultado: **14 tabelas**. A versão 1 tinha bloco para 8. Faltavam `CADCHQ`,
`LOGCHQ`, `DEL_CADCHQ`, `DEL_MOVCAR` e `BOLCTR` — e o `DEL_MOVCAR` é justamente
o que prova que a parcela de cartão *saiu*, não só mudou. O RESUMO também não
contava `MOVPIX`, `LOGMPX`, `LOGLIB`, `MOVOCO` nem `HISOCO`, o que reabria o
buraco de "linha a mais passa" nesses blocos.

Dois achados de chave que só a leitura do comando real dá:

- `CADCHQ` é apagada por **`CHQ_EMPRCX`**, não por `CHQ_CODEMP`. As duas colunas
  divergem em **46 linhas** nesta base — filtrar pela errada traz linha que ficou
  e perde linha que saiu.
- `BOLCTR` é **reapontada** de um `AUTOINCREM` de `CADREC` para outro, então a
  chave tem de unir `CADREC` e `DEL_CADREC`.

`CADVAL` aparece na `LOGREP` e ficou **fora** de propósito: são três linhas da
tela guardando o último valor dos próprios filtros, por operador. Estado de UI
num assert só produz falha falsa.

**Lição:** nesta base, `grep` no código não serve para levantar efeito de
gravação. A `LOGREP` serve.

### 8.4 Varredura das travas do pre-commit — 03/09/2026

**Zero travas dentro do diff deste requisito.** Os 11 arquivos novos e o
`untEstornoReceber.pas` reescrito passam limpos em componentes proibidos,
`.SetFocus`, `StrToFloat`, `ActiveControl :=`, `Application.CreateForm`, `Now`
sem `fNow`, `FOREIGN_KEY_CHECKS` e propriedades de Fast4.

Dois sinalizados são **pré-existentes e fora do diff**, confirmado por
`svn diff`: o `Application.CreateForm(TfrmPrincipal, ...)` do `autcom.dpr`
(linha 4922, o form principal do executável) e três `StrToFloat` no
`untBaixaReceber.pas`, cujo diff são 90 linhas de formatação e nada mais.

#### SQL por concatenação: 12 pontos, classificados

**Nove concatenam nome de objeto ou operador, não dado de entrada** — e nome de
tabela ou de coluna **não pode** ser parâmetro em SQL. Não são injectáveis:

| Onde | O que concatena |
|------|-----------------|
| `FiltroEstorno:714` | `ColunasDeCadRec`, lista de colunas constante |
| `EstornoDuplicatas:629, 937, 1096` | nome de tabela, passado por `fTabelaValidada`, que aceita só `CADREC` e `ADTCLI` |
| `EstornoDuplicatas:1778, 1801` | o operador de comparação (`=` ou `<`), constante interna |
| `ValidacaoEstorno:1003` | composição de subconsulta |

**Três concatenam VALOR e são violação real** — nenhuma introduzida por este
requisito, todas herdadas da origem:

1. `untEstornoReceber.pas:2348` em `ValidacoesDeRecebimentoPorPix` — monta o
   `SELECT` da `MOVPIX` concatenando `CTR_SEQCON`, `CTR_EMPBAI` e `CTR_DTAREC`.
   **É duplicação pura**: o mesmo SQL já existe parametrizado em
   `TDevolucaoPix.fCarregarRegistrosPix`, com as mesmas 18 colunas e o mesmo
   filtro. Trocar as 9 linhas por uma chamada resolve os dois problemas de uma
   vez — exige incluir `Financeiro.ContasReceber.DevolucaoPix` no `uses`, que
   hoje **não** está lá.
2. `ValidacaoEstorno:1197` — `WHERE CTP_CTPCOM IN (` + lista +  `)`.
3. `ValidacaoEstorno:1290` — `WHERE ` + cláusula montada com valores de campo
   (`COM_NUMAGR`, `COM_EMPAGR`, `COM_PARAGR`, `COM_CODCLI`), construída no form.

**Por que não corrigi.** O CLAUDE.md manda *reportar sempre* concatenação de
SQL na zona legado, e manda **não refatorar proativamente**. As três são
anteriores a este requisito. A 1 é barata e tentadora, mas está no caminho do
Pix — justamente o que ainda não foi validado em tela (§8 item 2). Mexer ali
agora invalidaria a validação que está para acontecer. As 2 e 3 são listas de
tamanho variável: parametrizar exige gerar nomes de parâmetro em laço, o que é
mudança de comportamento em código legado, não formatação.

**DECIDIDO pelo requisitante em 03/09/2026: ficam como estão.** A razão dada
foi explícita e vale como princípio para o resto do requisito — *"o objetivo
principal é não quebrar o autcom desktop"*. Nenhuma das três é defeito
introduzido aqui, e corrigi-las trocaria risco conhecido (concatenação antiga,
em produção há anos, com entrada que não vem do usuário final) por risco novo
num form já compilado e parcialmente validado.

Se algum dia forem corrigidas, que seja em requisito próprio, com validação de
tela própria — e a 1 é a única barata, porque o substituto parametrizado já
existe em `TDevolucaoPix.fCarregarRegistrosPix`.

### 8.5 Pix validado em tela — 03/09/2026, 11:09

Recebimento por **Pix QR Code**, duplicata `030920262525` da empresa 592,
R$ 2,35. Baixa **total, sem desmembramento**. Estorno pela tela às 11:09:34.

**A regra passou, e com devolução automática.** Rastro na `LOGMPX`:

| Hora | Evento | Status |
|------|--------|--------|
| 11:06:43 | `INCLUSÃO PIX A VISTA` | ATIVA |
| 11:08:24 | `BAIXA PIX` | CONCLUIDA |
| 11:09:39 | `DEVOLUCAO PIX` (frmEstornoReceber) | **DEVOLVIDO** |
| 11:09:40 | `EXCLUSÃO - ESTORNO RECEBER` | DEVOLVIDO |

A duplicata voltou a 2,35 com todos os campos de baixa nulos, **nenhum crédito
foi gerado** (correto — o título voltou aberto; os dois `CC` do cliente são de
24/08, do retrato), e a `MOVPIX` foi apagada. Os acentos de `INCLUSÃO` e
`EXCLUSÃO - ESTORNO RECEBER` gravaram certo — são dois dos 47 literais da §3.3.

**Duração real da devolução: ~6 s** (11:09:34 → 11:09:40), contra os 120 s de
teto da §8.1. Primeira medição de verdade desse caminho.

#### E reprovou a `008` — dois furos, ambos do mesmo tipo

Numa baixa **total sem desmembramento** nada é arquivado: a própria `CADREC` é
atualizada no lugar e o estorno limpa os campos de volta. Logo:

1. **O sequencial sumia das duas fontes.** `CADREC` com `CTR_SEQCON` 0 e
   `DEL_CADREC` **vazia** → `@SeqCon` caía para 0, e todo bloco chaveado por
   sequencial (`MOVCAR`, `LOGMCA`, `DEL_MOVCAR`, `CADCHQ`, `DEL_CADCHQ`,
   `LOGCHQ`) voltaria vazio — ou casaria com linhas alheias de sequencial zero.
2. **A chave do Pix sumia.** O estorno **limpa** `CTR_EMPPIX` e `CTR_TX_PIX` do
   título restaurado → `@ChavePix` não resolvia nada, e `MOVPIX`/`LOGMPX`
   voltariam vazios.

Em ambos, vazio compara igual a vazio: o caso passaria afirmando nada. Era
exatamente o defeito que a procedure existe para impedir, dentro dela mesma.

**Correção (versão 3):** a `LOGCTR` vira a **terceira fonte** das duas chaves —
ela é append-only e carrega a chave da duplicata junto do sequencial e do txid.
Medido: recupera `CTR_SEQCON` 300 e o txid `R3ZnRK6aQ...`. E quando nem assim há
sequencial, o filtro passa a ser ` FALSE ` em vez de `= 0` — trazer linha alheia
é pior que trazer nada.

**Terceiro achado, menor mas do mesmo tipo:** `PIX_QTD_DEVOLUCOES` (soma de
`MPX_QTDDEV`) **não prova devolução**. Ficou ZERO nas quatro linhas mesmo com
status DEVOLVIDO, e a `MOVPIX` é apagada de todo jeito. Quem prova é a `LOGMPX`:
a versão 3 acrescenta `PIX_DEVOLVIDOS`, contagem de linhas com
`MPX_STATUS = DEVOLVIDO` — medido, dá 2.

**Lição, e é a mesma da §8.3:** eu desenhei a `008` sobre um único cenário
observado (baixa parcial desmembrada em cinco modalidades). O cenário mais
simples — baixa total — tem um comportamento **estruturalmente diferente**, e
nenhuma leitura de código teria mostrado isso. Mostrou rodar o caso.

### 8.6 Crédito e juros validados em tela — 03/09/2026, 11:22

Duplicata `063522202565`, empresa 592, R$ 6,35, recebida por Pix com **juros de
R$ 16,12** — recebido total 22,47. Estorno às 11:22:30.

**Os dois caminhos fecharam:**

- Título voltou a 6,35, com `CTR_VALJUR` e `CTR_VALDES` zerados
- `MOVBAN` fecha exato: crédito 22,47 (`Rec. 00059920-...`) contra débito 22,47
  (`ESTORNO DA DUPLICATA 063522202565A`). O lançamento inverso cobre **principal
  mais juros**, não só o principal
- Crédito gerado: `CADREC` espécie `CC`, `CTR_VALDUP` **−22,47**, histórico
  `CRÉDITO GERADO POR ESTORNO DE RECEBIMENTO PIX - 063522202565A-592` — mais um
  dos 47 literais da §3.3 gravando com acento

Aqui o Pix **gerou crédito em vez de devolver**, ao contrário da §8.5. A RN06
derivando a ação está exercitada nos dois sentidos.

**Sobre o desconto ter ficado zerado** — informado pelo requisitante em 03/09, e
não é dedutível do código lendo rápido: **juros e desconto se abatem um no
outro**, de modo que a baixa grava **ou** juros **ou** desconto, nunca os dois.
`CTR_VALDES` = 0,00 com `CTR_VALJUR` = 16,12 é o comportamento correto, e não
meio caminho de um teste.

Consequência para a validação: o caso de desconto é o **mesmo mecanismo com o
sinal trocado**, e o que o estorno faz é zerar o campo que estiver preenchido.
Continua valendo exercitá-lo uma vez — é outro campo sendo escrito — mas o risco
é baixo, e não é bloqueio.

#### E o achado que trava a API: `CFG_PCTRPX` está vazia em TODAS as empresas

O crédito saiu com `CTR_CODPOR` 59920 e `CTR_CODEVE` 00001. Esses valores **não
vieram da configuração**: vieram do diálogo `SelecionaPortadorEventoGeracaoCredito`,
onde o operador escolhe.

Conferido na `CFGSIS`: `CFG_PCTRPX` e `CFG_ECTRPX` estão com `SIS_VALCFG` **vazio
nas 87 empresas**, a 592 inclusive.

Consequência direta, e não é defeito — é a RN07 funcionando: **hoje o endpoint
recusaria com 422 `CFG_PCTRPX_VAZIA` todo estorno de Pix que precise gerar
crédito.** O serviço não tem diálogo para perguntar, então ou a configuração
existe ou ele recusa.

Duas coisas decorrem:

1. **É pré-requisito de implantação, e precisa ir para o suporte** junto das
   divergências da §7. Sem preencher, o endpoint entrega metade do que promete.
2. **O caminho de crédito da API não tem como ser testado** enquanto a
   configuração estiver vazia — o caso de teste 56
   (`TEST_ESTORNO_PIX_CREDITO_01`) depende de preenchê-la antes. O 57
   (`TEST_ESTORNO_CFG_PCTRPX_VAZIA_01`), esse, passa hoje sem preparo nenhum.

Valores que a tela usou e servem de semente para a configuração da 592:
portador `59920`, evento `00001`.

### 8.7 Diretivas condicionais balanceadas — 03/09/2026

Antes de queimar ciclo de PAServer, conferi o balanço de `{$IFDEF}` / `{$ELSE}` /
`{$ENDIF}` nas cinco classes. Diretiva desbalanceada **compila no Windows** — o
ramo `IFNDEF LINUX` é o tomado — e só estoura no Linux, apontando o fim do
arquivo em vez da diretiva.

| Unit | abre | senão | fecha |
|------|------|-------|-------|
| `EstornoTypes` | 0 | 0 | 0 |
| `ValidacaoEstorno` | 1 | 1 | 1 |
| `DevolucaoPix` | 2 | 1 | 2 |
| `FiltroEstorno` | 5 | 1 | 5 |
| `EstornoDuplicatas` | 28 | 4 | 28 |

**Todas balanceadas.** Uma classe de surpresa a menos no primeiro build Linux.

Nota de ferramenta: a primeira passada acusou quatro diretivas abertas e não
fechadas — todas dentro de comentários `//` que **citam** a diretiva em prosa.
Contador que não remove comentário mede o texto, não o código.

### 8.8 Cartão isolado validado — 03/09/2026, 11:32

Duplicata `543265645364`, empresa 592, R$ 106,36, baixa **total em cartão**
(sequencial 302). Estorno às 11:32:22, título restaurado a 106,36 com
`CTR_CARTAO` zerado.

Era mais denso do que "cartão isolado" sugere: **12 parcelas em 2 cartões**
distintos, somando 103,12 (a diferença de 3,24 para os 106,36 é a taxa).

| Tabela | Depois do estorno |
|--------|-------------------|
| `MOVCAR` | **0** — as 12 parcelas saíram |
| `DEL_MOVCAR` | **12** — arquivadas |
| `LOGMCA` | 24 — 12 de inclusão, 12 de exclusão |
| `BANCTR` | 2 — baixa e estorno |
| `MOVBAN` | crédito 106,36 = débito 106,36 |
| `CADREC` | 1, restaurada |
| `DEL_CADREC` | 0 — baixa total, nada a arquivar |

#### As duas correções da `008` se provaram aqui

**1. A `DEL_MOVCAR` era mesmo necessária (§8.3).** A `MOVCAR` fica **vazia**
depois do estorno. Sem o bloco da `DEL_MOVCAR` não existe forma de provar que as
12 parcelas saíram — só que não estão mais lá, o que é indistinguível de nunca
terem existido.

**2. O fallback da `LOGCTR` (§8.5) salvou o caso inteiro.** Baixa total de novo:
`CADREC` com `CTR_SEQCON` 0 e `DEL_CADREC` vazia. Na versão 2, `@SeqCon` cairia
para 0, e está medido que `MOVCAR`, `DEL_MOVCAR` e `LOGMCA` com sequencial zero
devolvem **zero linhas** na 592.

Ou seja: a versão 2 reportaria os três blocos vazios num teste que tem **36
linhas de evidência**, e o caso passaria afirmando que nada aconteceu. A `LOGCTR`
recupera o sequencial 302 e o recorte volta correto.

É a segunda vez que o mesmo cenário — **baixa total sem desmembramento** — expõe
a mesma fragilidade. Vale como regra: qualquer chave derivada da `CADREC` neste
requisito precisa de terceira fonte, porque o estorno limpa a linha em vez de
arquivá-la.

### 8.9 Primeiro build Linux — 03/09/2026

O `dcc` parou em **um** erro real nas cinco classes:
`TValidacoesPagamentoOnline` é desconhecida no Linux. A unit
`untPgtOnlineApi` já estava no `uses` comum — a **classe** é que está declarada
sob `{$IFNDEF LINUX}` dentro dela própria.

Levantado antes de decidir: as duas dependências dela
(`fDocumentoPagamentoLinkPagamentoCitel`, linha 132, e `TLinkPagamentoCitelCfg`)
estão **fora** de condicional, ou seja, a classe compilaria no Linux se a guarda
fosse aberta — e abrir uma `{$IFNDEF LINUX}` é rigorosamente um no-op para o
Windows, que já toma esse ramo.

**Decisão do requisitante: não abrir.** O `autcom` não se toca, nem com mudança
comprovadamente neutra. `fTemLinkPagamento` foi para `{$IFNDEF LINUX}` —
declaração, implementação, variável local e ponto de chamada.

Os três `H2077` são `Result := False` seguido de atribuição incondicional. Estilo
defensivo, não defeito — não mexidos.

#### E um erro que eu mesmo introduzi ao documentar a lacuna

Escrevi o comentário explicativo num bloco `{ ... }` e citei `{$IFNDEF LINUX}`
na prosa. **Comentário de bloco no Delphi não aninha:** ele termina no primeiro
`}`, que passou a ser o da diretiva. Todo o texto seguinte viraria código.

Pegou porque rodei o verificador de balanço de diretivas logo depois, e ele
acusou uma abertura a mais. **Comentário `//` não tem esse problema** — as
citações da diretiva que já existiam nas outras classes são todas `//`, e por
isso sempre foram inofensivas.

Varri as nove units do requisito atrás do padrão: zero ocorrências.

### 8.10 `untTMovCarRepository` aberta para o Linux — 03/09/2026

Segundo erro do build: `untTMovCarRepository` puxava `untFuncoesSimples`, e o
requisitante perguntou o que de fato era necessário antes de sair carregando
dependência. Foi a pergunta certa.

**Necessária, sim.** `fEstornaMovCar` é chamada em `pApagaChequeCartao` quando a
baixa teve cartão, **sem guarda de plataforma** — o cheque ao lado já está sob
`{$IFNDEF LINUX}` porque está fora do escopo; o cartão é o escopo. Sem ela o
endpoint não estorna cartão, que é o requisito inteiro.

**E a cadeia era muito menor do que o erro sugeria.** Rastreada:

| Peça | Situação |
|------|----------|
| `pExcluir` (o que usamos) | clone p/ `DEL_MOVCAR` + `untLogMca.GravaLogMca` + delete pelo ORM — tudo portável |
| `pGravaLog` | `Application.ExeName` e `fRetAutoIncrem` — **os dois únicos empecilhos** |
| `untDelRepository`, `untUtilRepository` | já no `.dpr`, já com `{$IFDEF LINUX}` |
| `untLogMca`, `untObjectManager`, `untFieldFiltros` | já no `.dpr` |

`pGravaLog` **não tem um único chamador no projeto** — os outros `pGravaLog` que
aparecem no grep são homônimos de `TArquivosBanco*`, com outra assinatura.

**Decisão do requisitante: opção A.** `pGravaLog` e seus dois `uses` foram para
`{$IFNDEF LINUX}`, e o ramo Linux ganhou o `services.core.uses.inc` — de onde vem
o `fEmptyStr` que as linhas 120-132 usam fora do `pGravaLog`. Copiei o caminho do
include do vizinho `untGravaMovCar`, que está na mesma pasta e já compila.

**Windows: nada muda.** `{$IFNDEF LINUX}` não tira nada do ramo que o `dcc32` já
toma. É a mesma forma de mudança vetada em `untPgtOnlineApi` (§8.9); a diferença
é a aposta: lá o custo de não mexer era uma validação a menos, aqui era o
requisito.

Este é o **segundo arquivo do desktop** alterado fora das cinco classes — conta
para o escopo de regressão do commit.

### 8.11 Build Linux passou — 03/09/2026

**`Success`.** As cinco classes compartilhadas, o service, o worker e o
controller compilam para Linux. Era o maior risco aberto do requisito (§8
item 1) e está fechado.

Seis erros, e a distribuição diz algo:

| # | Símbolo | Onde | Natureza |
|---|---------|------|----------|
| 1 | `TValidacoesPagamentoOnline` | `untPgtOnlineApi` | classe sob `{$IFNDEF LINUX}` |
| 2 | `untTMovCar` | `.dpr` do serviço | unit não declarada |
| 3 | `frwk` | `untObjectManager` | global que só existe no Windows |
| 4 | `GravaLogMca` | `untLogMca` | mesma rotina, nome diferente por plataforma |
| 5 | `ExcluirPixDoCaixa` | `untTFuncoesPixAutcom` | rotina sob `{$IFNDEF LINUX}` |
| 6 | `pCarregaChave` | **classe deste requisito** | visibilidade |

**Cinco de seis foram atrito com o legado, não defeito do porte.** Nenhum
apareceu nas 4.578 linhas do motor — a `EstornoDuplicatas` passou de primeira
assim que as dependências abriram. O único defeito próprio foi o 6, e custou uma
linha.

Vale para o próximo porte: o custo não está em traduzir a regra, está em
descobrir o que o Windows dá de graça. Nenhuma das cinco primeiras aparecia em
leitura de código.

#### Os dez hints, conferidos um a um

- **`H2269`, `Workers.pas:99`** — visibilidade de `LoadMethods` na classe base.
  **Pré-existente**: `svn diff` confirma que a linha não está no diff deste
  requisito.
- **Cinco `H2077` de `Result`** — `Result := False` sobrescrito antes de ser
  lido. Estilo defensivo do arquivo.
- **Quatro `H2077` de variável local** (`fltTotParc`, `fltValLan`, `fltTecTot`,
  `blnEstDtaDoc`) — rastreados: cada uma é inicializada no topo do método **e
  reinicializada dentro do laço** antes do uso. Redundante, não errado. O
  `H2077` só dispara quando o compilador **prova** que a atribuição é
  sobrescrita, então nenhuma delas esconde valor perdido.

Nenhum hint foi mexido: são todos anteriores ao requisito ou inofensivos, e o
CLAUDE.md manda não refatorar proativamente na zona legado.

### 8.12 Ponta a ponta pela API — 03/09/2026, 15:44

**Fechou o ciclo completo**, tudo por HTTP contra `10.0.0.205:8082`:
`POST /api/login` → `GET /cobranca/duplicatas` → `POST /cobranca/baixa` →
`POST /cobranca/estorno`. Resposta **200 em 0,65 s**, sequencial 304.

| Conferência no banco | |
|---------------------|---|
| `MOVCAR` | 0 — as 2 parcelas saíram |
| `DEL_MOVCAR` | 2, com `OPEDEL` 998, `DTADEL` 2026-09-03, `HORDEL` 15:44:05.2 |
| `LOGMCA` | 4 |
| `MOVBAN` | crédito 319,08 = débito 319,08 |
| Título | 106,36, de volta em aberto |
| `LOGCTR` | origem `Financeiro.Services.Cobranca.Estorno` (RN10) |

#### Três defeitos que só a chamada real encontrou

Nenhum aparecia na compilação, e nenhum aparecia na tela.

**1. `CTR_PARCEL` não existe no dataset (HTTP 500).** O `SELECT` de
`TFiltroEstornoSQL` **renomeia**: `CTR_NUMDUP AS NUMDUP`, `CTR_PARCEL AS PARDUP`,
e `CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_NUMDUP` — o nome antigo fica com **outro
valor**. Três pontos meus liam os nomes originais; o `pCarregaChave` derrubava
toda chamada. A tela nunca passa por `fMotivoForaEscopoDaBaixa` (os portões da
RN02 são do endpoint), então nenhuma rodada de tela tocaria essa linha.

**2. O ORM não roda no serviço (HTTP 422).** `fGetMovCarsRcx` usa Aurelius, que
cria componentes UniDAC com `Tag` zero; o `ShowDebugForm` — instalado pelo
monitor de replicação — exige que o `Tag` resolva uma conexão registrada e
levanta exceção **antes do `WriteLog`**, por isso o SQL culpado nunca aparecia no
log. Resolvido tirando o ORM: ver §8.13.

**3. `HORDEL` gravava a data zero.** Coluna `varchar(10)`, e eu passava
`AsDateTime := Time`. O `Time` devolve `TDateTime` com a data zerada e o driver
gravou `1899-12-30` — perdendo exatamente a hora. Só apareceu porque comparei as
duas gerações lado a lado na própria `DEL_MOVCAR`: sequencial 302 (ORM, tela)
trazia `11:32:23.8`. Conferir só "gravou 2 linhas" teria deixado passar.

#### E duas hipóteses minhas que o log desmentiu

Apostei no ORM, **descartei** o ORM ao ler mal o `fltValCar`, e voltei ao ORM. O
que resolveu foi o requisitante depurar e apontar a linha. Lição repetida da
§8.3 e da §8.5: neste código, dedução por leitura erra; medição acerta.

### 8.13 O contrato e o cartão, decididos pelo requisitante — 03/09/2026

**O array `erros[]` saiu.** Não era o padrão da API — o irmão direto,
`TBaixaDuplicatasResult`, devolve `sucesso` / `sequencialControle` /
`empresaBaixa` / `mensagem`, sem array e sem código de regra. E numa recusa ele
**nunca** tinha mais de um item: todo caminho de recusa sai no primeiro problema.
Eu havia construído um array de erros para um caso que produz um erro.
`duplicatasEstornadas` ficou — não é erro, é o que a RN01 exige informar.

**O cartão saiu do ORM nas DUAS plataformas.** `pExcluiMovCarDaBaixa` substitui
`TMovCarRepository.pExcluir`: arquiva na `DEL_MOVCAR`, grava `LOGMCA`, apaga a
`MOVCAR`. Uma rotina só, sem `{$IFDEF}` — o que elimina o risco de os dois
caminhos divergirem, que era minha objeção a tirar o ORM.

Efeito colateral bom: `untTMovCar` e `untTMovCarRepository` ficaram sem uma
referência de tipo sequer, saíram do `.dpr` do serviço, e com isso pude
**reverter o `untTMovCarRepository.pas` ao original**. O desktop passou de três
arquivos alterados para dois mais o `untLogMca`.

**A lista de colunas é a INTERSEÇÃO das duas tabelas**, e isso foi correção do
requisitante: eu montava o `INSERT` só com as colunas de `MOVCAR`, tratando um
retrato de hoje como invariante. Coluna acrescentada na `MOVCAR` e esquecida na
`DEL_MOVCAR` faria o `INSERT` estourar e derrubaria o estorno de cartão inteiro.
O ORM **não quebrava nesse caso** — grava pelas propriedades mapeadas e ignora
coluna física fora do mapeamento. Era robustez perdida sem eu perceber.

### 8.14 Os dois H2077 que sobram no Linux são para ficar — 03/09/2026

As atribuições mortas foram removidas a pedido do requisitante: **oito**, todas
as que o compilador Windows provou mortas. O build Windows ficou em zero hint
nesses arquivos.

**O Linux continua com dois, e não devem ser mexidos:**

| Símbolo | Linha |
|---------|-------|
| `fEstornaMovbanJurosDescto` | `Result := False` |
| `fltValLan` | inicialização no topo do método |

Os dois são hint **só no Linux**. No Windows a mesma linha é lida antes de ser
sobrescrita, porque o caminho que a lê está sob `{$IFNDEF LINUX}`. Remover para
calar o hint do Linux **quebra o desktop**.

O inverso também ocorreu e serviu de aviso: `blnTemChq` era hint **só no
Windows**, porque o trecho está sob `{$IFNDEF LINUX}` e o Linux nem o compila.
Esse saiu.

**Lição:** tratar "a lista de hints" como uma coisa só teria removido duas
atribuições vivas. Em unit com compilação condicional, hint é por plataforma, e a
diferença entre as duas listas é informação.

Envolver as duas em `{$IFDEF}` só para zerar o contador seria pior que o hint.

### 8.15 A regressão que quase passou: `fParcialBaixadaJunto` — 03/09/2026

**Sintoma.** Estorno pela tela de uma baixa desmembrada recusava com
*"Primeiro deve ser estornada a duplicata principal (Seq. 0)"*.

**O que denunciou a origem foi a redação.** A mensagem da origem é *"Primeiro
**você deve estornar** a duplicata principal"*; a minha é *"Primeiro **deve ser
estornada**"*. Bastou comparar as duas para saber que a recusa vinha da classe
nova, e não do form.

**A causa.** A origem (`untEstornoReceber.pas:3646`) só recusa a parcial quando a
principal está baixada **e não foi baixada junto com ela**:

```pascal
Else                          // principal ja foi recebida
  If fParcialBaixadaJunto Then
    strMarcar := 'M'          // passa
  Else
    ... recusa ...
```

`fParcialBaixadaJunto` compara `CTR_DTABAI`, `CTR_SEQCON` e `CTR_EMPBAI` da
parcial com os da principal marcada. Numa **baixa desmembrada por modalidade**
as linhas nascem no mesmo recebimento, então batem, e o estorno segue.

**Por que escapou da extração:** é uma função **local**, declarada dentro do
método. `grep fParcialBaixadaJunto` devolve duas linhas — cabeçalho e chamada —
e **nenhuma** com `TfrmEstornoReceber.`, que é o padrão que eu usei para varrer o
que precisava portar. Função local não aparece nesse padrão.

**Gravidade:** com ela faltando, **nenhuma baixa desmembrada por modalidade podia
ser estornada pela tela.** É o cenário mais comum do requisito.

**Correção:** `fParcialBaixadaJuntoComPrincipal` na classe, usada como saída
antes da recusa. Portei **só a leitura** — a original também *desmarca* as linhas
que não batem, e esse efeito colateral continua no form, mantendo a classe sem
gravar nada.

#### Validação na tela, 16:05 — e a estreia da rotina nova de cartão

Duplicata `543265645364`, sequencial 305, baixa desmembrada em 4 linhas.

| | |
|---|---|
| `LOGCTR` | `ESTORNO` nas quatro linhas (SEQBAI 0,1,2,3) por `frmEstornoReceber` |
| `CADREC` | 1 linha, 106,36, recebido 0,00 |
| `DEL_CADREC` | 3 — as parciais arquivadas |
| `MOVCAR` / `DEL_MOVCAR` / `LOGMCA` | 0 / 7 / 14 |
| **`HORDEL`** | **`16:05:39.9`** — formato certo |
| `MOVBAN` | crédito 425,44 = débito 425,44 |

Vale o registro: esta foi a **primeira execução do `pExcluiMovCarDaBaixa` na
tela**. O desktop saiu do ORM e gravou `DEL_MOVCAR`, `LOGMCA` e o `HORDEL`
corretos — a correção de formato, achada pela API, valeu também aqui.

**Lição para a próxima extração:** varrer por `TClasse.metodo` perde toda função
local. Numa unit de 8.500 linhas com métodos de centenas de linhas, isso não é
caso raro.

### 8.16 RN01 provada pela API — 03/09/2026, 16:14

**O teste que a RN01 pedia:** baixar três duplicatas juntas, estornar informando
**uma só**, e o endpoint alcançar as três.

Baixa (sequencial 307), três títulos **distintos** — de propósito, para não
provar apenas que ele pega outras parcelas do mesmo número:

| Duplicata | Valor |
|-----------|-------|
| `030920260000-A` | 35,00 |
| `030920262525-A` | 2,35 |
| `G00000000002-B` | 56,33 |
| | **93,68** em cartão |

Estorno com `numeroDuplicata: "030920262525"` apenas. Resposta **200**, e
`duplicatasEstornadas` com as **três**. No banco, as três voltaram ao valor
original com `CTR_SEQCON` zerado, e `CADREC` do lote 307 ficou vazia.

#### O acaso que fortaleceu o teste

A `030920260000-A` tinha, do mesmo dia, **outra baixa nunca estornada** — o lote
299, desmembrado em cinco parciais. O estorno do 307 **não encostou nela**: as
cinco linhas do 299 seguem intactas.

Isso prova mais do que o teste planejado: o alcance da RN01 e o lote, e nao a
duplicata. Um estorno que varresse "todas as linhas desta duplicata" teria
levado o 299 junto e ninguem notaria pela resposta.

Conferência bancária por título:

| Título | Crédito | Débito | Saldo |
|--------|---------|--------|-------|
| `030920262525-A` | 4,70 | 4,70 | **0,00** |
| `G00000000002-B` | 56,33 | 56,33 | **0,00** |
| `030920260000-A` | 110,00 | 35,00 | 75,00 — histórico anterior, incl. o lote 299 |

O débito de 35,00 é exatamente o que este estorno gerou. O resíduo do terceiro
título é de baixas anteriores em aberto, e não desequilíbrio.

`DEL_MOVCAR` com 1 linha e `HORDEL` em `16:14:46.3` — o formato corrigido.

### 8.17 Estorno de baixa PARCIAL pela API — 03/09/2026, 16:17

`G00000000002-C`, valor 56,33. Baixa **parcial** de 20,00 em cartão
(sequencial 308), depois estorno.

Depois da baixa parcial, o título vira duas linhas — o comportamento próprio da
parcial, que é o que torna esse caso diferente do total:

| | `CTR_SEQBAI` | `CTR_SEQCON` | `CTR_VALDUP` | `CTR_VALREC` |
|---|---|---|---|---|
| saldo em aberto | 0 | 0 | **36,33** | 0,00 |
| parcial baixada | 1 | 308 | 0,00 | **20,00** |

Estorno com `sequencialBaixa: 1`. Resposta **200**. Depois:

| Conferência | |
|-------------|---|
| `CADREC` | **1 linha**, valor **56,33** — o cheio de volta |
| `DEL_CADREC` | 1 — a parcial arquivada |
| `MOVCAR` / `DEL_MOVCAR` | 0 / 1 |
| `HORDEL` | `16:17:13.2` |
| Saldo bancário do título | **0,00** — crédito igual a débito |

O ponto que a parcial exercita e o total não: o estorno precisa **fundir** o
saldo de volta no título e sumir com a linha da parcial. Duas linhas viram uma,
com 36,33 + 20,00 = 56,33.

### 8.18 Pix pago de verdade, estorno gerando credito — 03/09/2026, 16:32

Primeiro ciclo Pix completo **pela API**: criar cobrança, pagar no banco,
processar, estornar.

| Etapa | |
|---|---|
| `POST /api/pix/cobrancaimediata` | txid `y5jIwl4c...`, R$ 2,35, duplicata `030920262525-A` |
| Pagamento | feito pelo requisitante no simulador do BB |
| `processarpagamento` | lote **309**, 1 duplicata baixada |
| `POST /api/contasareceber/cobranca/estorno` | 200 |

Depois: a duplicata voltou ao aberto, e nasceu o crédito `000000000003-A` de
**−2,35** com portador `59920` e evento `00001` — exatamente `CFG_PCTRPX` e
`CFG_ECTRPX`. A `MOVPIX` saiu para `DEL_MOVPIX` com `OPEDEL='998'` e
`HORDEL='16:32:29'`.

**A prova que vale mais que a conferência de campos:** o `LOGMPX` da API gravou
o par `GERAÇÃO CRÉDITO ESTORNO PIX` + `EXCLUSÃO - ESTORNO RECEBER`, na mesma
ordem e com os mesmos campos que o `frmEstornoReceber` tinha gravado às 16:08 no
teste pela tela. Tela e API deixam o mesmo rastro.

#### Os dois headers que faltavam

O `POST /api/pix/cobrancaimediata` recusava com *"Operador do servico sem o
direito BAIXACTRBTNCONFIRMA"*. Não era falta de direito: eu chamava **sem os
headers** `Empresa` e `OperadorLogado`, que o `TConnectionMiddleware`
(`api.core.middleware.pas:69`) usa para definir empresa e `strLoginUsuarioLogado`.
Sem eles a chamada corre com o operador default, que não tem o direito.

### 8.19 Pix de TRÊS duplicatas — 03/09/2026, 16:36

Uma cobrança de **R$ 19,06** para três títulos distintos (2,35 + 6,35 + 10,36),
lote **310**, todos apontando para **uma** `MOVPIX`. Estorno informando **só a
`063522202565-A`**, a do meio.

| Conferência | |
|---|---|
| `duplicatasEstornadas` | as **três** |
| `CADREC` | as três no valor original, `SEQCON=0`, `RECPIX='N'`, `TX_PIX=NULL` |
| Crédito | **um só**, `000000000004-A` = −19,06 |
| `G00000000001` parcelas **B** e **C** | **intactas** |

`MOVBAN`: três débitos `ERC`, um por duplicata com seu valor exato, e **um**
crédito `CRC` de 19,06. A assimetria é o certo — o débito desfaz cada baixa, o
crédito representa o Pix, que é um só.

**Este teste é o que expôs o defeito do histórico** (§8.20). Com duplicata única
nada aparece: a chave informada e a primeira do lote coincidem.

---

## 8.20 Os defeitos achados em 03/09 depois de conferir o SVN

O requisitante mandou conferir a origem pelo `svn cat` em vez de confiar na
minha leitura. Isso derrubou uma suposição minha e, ao puxar o fio, apareceram
mais quatro — **dois deles quebrariam o autcom desktop**.

### D1 — a chave vinha da primeira linha do lote

A origem monta o histórico do crédito com `edtNumDup.Text + edtParcel.Text +
'-' + edtCodEmp.Text` (SVN r490656:5057): os **edits da tela**, a duplicata que
o operador informou, fixos durante todo o estorno.

O serviço fazia:

```pascal
LcdsDuplicatas.First;                                    // descarta o Locate
TValidacaoEstorno.pCarregaChave(LcdsDuplicatas, LEstorno.Chave);
```

`LinhaDaChave` tinha localizado a linha certa logo acima; o `First` jogava fora.
A chave virava a **primeira do lote**. Medido: estorno pedido para
`063522202565-A` gravou o crédito como `030920262525A-592`.

Alcance além do texto: `pGerarLogLiberacao` nomeava a duplicata errada, e em
`EstornoDuplicatas.pas:4419` a chave entra numa **comparação que decide** o
tratamento de adiantamento de pedido (espécie `PD`) — ali é comportamento.

**Correção:** `LinhaDaChave` reposiciona antes do `pCarregaChave`.

### D2 — a validação do portador não existia

Havia um comentário afirmando *"a classe recusa se vier vazio"* e **nenhuma
recusa no código**: o portador saia de `CTR_PORBAI` da primeira linha, vazio ou
não.

A origem (`fPedePortador`, r490656:2483) percorre **todas** as linhas marcadas e,
se qualquer uma tiver portador em branco ou inexistente na `CADPOR`, **para e
pede o portador ao operador**.

**Correção:** `PortadorDaBaixa` replica o laço; headless não tem a quem pedir,
então vira recusa. Usa `fCampoTabela` sobre `CADPOR` — que é literalmente o corpo
do `fRetNomPortador` (`untFuncoesSimples.pas:13606`) — para não arrastar
`untFuncoesSimples` para o `.dpr` do serviço.

### D3 — o gate do lote: `fValidaMesmoRecebimento`

**O mais grave.** Outra função local perdida, o mesmo padrão do
`fParcialBaixadaJunto` (§8.15).

`MontarSelectSequenciais` devolve um `CTR_SEQCON` por baixa da chave, **sem
filtro de `CTR_SEQBAI`**, e a segunda passada traz as duplicatas de todos eles.
Na tela isso é inofensivo: o operador clica uma linha e `fValidaMesmoRecebimento`
(r490656:3428) só propaga a marca para as de **mesmo SEQCON, mesma empresa de
baixa e mesma data**. O serviço chamava `MarcarTodas`.

Medido em `2_30_BELAT_TC`:

| Chave | Linhas | Lotes | Empresas |
|---|---|---|---|
| `000000041214-A-CC-004` | 9 | **9** | 001 e 022 |
| `000000250315-Z-CC-004` | 7 | **7** | 022 |

Uma chamada informando essa chave desfaria **nove baixas, em duas empresas**.

Não apareceu nos testes porque toda chave usada tinha um lote só — a consulta de
verificação na empresa 592 volta vazia. **Ausência de dado não é ausência de
defeito.**

**Correção:** `MarcarDoRecebimento` replica o gate. E `fMotivoForaEscopoDaBaixa`,
que é só do endpoint e percorria tudo, passou a julgar apenas o marcado.

### D4 — `CTR_RESCAI = 1` sumiu da segunda passada

A origem filtra o resumo de caixa nas **duas** passadas (r490656:1555 e 1751).
A extração levou só a primeira.

**Isto quebra o desktop**, não o endpoint: `blnResCai = True` é caminho vivo —
`untRcxResumoCaixa.pas` e `untFatConfOrcamentos.pas` fazem
`frmEstornoReceber.blnResCai := True`. Sem o filtro, o grid do Resumo de Caixa
passa a mostrar baixas feitas **fora** do caixa.

**Correção:** `MontarSelectDuplicatas` ganhou `AApenasResumoCaixa`, e os dois
chamadores passam o valor. O ramo `ADTCLI` fica de fora — a origem também não
filtra ali (r490656:1841).

### D5 — `fParcialBaixadaJuntoComPrincipal` estreitado demais

Eu tinha lido a origem errado. Ela faz **duas coisas**:

- **retorno**: `Result := Not cdsDup.IsEmpty` — basta **existir** a principal
  marcada com a mesma chave. Não compara data, seqcon nem empresa;
- **efeito colateral**: o laço desmarca as linhas cujo `(DTABAI, SEQCON, EMPBAI)`
  diverge da principal.

Eu levei as três igualdades para dentro do **retorno**, estreitando-o. Como
`fValidarDuplicatas` roda pelos dois caminhos, isso era **recusa nova no
desktop**: uma principal marcada pelo segundo ramo de `MesmaDataDeBaixa` (bate
por `CTR_DTAREC`, não por `CTR_DTABAI`) era aceita pela origem e passava a ser
recusada.

**Correção:** predicado alinhado ao filtro do `cdsDup`. O desmarque continua no
`fParcialBaixadaJunto` do form (`untEstornoReceber.pas:1906`), que não foi
tocado.

### Menores, corrigidos junto

- **`ResolverPix` lia da primeira linha.** Havia um `ADataset.First` **depois** do
  `Locate('CTR_RECPIX','S')`. A origem (r490656:3798) filtra
  `CTR_MARDES='M' AND CTR_DTAREC IS NOT NULL` e lê da linha encontrada. Com um
  crédito `CC` em primeiro na ordenação, `CTR_DTAREC` vale 0, a consulta ia com
  `MPX_DTAREC = 1899-12-30` e não achava Pix — o estorno seguia deixando a
  `MOVPIX` para trás.
- **O flag do crédito acumulava com `Or`.** A origem (r490656:4825) sobrescreve a
  cada volta do laço das `MOVPIX`. Acumular apagava o aviso
  `PIX_CREDITO_NAO_GERADO` quando a última volta falhava.
- **`PERMDEVRECPIX` / `PERMESTSEMDEVPIX`.** A tela pede liberação por senha de
  supervisor antes de devolver o Pix ou de gerar crédito no lugar da devolução
  (`SolicitaDireitoDeAcessoDevolucaoPix`, r490656:4278). O endpoint executava sem
  exigir nada além de `DIRRCXEST`. Agora os dois direitos são portões, no mesmo
  molde da RN03. O operador 998 tem ambos, então o ambiente de teste segue
  funcionando.

### O que isso ensina sobre a extração

Três dos cinco defeitos são **funções locais** — `fValidaMesmoRecebimento`,
`MesmaDataDeBaixa`, `fParcialBaixadaJunto`. É o mesmo padrão da §8.15, e agora
com amostra suficiente para virar regra:

> Numa unit de 8.500 linhas, o que decide comportamento não está só nos métodos
> da classe. Varredura por `TClasse.metodo` **não encontra função local**, e
> função local é onde mora o gate.

E o segundo: **conferir a origem no SVN, não na memória**. O D1 só apareceu
porque o requisitante mandou olhar o `svn cat` em vez de aceitar a minha
explicação de que o histórico "nomeia o Pix, e o Pix é um só".

### 8.21 Limpeza dos comentários de extração — 03/09/2026

Pedido: tirar das units os comentários que eu escrevi, sem deixar linha em
branco. Removidos **278 blocos, 56 KB**, em 8 arquivos.

O texto integral ficou em `comentarios-removidos.md`, no scratchpad da sessão.

**O cuidado que a tarefa exige:** distinguir comentário meu de comentário da
origem, que veio junto com o código extraído. A primeira tentativa comparava
linha a linha e classificou como meus vários da origem — `// Historico 1`,
`// Limpa a origem do registro principal da MOVBAN (Req. 155872)`. Removê-los
seria perder o original.

O que funcionou: agrupar em **blocos** e julgar o bloco inteiro, com regra
conservadora — na dúvida, preserva. São meus os que citam `.pas:<linha>`
(referência que eu criei ao rastrear), os de duas linhas ou mais, e os de frase
longa. Sobrou rótulo curto de parâmetro, que é da origem.

Duas linhas em branco seguidas **ficam**: é o estilo da casa (12 na origem, 38 no
`untBaixaReceber`). Só 3+ foi colapsado — a origem não tem nenhuma.
### 8.22 `fPedePortadorCaixa` reposto — 04/09/2026

**O que ele faz.** Ao estornar, o sistema debita o lançamento bancário no
portador da baixa (`CTR_PORBAI`). Isso não serve quando a duplicata foi baixada
**pelo caixa em dia diferente do caixa corrente**: aquele caixa já fechou. A
origem então avisa e abre o `TfrmDigPortador` pedindo um portador de débito:

> *"Duplicata(s) baixada(s) pelo caixa em dia anterior, portanto será
> solicitado um portador para débito do lançamento da movimentação bancária!"*

Condição de disparo, por linha marcada (origem r490656:5423):

| | |
|---|---|
| `CTR_VALREC > 0` e `CTR_ORIGEM <> 'CTR'` | é linha de recebimento real |
| `CTR_DTAREC <> dtaDtaRcx` | recebida em dia diferente do caixa corrente |
| `CTR_RESCAI <> 0` | foi baixada pelo caixa |
| não é `AdiantamentoGeradoPeloCaixaSemRecebimentoVinculado` | |

Com `blnEstornoAutomatico` e portador já definido, sai sem perguntar.

#### O erro de leitura que eu cometi em 03/09

Classifiquei como "caminho de conjugadas, cenário já não validado" e deixei
como decisão do requisitante. **Estava errado**, e o motivo é instrutivo: o
método que o continha chama-se `fEstornaDuplicataConjugadas`, mas é o **fluxo
principal** do estorno da tela — a origem o chama em r490656:1204, no caminho
normal, depois do `fPedePortador` e da confirmação. O nome vem de ele tratar as
conjugadas no final.

> **Nome de método em unit legada não é documentação de escopo.** Ler o nome e
> concluir o alcance foi o que quase enterrou este defeito. O que decide é quem
> chama, e de onde.

#### Como foi reposto

No **form**, porque abre janela modal — a classe compartilhada segue sem UI:

- `fPedePortadorCaixa`, cópia da origem, com o gate de empresa do Req. 145940;
- `fPortadorParaDebitoDeCaixaAnterior`, o laço que a chamava;
- chamado em `fEstornaDuplicatas` com o `recParams` **já montado** —
  `AdiantamentoGeradoPeloCaixaSemRecebimentoVinculado` precisa dele — e antes
  de `TEstornoDuplicatas.fEstornarDuplicatas`.

O portador escolhido vai para uma variável local e só depois volta ao record.
Passar `recParams` como `const` e `recParams.Cabecalho.PortadorBaixa` como
`Var` na mesma chamada compilaria, mas record grande vai por referência no
`const`: a função de adiantamento enxergaria o portador já alterado. Na origem
`strPorBai` era variável separada, e assim continua.
### 8.23 A ancora do Pix que eu quebrei — 04/09/2026

Fora do escopo deste requisito, mas custou a manhã e ensina duas coisas.

#### O defeito original: `SELECT *` entre tabelas que divergiram

`TEST_PIX_PROCESSAR_PAGO_01` (caso 29) falhava com
*"Column count doesn't match value count at row 1"* — e a **rota respondia 200**.
O erro era do `sql_before`, que chama `pTestePixPagoRepor`:

```sql
INSERT INTO MOVPIX SELECT * FROM financeiro_baixa_test_movpix;
```

| Tabela | Colunas |
|---|---|
| `MOVPIX` | 58 |
| ancora `financeiro_baixa_test_movpix` | 48 |

Faltavam as 10 de devolução de Pix. A raiz e o `CREATE TABLE IF NOT EXISTS ...
LIKE MOVPIX` do bloco 1: cria uma vez e **nunca mais atualiza**. A `MOVPIX`
cresceu, a âncora ficou para trás.

É a mesma armadilha que o requisitante apontou em 03/09 no
`pExcluiMovCarDaBaixa` — *"e se os campos da movcar não existir na del?"*. Lá eu
corrigi com interseção de colunas; aqui ninguém tinha corrigido ainda.

#### O erro que eu cometi ao corrigir

Corrigi a estrutura e mandei **reaplicar o arquivo**. Mas o bloco 2 faz
`DELETE FROM ancora` e recaptura da `MOVPIX` — e a cobrança de referência,
criada em 26/08, já não estava mais lá. O realinhamento preservou o conteúdo; o
bloco 2, logo em seguida, apagou e não conseguiu refazer. **Âncora zerada.**

> O bloco está documentado como *"a captura da ancora (bloco 2) roda uma vez só"*,
> mas isso é intenção, não mecanismo: ele executa em toda aplicação do arquivo.
> **Ler o comentário e não o código** foi o erro — o mesmo gênero do
> `fEstornaDuplicataConjugadas`, cujo nome diz um escopo e o uso diz outro.

#### A recuperação

Pelo próprio "COMO REFAZER A ANCORA" do script, e sem ninguém pagar à mão — ele
documenta o endpoint de homologação do BB:

| Passo | |
|---|---|
| cobrança criada | `jebDxdN6uUP8XutZAQOaCIaHrgbeGQdKHu2`, R$ 112,66, parcelas E e F |
| paga no BB hm | `E00000000202609041212BKLQMVXX4QD` |
| status | CONCLUIDA |
| capturada **sem** processar | `SEQCON` e `VALREC` nulos |
| txid trocado | `006_INFRA_PIX_PAGO.sql` e `casos/0029` |

O passo de ordem crítica é não chamar o `processarpagamento` antes de capturar:
processar primeiro deixa a âncora com estado pós-baixa e a reposição passa a
repor um Pix já consumido. E há pressa — o monitor de Pix baixa sozinho.

#### As três correções que ficaram

1. **`pTestePixAncoraRealinhar`** no lugar do `CREATE TABLE IF NOT EXISTS`: cria
   se não existe, e se divergiu recria preservando o conteúdo pelas colunas
   comuns. Pode ser reaplicada à vontade.
2. **`DELETE` guardado por `EXISTS`**: só apaga a âncora se houver o que
   recapturar. Reaplicar o arquivo deixou de ser perigoso.
3. **Reposição por interseção**, sem `SELECT *`.

Detalhe que só apareceu ao rodar a consulta de verdade: a lista de colunas dá
**623 caracteres** e o `group_concat_max_len` padrão é **1024**. Já estava a 60%
do limite, e o corte do `GROUP_CONCAT` é **silencioso** — sairia truncada no meio
de um nome. Daí o `SET SESSION group_concat_max_len = 100000` nos dois pontos.

### 8.24 Por que a lib do Pix sumia todo deploy — 04/09/2026

`POST /api/pix/cobrancaimediata` recusava com *"O arquivo libIntegracaoPixCitel.so
não foi encontrado na pasta do AUTCOM"*. Aconteceu em 03/09 e de novo em 04/09,
sempre depois de um deploy.

No `FinanceiroServicesAPI.deployproj`, cada biblioteca aparece **duas vezes** —
uma por configuração. Menos uma:

| Biblioteca | Configurações |
|---|---|
| `bplNFe`, `bplShared.Functions`, `bplrtl260` | Debug, Release |
| `libcrypto`, `libmidas.so.2`, `libmysqlclient`, `libssl` | Debug, Release |
| **`libIntegracaoPixCitel`** | **só Debug** |

Deploy em Release não a levava. Corrigido com a entrada `Release`, igual às
vizinhas — edição de `.deployproj` que o CLAUDE.md permite justamente para
configuração de deploy/PAServer.

**Estes três arquivos são do Req. 458327**, não deste: `006_INFRA_PIX_PAGO.sql`,
`casos/0029_TEST_PIX_PROCESSAR_PAGO_01.sql` e o `deployproj`. Decidir se vão
junto ou em commit separado.
### 8.25 Os casos que provam o estorno — 04/09/2026

A suíte tinha 7 casos, **todos de recusa**: seis 400 e um 422. Provavam que o
endpoint recusa direito, e nada sobre ele **estornar** direito. O requisitante
apontou a lacuna com uma pergunta de uma linha: *"só criar teste de estorno com
400 e com 200?"*.

Agora são **11**, com quatro de 200:

| id | Cenário | O que exercita |
|---|---|---|
| 58 | cartão total | caminho base |
| 59 | parcial | duas linhas → funde o saldo de volta |
| 60 | Pix | `MOVPIX`→`DEL_MOVPIX` e crédito gerado |
| 61 | **conjugadas** | informa uma, alcança duas |

#### O obstáculo, e por que o desenho ficou inline

O `005` repõe o estado **limpo** — e a `pTesteBaixaSnapshotGravar` chega a
**recusar** tirar retrato se houver título baixado. Está certo para a suíte da
baixa, que parte do zero. O estorno precisa do oposto: um lote **já baixado**.

A saída veio de olhar o caso 1 (webhook): o `sql_before` aceita **vários
comandos** — ele usa 19. Então o preparo vai inline, sem procedure nova. Duas
vantagens: o caso fica autocontido, e cada comando pôde ser **testado**
isoladamente antes de entregar.

O preparo é gerado de uma baixa REAL feita pela API — não escrito à mão. Lê as
linhas que a baixa gravou e monta `CALL pTesteBaixaReset`, os `DELETE`, o
`UPDATE` da CADREC e os `INSERT` dos movimentos.

#### Sete defeitos que só apareceram executando

Nenhum apareceria em revisão de código:

1. **`BANCTR` tem FK para `MOVBAN`** (`CTB_SEQLAN`) — o pai entra primeiro. Na
   limpeza a ordem é a inversa, porque ali o CASCADE trabalha a favor.
2. **Limpar `MOVBAN` por subselect na `BANCTR` não funciona** — se ela já foi
   apagada, o subselect volta vazio, o `MOVBAN` sobrevive órfão e o INSERT morre
   em `Duplicate entry`. Limpa-se pela própria duplicata.
3. **`DEL_MOVCAR` precisa ser limpa** — o motor arquiva com `INSERT` (padrão do
   projeto para tabelas `DEL_`), e repor a linha com o mesmo `AUTOINCREM` faria o
   segundo estorno colidir. Em produção a linha só é arquivada uma vez.
4. **`CTR_MARDES` não existe na `CADREC`** — é coluna que o SELECT da tela cria
   para marcar linha no grid.
5. **Faltava repor `CTR_RECPIX`** — sem ele a RN02 recusa com *"não possui cartão
   nem Pix"*, porque `fLinhaTemCartaoOuPix` olha `CTR_CARTAO` e `CTR_RECPIX`.
6. **`LOGCTR` limpo por lote não alcança o log do estorno** — ele fica com
   `CTR_SEQCON = 0`, e a contagem crescia a cada rodada. Limpa-se pela chave.
7. **Sem `CALL pTesteBaixaReset` no início, o histórico acumula** — a
   `G00000000001` chegou a **11 linhas de `MOVBAN`**, e as contagens do RESUMO
   passaram a crescer. Os casos de baixa sempre começaram com o reset; faltava
   fazer o mesmo.

E um erro de método meu: gerei um retrato **depois** de estornar. O gerador lê o
estado corrente, então capturou o estado estornado — em silêncio, porque o SQL
continua válido. **Baixa e captura andam juntas.**

#### O `json_validate` não é um dump

O `CompareJson` itera sobre o **esperado** (`api.core.utils.pas:205`): campo
ausente no validate não é conferido. Os existentes têm 1 a 3,5 KB; o dump cru da
procedure tem 13 a 27 KB.

Ficam de fora:

- **voláteis**: `AUTOINCREM`, `CTB_SEQLAN`, horários — mudam a cada execução;
- **`CTR_DIFORI`**, que **acumula** (medido: 44,16 → 58,88 entre duas rodadas);
- **contagens de `MOVBAN`/`BANCTR`**, que são histórico da duplicata.

O que fica é o **estado final** — o que o estorno tinha de desfazer. Resultado:
1156, 4313, 1156 e 4316 chars, na faixa dos existentes. A data de hoje vira
`"CURRENT_DATE"`, como no caso 2.

#### Conjugadas, enfim

Era o cenário nunca validado. Conjugada é a linha marcada com `CTR_DTAREC = 0`
fora do resumo de caixa (`pAddConjugada`), e com duas ou mais o motor liga
`SugerirRebaixaConjugadas`. Uma baixa **parcial de duas duplicatas** produz
exatamente isso — dois saldos sem data de recebimento — e é montável pela API.

Informando **só a parcela C**, a resposta veio com **as duas**. Funciona.

#### O que não dá para automatizar por aqui

**Desmembrada por modalidade.** O `TBaixaMovimentos` do endpoint de baixa tem
**só `cartao`** — não existe dinheiro, cheque nem ordem no contrato. O cenário é
exclusivo da tela; automatizá-lo exige o retrato de uma baixa feita por lá.

#### Achado pré-existente: `AUTOINCREM` reaproveitado

O primeiro estorno de conjugadas falhou com
*`[fApagaDuplicataContasReceber] - Duplicate entry ... DEL_CADREC.PRIMARY`*.

A linha tinha sido arquivada ontem (lote 308); a baixa de hoje **recebeu o mesmo
`AUTOINCREM`**, e ao estornar o sistema tentou arquivar de novo.

`fApagaDuplicataContasReceber` está na **origem SVN** (linha 2802, ramo
`ESTORNO`) e serve também a cancelamento e faturamento. **Não é regressão da
extração.** Mas em produção apareceria assim: parcial criada → estornada → nova
parcial recebe o mesmo número → estorno falha. A correção seria `REPLACE` no
lugar de `INSERT`, como já se faz na `DEL_MOVPIX`. **Requisito à parte.**
---

## 9. Ambiente

- Build por linha de comando **não fecha** nesta working copy: falta
  `Packages\Faturamento\` (existe no repositório, `svn list` confirma) e 14 DCPs
  que o checkout `.111` tem. `autcom.dproj` morre com
  `Required package 'faturamento.impostos.interfaces' not found` antes de
  compilar qualquer fonte. **Compilação é feita pelo desenvolvedor na IDE.**
- Base de teste: MCP `api-teste` (o requisitante chama de "bela"). A
  `financeiro-dev` é outra base.
- MCP mostra `DATETIME` em UTC — 3h a mais que o gravado.

### 9.1 O reset da base apaga a evidência do teste — 03/09/2026

A duplicata `020920260000` do teste de 02/09 sumiu da `CADREC` e da `LOGCTR`.
Não foi o estorno: foi a procedure `pTesteBaixaReset('592')`, de
`padra_atualizado/Services/Financeiro.Services.API/Scripts/testes/005_INFRA_RESET.sql`
(infra do Req. 458327, da baixa). Ela apaga por empresa:

| Tabela | O que some |
|--------|-----------|
| `LOGCTR`, `BANCTR`, `MOVBAN`, `MOVCAR`, `LOGMCA`, `MOVPIX`, `PIXTEL`, `LOGMPX`, `LCKATC`, `MOVOCO`, `HISOCO` | tudo da empresa |
| `CADREC` | apagada e **reposta** do retrato `financeiro_baixa_test_cadrec` |

Duplicata criada **depois** do retrato não está no retrato — some e não volta.
A `DEL_CADREC` **não** é tocada: por isso as 5 parciais do estorno de 02/09
continuam lá, e são o único vestígio de que o teste aconteceu.

Confere pela aritmética: `CADREC` da 592 = 30 = 24 do retrato + 1 mãe + 5
parciais do teste de hoje.

**Consequência prática:** conferência no banco tem de ser feita **antes** do
próximo reset, ou os números têm de ser copiados para cá. Os do teste de 02/09
estão na §8.2.
