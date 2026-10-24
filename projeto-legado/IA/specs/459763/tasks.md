# Req. 459763 — Checklist de execução

Legenda de dono: **[impl]** quem implementa · **[analista]** analista de teste · **[wagner]** solicitante

---

## Fase 0 — Destravar

- [x] **[wagner]** Publicação simultânea de API e frontend — **não é necessário**. O REPOR+ ainda
      está implementando a integração; não há consumidor na forma antiga, o endpoint não ganha
      versão (03/09/2026, spec §8)
- [x] **[impl]** `svn add IA/specs/459763`

## Fase 1 — Infra de sequência (`Services.Core.*`)

- [x] `Services.Core.Utils.pas` — `fJsonAndamento` ganha `ANumero: Integer = 0` e
      `ATotalEtapas: Integer = 0` (declaração na interface **e** na implementação)
- [x] `fJsonAndamento` só adiciona `numero` e `totalEtapas` quando `> 0` (RN08)
- [x] `Services.Core.Worker.pas` — `TWorkerTaskProgress` ganha `FNumero` e `FTotalEtapas`
- [x] Nova sobrecarga `pDefinirEtapa(const AEtapa: string; ANumero, ATotalEtapas: Integer; APosicao, ATotal: Int64)`
- [x] Conferir que as sobrecargas **existentes** de `pDefinirEtapa` e o `pDefinirProgresso`
      **não** tocam `FNumero`/`FTotalEtapas` — é essa omissão que implementa a RN01
- [x] Guarda de "texto igual não suja" passa a comparar também `FNumero` e `FTotalEtapas`
- [x] `pLimpar` zera os dois campos novos
- [x] `fColher` ganha `out ANumero, ATotalEtapas: Integer`
- [x] `pGravarAndamento` e `pAmostrarAndamento` repassam os dois valores (incluindo a colheita
      final da linha ~1805)
- [x] Comentário na declaração de `TWorkerTaskProgress` explicando por que só uma sobrecarga
      mexe no número

## Fase 2 — Catálogo de etapas (`Cotacao.Giro.pas`, `Workers.pas`)

- [x] `TCotacaoGiroEtapaSeq` com os 8 valores, `CEtapasGiro` e `CTotalEtapasGiro = Ord(High(...)) + 1`
- [x] Textos do catálogo **idênticos** aos atuais, caractere por caractere (log de produção)
- [x] `TCotacaoGiroEtapa` ganha `ANumero, ATotalEtapas: Integer`
- [x] `pEtapa` / `pDetalhe` locais em `TCotacaoGiroExecutor.fCalcular`
- [x] `pEtapa` / `pDetalhe` locais em `TCotacaoGiroGravador.fGerar`
- [x] Reclassificar as 11 chamadas conforme a tabela do plan §2.4 — 8 numeradas, 3 detalhes
- [x] `WriteLog('[cotacao-giro] ' + ...)` preservado nos dois helpers
- [x] `Workers.pas` — callback anônimo despacha para a sobrecarga numerada quando `ANumero > 0`,
      e para a sem número quando `= 0`

## Fase 3 — DTO (`Cotacao.Types.pas`)

- [x] `uses` ganha `MVCFramework.Nullables`
- [x] `TCotacaoGiroEtapaDTO` com `numero`/`totalEtapas` (`NullableInt32`), `descricao`
      (`NullableString`) e `progresso` (`TCotacaoGiroProgresso`, nil-ável)
- [x] Destrutor de `TCotacaoGiroEtapaDTO` libera `Fprogresso`
- [x] `TCotacaoGiroAndamento`: `etapa` vira objeto nil-ável; `progresso` sai da raiz;
      `dataInicio`/`dataFim`/`mensagem` viram `NullableString`; `qtdItensGerados` vira `NullableInt32`
- [x] Construtor de `TCotacaoGiroAndamento` **não** instancia `Fetapa`
- [x] Destrutor libera `Fetapa`
- [x] Reescrever o comentário de `TCotacaoGiroProgresso` — a justificativa "instancia sempre"
      deixou de valer; explicar por que agora é nil-ável (RN07)
- [x] `MVCSwagJsonSchemaField` de cada propriedade nova/alterada, com texto que descreva o
      comportamento por status

## Fase 4 — Montagem da resposta (`Cotacao.Consulta.pas`)

