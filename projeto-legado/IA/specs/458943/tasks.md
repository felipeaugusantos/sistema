# Tarefas — Req. 458943

**Referência:** `spec.md` (o quê), `plan.md` (como), `record.md` (por quê — decisões,
achados e armadilhas).

> A narrativa das sessões saiu daqui em 03/09/2026 e está no `record.md`. Este
> arquivo é checklist.

---

## Fase 1 — Inventário de dependências — CONCLUÍDA

- [x] Destino das 14 units não provadas no Linux
- [x] Usos de `frmBaixaReceber` — 1 bloco, UI pós-transação
- [x] `untEstornoPagar` é órfã
- [x] Destino de `untConsultas` — fica no form
- [x] Genéricas que precisam de versão Linux (revisto na Fase 2 — nenhuma precisou)
- [x] Trechos de SQL por concatenação
- [x] Timeout e comportamento em falha da devolução de PIX
- [x] Relatório `fase1-inventario.md`
- [x] Checkpoint com o requisitante — escopo reduzido a cartão e PIX

## Fase 2 — Classes compartilhadas (Zona Legado) — CONCLUÍDA

- [x] `CFG_PCTRPX` e `CFG_ECTRPX` em `untCfgRepositorio.pas` (RN07)
- [x] `Financeiro.ContasReceber.EstornoTypes.pas`
- [x] `Financeiro.ContasReceber.ValidacaoEstorno.pas` — RN02, RN11, 30 métodos
- [x] `Financeiro.ContasReceber.DevolucaoPix.pas` — RN06
- [x] `Financeiro.ContasReceber.FiltroEstorno.pas` — carga completa (2 passadas + fallback `MOVGER` + crédito de `LOGCTR`)
- [x] `Financeiro.ContasReceber.EstornoDuplicatas.pas` — o motor
- [x] Portar `fEstornaDuplicataConjugadas` → `fExecutarEstorno`
- [x] Portar `pConfirmaEstornoInterno` → `fEstornarDuplicatas`
- [x] Blocos fora do escopo sob `{$IFNDEF LINUX}`
- [x] `pEmitirMensagem` → `pAddErro`; `pSetFocus`/`fMensagem` não atravessam
- [x] Genéricas Windows-only — nenhuma precisou de versão nova
- [x] Compilar Windows a cada unit
- [x] **Compilar Linux** — `Success` em 03/09 (`record.md` §8.11)

> **Lacuna aceita:** `fBloquearEstornoPedidoJaFaturado` é `{$IFNDEF LINUX}` e vale
> para espécie `PD`, que está no escopo. O serviço não terá essa validação.

## Fase 3 — Desktop (Zona Legado) — CONCLUÍDA

- [x] `pConfirmaEstornoInterno` chama a classe via `fEstornaDuplicatas`
- [x] RN12 — `fEstornoComDataDoDocumento` decide a data no form
- [x] Traduzir `TErrosEstorno` para `pEmitirMensagem` / `pSetFocus`
- [x] `SugerirRebaixaConjugadas` para a pergunta de `:6159`
- [x] `pCriaTemporaria` religado ao `TFiltroEstornoSQL` (680 → 166 linhas)
- [x] Remover código morto — 42 métodos, 3.852 linhas
- [x] Delegar os 16 métodos duplicados restantes
- [x] Restaurar os 47 literais que perderam acento
- [x] Tirar a nomenclatura "lote" — 65 identificadores, 47 trechos
- [x] Incluir as 5 units no `autcom.dpr` (BOM UTF-8 preservado)
- [x] Compilar `autcom.groupproj`
- [ ] Remover units órfãs do `uses` — **não feito**: detector heurístico deu falso
      positivo em `untTypesSistema`. Se for fazer, uma por vez com compilação entre

**Resultado:** `untEstornoReceber.pas` 8.693 → 3.416 linhas (−61%).

### Validação na tela

- [x] Fora do escopo do endpoint: dinheiro, cheque à vista, cheque pré, ordem de
      pagamento — **validado 03/09** (`record.md` §8.2 para o que ficou de fora)
