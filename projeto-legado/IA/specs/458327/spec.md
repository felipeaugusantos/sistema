# Req. 458327 — Reserva de duplicatas para baixa: espelho de validação + trava

| | |
|---|---|
| **Requisito** | 458327 — aberto por Felipe Carvalho Damacena em 25/08/2026 |
| **Sistema** | API Financeiro |
| **Caminho** | Principal |
| **Zona** | Moderna (endpoint + serviço) com um ajuste pontual na Legado (`ValidacaoBaixa`) |
| **Módulo** | Financeiro / Contas a Receber |
| **Serviço** | `Financeiro.Services.API` |
| **Requisito antecessor** | 454631 — baixa de duplicatas por classe central + endpoint REST |
| **Plano de execução** | `plan.md` nesta pasta |

### Texto do requisito, como aberto

> Criar um novo end-point para validar se a duplicata está com os parâmetros corretos
> para realizar a baixa

### Escopo além do texto — declarado, não inferido

O texto pede **validação**. A **reserva** (travar as duplicatas na `LCKATC` entre a
validação e a baixa) foi acrescentada em levantamento com o solicitante, pelo motivo da
seção 1: sem a trava, o operador do balcão pode pegar a duplicata entre a validação e a
baixa, e a validação antecipada não teria protegido de nada no caso que mais importa.

Fica registrado aqui para que o revisor saiba que a trava é escopo acordado, não
iniciativa de quem implementa. Se for cortada, o endpoint continua útil — vira só o
espelho de validação — e o que cai é a RN-01, a RN-05 a RN-10, o `DELETE` e o campo
`chaveReserva` na baixa.

---

## 1. Problema

O endpoint de baixa (`POST /contasareceber/cobranca/baixa`, entregue no 454631) roda
dezenas de validações antes de efetivar. A API consumidora só descobre que uma delas
falhou **depois de já ter cobrado o cliente** — recebe o PIX, chama a baixa e toma 400
porque o operador não tem direito na empresa, porque há boleto de adiantamento no lote,
ou porque o operador do balcão marcou a mesma duplicata na tela nesse meio-tempo.

Dinheiro entrou, título não baixou.

## 2. Objetivo

Um endpoint que é **espelho da baixa**: recebe o mesmo payload que a baixa vai receber,
menos o bloco de pagamento; roda as mesmas validações; e — se tudo passar — **reserva as
duplicatas** na `LCKATC` até a baixa acontecer.

O consumidor só apresenta a cobrança ao cliente depois de a reserva ter aprovado.

## 3. Princípio

> **Um ponto de entrada de validação, chamado duas vezes.**
>
> ```
> reserva → ValidarBaixa(payload sem movimentos)   + Travar
> baixa   → ValidarBaixa(payload completo)         + Efetivar + Destravar
> ```

Não existe uma segunda lista de validações para manter em sincronia com a primeira. É o
mesmo princípio da decisão **D-A** do 454631 — paridade por construção, não por teste —
aplicado um nível acima.

O que a reserva **não** consegue validar é apenas o que depende do instrumento de
pagamento. Esse conjunto está na seção 6 e precisa sair pequeno.

## 4. Contrato

### 4.1 Reserva

```http
POST /contasareceber/cobranca/reserva-duplicatas-baixa
Headers: Empresa, OperadorLogado
```

O corpo é **o corpo da baixa sem o bloco `movimentos`**:

```jsonc
{
  "historico1": "...",                 // obrigatório na baixa (:304) — logo, aqui também
  "historico2": "",
  "dataRecebimento": "26/08/2026",     // dd/mm/aaaa
  "duplicatas": [
    { "numeroDuplicata": "...", "parcela": "...", "especieDocumento": "...",
      "codigoEmpresa": "...",   "codigoCliente": "...",
      "tipoBaixa": "T",                // T ou P — declarado, nunca derivado
      "valorDuplicata": 600.00,
      "valorCorrigido": 617.28,
      "valorRecebido":  617.28,
      "jurosSugerido": 0, "jurosAtraso": 17.28, "multaAtraso": 0,
      "descontoSugerido": 0, "descontoPontualidade": 0, "despesasCobranca": 0 }
  ],
  "valorTotalAReceber": 1234.56        // conferência do total (RN-03)
}
```

