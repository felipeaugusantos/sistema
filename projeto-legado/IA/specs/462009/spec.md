# Especificação — Req. 462009

**Título:** Imprimir o pedido de venda no faturamento pelo coletor (`POST /faturamento/faturarpedidos`)
**Objetivo:** Quando o coletor pedir, a API de Faturamento imprime a folha de cada pedido faturado na mesma impressora da NF-e.
**Zona:** Moderna (`padra_atualizado/Services/`)
**Versão:** só a `02.30.74.150`: as APIs dos Services e os robôs Linux saem sempre dela, qualquer que seja a release do Autcom no cliente. O `vepeal` também lista a `02.74.150.100`, que não recebe alteração
**Prazo:** 06/11/2026 · teste no cliente agendado pelo Rafael Casagrande
**Data:** 2026-10-16

## 1. Contexto e porquê

Bela Tintas, loja 008 (depósito). Hoje a folha do pedido é impressa na rotina de impressão e baixa da separação, antes de o local de armazenamento existir. O responsável pela conferência anota à mão, pedido a pedido, o local de armazenamento, e a folha precisa acompanhar a nota até o romaneio por causa das observações do vendedor. A loja quer parar de imprimir na separação e passar a receber a folha do pedido junto com a NF-e, no faturamento pelo coletor.

O pedido tem duas partes:

| Parte | Req. | Situação |
|---|---|---|
| Coletor (Java) | 463255 | **entregue e baixado em 08/10/2026.** Envia `imprimirPedido` conforme uma configuração nova do coletor (nome sugerido na análise: `CFG_FAGIPD`, não confirmado na conclusão), e `pontoImpressaoPedido` com o mesmo valor de `pontoImpressaoNFe` |
| API de Faturamento | **462009** | este documento |

O contrato, então, já está fixado pelo consumidor: os nomes e os tipos dos campos não se negociam.

## 2. Como a folha chega ao operador

A folha do pedido sai na mesma impressora da NF-e e **vai para a mesma pilha, em qualquer ordem**. Não precisa ficar grudada na nota nem vir antes ou depois dela (definido pelo João).

## 3. Contrato

Dois campos novos no corpo de `POST /api/faturamento/faturarpedidos` (`TSolicitacaoFaturamentoPedidosParams`):

| Campo | Tipo | Ausente | Significado |
|---|---|---|---|
| `imprimirPedido` | boolean | `false` | imprimir a folha de cada pedido faturado |
| `pontoImpressaoPedido` | string | `''` | ponto de impressão (`PONIMP.PON_NOMPON`), resolvido como os outros pontos da rota |

A resposta **não muda**.

## 4. Requisitos funcionais

- **RF01.** Com `imprimirPedido = true`, depois que o faturamento conclui com sucesso, a API enfileira na SPOIMP uma impressão do PDF de **cada pedido do request** (`pedidos[]`): uma folha por pedido, não uma por nota gerada.
- **RF02.** O PDF é o mesmo do `GET /api/pedido/{documento}/{especie}/{empresa}/pdf`, gerado por `TPedidoService.fPedidoGerarPdf`, com o mesmo layout e a mesma regra de escolha dele.
- **RF03.** A impressão roda **em segundo plano**, como a do boleto e a do FF hoje. A resposta ao coletor não espera o PDF (decisão do João: "a expedição não espera").
- **RF04.** Com `imprimirPedido = false` ou ausente, o comportamento é idêntico ao de hoje.
- **RF05.** Com `imprimirPedido = true` e `pontoImpressaoPedido` vazio, não imprime e não dá erro. Ponto inexistente na PONIMP **não** é vazio: `TLibNfe.fRetornaNomeImpressora` devolve o próprio nome recebido quando não acha o ponto, e a folha vai para a SPOIMP como as do FF vão hoje.
- **RF06.** Valem as mesmas precondições das outras impressões pós-faturamento: `CFG_SPOIMP` ligada e o binário `FatImpressao` presente. Faltando uma delas, não imprime e não dá erro.
- **RF07.** Se o faturamento falhar (exceção, validação), nada se imprime: a impressão só é disparada depois do `TFaturamentoAutomatico.Execute` bem-sucedido.

## 5. Regras de negócio

- **RN01.** A API só obedece `imprimirPedido`. **Não** tenta distinguir se a chamada veio da separação ou da conferência de saída do coletor. O texto original do 462009 pedia só na conferência; quem decide é o coletor (confirmado pelo João na triagem).
- **RN02.** Falha ao gerar ou enfileirar a folha **não** desfaz nem bloqueia o faturamento, e a resposta não ganha erro novo. O erro vai para o log da API e para a LOGERR (`pMensagensErro(..., False)`), como no FF. O alarme no dia a dia é o operador: "não saiu impresso".

## 6. Desenho técnico