- [x] **PIX — devolução automática validada em 03/09** (`record.md` §8.5): Pix QR
      Code, baixa total, estorno com `DEVOLUCAO PIX` → status DEVOLVIDO em ~6 s
- [x] **PIX gerando crédito — validado em 03/09** (`record.md` §8.6): CC de
      −22,47, portador e evento pela tela, `MOVBAN` fechando principal + juros
- [x] **Juros — validado** na mesma rodada: R$ 16,12 revertidos
- [x] **Cartão isolado — validado em 03/09** (`record.md` §8.8): 12 parcelas em
      2 cartões, `MOVCAR` zerada, `DEL_MOVCAR` com as 12, `MOVBAN` fechando
- [x] **RN01 provada em 03/09** (`record.md` §8.16): três duplicatas baixadas
      juntas, estorno informando **uma** alcançou as três — e não encostou numa
      baixa anterior do mesmo título
- [x] **Estorno de baixa parcial** validado (`record.md` §8.17): saldo fundido
      de volta, 36,33 + 20,00 = 56,33
- [ ] Dentro do escopo, ainda: **conjugadas**. **Desconto** é o mesmo mecanismo
      do juros com o sinal trocado — os dois se abatem e só um é gravado
      (`record.md` §8.6) — risco baixo, não é bloqueio
- [ ] **Preencher `CFG_PCTRPX` e `CFG_ECTRPX`** — vazias nas 87 empresas. Sem
      isso o endpoint recusa todo estorno de Pix com crédito (`record.md` §8.6)
- [ ] Modo caixa (`blnResCai`) pelo Resumo de Caixa
- [ ] Estorno automático pelo Cancelamento de Documentos
- [ ] Adiantamento, vale-presente, contas a pagar
- [ ] **Commit próprio da extração**, sem alteração de comportamento

## Fase 4 — Serviço e API (Zona Moderna)

- [x] `Financeiro.Services.Cobranca.Estorno.Types.pas` — Params e Result
- [x] `Financeiro.Services.Cobranca.Estorno.pas` — `TEstornoService`
- [x] Payload → `EInvalidParams` (400)
- [x] RN02 sobre todas as duplicatas da baixa
- [x] RN03 — `DIRRCXEST`, recusa sem senha
- [x] RN06 — ação do PIX derivada, sem campo no payload
- [x] RN07 — `CFG_PCTRPX` / `CFG_ECTRPX`; vazia → 422 `CFG_PCTRPX_VAZIA`
- [x] RN10 — origem `Financeiro.Services.Cobranca.Estorno`
- [x] RN12 — sempre data do dia
- [x] Traduzir `TErrosEstorno` em 422
- [x] `AddMethod('TCobrancaEstornoService.Executar', …)`
- [x] `api.controller.cobranca.estorno.pas` + `initialization`
- [x] Swagger: rota, headers, 200/400/401/422
- [x] Incluir as 8 units no `FinanceiroServicesAPI.dpr`
- [x] Conferir o timeout do worker para o caminho de devolução — **teto é 120 s**,
      não 30 s, e o pior caso real **cabe**: 48 s. Medição no `record.md` §8.1
- [x] **Compilar para Linux via PAServer** — `Success` em 03/09. Seis erros,
      cinco deles atrito com o legado (`record.md` §8.11)

## Fase 5 — Testes e entrega

- [x] `api.controller.cobranca.estorno.test.pas` — em `Source/api/controller/`
- [x] `Target/Linux/Test_Cases/Cobranca/EstornoTest.inc` — **32 casos reservados**
      (ids 51 a 82), todos comentados. É a *lista de casos a cobrir*, que é o
      entregável de quem implementa; os `.sql` são escritos pelo analista