**A ordem dos campos é o contrato.** Ela não sai da ordem de declaração da classe por
acaso: o RTTI lista as propriedades da classe derivada **antes** das herdadas, então a
base `TBaixaLoteParams` não publica nada — guarda os campos como `protected` e expõe
métodos, e cada DTO publica o seu conjunto na ordem que quer. Reordenar as propriedades
publicadas muda o que o consumidor lê no Swagger.

**Por que os itens completos, e não só o total.** As validações que mais motivaram o
requisito — boleto de adiantamento, crédito vencido, CNPJ raiz, data de recebimento,
baixa total com desconto — são **de lote**, e o lote (`TAcumuladoLote`) só é montado
depois de cada linha receber `CTR_TIPBAI` e `CTR_VALREC`
(`Financeiro.Services.Cobranca.Baixa.pas:673-707`). Sem `tipoBaixa` e `valorRecebido`
por duplicata, a reserva não roda nenhuma delas. Ver seção 6.

**200**
```jsonc
{
  "chaveReserva": "MjQyMjU0NC41RjIxRjA0NjA5NzExMzI0MzY3REU4MzFBMkNDNzg0Mw",
  "mensagem": "Duplicatas reservadas com sucesso."
}
```

A resposta não devolve as duplicatas. O consumidor já declarou `valorCorrigido` e
`valorRecebido` no pedido; o papel da reserva é **confirmar** que batem, não recalcular e
devolver. Divergiu, é 400.

**400** — mesmo formato de erro da baixa, detalhando o que impediu. **Nada foi travado.**

### 4.2 Cancelamento

```http
DELETE /contasareceber/cobranca/reserva-duplicatas-baixa/{chaveReserva}
```

Decodifica e confere a assinatura (RN-06), depois
`pDestravaLCKATC('CADREC', con_id)` (`Task.Lock.pas:133`, já existe) — filtro por
`LCK_CON_ID` mais prefixo de `LCK_CHAACE`, sem varredura por origem. Assinatura inválida
→ 400.

### 4.3 Baixa (alteração)

```http
POST /contasareceber/cobranca/baixa
```

Ganha o campo opcional `chaveReserva`, **primeiro campo do corpo**:

```jsonc
{
  "chaveReserva": "...",               // opcional
  "historico1": "...", "historico2": "", "dataRecebimento": "26/08/2026",
  "movimentos": { "cartao": { ... } },
  "duplicatas": [ ... ]
}
```

Informada, a baixa decodifica e confere a assinatura (RN-06), reconhece as travas daquele
`con_id` como suas — em vez de recusar a duplicata como em uso por outra estação — e as
libera ao final, tendo dado certo ou não (RN-10). **Ausente, o comportamento de hoje
permanece intacto**, e é assim que os 17 casos da suíte do 454631 continuam passando.

**`movimentos.pix` deixou de existir** — ver RN-13. A baixa deste endpoint é de cartão.

### 4.4 Empresa e operador vêm do header, nunca do corpo

Idêntico à baixa:

| | Origem | Alimenta |
|---|---|---|
| Empresa logada | header `Empresa` | `VS_strCodEmp` — CNPJ raiz, direito do operador |
| Operador | header `OperadorLogado` | `strLoginUsuarioLogado` — validações de direito |
| Empresa da duplicata | `duplicatas[].codigoEmpresa` | identificação do título |

**Motivo, e não é estilo.** `EmpresasComDireitoBaixa` consulta `OPE_EMPCTR` por
`strLoginUsuarioLogado`, alimentado pelo middleware a partir do header. Operador vindo do
corpo quebraria o espelho na validação que motivou o requisito. O controller da baixa
**aplica** o operador, não só confere (`api.controller.cobranca.baixa.pas:73-78`); a
reserva faz igual.

## 5. Regras de negócio

