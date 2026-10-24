# Especificação — Req. 469079

**Título:** Entrada simplificada — fornecedor MATREV = 'M' não gera agendamento de recebimento
**Objetivo:** Impedir que a entrada simplificada de transferência gere agendamento de recebimento (AGEREC/AGEITE) e endereçamento por coletor para fornecedor com CADFOR.FOR_MATREV = 'M', já que a efetivação automática não credita saldo para ele (DET_FILKAR = 1).
**Zona:** Legado
**Data:** 2026-10-13

## 1. Contexto / problema atual
- Com CFG_TIPPNT = D (conferência depois da entrada), `TfrmRecTransfEstoque.fGravaMovDet` grava MOVDET com DET_FILKAR = 1 (item pendente de crédito) e `fAtualizaProduto` sai sem creditar saldo (`fZeraDataEntrada`).
- Para WMS com conferência depois da entrada, `fGeraAgendamento` é verdadeiro e `fGravaAgendamentoDeRecebimento` grava AGEREC (status EC) e AGEITE (AIT_NUMLOT NULL, AIT_QTDEND 0).
- A efetivação automática (`fEfetivaMvtoFiscal` → `TEfetivaMovimentoFiscal.pEfetiva`) força `blnFilKar := True` quando FOR_MATREV = 'M' (untEfetivaMovimentoFiscal.pas, linhas 902-906). Com isso, o bloco que credita saldo (fAtualizaEstoqueCadIte / TDetLoc.pAtualizaEstoqueLocalizacao, linhas 948-975) e o endereçamento (linha 985) não executam; o UPDATE MOVDET grava DET_FILKAR = 1 e DET_DTAENT.
- Resultado: o AGEREC/AGEITE existe e o coletor endereça, mas o saldo nunca entrou no lote "A DEFINIR".
- Evidência: log LOGREP_ARQUIV_20260829, transação 7451922199264493448 (24/08/2026): comandos 10236113 (AGEREC), 10236138 (AGEITE), 10236148 (UPDATE MOVDET FILKAR = 1), sem nenhuma escrita de saldo; documento 000001000077, espécie PD/TE, fornecedor 00000002, item 0945807, empresa 052.

## 2. Módulos e entidades envolvidos
- Módulo: movimentação de itens (entrada simplificada de transferência).
- Units: `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas` (alterar); `untEfetivaMovimentoFiscal.pas` (sem alteração, apenas referência).
- Tabelas: CADFOR (FOR_CODFOR, FOR_MATREV), AGEREC (AUTOINCREM), AGEITE (AUTOINCREM), MOVDET (AUTOINCREM, DET_FILKAR, DET_NUMLOT).

## 3. Requisitos funcionais
- RF01 — `fGeraAgendamento` deve retornar False quando o fornecedor do documento tem FOR_MATREV = 'M'.
- RF02 — Para fornecedor 'M', a entrada simplificada não deve gravar AGEREC/AGEITE nem acionar o plano de recebimento automático.
- RF03 — Para 'M' (não devolução) a entrada nasce efetivada como em untPcmGer: `fZeraDataEntrada` falso, DET_FILKAR = 1, sem crédito de saldo, sem endereçamento e com lote principal de compra no lugar de "A DEFINIR".

## 4. Regras de negócio
- RN01 — Fornecedor 'M' não credita saldo na efetivação (DET_FILKAR = 1); portanto não há o que endereçar e não deve haver agendamento/coletor.
- RN02 — Fornecedor diferente de 'M' mantém o comportamento atual (agendamento gerado quando WMS e conferência depois da entrada e TPLREC <> 'N').
- RN03 — Devolução (FblnDevolu) já não gera agendamento; a checagem de MATREV só é avaliada quando as demais condições já resultaram em True.

## 5. Requisitos técnicos / não-funcionais
- Arquivo em cp1252 com CRLF; edição somente via Python.
- O FOR_MATREV vem do campo `blnFornecedorMaterialUsoConsumo`, preenchido em `pCarregaFornecedor` (mesma consulta que já carrega `blnFornecedorIndustria`); sem consulta nova nem concatenação de SQL.
- Sem componentes ou chamadas proibidas pelo pre-commit.

## 6. Critérios de aceitação
- [ ] Entrada simplificada com fornecedor 'M' (WMS, conferência depois da entrada) não gera AGEREC/AGEITE.
- [ ] O MOVDET dessa entrada termina com DET_FILKAR = 1, data de entrada preenchida, lote principal de compra e sem crédito de saldo.
- [ ] Entrada simplificada com fornecedor não-'M' no mesmo cenário continua gerando AGEREC/AGEITE e plano de recebimento.
- [ ] A exigência de transportadora (CFG_TRASUG) não bloqueia a entrada de fornecedor 'M'.

## 7. Fora de escopo
- Alterar a regra do MATREV = 'M' em `pEfetiva`.
- Entradas fora da entrada simplificada de transferência.
- Fornecedor 'M' com CFG_TIPPNT = A: a regra geral é que 'M' nunca credita saldo, mas na entrada simplificada com TIPPNT = A o insert não aplica essa regra (untRecTransfEstoque.fGravaMovDet não força FILKAR = 1 e credita no insert), ao contrário de untPcmGer (linha 6104) e de pEfetiva. Decisão posterior: a regra do 'M' passou a valer em qualquer CFG_TIPPNT (ver RF03), o que cobre também esse caso.

## 8. Dependências e riscos
- Em multisseleção, `strIdeDig` é compartilhado entre documentos; seleção mista ('M' e não-'M') não foi analisada e deve ser validada.
- A mudança vale para toda entrada simplificada de fornecedor 'M' com WMS e conferência depois da entrada, não só para a nota do caso.
