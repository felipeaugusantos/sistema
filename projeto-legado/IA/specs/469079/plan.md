# Plano de Execução — Req. 469079

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Alterar `TfrmRecTransfEstoque.fGeraAgendamento` para retornar False quando CADFOR.FOR_MATREV do fornecedor for 'M', usando o novo campo `blnFornecedorMaterialUsoConsumo` (preenchido em `pCarregaFornecedor`, junto de `blnFornecedorIndustria`). O efeito só ocorre com CFG_TIPPNT = D, pois `fGeraAgendamento` depende de `fConferenciaDepoisDaEntradaLocal`. As demais decisões (fGravaAgendamentoDeRecebimento, fGeraPlanoRecebimentoAutomatico, fValidaTransportadoraAgendamento, fRetNumLot, bloco de `fDocumentoGeraEnderecamento`) já dependem de `fGeraAgendamento` e acompanham sem alteração. Para 'M' (não devolução) também: `fZeraDataEntrada` falso, `blnFilKar := True` em `fGravaMovDet`, sem crédito de saldo em `fAtualizaProduto`, `fDocumentoGeraEnderecamento` falso e lote principal de compra em `fRetNumLot` (Nota 2). A regra do 'M' em `pEfetiva` não muda.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untRecTransfEstoque.pas | padra_atualizado/fontes/movimentacaoitens/ | alterar (campo `blnFornecedorMaterialUsoConsumo`, `pCarregaFornecedor`, `fGeraAgendamento`; já aplicado na cópia de trabalho) |
| untEfetivaMovimentoFiscal.pas | padra_atualizado/fontes/movimentacaoitens/ | sem alteração (referência) |

## 3. Sequência de implementação
1. Declarar `blnFornecedorMaterialUsoConsumo`, preenchê-lo em `pCarregaFornecedor` e usá-lo em `fGeraAgendamento` (feito).
2. Conferir os efeitos em cadeia: fGravaAgendamentoDeRecebimento sai com True; fGeraPlanoRecebimentoAutomatico não faz nada com strIdeDig vazio; transportadora deixa de ser exigida; fRetNumLot e blnVaiGerarEnderecamentoDepois não pedem endereçamento.
3. Validar com a nota do caso (fornecedor 00000002, item 0945807, empresa 052).

## 4. Conformidade com padrões do projeto
- Zona Legado: Hungarian e prefixos p/f mantidos; campo novo `blnFornecedorMaterialUsoConsumo` segue o padrão de `blnFornecedorIndustria`, sem número de requisito no nome.
- Sem consulta nova: reaproveita a consulta de `pCarregaFornecedor`; sem SQL por concatenação.
- Pre-commit: sem componentes/chamadas/SQL proibidos.
- Encoding: cp1252 + CRLF preservados; validado sem U+FFFD.

## 5. Estratégia de testes
- Não existe suíte automatizada para esta tela (`AutcomTestesClientes` cobre apenas regras tributárias); validação manual.
- Casos: fornecedor 'M' sem AGEREC/AGEITE e com FILKAR = 1 sem saldo; fornecedor não-'M' com WMS continua gerando agendamento; seleção mista 'M' e não-'M'; devolução inalterada.

## 6. Riscos e mitigação
- Item 'M' sem lote principal de compra cadastrado → `fRetNumLot` levanta exceção; validar cadastro.
- CFG_TIPPNT = A com fornecedor 'M' → coberto pela regra ampliada do 'M'; validar também.
- Multisseleção com strIdeDig compartilhado → validar seleção mista.
- Alcance maior que a nota do caso → validar com outras entradas de fornecedor 'M'.