- [x] **`Scripts/testes/008_INFRA_PROCEDURE_ESTORNO.sql`** — escrita em 03/09.
      **Versão 2**: 17 blocos + RESUMO com contagem de todos, chaveada pela
      duplicata do request. A versão 1 só enxergava cartão — ver `record.md` §8.3. **Falta aplicar na
      base `api-teste` (`2_30_BELAT_TC`)** — o MCP é somente leitura. Motivo de
      existir:
      a `pProcessoBaixaDuplicatasResponse` **não serve** para o estorno. Ela monta
      o filtro a partir de `CADREC WHERE CTR_SEQCON = <seqcon>`, e depois do
      estorno não existe mais linha com aquele sequencial — todos os blocos
      voltariam vazios e o caso passaria sem conferir nada. A procedure nova tem
      de ser chaveada pela **duplicata do request**, e precisa de bloco de
      `DEL_CADREC` (é lá que as parciais estornadas ficam)
- [ ] Incluir no `FinanceiroServicesTEST.dpr` — **só depois do primeiro caso
      existir**. Um `[Test]` parametrizado sem nenhum `[TestCase]` ativo não tem
      argumento para receber e derruba a suíte inteira, não só este fixture
- [ ] Roteiro de validação manual da tela (entregável)
- [x] **Ponta a ponta pela API validado em 03/09** (`record.md` §8.12): login,
      consulta, baixa e estorno, com o banco batendo
- [ ] **Retestar cartão PELA TELA** — o `fEstornaMovCar` mudou para as duas
      plataformas (`record.md` §8.13); a validação de tela de 03/09 ficou velha
- [ ] Executar a suíte e validar os critérios do `spec.md` §6

## Fase 6 — Revisão e commit

- [ ] `svn add` dos 10 arquivos novos — as 5 classes compartilhadas, Types,
      Service, Controller, a unit de teste e o `EstornoTest.inc`
- [ ] Encoding: `.pas` em CP1252 com CRLF, sem `EF BF BD`
- [ ] `autcom.dpr` continua UTF-8 com BOM
- [x] Travas do pre-commit em todos os arquivos tocados — varridas em 03/09.
      **Zero travas dentro do diff deste requisito.** Os 11 arquivos novos e o
      `untEstornoReceber.pas` estão limpos. Dois sinalizados são pré-existentes e
      fora do diff: `Application.CreateForm` do form principal no `autcom.dpr`
      (linha 4922) e três `StrToFloat` no `untBaixaReceber.pas`
- [x] Nenhum SQL novo por concatenação **de valor**. Os 9 pontos de concatenação
      nas classes novas concatenam **nome de objeto ou operador**, não dado de
      entrada — ver `record.md` §8.4 para a classificação um a um
- [x] Decidido em 03/09: as 3 concatenações de valor pré-existentes **ficam como
      estão**. Princípio do requisitante: não quebrar o autcom desktop. Detalhe e
      justificativa no `record.md` §8.4
- [ ] Decidir se `untBaixaReceber.pas` (só formatação, outro requisito) entra no commit
- [ ] `/citel-aprovaRequisito`
- [ ] Gate DelphAI e token
- [ ] Commit da extração: `Req. 458943` + token
- [ ] Commit da API: `Req. 458943` + token
- [ ] Comunicar ao suporte as divergências tela × API das RN08 e RN12

---

## Estado em 03/09/2026, fim do dia

### Compila

| Projeto | Como | Resultado |
|---|---|---|
| `FinanceiroServicesAPI` | `_ci/ci.py --projeto FinanceiroServicesAPI` | **ok, 260s**, zero hint nos arquivos do requisito |
| `FinanceiroServicesTEST` | `_ci/ci.py --projeto FinanceiroServicesTEST` | **ok, 65s** |
| `autcom` (desktop) | MSBuild `autcom.dproj /p:Config=Debug /p:Platform=Win32` | ver `autcom_build.log` |

A esteira do `Services/TestExecute/_ci` compila sem IDE. `LEIAME.txt` na pasta.
**Um build por vez** — os 104 projetos dividem `Services/tmp` e `Services/bin`,
e o `ci.py` cria `build.trava`, que o TestExecute **não enxerga**.

### Testes automatizados

- [x] `api.controller.cobranca.estorno.test.pas` registrada no
      `FinanceiroServicesTEST.dpr` (junto com o `...Estorno.Types`), e a suíte compila
