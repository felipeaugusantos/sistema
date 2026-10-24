# Especificação — Req. 458943

**Título:** Endpoint de estorno de duplicatas recebidas na `Financeiro.Services.API`
**Objetivo:** Expor `POST /contasareceber/cobranca/estorno` capaz de desfazer o que o endpoint de baixa (`POST /contasareceber/cobranca/baixa`, Req. 454631) produz — recebimentos em **cartão e PIX** — reproduzindo a regra da tela `untEstornoReceber`, com desktop e serviço executando o mesmo código através de uma classe compartilhada que recebe um record de parâmetros.
**Zona:** Híbrida — Legado em `padra_atualizado/fontes/financeiro/contasareceber/`, Moderna em `padra_atualizado/Services/`
**Data:** 2026-09-01

---

## 1. Contexto / problema atual

O estorno de duplicatas recebidas só existe dentro da tela `TfrmEstornoReceber` — 8.517 linhas com toda a regra no próprio form. O endpoint de baixa não tem operação inversa: o que o service baixa hoje só pode ser desfeito por alguém no autcom.

O núcleo é `pConfirmaEstornoInterno` (`untEstornoReceber.pas:670`), ~560 linhas entrelaçadas com `fMensagem`, `pSetFocus`, `TfrmGravando` e leitura direta do grid `dbgDuplicatas` e do `cdsDados`.

### Escopo: espelhar o endpoint de baixa

O alvo não é "tudo que o autcom estorna" — é **desfazer o que o service baixa**. O `TBaixaService` só realiza baixas em cartão e PIX, sempre fora do resumo de caixa. O estorno cobre exatamente essa forma.

Isso não restringe por origem: a baixa não carrega em `CADREC` nenhuma marca de quem a criou (`strNomOrigem` vai só para `LOGMOVCTR`, como trilha de auditoria). O endpoint aceita qualquer baixa **com a forma** que o service produz, tenha sido criada por ele ou pela tela.

### Precedente arquitetural

Dois padrões de compartilhamento desktop/serviço existem no projeto, e o requisito adota o primeiro:

| Padrão | Exemplo | Forma |
|--------|---------|-------|
| **A — classe + record de parâmetros** | `Financeiro.ContasReceber.BaixaDuplicatas.pas` (Req. 454631, r491104) | **Adotado.** Regra extraída para uma classe com `{$IFDEF LINUX}` no `uses`, recebendo `TBaixaParams` e devolvendo `TResultadoBaixa` |
| B — Controller + View headless | `untRcxDigCartoesController.pas` | Lógica em unit Controller; o form vira casca; uma View headless atende o serviço |

**Por que o Padrão A.** A escolha foi medida. O `untBaixaReceber.pas` **antes** da extração do Req. 454631 (`svn cat -r 491103`) era mais entrelaçado com UI do que o estorno é hoje:

| | untBaixaReceber (antes) | untEstornoReceber (hoje) |
|---|---:|---:|
| Linhas | 13.566 | 8.517 |
| `fMensagem` / `pMensagemOk` / `pEmitirMensagem` | 143 | 94 |
| `pSetFocus` | 22 | 29 |
| `ShowModal` | 32 | 7 |
| `pCriarFormularios` | 34 | 8 |
| **Pontos de UI** | **231** | **138** |

A infraestrutura que faltava então (`Shared.Core`, os stubs de `Services/Core/Services.Core.Types.pas`, o cabeçalho `{$IFDEF LINUX}`) hoje existe e está em produção. O resultado fica simétrico: `TEstornoService` ao lado de `TBaixaService`.

**A classe não fica "sem UI".** Na `BaixaDuplicatas` sobraram 10 `fMensagem`, 4 `pMensagemOk`, 1 `ShowModal` e 1 `pCriarFormularios`, isolados por 13 diretivas. O mecanismo é empurrar as units VCL para o ramo `{$ELSE}`, com o Linux atendido por `Shared.Core`.

---

## 2. Módulos e entidades envolvidos

