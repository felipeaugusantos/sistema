# Especificação — Req. 462864

**Título:** Erro de FOREIGN KEY (FK_HISENT_02) ao confirmar entrada de mercadorias de nota de devolução
**Objetivo:** Permitir a confirmação da entrada de mercadorias vinculada a devolução de cliente, recebimento
de garantia ou retorno de consignação de equipamento, sem apresentar erro de chave estrangeira ao gravar o
histórico de entrada.
**Zona:** Legado
**Data:** 2026-09-18

## 1. Contexto / problema atual

A rotina de Entrada de Mercadorias (`PRINCIPAL > MOVIMENTAÇÃO DE ITENS > ENTRADA DE MERCADORIAS`) processa
tanto entradas normais de compra de fornecedor quanto devoluções de venda feitas por um cliente,
recebimentos de cliente em garantia e retornos de consignação de equipamento. Nesses três últimos casos, o
"documento de origem" referenciado pela entrada é, na prática, um pedido de venda anteriormente emitido para
um cliente — não um pedido de compra de um fornecedor.

Ao confirmar a entrada, a rotina de baixa do pedido (`fBaixaPedidosEmbalagem`, unit `untPcmGer.pas`) gravava
incondicionalmente um histórico de movimentação na tabela `HISENT`, usando o código da contraparte do
documento como se fosse sempre um fornecedor. Em fluxos de devolução/garantia/consignação, esse código é, na
verdade, o de um cliente — e como `HISENT.HIS_CODFOR` possui a restrição de chave estrangeira
`FK_HISENT_02` (exige existência em `CADFOR.FOR_CODFOR`), a gravação falhava com erro `#23000` e a entrada
não podia ser confirmada. Como medida paliativa, o cliente vinha sendo orientado a confirmar a entrada sem
referenciar a nota de venda original, perdendo o vínculo com o documento de origem.

## 2. Módulos e entidades envolvidos

- Módulo: Movimentação de Itens — Entrada de Mercadorias
- Units: `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas` (função `fBaixaPedidosEmbalagem`,
  chamada a partir da função aninhada `fBaixaPedidosEntrada`, dentro de `fConfirmaEntradaMercadorias`)
- Tabelas/entidades:
  - `HISENT` — histórico de entrada de mercadorias; campo `HIS_CODFOR` (chave estrangeira `FK_HISENT_02`
    → `CADFOR.FOR_CODFOR`)
  - `CADFOR` — cadastro de fornecedores; chave `FOR_CODFOR`
  - `PCMGER` — pedido de compra vinculado à entrada; chave `PCG_NUMPED` + `PCG_CODEMP`

## 3. Requisitos funcionais

- RF01 — A confirmação de entrada de mercadorias vinculada a devolução de cliente, garantia de cliente ou
  consignação de equipamento não deve gravar histórico de fornecedor (`HISENT.HIS_CODFOR`) usando o código
  do cliente envolvido no documento.
- RF02 — A baixa do pedido de compra vinculado (tabela `PCMGER`) deve continuar ocorrendo normalmente para
  esses fluxos, mesmo sem a gravação do histórico de fornecedor.
- RF03 — Entradas normais de compra de fornecedor (sem devolução/garantia/consignação) devem manter o
  comportamento atual, sem nenhuma alteração de resultado.

## 4. Regras de negócio

- RN01 — A gravação de `HISENT.HIS_CODFOR` só deve ocorrer quando o documento de entrada for efetivamente
  uma compra de fornecedor, ou seja, quando nenhuma das seguintes condições estiver ativa: devolução de
  cliente (`blnDevolu`), recebimento de cliente em garantia (`blnRecCliGarantia`), consignação de
  equipamento (`blnConEqu`) ou acesso via retorno de consignação (`blnAcessadoViaRetornoConsignacao`).
- RN02 — Nos casos em que a gravação de `HISENT.HIS_CODFOR` é descartada por RN01, o restante do
  processamento da baixa do pedido (`fBaixaPcmDet`, `fBaixaPcmGer`, atualização de saldo/embalagem) não é
  afetado e deve continuar sendo executado normalmente.

## 5. Requisitos técnicos / não-funcionais

- Encoding: `untPcmGer.pas` é cp1252/CRLF (Delphi legado) — qualquer edição deve preservar o encoding e não
  introduzir mojibake, especialmente por conter uma corrupção de encoding pré-existente e não relacionada
  (ver seção 8 de `correcaoFkHisentDevolucao_Req462864.md`).
- Compatibilidade: a alteração de assinatura de `fBaixaPedidosEmbalagem` não pode afetar o único outro call
  site existente (`fBaixaPedidos`, wrapper usado fora do fluxo de entrada de mercadorias), que não possui as
  flags de devolução/garantia/consignação em seu escopo de chamada.
- Sem impacto em transação/auditoria além do já existente na rotina de confirmação de entrada.

## 6. Critérios de aceitação

- [ ] Confirmar entrada de mercadorias referenciando um pedido de devolução de cliente não apresenta mais o
  erro `#23000` de violação de `FK_HISENT_02`.
- [ ] O pedido de compra (`PCMGER`) vinculado à devolução é baixado corretamente após a confirmação.
- [ ] `HISENT.HIS_CODFOR` não recebe gravação para documentos de devolução, garantia de cliente ou
  consignação de equipamento.
- [ ] Entrada normal de compra de fornecedor continua gravando `HISENT.HIS_CODFOR` normalmente, sem
  alteração de comportamento.

## 7. Fora de escopo

- Correção dos registros já gravados incorretamente (nenhum registro foi identificado como afetado neste
  chamado, já que a gravação sempre falhava por erro de FK antes de persistir).
- Correção da corrupção de encoding pré-existente identificada em `untPcmGer.pas` (UTF-8 dentro de arquivo
  cp1252, próximo à função `fZeraDataEntrada`) — não relacionada a este requisito.
- Alteração do wrapper `fBaixaPedidos` — mantido com comportamento inalterado (defaults `False` para as
  novas flags), por não fazer parte do fluxo do bug reportado.
- Simulação em ambiente de homologação — validação feita por revisão de código/escopo de variáveis, sem
  acesso a IDE Delphi/compilador neste ambiente de execução.

## 8. Dependências e riscos

- Dependência: os parâmetros `blnConEqu` e `AblnAcessadoViaRetornoConsignacao` já existirem como parâmetros
  de `fConfirmaEntradaMercadorias` (confirmado por leitura de código — sem necessidade de nova variável).
- Risco: nenhum risco residual identificado para o fluxo de fornecedor (equivalência lógica confirmada por
  revisão). Risco residual para os fluxos de devolução/garantia/consignação está limitado à ausência de
  validação em homologação, mitigado pela análise de escopo e pela equivalência de condição descrita no
  `plan.md`.