- [x] **7 casos escritos e validados** pelo `validar_casos.py` da casa —
      `Scripts/testes/casos/0051` a `0057`. São os **autocontidos**: recusa de
      payload (400) e chave inexistente (422). Não preparam nem alteram estado,
      então rodam em qualquer base com a infra aplicada
- [x] `EstornoTest.inc` com os 7 ativos e a lista de cobertura (ids 58+) comentada
- [ ] **Casos 58+ são do analista** (CLAUDE.md: quem implementa entrega o contrato
      e a lista; quem escreve o caso é o analista). Cada um precisa de baixa
      montada no `sql_before_exec_test`, e o dado varia por base

### Defeitos achados e corrigidos hoje

Detalhe em `record.md` §8.20. Cinco, sendo **dois que quebrariam o desktop**:

| | O que era | Onde |
|---|---|---|
| D1 | chave lida da primeira linha do lote, não da informada | serviço |
| D2 | validação do portador nunca existiu, só o comentário dizia que sim | serviço |
| **D3** | `MarcarTodas` sem o gate `fValidaMesmoRecebimento`: uma chave com nove baixas desfaria as nove | serviço |
| **D4** | `CTR_RESCAI = 1` sumiu da 2ª passada | **desktop** (Resumo de Caixa) |
| **D5** | `fParcialBaixadaJuntoComPrincipal` estreitado: recusa nova | **desktop** |

Mais três menores: `ResolverPix` lia da primeira linha, o flag do crédito
acumulava com `Or`, e os direitos `PERMDEVRECPIX` / `PERMESTSEMDEVPIX` não eram
exigidos.

### Cobertura contra o SVN

`scratchpad/cobertura.py` confere **toda rotina** da origem r490656 — 109
métodos e 9 funções locais — contra os arquivos de hoje. Resultado: todas
presentes, exceto as renomeadas (`fGetSqlWhereSeqCon`→`WhereDosSequenciais`,
`fTabelaCredito`→`TabelaDoCredito`, `pCarregaDadosCredito`→`CarregarDadosDeCredito`,
`RegistroCreditoAdiantamentoEstornado`→`CreditoDeAdiantamentoEstornado`,
`FiltroPossuiBaixaDeDuplicatasComTotalEParcial`→`SeqConComBaixaTotalEParcial`),
a inlined (`fChequeExiste` dentro de `fEstornaCheque`) e **uma que sumiu de
verdade** — ver decisão 2 abaixo.

**Rodar esse script sempre que mexer na extração.** Foi varredura por
`TClasse.metodo` que deixou passar as funções locais dos defeitos.

---

## DECISÕES QUE DEPENDEM DE VOCÊ

### 1. `untBaixaReceber.pas` entra no commit?

Está modificado **só em formatação** e pertence ao **Req. 454631**, não a este.
Opções: deixar de fora (`svn revert`) e commitar no requisito dele, ou incluir
aqui assumindo a mistura. **Não mexi.**

### 2. ~~`fPedePortadorCaixa`~~ — RESOLVIDO em 04/09/2026

**Eu tinha errado a gravidade.** Escrevi que era "só conjugadas"; não era.
`fEstornaDuplicataConjugadas`, apesar do nome, é o **fluxo principal** do
estorno da tela (origem r490656:1204) — o "conjugadas" vem de ele tratar as
conjugadas no fim. O `fPedePortadorCaixa` valia, portanto, para **todo** estorno
de duplicata baixada pelo caixa em dia diferente do caixa corrente.

Reposto no form (é diálogo, não vai para a classe):

- `fPedePortadorCaixa` — cópia da origem r490656:2440
- `fPortadorParaDebitoDeCaixaAnterior` — o laço que a chamava, que na origem
  vivia dentro do `fEstornaDuplicataConjugadas` (r490656:5423)
- chamado em `fEstornaDuplicatas`, com o record montado e antes de a classe
  gravar qualquer coisa

Detalhe em `record.md` §8.22.

### 3. Os portões de direito do Pix

