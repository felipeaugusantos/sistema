# Especificação — Req. 459132

**Título:** Endereçamento de entrada gerando quantidade duplicada e saldo negativo no lote "A DEFINIR"
**Objetivo:** Impedir que o endereçamento de uma entrada grave, na Transferência entre Armazéns (TA), uma quantidade maior que a da Nota Fiscal/documento de entrada.
**Zona:** Legado
**Data:** 2026-09-01

## 1. Contexto / problema atual

Loja SMF FERRAMENTAS LJ 001 (empresa 001, base AUTCOM), executável 379.48.02.30 (04/08/2026).

A auditoria de saldo do lote "A DEFINIR" acusou saldo negativo. Investigação (Req. 459132, solicitante Misael) identificou que, no endereçamento da entrada da NF `000000009771-NF` (item `07888`, CLAFIS 2102, quantidade 217,0000), a Transferência entre Armazéns (TA `000000010981`) gerada foi gravada com quantidade **434,0000** — exatamente o dobro da NF — tanto na linha de saída (CLAFIS 5999, lote "A DEFINIR") quanto na linha de entrada (CLAFIS 1999, lote "EXTERNO AMERICO").

O mesmo padrão (`MOVDET.QTDITE` = 2× a quantidade da NF, `DEL_FATDOR.FDO_QTDBAI` = 2× `DEL_FATDOR.FDO_QTDITE`) se repete nos **7 itens** do documento, não apenas no item 07888 — não é um problema isolado de um item específico, e sim do documento inteiro.

### Achados da investigação (ver seção 8 para detalhes)

1. **Não houve geração duplicada da TA.** `LOGREP_ARQUIV_20260829` mostra, para a transação (`LOG_CON_ID`/`LOG_IDTRAN`) da NF: `MOVGER` inserido 1 vez e `MOVDET` inserido 14 vezes — exatamente o esperado para 7 itens × 2 linhas (saída + entrada). A quantidade **já chega duplicada** na única geração, não é a `TTransferenciaArmazens.fGeraTransferencia` rodando duas vezes.

2. **A validação que deveria acusar a divergência não disparou.** `TTransferenciaArmazens.pValQtdEnderecada` ([untTransferenciaArmazens.pas:2281](../../../padra_atualizado/fontes/movimentacaoitens/untTransferenciaArmazens.pas)) compara a quantidade já endereçada (`fltQtdEnderada`, calculada a partir de `MOVDET`/TAs) contra a quantidade a endereçar do pedido (`fltQtdAEnderecar`, `SUM(FDO_QTDITE)` de `DEL_FATDOR`). Essa segunda soma **não subtrai `FDO_QTDBAI`** — soma a quantidade total do pedido, não a pendente. Isso é uma falha de defesa: mesmo com os dois lados divergindo (434 endereçado vs. quantidade real pendente do pedido), a comparação pode não ter capturado a divergência corretamente.

3. **Configuração mal identificada na verificação inicial do cliente.** O e-mail original verificou `CFG_CONEND` e `CFG_UDEVME` (ambas `N`), concluindo que o fluxo de "conferência digital" estaria desligado. Porém o código que efetivamente troca a fórmula de cálculo da quantidade a endereçar usa a flag `blnCofEnd`, lida de **`CFG_COFEND`** (config diferente de `CFG_CONEND`) combinada com `CFG_TIPPNT = 'D'` ([untEntEnderecamentoProduto.pas:557](../../../padra_atualizado/fontes/movimentacaoitens/untEntEnderecamentoProduto.pas)). Confirmado no banco: `CFG_COFEND = 'S'` e `CFG_TIPPNT = 'D'` para a empresa 001 — ou seja, **esse fluxo está ativo**, ao contrário do que a checagem original concluiu.

4. **Com `CFG_COFEND` ativa**, a quantidade a endereçar de cada linha passa a ser calculada como `IFNULL(DIC_QTDITE, 0) + IFNULL(DIC_QTDLDE, 0) - @ITE_QTDEND_1` ([untEnderecamentoProduto.pas:2207](../../../padra_atualizado/fontes/movimentacaoitens/untEnderecamentoProduto.pas)), em vez de `FDO_QTDITE - FDO_QTDBAI` (fórmula usada quando a config está desligada). O registro de `DIGCON` do item 07888 já apresenta `DIC_QTDTOT = 217` (correto) mas `DIC_QTDITE = DIC_QTDEND = 434` (duplicado) **antes** da geração da TA — ou seja, a duplicação entra pelo `DIGCON`, e só se propaga para a tela/gravação de endereçamento porque `CFG_COFEND` está ativa nessa loja.

5. **Origem exata da duplicação em `DIGCON.DIC_QTDITE` não foi confirmada com certeza.** Não há triggers no banco (`DEL_FATDOR`, `FATDOR`, `MOVDET`, `DIGCON` sem triggers) e não foi encontrada, por leitura estática de código, uma segunda chamada explícita que grave o valor duas vezes. O candidato mais provável identificado é `TEnderecamentoConferenciaParcial.Processa` ([untTEnderecamentoConferenciaParcial.pas:306](../../../padra_atualizado/fontes/cadastros/untTEnderecamentoConferenciaParcial.pas)), que dispara **duas threads concorrentes sem sincronização** sobre `TUniQuery`s ligadas à mesma conexão de banco, com espera em busy-wait (`while not X do;`, sem yield) — um padrão de risco real para leitura/gravação não determinística, mas não confirmado como a causa exata deste caso (registrado como investigação futura, fora do escopo desta correção).

## 2. Módulos e entidades envolvidos