- [x] `pPreencherProgresso` passa a `fLerEtapa(const AJsonStatus): TCotacaoGiroEtapaDTO`,
      devolvendo `nil` em JSON vazio ou ilegível
- [x] Ler `numero`/`totalEtapas` do JSON, ausência → `null` (base sem coluna `_STATUS`)
- [x] `progresso` só instanciado quando `total > 0`; `percentual` continua calculado, nunca persistido
- [x] `PENDENTE`: `etapa := nil`, datas/qtd/mensagem `null` (RN03, CA01)
- [x] `PROCESSANDO`: etapa completa, qtd/mensagem `null` (CA02, CA03, CA04)
- [x] `CONCLUIDO`: mover `descricao` para `mensagem` **antes** de anular; `FreeAndNil(progresso)`;
      `numero`/`totalEtapas` preservados; `qtdItensGerados` do `_RESULT` (RN04, CA05, CA06)
- [x] Constante de fallback da `mensagem` do `CONCLUIDO`
- [x] `ERRO`: `descricao` e `progresso` intactos; `mensagem` do `_RESULT`; qtd `null` (RN05, CA07)
- [x] `FindField(_STATUS)` preservado (CA13)
- [x] Tolerância a JSON inválido preservada — devolve ausência, nunca levanta (RN09)

## Fase 5 — Aviso nomeado (`Cotacao.Notificacao.pas`)

- [x] `fNomeDaCotacao(const AstrSeqRascunho): String` com `SELECT COT_DESCRI FROM COTGER_RES
      WHERE AUTOINCREM = :SEQ`, `ParamByName`
- [x] Falha na leitura → vazio + `WriteLog`, sem levantar (RN11)
- [x] Leitura **antes** do `pGravar`, fora da transação dele
- [x] Quatro literais de mensagem — dois nomeados, dois de fallback (spec §6)
- [x] Nome em branco cai no fallback, sem aspas vazias (CA11)
- [x] Verificar encoding Windows-1252 dos literais acentuados após salvar
- [x] `pNotificarConclusao` continua não levantando exceção (RN12)

## Fase 6 — Build

- [x] **Build** (não Compile) de `SuprimentoServicesAPI` — Release, Linux
- [x] **Build** de `FaturamentoServicesAPI` — serviço não tocado, prova que a alteração aditiva
      em `Services.Core.*` não quebrou ninguém
- [x] Conferir tamanho do `.so` gerado (Release, não Debug)

## Fase 7 — Contrato de teste

O que quem implementa entrega: o contrato e a lista de casos. **Escrever os casos é do analista.**

- [x] **[impl]** Verificar em runtime que `TApiUtils.JsonAs<TCotacaoGiroAndamento>` desserializa
      `"etapa": null` sem AV — a suíte faz ida e volta no DTO (`api.controller.cotacao.test.pas:348`)
- [x] **[impl]** Verificar que `TApiUtils.CompareJson` compara `null` corretamente contra o
      esperado
- [x] **[impl]** Verificar que `MEN_MENSAG` acentuado sai correto no banco (charset da conexão)
- [x] **[impl]** Entregar ao analista o corpo esperado dos 4 status (spec §5) e os textos de
      `MEN_MENSAG` (spec §6) como JSON/SQL pronto para colar
- [x] **[impl]** Conferir se os casos existentes de andamento quebram com a forma nova — **não
      quebram**. `CompareJson` itera só as chaves do esperado e ignora chave extra na resposta, e
      os casos 9, 10 e 11 assertam apenas `status`, `qtdItensGerados` e `mensagem`, todos ainda na
      raiz. O bloco `SSATSK` do `json_validate` não assere `SST_STATUS`. Nenhuma migração de dado
      de teste é pré-requisito para rodar a suíte
### Validado na corrida de 03/09/2026 17:44 — 29/29 passaram, API republicada

- [x] **CA01** PENDENTE saiu `{"status":"PENDENTE","etapa":null,...}`, todos os campos `null`
- [x] **RN01/RN02** `SST_STATUS` das tarefas 793–796 com `"numero":8,"totalEtapas":8`
- [x] **RN04** CONCLUIDO com `mensagem:"Itens gravados no rascunho."` e `qtdItensGerados:60`
- [x] **CA09/CA10** `MEN_MENSAG` nas quatro variantes com `de "TESTE API"`, acentuação íntegra
- [x] Casca vazia de `etapa` corrigida — o caso 9 devolvia objeto de quatro `null`, agora `null`

