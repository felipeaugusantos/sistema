# Especificação — Req. 458331

**Título:** Entrada de material de uso e consumo travada com FLUPDC ativo (GER_ENTDIR gravado 'S' indevidamente)
**Objetivo:** Corrigir `TNFeXml.fGravaGerEle` para não gravar `GER_ENTDIR='S'` na importação do XML quando o fluxo exige pré-nota (FLUPDC ativo), permitindo que a nota seja localizada e processada normalmente pela pré-nota e pela entrada automatizada.
**Zona:** Legado
**Data:** 2026-08-26

## 1. Contexto / problema atual

Ticket Zendesk 1645568 (fornecedor 1238, nota 584364): ao tentar finalizar a entrada de mercadoria, o sistema não encontra o item, faltando a etapa de conferência/pré-nota. Foi feito ajuste manual no banco para o cliente conseguir prosseguir, mas a causa raiz não foi corrigida no código.

Rastreamento da causa raiz:

- `TNFeXml.fGravaGerEle` (`untEntNfeXml.pas`), no ramo em que o fornecedor tem `FOR_MATREV = 'M'` (material de uso e consumo), grava `FieldByName('GER_ENTDIR').AsString := 'S'` **incondicionalmente**, antes de checar `fCfgSis('FLUPDC', varBoolean)`.
- Com FLUPDC ativo, o fluxo exige que a nota passe por pré-nota antes de fechar a entrada — por isso o mesmo trecho grava `GER_DTACON` (conferência) mas não `GER_DTALIB`/`GER_CONDIR` nesse caso.
- Só que `GER_ENTDIR` já foi para `'S'` antes desse `if`, e a query que localiza notas pendentes de pré-nota (`fPesqGerelePreNotaEntrada`, usada por `TPreNota.fSelecionaNFE`) exige `IFNULL(GER_ENTDIR, "N") <> "S"` (`untConsultas.pas:31125`). A nota fica **invisível** para a pré-nota.
- Sem passar pela pré-nota, `GER_DTALIB` nunca é preenchido. A listagem final de `TEntradaAutomatizada.fSQLNotas` (via `fSQLNotasEntrada`) exige, com FLUPDC ativo, `GER_DTALIB IS NOT NULL AND GER_DTACON IS NOT NULL` (`untConsultas.pas:31686-31687`) — condição nunca satisfeita. É exatamente o sintoma relatado: "não está encontrando o item para finalizar a entrada".

Os demais ramos de `fGravaGerEle` que gravam `GER_ENTDIR='S'` (devolução/retorno de garantia — `xmlEntradaMercadoriasSistemaAnteriorDevolucao`, `xmlDevolucaoEntradaEmitidaFornecedor`, `xmlCFG_UVNEGFEntMerRetornoFornecedor`, `xmlCFG_IMPXGRGarantiaRetFornecedor`) não dependem de FLUPDC e fecham a entrada direta de propósito — não são afetados por este bug e ficam fora de escopo.

## 2. Módulos e entidades envolvidos