- Módulo: movimentacaoitens (endereçamento de entrada / transferência entre armazéns)
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/untTransferenciaArmazens.pas` (`TTransferenciaArmazens.pValQtdEnderecada`)
  - `padra_atualizado/fontes/movimentacaoitens/untEnderecamentoProduto.pas` (referência — não alterada nesta correção)
  - `padra_atualizado/fontes/movimentacaoitens/untEntEnderecamentoProduto.pas` (referência — não alterada nesta correção)
  - `padra_atualizado/fontes/cadastros/untTEnderecamentoConferenciaParcial.pas` (referência — investigação futura, não alterada nesta correção)
- Tabelas/entidades:
  - `MOVDET` (chave: `DET_SEQGER` + item)
  - `DEL_FATGOR` / `DEL_FATDOR` (pedido de reserva de estoque; chave: `AUTOINCREM`)
  - `DEL_EXTGOR` (chave: `FGO_SEQFGO`, campo `FGO_DOCEND` referencia o documento de origem)
  - `DIGCON` (conferência digital; chave: `AUTOINCREM`, `DIC_SEQGER` referencia o pedido de reserva)
  - `CFGSIS` (`CFG_COFEND`, `CFG_TIPPNT`, `CFG_CONEND`, `CFG_UDEVME`)

## 3. Requisitos funcionais

- RF01 — `pValQtdEnderecada` deve comparar a quantidade já endereçada contra a quantidade **pendente** do pedido (`FDO_QTDITE - FDO_QTDBAI`), não contra `FDO_QTDITE` puro, para os itens do pedido vinculado ao documento de origem.
- RF02 — Quando a divergência for detectada, o comportamento existente (levantar exceção "Houve inconsistência na gravação da TA...", com rollback) deve ser mantido — não se está criando um novo tratamento de erro, apenas corrigindo a base de comparação.

## 4. Regras de negócio

- RN01 — A quantidade a endereçar de um item nunca pode ser maior que a quantidade pendente do pedido de reserva vinculado (`FDO_QTDITE - FDO_QTDBAI`). Se o cálculo de endereçamento produzir um valor maior (por qualquer causa upstream, incluindo duplicação em `DIGCON`), a gravação da TA deve ser bloqueada pela validação existente, não silenciosamente aceita.
- RN02 — Itens sem `FDO_QTDBAI` (NULL) devem ser tratados como pendência total (`IFNULL(FDO_QTDBAI, 0)`), preservando o comportamento atual para pedidos ainda não baixados.

## 5. Requisitos técnicos / não-funcionais

- Alteração restrita a uma consulta SQL já parametrizada (sem `ParamByName` novo necessário — `FDO_QTDBAI` é uma coluna adicional na mesma tabela já presente no FROM).
- Sem impacto em transação/auditoria: a correção apenas ajusta a base de comparação de uma validação que já existe e já roda dentro da transação de geração da TA.
- Comentário no fonte + nota técnica referenciando Req. 459132, documentando por que a subtração de `FDO_QTDBAI` é necessária (evita que uma duplicação em `DIGCON.DIC_QTDITE`, hoje possível quando `CFG_COFEND` está ativa, passe pela validação sem ser detectada).

## 6. Critérios de aceitação

- [ ] Em um cenário onde a quantidade endereçada (`MOVDET`/TA) for maior que a quantidade pendente real do pedido (`FDO_QTDITE - FDO_QTDBAI`), `fGeraTransferencia` deve lançar a exceção de inconsistência e fazer rollback, não gravar a TA.
- [ ] Em um cenário normal (sem divergência), o comportamento de `pValQtdEnderecada` permanece inalterado — nenhuma regressão em endereçamentos que hoje funcionam corretamente.
- [ ] O comentário/nota técnica no fonte referencia "Nota 1 - Req. 459132".

## 7. Fora de escopo

- Encontrar e corrigir a causa raiz exata da duplicação de `DIGCON.DIC_QTDITE` (candidato mais provável: concorrência sem sincronização em `TEnderecamentoConferenciaParcial.Processa`) — requer reprodução instrumentada/log em ambiente de teste do cliente, não coberta por esta correção.
- Corrigir a configuração `CFG_CONEND` vs. `CFG_COFEND` mal identificada na checagem inicial do cliente — é uma correção de diagnóstico, não de código.
- Qualquer alteração em `untEnderecamentoProduto.pas`, `untEntEnderecamentoProduto.pas` ou `untTEnderecamentoConferenciaParcial.pas` — ficam apenas documentadas como referência/investigação futura.
- Reprocessamento/estorno dos dados já gravados incorretamente para a NF `000000009771` / TA `000000010981` (ação operacional, fora do escopo de desenvolvimento).

## 8. Dependências e riscos

- **Dependência de confirmação:** a causa raiz completa (por que `DIGCON.DIC_QTDITE` duplicou) não foi fechada com 100% de certeza. A correção proposta é defensiva — impede o sintoma relatado (saldo negativo por endereçamento além da entrada) independentemente da causa raiz exata, mas não elimina a possibilidade de o mesmo mecanismo gerar outros sintomas (ex.: exceção sendo lançada com mais frequência do que o esperado, se a duplicação em `DIGCON` for recorrente).
- **Risco:** se a duplicação em `DIGCON` for frequente nessa loja (config `CFG_COFEND` ativa), a correção pode passar a bloquear endereçamentos que hoje "passam" incorretamente — o que é o comportamento desejado, mas pode gerar volume de chamados até a causa raiz em `DIGCON`/`TEnderecamentoConferenciaParcial` ser investigada e corrigida separadamente.
- **Escopo confirmado como único caso reportado até o momento** (não há evidência de recorrência em outras lojas/documentos até esta análise).