| # | Regra |
|---|---|
| **RN-01** | **Tudo ou nada.** Qualquer duplicata do lote que falhe validação ou já esteja travada faz a reserva não travar nenhuma e devolver 400 com a lista do que impediu. |
| **RN-02** | **`dataRecebimento` vem do payload e a baixa usa a mesma.** É o que torna o recálculo determinístico: mesma data + mesmas duplicatas (protegidas pela trava) = mesma conta. |
| **RN-03** | **`valorTotalAReceber` é conferência**, não fonte. Confrontado contra a soma dos `valorRecebido`. Diverge → 400 com o detalhamento. |
| **RN-04** | **Sem `portador` no payload.** A única validação de portador do fluxo é sobre o `CTR_CODPOR` **da duplicata** (`Cobranca.Baixa.pas:424`); o portador **do pagamento** não é validado em lugar nenhum da baixa. Não há o que espelhar, e validá-lo seria regra nova, não espelho. Premissa do consumidor, registrada: uma modalidade por lote — PIX ou cartão, nunca os dois. |
| **RN-05** | **Chave de trava idêntica à do desktop** — `ChaveLockDuplicata`. Duas por duplicata: sem parcela e com parcela, tomadas pelo próprio `fDuplicataTravada`. A chave sem parcela é compartilhada entre parcelas do mesmo título, e **não exige tratamento**: dentro da requisição o guard `fLockedByCurrentConnection` reconhece a trava como própria e não tenta de novo; a liberação é por `LCK_CON_ID`, que apaga as duas de uma vez. Verificado ao vivo. |
| **RN-06** | **`chaveReserva` = connection id assinado, e a infra é do Core.** `fMontarChaveReserva` / `fConIdDaChaveReserva`, em `Services.Core.Task.Lock.pas` — servem a qualquer serviço. A chave é `Base64URLSafe(con_id + '.' + GetMD5(SECRET + con_id))`: **URL-safe de propósito**, porque viaja no path do `DELETE` e uma `/` do Base64 padrão quebraria o roteamento. Na volta: decodifica, separa no ponto, recalcula a assinatura e compara — bateu, usa o `con_id` direto. **O(1), sem consulta ao banco.** A assinatura impede forjar id alheio; sendo constante compilada, não há segredo a distribuir e restart não invalida chave em aberto. Chave malformada, adulterada ou com assinatura errada → 400. |
| **RN-07** | **A reserva não expira.** Sem TTL e sem reclaim automático. Sai por exatamente três caminhos: o `DELETE` com a chave de reserva, a baixa, ou a tela de liberação manual do desktop (`untRelacaoLocks` — `TfrmRelacaoLocks`, botão Liberar / F4, que já lista e libera chave `CADREC`). Ver seção 7.1. |
| **RN-08** | **A baixa NÃO confere o lote contra o reservado.** Garantir que manda o mesmo lote é do consumidor. Conferir duplicata a duplicata contra a `LCKATC` seria peso sem contrapartida, porque as duas coisas que a conferência protegeria já estão cobertas: título não reservado **é validado do mesmo jeito**, pois a baixa roda o pipeline inteiro nele e tenta travá-lo na hora; e reservado-mas-não-baixado **não vira órfão**, porque a liberação da RN-10 é por `LCK_CON_ID` e leva a reserva toda. Da chave só se exige que seja válida (RN-06). |
| **RN-09** | **Sem recuperação de chave de reserva perdida.** Não há idempotência nem `DELETE` por lista de duplicatas. Perdeu a chave de reserva, a reserva só sai pela tela de liberação manual do desktop. Decisão consciente — ver 7.1. |
| **RN-10** | **Liberação garantida.** Com `chaveReserva` informada, a liberação das travas roda no `finally` da baixa — sucesso ou falha. |
| **RN-11** | **A duplicata tem de existir.** Adiantamento / `TDocAdiantamento` está fora deste requisito. |
| **RN-12** | **Nada muda no desktop.** O operador continua vendo a mensagem genérica do `fGetHostLock`, e libera reserva presa pela tela que já existe. |
| **RN-13** | **A baixa por PIX sai do `/cobranca/baixa`.** O bloco `movimentos.pix` deixa de existir no payload; a baixa deste endpoint é de cartão. Quem recebe por PIX cria a cobrança já vinculada às duplicatas (`POST /pix/cobrancaimediata` com `duplicatas[]`) e depois chama `POST /pix/cobrancaimediata/processarpagamento/{txidpix}/{empresapix}`, que despacha o robô. **Consequência:** não há mais como baixar por PIX em duas chamadas de grupos diferentes — o vínculo tem de ser declarado na criação da cobrança, não na baixa. |