### Validado por GET direto na API — 03/09/2026 18:07, `10.0.0.205:31417`

Os casos da suíte não exercitam o objeto `etapa`, porque as fixtures 42 e 44 têm `SST_STATUS`
nulo ou no formato antigo. GET nas tarefas geradas pelo código novo fechou o que faltava:

- [x] **CA05** tarefa 793 → `"etapa":{"numero":8,"totalEtapas":8,"descricao":null,"progresso":null}`
      com `qtdItensGerados:60` e `mensagem:"Itens gravados no rascunho."`
- [x] **CA02** tarefa 797 → `"numero":2,"totalEtapas":8`. Número intermediário: a indexação pelo
      catálogo funciona, não só o valor final
- [x] **CA04** tarefa 797 → `"progresso":null` em etapa sem medição
- [x] **CA07** tarefa 797 → ERRO **mantém** `descricao:"Validando filtros..."`, contra CONCLUIDO
      que a anula. A assimetria RN04/RN05 está medida
- [x] **RN06** tarefa 797 → `qtdItensGerados:null` em ERRO, não `0`

### Captura ao vivo do ciclo — POST + poll de 200 ms no GET

- [x] **CA03** tarefa 809 → `descricao:"Carregando itens, aguarde..."` com `numero:7` preservado.
      A mensagem é do motor legado, fora do catálogo, e não moveu a sequência — a regra central do
      requisito, medida
- [x] Ciclo `PENDENTE` → `PROCESSANDO` → `CONCLUIDO` observado numa única tarefa
- [x] **Bug 1 corrigido** — `mensagem` do CONCLUIDO vinha da última descrição publicada e perdia a
      corrida contra o `_DTAFIN`; veio `"Gravando os itens no rascunho..."`. Agora é constante
- [x] **Bug 2 corrigido e verificado** — `numero` do CONCLUIDO vinha 7 de 8 pela mesma corrida.
      `pEncerrar` força `numero := totalEtapas`. Tarefa 832 devolveu `numero:8` na primeira
      resposta CONCLUIDO, com `mensagem:"Itens gravados no rascunho."`
- [x] **RN07/CA04 com medição** — tarefa 832 em PROCESSANDO trouxe
      `"progresso":{"posicao":70,"total":88,"percentual":79.5454545454545}`. Era o último campo do
      contrato que nunca havia aparecido em resposta nenhuma

### Não validado — casos que faltam ao analista

- [ ] **[analista]** CA06 (zero itens), CA11 (nome em branco), CA12 (`FSATSK`/`FNATSK` sem as
      chaves novas)
- [x] **[impl]** `percentual` arredondado a duas casas com `RoundTo(..., -2)` (RN14). Decidido em
      03/09/2026: arredonda na API, não no front. Compilado
- [x] **[impl]** Formato do `percentual` confirmado ao vivo — tarefa 854 devolveu
      `"percentual":52.27` (46 de 88). Duas casas limpas, sem dízima: o serializador imprime a
      representação mínima de ida-e-volta, então `RoundTo` sobre `Double` basta e não é preciso
      trocar por `Currency`
- [ ] **[wagner]** Formato de `dataInicio`/`dataFim`: sai `2026-08-19T00:59:46.000-03:00`, com
      offset e milissegundos, e o documento do requisito mostra `2026-09-02T10:15:00`. É
      comportamento pré-existente do `fDataIso`, não alterado aqui — confirmar se o front parseia
      a forma com offset
- [ ] **[analista]** `Scripts/testes/ROTEIRO_MANUAL.md` e `README.md` — as duas citam a forma
      antiga do andamento

## Fase 8 — Entrega

- [ ] **[impl]** `analysis.md` (CAIXA ALTA) para o revisor humano
- [ ] **[impl]** `svn add` de qualquer arquivo novo
- [ ] **[impl]** `/review` antes do DelphAI
- [ ] **[impl]** DelphAI → token na mensagem de commit
- [ ] **[impl]** Commit com primeira linha `Req. 459763`
- [ ] **[impl]** Republicar o serviço de Suprimento
- [ ] **[impl]** `/resumoAnaliseRequisito` → `record.md`