Implementei `PERMDEVRECPIX` e `PERMESTSEMDEVPIX` como **recusa** quando o
operador não tem o direito — a tela pede senha de supervisor, e headless não tem
a quem pedir. O operador **998 tem os dois**, então o ambiente de teste segue
funcionando.

Se a intenção do endpoint for rodar sem esse controle, é só dizer e eu tiro —
mas aí some também a trilha de autorização que a tela grava em LOGVAR/LOGLIB.

### 4. A `008_INFRA_PROCEDURE_ESTORNO.sql` precisa ser aplicada

A base tem a **versão 2**; a unit de teste exige a **3** e falha de propósito se
a marca não bater. **Não consigo aplicar** — o acesso MySQL desta sessão é
somente leitura.

### 5. Não commitar o que não é deste requisito

A working copy tem modificações de **outra sessão**, que eu não toquei:

- `ConsultarPagamentosPixService.dpr` — troca `TFormatSettings.Create('pt-BR')`
  por `FormatSettings_ptBR` (outro requisito)
- `FinanceiroServicesAPI.deployproj` — troca `swagger-ui-bundle.js` por `swagger-ui.js`
- `Packages/Tintas/View/package/Tintas.View.res` — binário
- `FinanceiroServicesTEST.dproj` — perdeu um `Debugger_RunParams` (ruído de IDE)

E os gerados de build, que o próprio `ci.ini` manda reverter: `version.inc`,
`svn_rev.inc`, `rev.inc`, `opcoes.ini`, `*.identcache`, `*.local`.

---

## Para commitar

### `svn add` (12 arquivos novos)

```
padra_atualizado/fontes/financeiro/contasareceber/Financeiro.ContasReceber.EstornoTypes.pas
padra_atualizado/fontes/financeiro/contasareceber/Financeiro.ContasReceber.ValidacaoEstorno.pas
padra_atualizado/fontes/financeiro/contasareceber/Financeiro.ContasReceber.DevolucaoPix.pas
padra_atualizado/fontes/financeiro/contasareceber/Financeiro.ContasReceber.FiltroEstorno.pas
padra_atualizado/fontes/financeiro/contasareceber/Financeiro.ContasReceber.EstornoDuplicatas.pas
padra_atualizado/Services/Core/financeiro/services/types/Financeiro.Services.Cobranca.Estorno.Types.pas
padra_atualizado/Services/Core/financeiro/services/Financeiro.Services.Cobranca.Estorno.pas
padra_atualizado/Services/Financeiro.Services.API/Source/api/controller/api.controller.cobranca.estorno.pas
padra_atualizado/Services/Financeiro.Services.API/Source/api/controller/api.controller.cobranca.estorno.test.pas
padra_atualizado/Services/Financeiro.Services.API/Target/Linux/Test_Cases/Cobranca/EstornoTest.inc
padra_atualizado/Services/Financeiro.Services.API/Scripts/testes/008_INFRA_PROCEDURE_ESTORNO.sql
padra_atualizado/Services/Financeiro.Services.API/Scripts/testes/casos/005[1-7]_TEST_ESTORNO_*.sql   (7 arquivos)
```

### Modificados que são deste requisito

```
padra_atualizado/autcom.dpr                     (5 units; UTF-8 com BOM - preservado)
padra_atualizado/fontes/financeiro/contasareceber/untEstornoReceber.pas
padra_atualizado/fontes/financeiro/cartoes/untLogMca.pas
padra_atualizado/fontes/configuracoes/untCfgRepositorio.pas
padra_atualizado/Services/Core/financeiro/services/Financeiro.Services.Workers.pas
padra_atualizado/Services/Financeiro.Services.API/Target/Linux/FinanceiroServicesAPI.dpr
padra_atualizado/Services/Financeiro.Services.API/Target/Linux/FinanceiroServicesTEST.dpr
```

### Sequência

1. decidir os itens 1 a 3 acima
2. aplicar a `008` versão 3 e os casos `0051`–`0057`
3. `/citel-aprovaRequisito`
4. gate DelphAI → token
5. commit: 1ª linha `Req. 458943` + token
