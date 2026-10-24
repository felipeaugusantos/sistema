# Fase 1 — Inventário de dependências — Req. 458943

**Referência:** `plan.md` §4, `tasks.md` Fase 1
**Data:** 2026-09-01
**Veredito:** **VIÁVEL em uma etapa**, com duas decisões pendentes do requisitante (seção 6)

Nenhum código foi alterado nesta fase.

---

## 1. Units do `uses` — destino confirmado

Das 41 units do `uses` da `implementation` de `untEstornoReceber.pas`, 27 já compilam para Linux. As 14 restantes foram abertas no call site:

| Unit | Uso real | Destino | Confirmado por |
|------|----------|---------|----------------|
| `untBaixaReceber` | 1 bloco (L6157–6165) | **Fica no form** | Abre `TfrmBaixaReceber` para rebaixar conjugadas depois do estorno — UI pura, pós-transação |
| `untFuncFat` | **nenhum** | **Sai do `uses`** | 0 símbolos de nível superior usados. O `fRetRcxCon` que aparece é método de `TFatVenda`; as 4 chamadas resolvem para `untFuncoesSimples.fRetRcxCon` |
| `untEstornoPagar` | **nenhum** | **Sai do `uses`** | Exporta só `TfrmEstornoPagar`, com 0 usos |
| `untConsultas` | 2 (L4934, L5275) | **Fica no form** | `fPesqCliente` e `fPesqEmpresa`, dentro de `edtCodCliKeyPress` / `edtCodEmpKeyPress` |
| `untMemo` | 1 | **Fica no form** | Só `TfrmMemo` |
| `untGravando` | 3 | **Fica no form** | Só `TfrmGravando` |
| `untCancelamentoDocResumo` | 2 | **Fica no form** | Só `TfrmCancelamentoDocResumo` |
| `untFuncoesRel2` | **nenhum** | **Sai do `uses`** | 0 símbolos usados |
| `untDigPortador` | 4 | **Elimina — RN04** | Todos dentro de `fPedePortador` / `fPedePortadorCaixa` |
| `untDigOcorrencia` | 1 | **Elimina — RN08** | Dentro do bloco `CFG_RMOTES` |
| `untAdiantamentoCliente` | 8 (`TAdiantamento`) | **Vai junto** | `fValidaEstornoAdiantamento`, `pEstornaAdiantamentoCliente` — regra |
| `untTCadPagRepository` | 3 (`TCadPagRepository`) | **Vai junto** | Dentro de `pEstornaContasAPagar` — regra |
| `untFuncoes` | — | **Ramo `{$ELSE}`** | Padrão da `BaixaDuplicatas` |
| `untFuncoesSimples` | — | **Ramo `{$ELSE}`** | Padrão da `BaixaDuplicatas` |

**Correção ao `plan.md`:** ele previa `untConsultas` saindo por ter 0 chamadas de `fConsulta`. A unit **é** usada, mas por `fPesqCliente`/`fPesqEmpresa` em eventos de campo. O destino não muda (fica no form); a justificativa sim.

Três units saem por serem órfãs — `untFuncFat`, `untEstornoPagar`, `untFuncoesRel2`. Remover e compilar confirma.

---

## 2. Funções genéricas — o que precisa de versão Linux

O estorno usa **58** funções de `untFuncoes` / `untFuncoesSimples`:

| Situação | Qtd |
|----------|----:|
| Já usadas pela `BaixaDuplicatas` / `ValidacaoBaixa` — provadas no Linux | 29 |
| Existem em `Services/Core` ou `fontes/Core` | 15 |
| **Sem equivalente Linux** | **14** |

Das 14 sem equivalente, quatro caem fora por decisão de escopo ou por serem UI:

| Função | Situação |
|--------|----------|
| `fEmpresaTemAcessoPortador` | Eliminada — RN04 (só existe em `fPedePortador*`) |
| `fExisteConfiguracao` | Eliminada — RN08 (só existe no bloco `CFG_RMOTES`) |
| `fGetMenu` | UI — mas está em `fValidaEstornoAdiantamento`, que é regra. **Ver seção 6.1** |
| `fRetornaStack` | Diagnóstico; vira no-op no Linux |

Restam **10 funções que precisam de versão Linux**, todas regra de negócio:

1. `EstaConciliado`
2. `fVerificaSeDuplicataEstaVinculadaParaConciliacao`
3. `fCarregaCartoesTransferidos`
4. `fCarregaChequesTransferidos`
5. `fCriaQueryCadPagCTPCom`
6. `fDocumentoFaturado`
7. `fDuplicataPrincipalBaixada`
8. `fEhDuplicataOriginadaDeConverte`
9. `fTipDtaEstBai`
10. `pGeraLogLiberacao`

