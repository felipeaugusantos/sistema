# Req. 458327 — Reserva de duplicatas para baixa — plano de execução

Especificação: `spec.md` nesta pasta. Requisito antecessor: **`IA - Copia/454631/`**
— fora de `IA/specs/`, ver nota no `spec.md`.

---

## 1. O que já existe e não precisa ser escrito

| Peça | Onde | Estado |
|---|---|---|
| Trava cooperativa em `LCKATC` | `Services/Core/Services.Core.Task.Lock.pas` | pronta, em produção |
| Mesma trava no desktop | `fontes/genericos/untTLock.pas` | pronta |
| Chave de trava de duplicata | `ValidacaoBaixa.pas:679` — `ChaveLockDuplicata` | pronta |
| Travar / destravar por `CON_ID` | `fLock_Unlock(..., ACon_Id)` — o `DELETE` filtra por `LCK_CON_ID`, não pela conexão viva | pronta |
| **Corpo do endpoint DELETE** | `pDestravaLCKATC('CADREC', con_id)` — `Task.Lock.pas:133` | **pronta** |
| Hash e Base64 | `GetMD5` (`Services.Core.Utils.pas:153`), `fBase64Codifica`/`fBase64Decodifica` (`:1314`/`:1331`) | prontas, já linkadas |
| Destravar lista | `TLock.DestravarListaDuplicatas` | pronta — serve à compensação da RN-01 |
| Liberação manual de trava presa | `fontes/util/untRelacaoLocks.pas` — `TfrmRelacaoLocks`, botão Liberar / F4 | pronta; o filtro da listagem exclui só `%PAF\_%` e `%.IF\_%`, então chave `CADREC` aparece |
| Cálculo do valor corrigido | `TCalculoValorCorrigido.Calcular` | pronta |
| Cálculo da baixa parcial | `TCalculoBaixaParcial.Calcular` | pronta |
| Validações da baixa | `Financeiro.ContasReceber.ValidacaoBaixa.pas` | prontas, catalogadas em `454631/validacoes.md` |
| Operador e empresa por header | `api.core.middleware.pas:70-81` | pronta |

**Não há alteração de schema.** A identidade é o `LCK_CON_ID` (`varchar(10)`, cabe o
connection id do MySQL); o que trafega é ele assinado (RN-06). `LCK_ORIGEM` **não é usado**
— foi avaliado e descartado: identificar por origem obrigaria a filtrar `LCK_ORIGEM`, que
não é indexado.

**Não há TTL nem reclaim** (RN-07). A reserva sai pelo DELETE, pela baixa, ou pela tela de
liberação manual. Em particular, `pDestravaLockForcado` **não deve ser usado** neste
fluxo: apaga por `LCK_CHAACE` sem checar a identidade do dono.

**Consequência da escolha:** sem origem não há contagem de referência em `LCK_QTDTRA`, e a
chave de trava sem parcela — compartilhada entre parcelas do mesmo título — volta a exigir
controle manual na reserva (RN-05).

## 2. Units impactadas

### 2.1 Novas

| Unit | Papel |
|---|---|
| `Services/Core/financeiro/services/Financeiro.Services.Cobranca.Reserva.pas` | Serviço: valida, trava, monta a resposta |
| `.../types/Financeiro.Services.Cobranca.Reserva.Types.pas` | DTOs de entrada e saída |
| `Services/Financeiro.Services.API/Source/api/controller/api.controller.cobranca.reserva.pas` | Controller — POST e DELETE |

### 2.2 Alteradas

| Unit | Alteração |
|---|---|
| `fontes/financeiro/contasareceber/Financeiro.ContasReceber.ValidacaoBaixa.pas` | `con_id` da reserva pela cadeia de três métodos (seção 4) |
| `Services/Core/financeiro/services/Financeiro.Services.Cobranca.Baixa.pas` | Extração do pipeline (seção 3); corte do `ValidarParametros` (3.1); `chaveReserva`; conferência do lote (RN-08); liberação no `finally` (RN-10) |
| `.../types/Financeiro.Services.Cobranca.Baixa.Types.pas` | Campo `chaveReserva` em `TBaixaDuplicatasParams` |
| `Target/Linux/FinanceiroServicesAPI.dpr` | `uses` das units novas |

### 2.3 Intocadas — por decisão

`untBaixaReceber.pas` e qualquer fonte do desktop. A RN-12 depende disso.

## 3. A extração: a costura já existe

Revisto na Fase 1. Era o item que eu estimava como o mais caro do plano; não é.