- Módulo: movimentação de itens / entrada de mercadorias (importação de NF-e)
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/untEntNfeXml.pas` — `TNFeXml.fGravaGerEle` (alterar)
  - `padra_atualizado/fontes/genericos/untConsultas.pas` — `fPesqGerelePreNotaEntrada`/`fSQLNotasEntrada` (só leitura/consulta, não alterar)
  - `padra_atualizado/fontes/movimentacaoitens/untPreNota.pas` — `TPreNota.fSelecionaNFE` (não alterar)
  - `padra_atualizado/fontes/movimentacaoitens/untEntPreNotaEntrada.pas` — liberação da pré-nota, `UPDATE GERELE SET GER_DTALIB=...` (não alterar)
  - `padra_atualizado/fontes/movimentacaoitens/untEntradaAutomatizada.pas` — `TEntradaAutomatizada.fCarregaNota`/`fSQLNotas` (não alterar; validado como consistente com o fix)
- Tabela: `GERELE`, chave `AUTOINCREM`. Campos envolvidos: `GER_ENTDIR`, `GER_CONDIR`, `GER_DTALIB`, `GER_DTACON`, `GER_CODFOR`.
- Tabela `CADFOR`, campo `FOR_MATREV` — classifica fornecedor como material de uso/consumo (`'M'`).
- Configuração de sistema: `FLUPDC` (`fCfgSis('FLUPDC', varBoolean)`) — habilita o fluxo de conferência/pré-nota obrigatória para itens de consumo.

## 3. Requisitos funcionais

- RF01 — Ao importar XML de NF-e de fornecedor com `FOR_MATREV='M'` e `FLUPDC` ativo, a nota deve permanecer com `GER_ENTDIR='N'` até que a pré-nota seja processada, para ser localizável por `TPreNota.fSelecionaNFE`.
- RF02 — Ao importar XML de NF-e de fornecedor com `FOR_MATREV='M'` e `FLUPDC` **inativo**, o comportamento atual deve ser mantido: `GER_ENTDIR='S'`, `GER_DTALIB` e `GER_CONDIR='S'` gravados na importação (entrada direta, sem pré-nota).

## 4. Regras de negócio

- RN01 — `GER_ENTDIR` só pode ser `'S'` no ramo `FOR_MATREV='M'` quando FLUPDC estiver **inativo** (entrada fecha direto). Com FLUPDC ativo, `GER_ENTDIR` deve ser `'N'` na importação, e só passa a refletir o fechamento da entrada mais adiante no fluxo existente (pré-nota → entrada automatizada), sem necessidade de alteração adicional — a cadeia já foi validada como consistente (ver seção 1).
- RN02 — O ramo `Else` original (fornecedor sem `FOR_MATREV='M'`), que já grava `GER_ENTDIR='N'`, não é alterado.
- RN03 — Os ramos de devolução/retorno de garantia (`xmlEntradaMercadoriasSistemaAnteriorDevolucao`, `xmlDevolucaoEntradaEmitidaFornecedor`, `xmlCFG_UVNEGFEntMerRetornoFornecedor`, `xmlCFG_IMPXGRGarantiaRetFornecedor`) não são alterados — continuam gravando `GER_ENTDIR='S'` incondicionalmente, por não passarem pelo fluxo de pré-nota.

## 5. Requisitos técnicos / não-funcionais

- Alteração pontual, sem mudança de transação/auditoria/permissão.
- Sem impacto em SQL de outras units — a correção não altera as queries de seleção, apenas o valor gravado na importação.

## 6. Critérios de aceitação

- [ ] Importar XML de fornecedor com `FOR_MATREV='M'` e `FLUPDC='S'`: a nota é gravada com `GER_ENTDIR='N'` e `GER_DTACON` preenchido.
- [ ] A mesma nota aparece na consulta de `TPreNota.fSelecionaNFE` para seleção de pré-nota.
- [ ] Após liberar/confirmar a pré-nota (`GER_DTALIB` preenchido), a nota aparece em `TEntradaAutomatizada` para finalizar a entrada de mercadoria.
- [ ] Importar XML de fornecedor com `FOR_MATREV='M'` e `FLUPDC='N'` (regressão): comportamento inalterado — `GER_ENTDIR='S'`, `GER_DTALIB` e `GER_CONDIR='S'` gravados direto na importação, sem passar por pré-nota.

## 7. Fora de escopo

- Levantamento ou correção em lote de notas já gravadas no banco com o padrão do bug (`GER_ENTDIR='S'` indevido). O caso do ticket (nota 584364/fornecedor 1238) já foi ajustado manualmente pelo suporte.
- Alteração nos demais ramos de `fGravaGerEle` (devolução/retorno de garantia) — não afetados pelo bug.
- Alteração nas queries de `untConsultas.pas` — já estão corretas e coerentes com o fix.

## 8. Dependências e riscos

- Risco baixo: mudança isolada a um ramo condicional já existente (`FOR_MATREV='M'`), sem alterar lógica de outros ramos/fluxos.
- Dependência: nenhuma outra unit precisa mudar — cadeia pré-nota → entrada automatizada já trata `GER_ENTDIR='N'` corretamente para outros fornecedores (fluxo pré-existente, não criado por este requisito).