Ordem de grandeza compatível com o precedente: o Req. 454631 alterou 414 linhas somando `untFuncoesGenerica` (210), `untFuncoesSimples` (132) e `untFuncoes` (72).

---

## 3. Pontos de decisão do operador — inventário completo

Varredura de `fMensagem` com opção `&Sim` (incluindo chamadas multilinha) e de `fGetMenu`:

| Linha | Pergunta | Destino |
|------:|----------|---------|
| 1187 | "Confirma estorno de duplicata(s)?" | A requisição é a confirmação |
| **1196** | Duplicata descontada no banco — tarifas não serão estornadas | **Pendente — seção 6.2** |
| 3832 | Cobrança PIX vinculada, valor não será devolvido automaticamente | Coberto pela RN06 → 422 |
| 3885 | "O sistema irá realizar a devolução via Pix. Deseja continuar?" | `tipoEstornoPix=devolucao` é a confirmação |
| 4994 | "Deseja gerar um crédito ao cliente?" | `tipoEstornoPix=credito` |
| 6159 | "Deseja baixar as duplicatas novamente?" (conjugadas) | UI pós-transação, fica no form |
| **556** | `fGetMenu` — escolher qual adiantamento estornar | **Pendente — seção 6.1** |

O `TResultadoEstorno` precisa de um campo `SugerirRebaixaConjugadas: Boolean` para o form saber se faz a pergunta de L6159 depois de a classe retornar.

---

## 4. SQL por concatenação

12 ocorrências detectadas por varredura de linha única. Classificação:

**Estrutura, não dado — aceitável, mas vale trocar por SQL fixo:**
- L1555, L1751 — `IIF(blnResCai, ...)` monta cláusula
- L6393, L6442 — `IIF(strTipChq='AVI','=','<')` monta operador
- L2608 — `'UPDATE ' + CTR_TABELA` (vale `CADREC` ou `ADTCLI`; trocar por `CASE` explícito)

**Dado concatenado — corrigir para `ParamByName()`:**
- L1786, L1788 — `fCfgSis('CTARCX')` / `fCfgSis('PORRCX')` interpolados
- L2785 — `QuotedStr(CTR_SEQBAI)`
- **L3763, L5160** — `' AND RCX_CODCAX="' + strCodigoCaixa + '"'`, **sem `QuotedStr`** — os piores
- L7620, L7621 — `QuotedStr` em `RCX_ESPDOC` / `RCX_CODEMP`

> **A varredura subestima.** SQL montado em várias linhas escapa da heurística — ex. `ValidacoesDeRecebimentoPorPix` (L3806–3814) concatena `MPX_SEQCON=`, `MPX_CODEMP="`, `MPX_DTAREC="` e não aparece na lista. O mapeamento definitivo tem de ser feito manualmente durante a extração, unit por unit.

---

## 5. Devolução de PIX — timeout e falha

`SolicitarDevolucaoDoPix` (L4387) faz **polling síncrono** contra o banco:

- `LTempoAguardo` = 3.000 ms, ou **7.000 ms** quando `MPX_USASHP='S'` ou `MPX_PIXSCP='S'` (L4428)
- laço de **4 iterações** com `Sleep(LTempoAguardo)` (L4440–4461)
- **pior caso: ~28 s de `Sleep`** dentro da requisição, mais o tempo das chamadas REST
- não resolvido ao fim do laço → `Raise` pedindo para aguardar ~2 min e repetir (L4464)

Consequências para o endpoint:

| Ponto | Encaminhamento |
|-------|----------------|
| `Application.ProcessMessages` (L4456) | **Tem de sair** — é o único `Application.` da unit; não há message loop no serviço |
| Timeout do endpoint | Precisa ser explícito e maior que 30 s no caminho `tipoEstornoPix=devolucao`; confirmar o default do worker/DMVC |
| Falha parcial | **Protegida.** `ValorPixJaDevolvidoNoBanco` é checada na entrada (L4413) e dentro do laço (L4458) — o retry não devolve em dobro |
| Semântica do erro | O `Raise` vira 422 com a mensagem `DEVPIX-...`; o estorno faz rollback e o consumidor repete |

---

## 6. Decisões do requisitante — RESOLVIDAS em 01/09/2026

**O escopo foi reduzido a estorno de recebimentos em cartão e PIX puros**, com o alvo redefinido como *desfazer o que o `TBaixaService` baixa hoje*. Ver `spec.md` RN02.