## 6. Divisão das validações — a entrega de análise deste requisito

As validações da baixa vivem em **duas camadas**, e a distinção é o eixo do requisito:

```
loop nas duplicatas:
  ValidarDuplicataParaBaixa(...)                    ← camada 1: lê CADREC como veio
  ...linha recebe CTR_TIPBAI, CTR_VALREC, ...       ← :673-703
  AcumularLinhaLote(...)                            ← :707 — DEPOIS da mutação
ValidarComposicaoDoLote(AAcumulado, ...)            ← camada 2: :715
```

| Camada | Depende de | Exemplos | Espelhável? |
|---|---|---|---|
| **1 — linha** | `CADREC` como carregado | direito de baixa (`OPE_EMPCTR`), empresa × portador, já baixada por outro, excluída, SEFAZ, cancelamento pendente, duplicata travada | Sim, direto |
| **2 — lote** | `TAcumuladoLote`, montado a partir de `CTR_TIPBAI` + `CTR_VALREC` por linha | **boleto de adiantamento** (`:512`), crédito vencido (`:542`), baixa total com desconto (`:536`), CNPJ raiz (`:578`), data de recebimento (`:490`), taxa marketing (`:493`), crédito de empresa (`:499`) | Sim, **e só porque o payload traz `tipoBaixa` e `valorRecebido` por duplicata** |
| **3 — pagamento** | bloco `movimentos` | dados do cartão, cheque | Não — só na baixa |

A camada 3 é o único ponto por onde a baixa ainda pode recusar algo que a reserva
aprovou. Sair pequena e escrita é critério de aceitação.

**Classificação concluída** — `validacoes-classificadas.md` nesta pasta:

| Camada | Itens | Espelhável |
|---|---:|---|
| 1 — linha | 10 | sim |
| 2 — lote | 15 | sim |
| 3 — pagamento | 7 | não |
| Podadas / não aplicáveis | 3 | — |

**25 de 32 validações ativas entram na reserva.** As 7 de fora são exclusivamente do bloco
`movimentos`.

E o corte é uma costura que já existe no `Executar` (`:1101-1128`):

```pascal
ValidarParametros · AbrirDuplicatas · PrepararDuplicatas · ValidarDireitosBaixaDoLote
── corte ──
MontarCartoes · MontarFormasPagamento · GravarBaixa
```

A reserva é o trecho acima do corte. As quatro chamadas já são procedures separadas.

> **Nota de localização.** Os artefatos do 454631 estão em `IA - Copia/454631/`, fora de
> `IA/specs/`. Não foram movidos: pode haver sessão em andamento neles. Migrar é decisão
> do autor da pasta.

## 7. Riscos declarados

### 7.1 Reserva órfã é permanente — e é uma troca consciente

A RN-07 tirou o TTL. Reserva abandonada (app caiu, perdeu a chave de reserva, cliente desistiu) fica
travada **indefinidamente**.

**O que se ganhou com isso.** O TTL trazia junto uma corrida capaz de gerar baixa dupla:
reclaim é ler → apagar → inserir, sem transação (MyISAM), e o apagar seria por
`LCK_CHAACE`, sem checar quem é o dono. Duas requisições concorrentes sobre a mesma
reserva vencida podiam ambas se julgar donas — a segunda apagando a linha recém-criada
pela primeira. Sem TTL, esse modo de falha não existe.

`pDestravaLockForcado` tem exatamente esse defeito (`DELETE ... WHERE LCK_CHAACE = :CHAACE
AND LCK_TENTAT >= N`) e **não deve ser usado** neste fluxo.