O `Executar` (`:1101-1128`) já tem o corte pronto:

```pascal
ValidarParametros(AParams)                     // :1101  camada 1 (forma) + camada 3
AbrirDuplicatas(...)                           // :1116
PrepararDuplicatas(...)                        // :1117  camada 1 por linha → popular
                                               //        → acumular → camada 2 do lote
ValidarDireitosBaixaDoLote(...)                // :1121  camada 2, os 7 direitos
── CORTE ────────────────────────────────────────────────────────────────
MontarCartoes · ResolverPix · MontarFormasPagamento     // camada 3
GravarBaixa(...)                               // :1128
```

**A reserva é o trecho acima do corte**, e as quatro chamadas já são procedures
separadas. A extração é um método que as invoca em ordem e para antes do
`MontarCartoes` — **a ordem interna do `PrepararDuplicatas` não é tocada**, que era
exatamente o que se queria evitar.

**Por que isso é seguro:** `AcdsCtaRec` é `TUniClientDataSet` em memória. O `Post` da
linha 705 grava no dataset cliente, **não no banco** — só um `ApplyUpdates` persistiria.
A reserva roda o pipeline inteiro sem efeito colateral em `CADREC`.

### 3.1 A única cirurgia fina: `ValidarParametros`

`ValidarParametros` (`:294-355`) mistura as camadas:

| Trecho | Camada |
|---|---|
| `historico1`, `dataRecebimento`, `duplicatas` não vazia, `ValidarItem` por item | 1 |
| `movimentos` obrigatório (`:317-319`) | 3 |
| `cartao.portador`/`planoContas`, `ValidarPix`, `ValidarCartao` (`:324-337`) | 3 |
| soma `valorRecebido` = soma dos movimentos (`:339-354`) | 3 |

Partir em dois: a parte comum e a de movimentos. A baixa chama as duas; a reserva chama a
primeira mais a conferência da RN-03 — que é a **mesma equação** do trecho `:339-354`, com
`valorTotalAReceber` no lugar do total dos movimentos.

Daí também sai o `historico1` no payload da reserva: é obrigatório na baixa (`:304`), e
sem ele a reserva aprovaria um payload que a baixa recusa.

## 4. O con_id assinado na cadeia de trava

`fLockedByCurrentConnection` (`ValidacaoBaixa.pas:362-371`) decide "essa trava é minha?"
comparando `LCK_CON_ID` com a conexão **viva**:

```pascal
Result := (fGetIdConnectionLock(strChaLck) = untFuncoesGenerica.GetConnectionID) And
          ((LIPConnectionLock = GetIPAddressAsString) Or
           (LIPConnectionLock = VS_IPAddressAsString));
```

Com reserva, o `CON_ID` da trava é de outra conexão — o método diz "não é minha" e a baixa
recusa com "em uso por outra estação". A alteração: comparar contra o `con_id` que veio
decodificado da `chaveReserva`, em vez da conexão viva.

```pascal
If ACon_IdReserva <> '' Then
  Result := (fGetIdConnectionLock(strChaLck) = ACon_IdReserva) And <teste de IP intacto>
Else
  Result := <comparação atual, intacta>;
```

Duas observações que encolhem o trabalho:

1. **O teste de IP continua correto** — a reserva foi feita pelo mesmo processo, então
   `LCK_NUM_IP` bate. Só a comparação de `CON_ID` muda.
2. **A cadeia é curta e fechada.** `fLockedByCurrentConnection` é `strict private`:

```
fDuplicataTravada (público, :690)
  └─ DuplicataJaEmUsoPorOutraEstacao (:352)
       └─ fLockedByCurrentConnection (:362)
```

Um parâmetro `ACon_IdReserva: String = ''` propagado pelos três. **As três chamadas do
desktop** (`untBaixaReceber.pas:3443`, `:6069`, `:6192`) omitem o parâmetro, caem no
default e mantêm o comportamento byte a byte.

## 5. Sequência

### Fase 1 — Classificação das validações ✔ concluída
Saída: `validacoes-classificadas.md`. Placar: 25 de 32 espelháveis, 7 só com pagamento.
P-01 e P-02 encerradas — nenhuma pendência em aberto.

### Fase 2 — Extrair o pipeline de validação ✔ concluída
A extração da seção 3, mais o corte do `ValidarParametros` (3.1). Rodar a suíte do 454631
antes e depois; o placar tem de ser idêntico.