Isso encerra as duas pendências abaixo: ambos os casos passam a ser recusados com 422 pelo endpoint, e **permanecem funcionando na tela**.

### Dados que embasaram a decisão

Base `financeiro-dev` — proporções indicativas, não verdade de produção; a *existência* dos casos está provada.

| Filtro acumulado sobre `CADREC` com `CTR_DTAREC` não nulo | Baixas |
|---|---:|
| Recebidas em cartão ou PIX | 4.069 |
| + puras (sem dinheiro, cheque ou ordem de pagamento não-PIX) | 3.102 |
| + sem adiantamento e sem desconto no banco | 3.072 |
| + fora do resumo de caixa | 570 |

Dentro do escopo final (570 baixas):

| | |
|---|---:|
| `CTR_AUTCTP` preenchido — contas a pagar vinculado | **0** |
| `CTR_CTPCOM` preenchido — comissão de agrupamento | 14 |
| Com juros ou desconto | 286 |
| Cartão | 289 |
| PIX | 286 |

> **`CTR_ORDPAG` é onde o valor do PIX é gravado** (`untEstornoReceber.pas:881` rotula `ORDPAG` como "Pix" quando `RECPIX='S'`). Uma primeira contagem que tratou `ORDPAG` como modalidade separada superestimou as baixas mistas em 51%; qualificada por `CTR_RECPIX`, a taxa real é 24%.
>
> **A queda de 3.072 para 570 não mede perda de alvo.** 81% das baixas puras de cartão/PIX vêm do resumo de caixa, e o `TBaixaService` nunca baixa pelo caixa — essas nunca estiveram no alvo do endpoint. A recusa de `CTR_RESCAI=1` sai de graça.

`strNomOrigem` não serve de filtro: vai para `LOGMOVCTR` via `fGravaLogMovCtr`, como trilha de auditoria, e não existe coluna em `CADREC` que marque quem criou a baixa. Por isso o endpoint qualifica pela **forma** da baixa, não pela origem.

### 6.1 — Múltiplos adiantamentos *(resolvido: recusa 422)*

`fValidaEstornoAdiantamento` (L456): quando `qryAdiantamentos.RecordCount > 1` (L541), a tela monta uma lista com data, hora, empresa e valor de cada adiantamento e chama `fGetMenu` (L556) para o operador escolher qual estornar.

A API recebe uma chave só e não tem como escolher. **Como proceder?**

### 6.2 — Duplicata descontada no banco *(resolvido: recusa 422)*

L1192–1201: quando `CFG_ENCBAN` está ligada, `CTR_MOVDES` não é nulo e o banco não é 237 nem 033, a tela avisa que o estorno lançará o valor na movimentação bancária **mas não estornará as tarifas do desconto**, que ficam para acerto manual, e pede confirmação.

É um aviso de consequência financeira, não uma escolha técnica. **Como proceder?**

---

## 7. Conclusão

A cauda VCL é menor do que o `plan.md` supunha: das 14 units não provadas, **sete saem sem substituto**, três são órfãs, duas morrem por RN04/RN08 e duas vão para o ramo `{$ELSE}`. Apenas duas carregam regra e precisam acompanhar a extração.

O trabalho real concentra-se em **10 funções genéricas** que precisam de versão Linux e no mapeamento manual do SQL concatenado.

**Não era necessário reduzir o escopo por inviabilidade técnica.** A redução a cartão e PIX (seção 6) foi decisão de produto — alinhar o estorno ao que o endpoint de baixa cobre — e não consequência do inventário.

### Efeito da redução sobre o trabalho

Menor do que parece à primeira vista. Como Delphi compila a unit inteira e **a tela precisa continuar estornando tudo que estorna hoje**, os caminhos fora do escopo do endpoint não podem simplesmente sumir: eles vão para a classe compartilhada dentro de blocos `{$IFNDEF LINUX}`, como a `BaixaDuplicatas` já faz com suas 13 diretivas.

O que a redução de fato economiza:

| | |
|---|---|
| Superfície de compilação Linux | `untTCadChqRepository`, `untCadChq`, `untAdiantamentoCliente`, `untTCadPagRepository`, `TResumoDeCaixa` ficam fora do binário do serviço |
| Funções genéricas com versão Linux | de 10 para **9** (`fCarregaChequesTransferidos` sai) |
| Decisões de operador a resolver | `fGetMenu` e o aviso de duplicata descontada saem do caminho headless |
| Casos de teste da API | concentrados em cartão e PIX |

O que **não** economiza: a extração em si. O motor, as validações e o bloco PIX continuam saindo do form por inteiro.

**A Fase 2 pode começar.**