**Módulos:** financeiro (contas a receber), Services (Financeiro.Services.API)

| Unit | Papel |
|------|-------|
| `fontes/financeiro/contasareceber/untEstornoReceber.pas` | Origem da regra; passa a montar `TEstornoParams` e chamar a classe |
| `fontes/financeiro/contasareceber/Financeiro.ContasReceber.EstornoDuplicatas.pas` | **Nova** — a regra compartilhada |
| `fontes/financeiro/contasareceber/Financeiro.ContasReceber.ValidacaoEstorno.pas` | **Nova** — validações e portões de escopo |
| `fontes/financeiro/contasareceber/Financeiro.ContasReceber.FiltroEstorno.pas` | **Nova** — carga do lote |
| `fontes/financeiro/contasareceber/Financeiro.ContasReceber.DevolucaoPix.pas` | **Nova** — bloco PIX |
| `Services/Core/financeiro/services/Financeiro.Services.Cobranca.Estorno.pas` | **Nova** — service |
| `Services/Financeiro.Services.API/Source/api/controller/api.controller.cobranca.estorno.pas` | **Nova** — rota REST |

**Tabelas:**

| Tabela | Chave / uso |
|--------|-------------|
| `CADREC` | `CTR_NUMDUP` + `CTR_PARCEL` + `CTR_ESPDOC` + `CTR_CODEMP` + `CTR_CODCLI` + `CTR_SEQBAI`. Lote: `CTR_SEQCON` + `CTR_EMPBAI` + `CTR_DTABAI` |
| `MOVPIX` | `MPX_SEQCON` + `MPX_CODEMP` + `MPX_DTAREC` — recebimento PIX vinculado |
| `MOVCAR` | Movimento de cartão desfeito pelo estorno |
| `MOVBAN` | Lançamento bancário do estorno, inclusive juros/desconto separados |
| `LOGCTR` / `LOGMOVCTR` | Log do estorno e trilha de origem |

---

## 3. Requisitos funcionais

- **RF01** — Expor `POST /contasareceber/cobranca/estorno` na `Financeiro.Services.API`, autenticado por JWT, com os headers `Empresa` e `OperadorLogado`, seguindo `api.controller.cobranca.baixa.pas`.
- **RF02** — Receber uma única chave por requisição: `numeroDuplicata`, `parcela`, `especieDocumento`, `codigoEmpresa`, `codigoCliente` e `sequencialBaixa`, todos obrigatórios.
- **RF03** — Extrair a regra de `TfrmEstornoReceber` para classes compartilhadas, compiladas pelo `autcom.dpr` e pelo `FinanceiroServicesAPI.dpr`. Desktop e serviço passam a executar o mesmo código, cada um montando um `TEstornoParams`.
- **RF04** — Manter a tela `frmEstornoReceber` funcionando exatamente como hoje, **inclusive nos cenários fora do escopo do endpoint** (dinheiro, cheque, adiantamento, caixa) — a extração não pode reduzir o que a tela faz.
- **RF05** — Responder `200` com o resultado, `400` para payload inválido e `422` quando uma regra recusar, sempre nomeando o motivo.
- **RF06** — Cobrir estorno de baixa em **cartão** e em **PIX**, total e parcial, incluindo juros e desconto, comissões de agrupamento e duplicatas conjugadas.

---

## 4. Regras de negócio

### RN01 — Escopo do estorno: o lote inteiro

A chave de cinco campos mais o `sequencialBaixa` identifica **uma linha** de `CADREC`; dela sai o `CTR_SEQCON`. Todas as duplicatas daquele `CTR_SEQCON` são marcadas (`CTR_MARDES = 'M'`) e estornadas juntas.

Motivo: `pCriaTemporaria` (`untEstornoReceber.pas:1543`) monta o dataset com o lote completo porque as validações de consistência — `FiltroPossuiBaixaDeDuplicatasComTotalEParcial`, `fVerificaDocumentosBaixados`, `fVerificaDatasDiferentes` — raciocinam sobre o lote.