**O que se perdeu.** Não há liberação automática **nem recuperação de chave de reserva perdida**
(RN-09). Se a resposta da reserva se perder no caminho — timeout, app fechado, sem sinal —
o consumidor fica sem a chave de reserva, e as duplicatas ficam presas até alguém abrir a tela
`untRelacaoLocks` e liberar.

Isso é atendimento humano, não fluxo: não serve ao cliente parado na frente do vendedor.
**Foi aceito conscientemente**, em troca de não carregar idempotência. Se a operação
reclamar da frequência, o caminho de correção fica registrado: uma chave de idempotência
enviada pelo consumidor e gravada em `LCK_ORIGEM` (`varchar(150)`, ocioso neste fluxo),
que faria o retry reencontrar a reserva em vez de recomeçar. Custa uma consulta por
`LCK_ORIGEM`, que não é indexado — foi o que descartou usá-lo como identidade na RN-06.

**Efeito colateral aceito:** pela mesma tela, um operador pode liberar uma reserva
**viva**, enquanto o cliente ainda está pagando. É o mesmo poder que ele já tem sobre
qualquer trava de estação, e fica registrado como tal.

### 7.2 ~~Worker apagando a reserva~~ — resolvido

**Era o risco mais grave do desenho, e ele deixou de existir.**

O worker encerra toda tarefa com `pDestravarTodosLocksConexaoAtual`
(`Services.Core.Worker.pas:2042`), que apaga as travas da conexão. Para a baixa isso é
inofensivo — ela toma e devolve na mesma tarefa. Para a reserva seria **fatal, e não
raro**: a reserva roda dentro de uma tarefa de worker, então as travas morreriam ao fim
dela, **sempre**. O endpoint responderia 200 sobre uma reserva que já não existia.

Eu tinha registrado isto como colisão rara de `con_id` reciclado. Estava errado por
subestimação: pelo caminho do worker a perda era certa.

**Resolvido pela marca de origem** (seção 10): nenhum delete-all da `LCKATC` toca linha
com `LCK_ORIGEM = 'RESERVA - SERVICE API'`. Verificado ao vivo — as travas sobrevivem ao
encerramento da tarefa.

Sobra apenas a mitigação de barato: a baixa não pressupõe que a trava está lá. Sumiu a
linha, ela revalida e retrava em vez de estourar.

### 7.3 A trava é advisory

Protege apenas quem consulta a chave. Uma rotina em lote que altere despesa de cobrança
direto no `CADREC` sem passar pela trava fura o espelho. Não inventariado; fica
registrado.

### 7.4 Atomicidade do lote

O `UNIQUE KEY (LCK_CHAACE)` garante cada trava individualmente; a do **lote** é por
compensação (RN-01) — trava uma a uma e, na primeira recusa, destrava as já tomadas.

## 8. Decisões pendentes

| # | Assunto |
|---|---|
**Nenhuma.** As duas que existiam foram encerradas:

| # | Assunto | Desfecho |
|---|---|---|
| ~~**P-01**~~ | Validar o portador do PIX na reserva | **Encerrada na Fase 1:** não existe validação do portador do pagamento em nenhum ponto da baixa — não há RN26 a espelhar. Ver `validacoes-classificadas.md`, seção 7.4. Resultado: `portador` saiu do payload (RN-04). |
| ~~**P-02**~~ | Recuperação de chave de reserva perdida | **Encerrada:** não se trata neste requisito (RN-09). Caminho de correção registrado em 7.1, caso a operação reclame. |

## 9. Critérios de aceitação

> **Situação em 26/08/2026.** Verificados ao vivo contra `10.0.0.205:8083`, base
> `2_30_BELAT_TC`, empresa 592: **1, 2, 4, 4b, 5, 6, 9, 12, 13**. O roteiro e os números
> estão em `tasks.md`. Não verificados: **3** (exige a tela do desktop), **8** e **11**
> (exigem forjar estado), **10** (exige espera), **14** e **15** (exigem massa
> específica).