Molde: a impressão do FF em [Faturamento.Services.Faturamento.pas](../../../padra_atualizado/Services/Core/faturamento/services/Faturamento.Services.Faturamento.pas) (`pDispararImpressaoFF` + `TThreadImprimirFF`).

- `pDispararImpressaoPedido(AParams)`: sai se `imprimirPedido` for falso ou o ponto vier vazio. Resolve o nome da impressora por `TLibNfe.fRetornaNomeImpressora`, como o FF e o boleto, e cria uma thread por pedido de `AParams.pedidos`.
- `TThreadImprimirPedido`: segue a estrutura das irmãs (`BeginThreadConnection`, `fAssumirOperadorDaRequest`, precondições, `try/except` com `pMensagensErro`, `pLimparVariaveis`/`EndThreadConnection`). Gera o PDF por `TPedidoService.fPedidoGerarPdf`, chamado direto, porque já se está no worker filho, e enfileira por `TSpoolImpressaoCitel.fEnviarPDFParaImpressao('TThreadImprimirPedido', 'Pedido ' + numero + especie + empresa, ponto, arquivo)`.
- Chamada uma vez em `fFaturarPedidos`, **depois** do laço que monta o resultado e dispara as impressões por nota, e não dentro dele.
- `fFaturarPedidos` roda no worker filho (`fExecuteTask` + `AddMethod` já existentes). Nenhuma rota nova, então `IA\rules\services-workers.md` não pede nada além do que já existe.
- Swagger: `MVCSwagJsonSchemaField` nos dois campos, descrevendo só o que o código faz.

### Deixado para quem implementa
- Se `fPedidoGerarPdf` devolver `sucesso = False` (layout não encontrado, `FatImpressao` sem gerar), registrar a mensagem no log e sair, sem exceção.
- Nome da classe e da procedure, desde que siga o padrão das irmãs.

## 7. Casos de teste (suíte `Faturamento.Services.API`)

Escritos por quem implementa (CLAUDE.md, endpoints dos Services). Base: o caso **1168** (`TEST_FATURAR_PD_EMP_069_37`), que fatura o pedido `000000000004` da 068 na 069 com `pontoImpressaoNFe = "004"`, e cujo `sql_before` deixa o pedido pronto para refaturar.

| Cenário | Request | Afirma |
|---|---|---|
| Positivo | 1168 + `imprimirPedido: true`, `pontoImpressaoPedido: "004"` | 200, como o 1168; **uma** linha na SPOIMP com `SPO_NOMPRO = 'TThreadImprimirPedido'` e `SPO_DESPRO` do pedido, e `SPO_PONIMP` do ponto |
| Negativo — flag falsa | 1168 + `imprimirPedido: false` | 200; nenhuma linha `TThreadImprimirPedido` para o pedido |
| Negativo — ponto vazio | 1168 + `imprimirPedido: true`, `pontoImpressaoPedido: ""` | 200; nenhuma linha |

- A impressão é assíncrona: o assert de banco **precisa esperar** a linha aparecer, com um limite de alguns segundos, antes de reprovar. Sem isso o caso positivo reprova ao acaso. O mecanismo da espera é escolha de quem implementa, dentro do runner existente.
- O `sql_before` apaga as linhas `TThreadImprimirPedido` deste pedido na SPOIMP, para o caso não passar com a linha da execução anterior.
- Assert de banco no formato da suíte: um bloco por tabela, via `pTesteMontarJsonTabela`.
- Precondição do ambiente de teste: `CFG_SPOIMP = S` na 069 e `FatImpressao` ao lado da API. Conferir antes de concluir que o positivo falhou por defeito.

## 8. Critérios de aceitação

- [ ] `imprimirPedido: true` com ponto válido: uma linha na SPOIMP por pedido do request, com o PDF do pedido, e a resposta igual à de hoje.
- [ ] `imprimirPedido` falso ou ausente: nenhuma linha nova, e o comportamento de hoje fica intacto (os 42 casos de `FaturarPedidosTest` seguem verdes).
- [ ] Ponto vazio: não imprime e não dá erro.
- [ ] Falha na geração do PDF: o faturamento se mantém e o erro vai para a LOGERR.
- [ ] Coletor do 463255 contra a API nova: os campos são aceitos sem erro.

## 9. Fora de escopo

- Distinguir separação de conferência (RN01).
- Ordem ou agrupamento físico da folha com a nota (seção 2).
- Mudar o layout do pedido.
- Avisar o coletor de falha na impressão (RN02).

## 10. Risco a verificar na análise

- **Ordem de implantação — descartado (medido em 16/10/2026).** O `BodyAs` do DMVC (`TMVCJsonDataObjectsSerializer.JsonObjectToObject`) percorre as propriedades da **classe destino** e ignora chave do JSON que não existe nela. Um coletor do 463255 contra a API antiga fatura normalmente; só não imprime a folha.