A marcação passa por `pMarcaDuplicata` (`:2822`), onde os locks são adquiridos. Documento travado por outra estação recusa com **422**.

### RN02 — Portões de escopo: só cartão e PIX puros

O endpoint recusa com **422**, nomeando a condição, quando a baixa contiver:

| Condição | Campo |
|----------|-------|
| Cheque à vista | `CTR_CHQAVI <> 0` |
| Cheque pré-datado | `CTR_CHQPRE <> 0` |
| Adiantamento de cliente | `CTR_ADTCLI = 'S'` |
| Duplicata descontada no banco | `CTR_MOVDES` não nulo |
| Recebimento pelo resumo de caixa | `CTR_RESCAI = 1` |

E o lote precisa ter ao menos uma linha com cartão ou PIX. Os portões valem para **todas as linhas do lote**, não só a da chave — uma baixa mista é recusada inteira.

#### Por que dinheiro e ordem de pagamento NÃO são recusados

Duas descobertas do levantamento derrubaram travas que a primeira versão desta RN previa:

**Dinheiro.** O valor pago com crédito de cliente é gravado em `CTR_DINHEI`, não em `CTR_CREDIT` — essa coluna existe mas está zerada nas 98.484 baixas da base. O próprio sistema distingue crédito de dinheiro por casamento de valor no momento da gravação (`untCadRec.pas:1711`), informação que não sobrevive até o estorno. Como `TBaixaMovimentos` do endpoint de baixa expõe **apenas `cartao`**, ele nunca cria dinheiro de verdade: `CTR_DINHEI` nas baixas que ele produz é sempre crédito. Recusar dinheiro recusaria justamente o alvo do endpoint.

**Ordem de pagamento.** PIX é, no fundo, ordem de pagamento — o valor recebido por PIX cai em `CTR_ORDPAG` (`untEstornoReceber.pas:881` rotula `ORDPAG` como "Pix" quando `RECPIX='S'`). Recusar ordem de pagamento recusaria PIX por via indireta.

O recebimento pelo resumo de caixa é recusado porque o modo caixa exige `fSaldoCaixaSuficiente`, as travas de fechamento e transferência, `fCaixaDebaixaCtrDiferenteDoCaixaDeEstorno` e o portador de caixa — nada disso é replicado. Como o `TBaixaService` nunca baixa pelo caixa, a recusa não reduz o alvo do endpoint.

### RN03 — Direito de acesso sem senha

`DIRRCXEST` é verificado para o operador do header `OperadorLogado`. Ausente o direito, **422** com o motivo — nunca o fluxo de senha (`objLiberacao.fLibera` com `fCfgSis('ESTCTR')`, `:888`).

Precedente: `TBaixaService.ValidarDireitosBaixaDoLote` recusa com *"Operador do servico sem o direito X, exigido para Y"*.

### RN04 — Portador da baixa não vem no payload

`fPedePortador` (`:2483`) só pergunta quando alguma linha marcada tem `CTR_PORBAI` vazio ou apontando para portador inexistente. Na classe extraída a pergunta desaparece: `strPorBai` vem de `CTR_PORBAI`, e linha sem portador válido vira erro no `TErrosEstorno` — **422** nomeando a duplicata.

### RN05 — Data do estorno é derivada, não informada

`dtaEstorn` continua saindo do registro e de `VS_Date` (`:5623`, `:5680`, `:5702`), incluindo `fBuscaDataEstornoSintetica`. Não há campo de data no payload.

### RN06 — Devolução de PIX: decisão derivada, nunca recusa

**Não há campo de PIX no payload.** Quando o recebimento tem PIX vinculado, o que fazer com ele é derivado da configuração da empresa e do estado do recebimento — do mesmo jeito que a tela decide, só que sem perguntar:

| Situação | Ação |
|----------|------|
| Nenhum portão fechado | **Devolve** o valor ao cliente via PIX |
| `CFG_DEVPIX` desligada na empresa (`:6975`) | **Gera crédito** ao cliente |
| Chave PIX de banco `748` ou `208` sem Shipay (`:3827`) | **Gera crédito** |
| `CTR_DTAREC` com 90 dias ou mais (`:3854`) | **Gera crédito** |
| `MPX_USASHP='S'` com `MPX_QTDDEV` em (1,2) (`:5000`) | **Nada** — só remove a cobrança |
| Sem registro em `MOVPIX` | **Nada** |

**O PIX nunca recusa o estorno.** Na tela, todas essas condições convergem para o aviso de `:3830`, que oferece gerar crédito no lugar da devolução — o endpoint faz o mesmo automaticamente. A resposta informa qual caminho foi tomado.

> Versões anteriores desta spec previam um campo `tipoEstornoPix` no payload e 422 para cada portão. Retirado em 01/09/2026: se a empresa está configurada para devolver, deve devolver; o crédito é a saída quando a configuração diz que não, ou quando alguma regra impede — como banco que não faz devolução. Pedir a escolha ao consumidor exigiria que ele conhecesse a configuração do cliente e as capacidades do banco.

### RN07 — Portador e evento do crédito vêm de configuração

**O payload nunca pede portador nem evento.** Sempre que o endpoint gerar crédito (RN06), os dois valores vêm de configuração da empresa:

| Configuração | Conteúdo | Grupo |
|--------------|----------|-------|
| `CFG_PCTRPX` | Portador — Geração de Crédito de Cliente proveniente de estorno de Pix | CONTAS A RECEBER |
| `CFG_ECTRPX` | Evento — Geração de Crédito de Cliente proveniente de estorno de Pix | CONTAS A RECEBER |

Qualquer uma vazia no momento de gerar o crédito → **422 nomeando a configuração a preencher**. Mesma linha da RN04: o serviço não escolhe portador sozinho.

**Por que configuração e não payload.** Na tela, `SelecionaPortadorEventoGeracaoCredito` (`:4213`) abre `TfrmBaixaAnalitica` para o operador escolher — não há registro de onde derivar os valores. Exigi-los no payload obrigaria o consumidor a conhecer o plano de portadores do cliente, e tornaria o caminho de crédito inutilizável justamente quando ele é a única saída (RN06.1). Com configuração, o crédito é sempre autossuficiente.

**Configurações novas.** Não existe par equivalente hoje. O parente mais próximo é `CFG_PCTRCC` (*"Portador - Geração de Crédito de Cliente provenientes de adiatamento"*), já lido pelo estorno em `:4249`, mas escopado a adiantamento — reaproveitá-lo mudaria o significado de um valor que os clientes preencheram com outra finalidade. Para evento não existe nada: `CFG_EVE_CC` é apenas o liga/desliga *"Obrigatório informar evento ao incluir crédito de cliente?"*.

> **Não altera a tela.** `frmEstornoReceber` continua abrindo `TfrmBaixaAnalitica` para o operador escolher. As configurações servem ao caminho headless.

### RN08 — Motivo do estorno não é solicitado

O bloco de `CFG_RMOTES` (`:5344`) **não executa** no caminho headless. `strMotEst` e `LHistComplementar` ficam vazios; `CTR_MOTEST` (`:2236`) e o `GravaLogCtr` (`:2271`) gravam em branco.

> **Divergência assumida.** Em cliente com `CFG_RMOTES` ligado, estorno pela API e pela tela produzem registros diferentes: o da API fica sem ocorrência. Decisão do requisitante em 31/08/2026; consultas por ocorrência de estorno não enxergarão os estornos feitos pela API.

### RN09 — Transação

O estorno é atômico: `fStartTransactionGen` / `fCommitGen` / `fRollBackGen`. Falha em qualquer etapa desfaz tudo e libera os locks adquiridos em `pMarcaDuplicata`.

### RN10 — Origem registrada no log

O estorno grava `strNomOrigem = 'Financeiro.Services.Cobranca.Estorno'` em `LOGMOVCTR`, espelhando o que o `TBaixaService` faz com `'Financeiro.Services.Cobranca.Baixa'` (`Financeiro.Services.Cobranca.Baixa.pas:1091`).