### Fase 3 — O con_id assinado na cadeia de trava ✔ concluída
A alteração da seção 4. Verificável sozinha: com o parâmetro vazio, tudo como hoje.

### Fase 4 — Serviço e DTOs da reserva ✔ concluída
Validar via fase 2 → travar com compensação → responder `{ chaveReserva, mensagem }`.

### Fase 5 — Controller (POST e DELETE) ✔ concluída
Espelhar `api.controller.cobranca.baixa.pas`. DELETE = `pDestravaLCKATC('CADREC', con_id)`,
Sem recuperação de chave perdida (RN-09).

### Fase 6 — Baixa consumindo a chave de reserva ✔ concluída
Campo `chaveReserva`, conferência do lote (RN-08), liberação no `finally` (RN-10), trava sumida
tratada como reserva perdida (risco 7.2).

### Fase 7 — Projeto e suíte ✔ concluída
`uses` no `.dpr`, compilar para Linux, estrutura de testes.

```
1 → 2 → ┬→ 3 ─┬→ 6 → 7
        └→ 4 → 5 ─┘
```

---

As fases abaixo **não estavam no plano original**. Cada uma nasceu de uma decisão tomada
com o requisito já em andamento; a justificativa de cada uma está no `record.md`.

### Fase 8 — PIX vinculado a duplicatas ✔ concluída
`POST /pix/cobrancaimediata` ganha `duplicatas[]` e `chaveReserva`. Com duplicatas, a
cobrança nasce amarrada: o `txId` vai para o `CTR_TX_PIX` de cada título junto com os
valores daquela baixa, que é o que permite ao robô baixá-los depois.

A validação do lote roda **inteira**, mesmo com `chaveReserva`. Não é desperdício: é o que
impede a cobrança de nascer para um lote que não poderia ser baixado — e a população do
dataset, que o `AtualizarCadRecPix` exige, vem junto de graça.

### Fase 9 — `/pix/cobrancaimediata/processarpagamento/{txid}/{emp}` ✔ concluída
Espelha o `Faturamento.Services.Pix.fProcessarPagamento`, com o alvo trocado: lá é um
pedido em `FATGOR`, aqui são as duplicatas amarradas por `CTR_TX_PIX`.

**Não baixa.** Confere as pré-condições, entrega o txid ao robô e depois **lê o banco**
para saber se o efeito aconteceu — `ShellExecute` que volta vazio não distingue sucesso de
falha silenciosa. Essa verificação não é teórica: foi ela que impediu a API de responder
sucesso duas vezes, primeiro com o robô sem conectar no banco e depois com ele bloqueado
pela `PIXTEL`.

### Fase 10 — o PIX sai do `/cobranca/baixa` (RN-13) ✔ concluída
Com o PIX vinculado na criação e baixado pelo robô, o `movimentos.pix` virou uma segunda
rota para o mesmo efeito — e a única que confirmava o pagamento no PSP por conta própria.
Saiu inteira: payload, validação e as ~190 linhas que ela sustentava no service.

**Efeito no contrato:** `movimentos` só aceita `cartao`, então todo lote precisa de ao
menos um cartão. Era pix-ou-cartão; virou cartão.

### Fase 11 — `EInvalidParams` fora do Core ✔ concluída
`fConIdDaChaveReserva` virou TryParse; quem traduz a recusa em 400 são os chamadores do
financeiro. Motivo: existem **três** `untTypesSistema.pas` na árvore e o `.dpr` do robô
aponta para um fork que não declara `EInvalidParams`. Unit do Core que dependa dela está
apostando em qual cópia o projeto consumidor vai resolver.

### Fase 12 — a `PIXTEL` bloqueava o próprio processamento ✔ concluída
Bug **de produção**, achado pelo caso 29 quando ele reprovou na estreia. A reserva que a
API grava ao criar a cobrança impedia o robô de processá-la, e o endpoint só funcionava
depois de ela vencer — 30 min no vinculado, 24h no avulso. Correção: soltar a reserva antes
de despachar o robô, porque entregar o txid a ele é transferir a posse.

Detalhe completo no `record.md`, seção 3.

## 6. Riscos do plano