1. Reserva com lote válido devolve 200 com `chaveReserva` e mensagem, e existem linhas em `LCKATC` com chave `CADREC...` e o `LCK_CON_ID` que a chave carrega.
2. Reserva com uma duplicata já travada no desktop devolve 400 e **nenhuma** linha nova em `LCKATC` (RN-01).
3. Com a reserva ativa, o operador não consegue marcar a duplicata na tela e recebe a mensagem de "outra estação".
4. Baixa com `chaveReserva` efetiva e **não sobra linha** em `LCKATC` com aquele `LCK_CON_ID`.
4b. `chaveReserva` com assinatura adulterada devolve 400, na reserva e na baixa (RN-06).
5. Baixa **sem** `chaveReserva` se comporta exatamente como antes deste requisito.
6. `DELETE` com a chave de reserva apaga as travas daquela reserva e nada além delas.
7. ~~Baixa cujo lote difere do reservado devolve 400~~ — **removido** junto com a RN-08.
8. Baixa com `chaveReserva` cuja trava sumiu revalida, retrava e efetiva — não estoura.
9. Baixa que falha no meio, com `chaveReserva`, libera as travas da reserva (RN-10).
10. Reserva não liberada continua travada após qualquer intervalo — não há expiração (RN-07).
11. Reserva presa aparece na tela `untRelacaoLocks` e é liberável por lá.
12. Lote com duas parcelas do mesmo título reserva e libera corretamente a chave sem parcela (RN-05).
13. Reserva com `valorTotalAReceber` divergente da soma dos `valorRecebido` devolve 400 com o detalhamento (RN-03).
14. Reserva com `valorCorrigido` divergente do que o sistema calcula para a `dataRecebimento` informada devolve 400.
15. Lote com boleto de adiantamento é recusado **na reserva**, não na baixa — a validação de camada 2 roda de verdade.

---

## 10. Infraestrutura de reserva no Core — serve a qualquer serviço

O mecanismo não tem nada de específico do Financeiro, e foi escrito para Suprimento e
Faturamento reusarem sem configurar nada. Vive em `Services.Core.Task.Lock.pas`, seção
**RESERVA DE TRAVA**.

```pascal
const
  LCK_ORIGEM_RESERVA = 'RESERVA - SERVICE API';

function  fMontarChaveReserva(const ACon_Id: String): String;
function  fConIdDaChaveReserva(const AChaveReserva: String): String;
procedure pMarcarTravasComoReserva(const ACon_Id, APrefixoChave: String);
```

**O problema que resolve.** Uma reserva é uma trava que precisa sobreviver à requisição
que a criou. Isso não acontece sozinho: o worker encerra toda tarefa apagando as travas da
conexão. A proteção é a marca — os três delete-all da unit passaram a excluir
`IFNULL(LCK_ORIGEM,'') <> 'RESERVA - SERVICE API'`.

**Por que uma constante única e não uma origem por serviço.** Igualdade em vez de `LIKE`,
e — mais importante — a proteção vale para reserva de **qualquer** serviço. Com origem por
serviço, um worker do Financeiro que recebesse um `con_id` reciclado apagaria uma reserva
do Faturamento, porque a origem seria diferente da sua. O preço é a tela de liberação não
distinguir qual serviço segura a trava; o IP, a máquina e o operador continuam lá.

**Desempenho.** A origem nunca é usada para *procurar*, só para *descartar*. O `EXPLAIN` do
delete-all dá `type: ref`, `key: IDX_LCKATC_01`, 1 linha — o `<>` só é avaliado na linha
que o índice já encontrou. Identificar a reserva *por* origem seria varredura, e foi
descartado por isso.

**Como um serviço novo usa.** Chama o pipeline que toma as travas, depois
`pMarcarTravasComoReserva(con_id, '<prefixo da chave de trava dele>')`, esvazia a lista do
`TLock` para o destrutor não soltar, e devolve `fMontarChaveReserva(con_id)`. Na volta,
`fConIdDaChaveReserva` e `pDestravaLCKATC(prefixo, con_id)`.

**O que a marca não protege, de propósito:** a liberação por `LCK_CON_ID`, que é como o
dono devolve a reserva, e a tela `untRelacaoLocks` do desktop, que apaga a linha
selecionada. São as duas válvulas de escape.