### RN11 — Impedimentos por linha do lote

> Acrescentada em 02/09/2026, durante a Fase 2.

Na tela estas validações rodavam em `pSelecionaDuplicata` (`untEstornoReceber.pas:3326`),
o handler que marca as linhas no grid — uma por vez, conforme o operador seleciona.
O endpoint marca o lote inteiro de uma vez por `FiltroEstorno`, então nenhuma delas
rodaria: **o estorno passaria por título conciliado, título com Pix ativo e parcela
fora de ordem, sem aviso.**

`TValidacaoEstorno.fValidarLinhasDoLote` percorre o lote marcado e recusa na primeira
que barrar, que é o efeito prático do `blnDocumentosOk := False` da origem:

| Regra | Recusa quando | Origem |
|---|---|---|
| `CREDITO_TAXA_MARKETING` | espécie `TX` com `CTR_VALREC < 0` | `:3573` |
| `ORIGINADA_DE_CONVERTE` | duplicata originada de converte — só consulta | `:3484` |
| `LINK_PAGAMENTO` | há link de pagamento online ativo | `:3496` |
| `CONCILIADO` | `CTR_DOCBAI` já conciliado (`CTB_DTACON` preenchida) | `:3584`, `:3668` |
| `VINCULADO_PARA_CONCILIACAO` | vinculado para conciliação em `BANEXR` | `:3596` |
| `PIX_ATIVO_NO_CREDITO` | crédito `CC` em aberto com `CTR_TX_PIX` ativa | `:3519` |
| `PIX_ATIVO_NA_PARCIAL` | parcela cuja principal está em aberto com Pix ativo | `:3679` |
| `PRINCIPAL_JA_BAIXADA` | parcial cuja principal já foi baixada | `:3620` |
| `PRINCIPAL_AUSENTE` | parcial sem registro principal (provável agrupamento) | `untFuncoes.pas:10616` |
| `PARCIAL_POSTERIOR_BAIXADA` | há parcial com `SEQBAI` maior já baixada | `:3623` |

**Divergência de guarda.** `DuplicataCreditoEmAbertoPossuiChavePix` (`:3208`) e
`DuplicataEmAbertoDaParcialPossuiChavePix` (`:3260`) abriam com
`If CTR_MARDES = 'M' Then Exit`, porque na origem rodavam *antes* de a linha ser
marcada. Mantido o guarda, seriam código morto no caminho headless. Ele saiu: a
pergunta que interessa é sobre o registro principal em `CADREC`, não sobre o
estado da marcação.

**Fora:** `TAdiantamento.fAdiantamentoPossuiDebitos` e
`TAdiantamento.fPossuiCreditoGerado` — valem para `ADTCLI`, recusado pela RN02, e a
unit não compila para Linux.

### RN12 — Data do estorno: sempre a data do dia no endpoint

> Definida com o requisitante em 02/09/2026: *"a gente nunca pede a data, faz o
> esquema do estorno automático"*.

A tela decide a data do estorno em três etapas (`untEstornoReceber.pas:5490`):
direitos `DTAOER`/`DTESTR`, `CFG_RDTEMB` e, quando a configuração manda perguntar,
o diálogo `TfrmDtaEstorno` (`fTipDtaEstBai`).

O endpoint **não percorre nenhuma delas**. Grava sempre com a data do dia
(`VS_Date`), reproduzindo o caminho `blnEstornoAutomatico` da origem (`:5502`) —
que também ignora `CFG_RDTEMB` e o teste de direitos.

A decisão não vive no motor: chega pronta em
`TEstornoOpcoes.EstornoComDataDoDocumento`. O serviço passa `False`; a tela passa
o que apurou. O que permanece no motor é apenas a varredura que define *se* a data
do documento chega a valer para o lote (`RESCAI = 0`, ou `CTR_DTAREC` diferente da
data do caixa).