| Risco | Mitigação |
|---|---|
| ~~Fase 2 é refatoração de alto risco~~ — **reavaliado para baixo na Fase 1** | A costura já existe (seção 3); a ordem interna do `PrepararDuplicatas` não é tocada. Ainda assim: suíte do 454631 antes e depois, e **não reordenar nada** |
| Partir o `ValidarParametros` deixar de fora uma checagem de camada 1 | É a única cirurgia fina que sobrou (seção 3.1). Conferir item a item contra a tabela lá |
| Duplicar validação em vez de extrair | Viola o princípio da seção 3 da spec. Se a extração ficar cara, **parar e reavaliar** — não copiar |
| Usar `pDestravaLockForcado` | Apaga por `LCK_CHAACE` sem checar dono. Proibido neste fluxo |
| Reintroduzir TTL "para segurança" | A RN-07 é decisão consciente e trocou o TTL pela ausência da corrida de reclaim. Reabrir exige reabrir o risco 7.1 junto |
| Escopo vazando para o desktop | RN-12. Alteração em `fontes/` fora de `ValidacaoBaixa.pas` é sinal de desenho fora do trilho |
| Worker apagando reserva (7.2) | Tratado na fase 6, não deixado para depois |

## 7. Testes — quem escreve o quê

Zona Moderna: a infraestrutura existe, **os casos são escritos por analista humano**. A
entrega de quem implementa é o contrato (seção 4 da spec) e a lista de casos a cobrir
(seção 9 — critérios de aceitação).

Criar e registrar o projeto de teste é trabalho de projeto Delphi, portanto de quem
implementa. Escrever caso de teste é do analista.

Três critérios não saem de um `.sql` de caso comum e precisam de roteiro próprio:
**9.8** (trava sumida pelo worker), **9.10** (reserva que não expira) e **9.11**
(liberação pela tela `untRelacaoLocks`). Sinalizar ao analista.

**O que efetivamente foi feito** (27/08): a suíte foi de 17 para **29 casos**, verdes.
Doze novos cobrindo reserva, cancelamento, baixa com chave, PIX vinculado e processamento.
Os arquivos ficam em `Services/Financeiro.Services.API/Scripts/testes/casos/`, e o que a
suíte não alcança está na seção *Fora destes scripts* do `README.md` de lá.

Duas peças de infraestrutura foram necessárias, e são trabalho de quem implementa:

- **`005`** — o `pTesteBaixaReset` passou a limpar `LCKATC`, `MOVPIX`, `PIXTEL` e `LOGMPX`.
  Sem isso a reserva de um caso vira herança do seguinte, que responderia "duplicata não
  disponível" e ficaria **verde afirmando outra coisa**.
- **`006`** — a **âncora de PIX pago**: uma cobrança paga uma única vez em homologação,
  cujo estado local é reposto antes de cada rodada. É o que tornou o sucesso do
  `processarpagamento` automatizável, cenário que eu tinha dado como impossível.

Continua sem cobertura o **crédito de cliente** (`MPX_CHA_CC`) no processamento — precisa
de uma segunda âncora.

---

## 8. Coisas que só se descobre mexendo

Registradas porque custaram tempo e não estão em lugar nenhum do projeto.

**A ordem dos endpoints no Swagger vem da tag, não do código.** O `SortApiPaths` do
`MVCFramework.Middleware.Swagger.pas` ordena os paths por `CompareText` do primeiro
argumento do `MVCSwagSummary`. Entre paths de **mesma tag** o comparador devolve 0 e a
ordem é o que o QuickSort deixar. Nem o `uses` do `.dpr`, nem a ordem de declaração dos
métodos, nem a de registro influenciam — o `TControllersRegister` guarda os controllers
num `TDictionary`, cuja enumeração é por hash. Fixar a ordem exigiria mexer em fonte
vendored do DMVC; foi avaliado e deixado como está.

**A ordem dos campos no payload vem da hierarquia de classes.** `TRttiType.GetProperties`
devolve as propriedades da classe derivada antes das herdadas. Publicar campos numa classe
base joga-os para o fim do JSON. Por isso `TBaixaLoteParams` não publica nada.

**O `.dpr` do Financeiro é UTF-8 com BOM**, ao contrário dos `.pas`, que são CP1252.

**Não usar ferramenta de texto do Bash em fonte Delphi.** O `sed` do Git Bash normalizou um
arquivo inteiro para LF numa tentativa de inserir uma linha. E a Edit tool converte `.pas`
CP1252 para UTF-8, destruindo os acentos — aconteceu nesta sessão, com `svn revert` para
recuperar. O hook `.claude/hooks/delphi-encoding.ps1` existe para impedir isso, mas **não
disparou em nenhuma chamada**. A forma segura é script Python fazendo `replace` em bytes,
com padrões ASCII, conferindo a contagem de bytes >127 antes e depois.
