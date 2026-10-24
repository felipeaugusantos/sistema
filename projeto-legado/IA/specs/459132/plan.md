# Plano de Execução — Req. 459132

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Correção pontual e defensiva em `TTransferenciaArmazens.pValQtdEnderecada`, dentro de `TTransferenciaArmazens.fGeraTransferencia` (unit `untTransferenciaArmazens.pas`). A validação já existe e já roda dentro da transação de geração da TA (chamada em `fGeraTransferencia` quando `Not FblnEndLocal And Not fEmptyStr(strSeqOri)`); a correção ajusta apenas a base de cálculo de uma das duas quantidades comparadas (`fltQtdAEnderecar`), fazendo-a refletir a quantidade **pendente** do pedido, não a quantidade total solicitada.

Nenhuma mudança de fluxo, de assinatura de método ou de arquitetura — é um ajuste de uma query SQL já parametrizada dentro de uma procedure local (`pValQtdEnderecada`, procedure aninhada em `fGeraTransferencia`).

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untTransferenciaArmazens.pas` | `padra_atualizado/fontes/movimentacaoitens/untTransferenciaArmazens.pas` | alterar |

## 3. Sequência de implementação

1. Localizar o SELECT de `qryPedidoEnderecamento` dentro de `pValQtdEnderecada` que produz `QTDAENDERECAR` (bloco iniciado em torno da linha 2362, `SELECT ... SUM(IFNULL(FDO_QTDITE, 0)) AS QTDAENDERECAR ... FROM DEL_EXTGOR INNER JOIN DEL_FATDOR ...`).
2. Alterar a expressão de `SUM(IFNULL(FDO_QTDITE, 0))` para `SUM(IFNULL(FDO_QTDITE, 0) - IFNULL(FDO_QTDBAI, 0))`, preservando alias `QTDAENDERECAR` e o restante da query (WHERE, GROUP BY) inalterados.
3. Adicionar comentário curto na mesma caixa da alteração, indicando `Verificar Nota 1 - Req. 459132`, explicando que a subtração de `FDO_QTDBAI` é necessária para que a validação capture divergências mesmo quando a quantidade a endereçar calculada upstream (via `DIGCON.DIC_QTDITE`, quando `CFG_COFEND` está ativa) vier duplicada.
4. Revisar o restante de `pValQtdEnderecada` (loop `While Not qryQtdEnderecada.eof`, comparação via `RoundTo(...,-4)`) para confirmar que nenhuma outra parte da procedure assume implicitamente que `QTDAENDERECAR` é o total bruto do pedido (não deve haver, já que essa é a única leitura de `qryPedidoEnderecamento.FieldByName('QTDAENDERECAR')`).
5. Validar manualmente em ambiente de teste do cliente: reproduzir (ou simular via dados de teste) um cenário em que a quantidade endereçada exceda a quantidade pendente do pedido, e confirmar que `fGeraTransferencia` agora lança a exceção "Houve inconsistência na gravação da TA..." em vez de gravar a TA com quantidade divergente.
6. Validar um cenário normal (sem divergência) para garantir ausência de regressão.

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian style, SQL via `TUniQuery.SQL.Add` com `ParamByName()` já existente — nenhuma alteração introduz concatenação de string nova em condição WHERE (a mudança é só na lista de campos do SELECT).
- Sem uso de componentes/chamadas proibidos pelo pre-commit (não há UI, `TBitBtn`, `TDBGrid`, `StrToFloat`, `Now()`, `Application.CreateForm`, `ActiveControl` ou SQL concatenado em condição envolvidos nesta alteração).
- Comentário + Nota técnica seguindo a convenção do projeto (comentário curto no fonte referenciando "Nota N - Req. NNNNNN"; explicação completa registrada na seção "Notas Referenciadas no Código-Fonte" do `resumoAnaliseRequisito`, quando executado).

## 5. Estratégia de testes

- Não há suíte DUnit específica para `TTransferenciaArmazens`/endereçamento de entrada neste projeto (`AutcomTestesClientes.groupproj` cobre apenas regras tributárias).
- Validação manual em ambiente de teste do cliente:
  - Caso 1 (regressão): endereçamento normal, sem divergência — deve continuar gravando a TA sem exceção.
  - Caso 2 (correção): cenário com quantidade endereçada divergente da pendente do pedido — deve lançar a exceção de inconsistência e fazer rollback (não gravar TA com quantidade indevida).
- Idealmente, se for possível reproduzir em teste a condição de `CFG_COFEND` ativa gerando `DIGCON.DIC_QTDITE` duplicado, validar ponta a ponta que a exceção passa a ser disparada antes da gravação do MOVDET/TA.

## 6. Riscos e mitigação

| Risco | Mitigação |
|---|---|
| Causa raiz da duplicação em `DIGCON.DIC_QTDITE` não corrigida — o sintoma "quantidade duplicada" pode continuar sendo gerado, só que agora bloqueado em vez de gravado. | Documentado em spec.md como fora de escopo; recomendar abertura de investigação futura específica sobre `TEnderecamentoConferenciaParcial.Processa` (threads sem sincronização) com log/reprodução instrumentada. |
| Bloqueio passa a ocorrer com mais frequência nessa loja (CFG_COFEND ativa), gerando volume de chamados de suporte até a causa raiz ser tratada. | Esperado e desejado — impede saldo negativo silencioso; comunicar ao suporte/Misael que exceções de inconsistência nesse fluxo específico podem aumentar até a causa raiz em `DIGCON` ser resolvida. |
| Alteração na query pode afetar outras lojas onde `CFG_COFEND` está desligada e o fluxo hoje funciona sem duplicação. | A mudança só restringe a validação (torna-a mais correta), não altera o cálculo de `fltQtdEnderada`; em cenários sem divergência real, `FDO_QTDBAI` já deveria ser 0 no momento da validação (a baixa do pedido normalmente ocorre após), então o comportamento em fluxos saudáveis não muda — validar isso no Caso 1 de teste. |