> **Divergência assumida.** Em cliente com `CFG_RDTEMB` = 2 (data do documento), o
> estorno pela tela grava com a data do documento e o pela API com a data do dia.
> Nenhum lançamento financeiro do endpoint retroage — que é o comportamento
> desejado.

---

## 5. Requisitos técnicos / não-funcionais

- A regra vive em classes compartilhadas; correção futura vale para tela e endpoint sem duplicação.
- `EstornoDuplicatas.pas` usa o cabeçalho de `BaixaDuplicatas.pas`: `{$IFDEF LINUX}` com `{$I '..\..\..\core\services.core.uses.inc'}` e `Shared.Core`; no `{$ELSE}`, as units VCL.
- Entradas públicas (o `pgbProgresso` previsto na análise não foi necessário):
  - `class function fEstornarDuplicatas(var AParams: TEstornoParams): TResultadoEstorno`
  - `class function fExecutarEstorno(var AParams: TEstornoParams; var AResultado: TResultadoEstorno): Boolean` — usada pela tela para as conjugadas.
- Erros seguem a forma de `TErroBaixa`: `Escopo`, `Regra`, `Mensagem`, `Chave` — é o que permite traduzir cada recusa em 422 com motivo nomeado.
- **Timeout — medido em 03/09/2026, e cabe.** `SolicitarDevolucaoDoPix` espera até 4 × 7.000 ms por registro da `MOVPIX` (3.000 ms fora de Shipay/Pix SCP), e `ApagaRegistroPix` chama isso uma vez por registro, em laço. O teto do worker é de **120 s** (`Services.Core.Worker.pas:1098`), contado desde antes do despacho. Pior caso **28 s**: quem consome este endpoint cria Pix só pela API de Pix do projeto, que gera um único Pix por baixa — escopo fechado pelo requisitante em 03/09/2026. O laço continua no código porque a classe é compartilhada com a tela, onde outras rotinas geram mais de um. Conta na `record.md` §8.1.
- **No timeout o worker não é cancelado.** O cliente recebe erro enquanto a operação pode se completar. É comportamento do manager, vale para todo endpoint que passa por ele — inclusive a baixa do Req. 458327 — e não se corrige neste requisito.
- `Application.ProcessMessages` (`:4456`) tem de sair — é o único `Application.` da unit e não há message loop no serviço.
- Fontes Delphi em **CP1252 com CRLF**; os `.md` em UTF-8.
- Auditoria: `GravaLogCtr` e `IAuditoriaGravacaoCtaReceber` continuam gravados pela classe, valendo para os dois lados.

---

## 6. Critérios de aceitação

- [ ] Estorno recusado com `CONCILIADO` quando o `CTR_DOCBAI` já está conciliado (RN11)
- [ ] Estorno recusado com `VINCULADO_PARA_CONCILIACAO` (RN11)
- [ ] Estorno recusado com `PIX_ATIVO_NO_CREDITO` e com `PIX_ATIVO_NA_PARCIAL` (RN11)
- [ ] Estorno recusado com `PARCIAL_POSTERIOR_BAIXADA` e com `PRINCIPAL_JA_BAIXADA` (RN11)
- [ ] O endpoint grava o estorno sempre com a **data do dia**, qualquer que seja `CFG_RDTEMB` (RN12)

- [ ] `POST /contasareceber/cobranca/estorno` estorna uma baixa em cartão e devolve `sucesso=true` com `sequencialControle` e `empresaBaixa`
- [ ] O estorno alcança **todas** as duplicatas do `CTR_SEQCON`, não só a linha da chave
- [ ] Baixa em cartão tem o `MOVCAR` desfeito e o `MOVBAN` de estorno gravado quando `DeveGravarMovBan` indicar
- [ ] Baixa com juros ou desconto tem o `MOVBAN` separado estornado (`fEstornaMovbanJurosDescto`)
- [ ] Baixa parcial — `pEstornaDuplicataParcial` reconstitui a duplicata original
- [ ] Baixa com comissão de agrupamento (`CTR_CTPCOM`) estorna a comissão
- [ ] Chave inexistente ou já estornada (`fDupJaEstornada`) responde `422`
- [ ] Baixa com cheque à vista ou cheque pré responde `422` nomeando a modalidade (RN02)
- [ ] Baixa em cartão **com parte em crédito** (`CTR_DINHEI <> 0`) é estornada normalmente, não recusada (RN02)
- [ ] Baixa com `CTR_ADTCLI='S'`, `CTR_MOVDES` preenchido ou `CTR_RESCAI=1` responde `422` (RN02)
- [ ] Baixa mista é recusada **inteira**, mesmo que a linha da chave seja cartão puro (RN02)
- [ ] Operador sem `DIRRCXEST` responde `422` nomeando o direito (RN03)
- [ ] `CTR_PORBAI` vazio em linha marcada responde `422` identificando a duplicata (RN04)
- [ ] Duplicata travada por outra estação responde `422` (RN01)
- [ ] `CFG_DEVPIX` desligada gera crédito em vez de devolver, e o estorno conclui (RN06)
- [ ] Recebimento com 90 dias ou mais gera crédito em vez de devolver (RN06)
- [ ] Crédito com `CFG_PCTRPX` ou `CFG_ECTRPX` vazia responde `422` nomeando a configuração (RN07)
- [ ] O crédito é gerado no portador de `CFG_PCTRPX` e evento de `CFG_ECTRPX`
- [ ] Falha no meio do processo faz rollback completo e libera os locks (RN09)
- [ ] `LOGMOVCTR` registra origem `Financeiro.Services.Cobranca.Estorno` (RN10)
- [ ] `CTR_MOTEST` gravado em branco mesmo com `CFG_RMOTES` ligado (RN08)
- [ ] **A tela continua estornando tudo que estornava antes** — inclusive dinheiro, cheque, adiantamento, vale-presente, contas a pagar e modo caixa (validação manual — roteiro na Fase 5)

---

## 7. Fora de escopo

Recusados pelo endpoint com `422` (RN02), mas **mantidos intactos na tela**:

- Baixa em cheque à vista ou cheque pré-datado
- Estorno de adiantamento de cliente e a escolha entre múltiplos adiantamentos (`fGetMenu`, `:556`)
- Duplicata descontada no banco (`CFG_ENCBAN`, `:1196`)
- Estorno pelo resumo de caixa
- Estorno de contas a pagar vinculado, vale-presente

Também fora:

- Fluxo de senha de liberação (RN03) e coleta de motivo (RN08)
- Escolha de portador da baixa pelo serviço (RN04)
- Estorno em lote: uma chave por requisição
- Endpoint de consulta das baixas estornáveis (o consumidor precisa saber o `sequencialBaixa`)
- Refatoração estética do código movido

---

## 8. Dependências e riscos

| Risco | Impacto | Mitigação |
|-------|---------|-----------|
| **Reescrita, não mudança de endereço** — cada linha extraída é chance de regressão, e não há teste automatizado no desktop | Alto — tela crítica do financeiro | Roteiro de validação manual como entregável; commit da extração separado. Referência: o Req. 454631 alterou 4.059 linhas do `untBaixaReceber.pas` |
| **A tela precisa continuar cobrindo o que o endpoint recusa** | Alto | Os portões da RN02 vivem na camada de serviço, **não** na classe. A classe segue tratando todas as modalidades para a tela |
| 9 funções genéricas sem equivalente Linux | Médio | Inventariadas na Fase 1 (`fase1-inventario.md` §2) |
| Transbordo para units genéricas | Médio | Precedente do Req. 454631: 414 linhas em `untFuncoes*` |
| Devolução de PIX chama banco no request | Médio | Timeout > 30 s; `ValorPixJaDevolvidoNoBanco` barra dupla devolução; falha → rollback (RN09) |
| SQL por concatenação no código movido | Médio | Mapeado em `fase1-inventario.md` §4; corrigir para `ParamByName()` ao extrair — é trava de pre-commit |
| Divergência de `CTR_MOTEST` (RN08) | Baixo | Decisão registrada; comunicar ao suporte |
