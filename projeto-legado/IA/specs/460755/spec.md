# Especificação — Req. 460755

**Título:** Entrada de devolução de cliente ignora itens de NF sem localização física por lote (DETLOC)
**Objetivo:** Permitir a entrada de mercadorias por devolução de cliente para documentos de venda que não possuem registro em DETLOC (documentos anteriores à ativação da configuração `UM1LFL`), sem alterar o comportamento já existente para documentos que possuem DETLOC.
**Zona:** Legado
**Data:** 2026-09-10

## 1. Contexto / problema atual

A rotina de entrada de mercadorias, ao selecionar itens para devolução de cliente, monta a consulta de itens disponíveis em `TfrmEntSelItensDevolucao.fGetSQL` (`untEntSelItensDevolucao.pas`). Quando a empresa está configurada para usar múltiplas localizações físicas por lote (`fUsaMaisDeUmaLocalizacaoFisicaPorLote` = config `UM1LFL`) e mantém o lote (`fCfgSis('MANEND') = 'S'`), a consulta passa a considerar a tabela `DETLOC` (`AConsiderarDETLOC = True`), via:

```sql
JOIN DETLOC ON D.AUTOINCREM = DTL_INCDET
```

Esse `JOIN` é um `INNER JOIN`. Documentos de venda lançados **antes** da ativação da configuração `UM1LFL` nunca tiveram registro em `DETLOC` gravado para seus itens. Para esses documentos, o `INNER JOIN` elimina todas as linhas do resultado — a consulta retorna vazia mesmo que o item nunca tenha sido devolvido.

Consequência: `TfrmEntSelItensDevolucao.blnTemItensDisponiveis` retorna `False`, e a rotina (`untEntDigPedido.pas`, linha 1084) exibe a mensagem "Todos os itens deste documento já foram devolvidos" — falso positivo, pois na verdade não existe nenhuma devolução vinculada (confirmado por consulta em `MOVDET` filtrando por `DET_DOCDEV`/`DET_ESPDEV`/`DET_EMPDEV`/`DET_CODCLI`, sem resultados).

Caso real de reprodução: NF 000000207774, empresa 001, cliente Intercores (10034715) — documento anterior à ativação de `UM1LFL`, sem registro em `DETLOC`. Nesse caso, `MOVDET.DET_NUMLOT` também é `NULL` para todos os itens (confirmado no banco).

**Ponta a ponta investigado e descartado:** cogitou-se que `TfrmEntMercadorias.pAdicionaItem` (`untEntMercadorias.pas`, linha ~6012) também precisaria de ajuste, pois resolve `LOCFIS` buscando em `LOTLOC` sempre que `fUsaMaisDeUmaLocalizacaoFisicaPorLote` está ativo, sem fallback para lote sem registro em `LOTLOC`. Verificado que **não se aplica**: como `DET_NUMLOT` vem `NULL` para o documento de reprodução, `strNumLot` chega vazio em `pAdicionaItem`, que já cai no ramo `fEmptyStr(strNumLot)` (usa `ITE_LOCFIS`) — o ramo `LOTLOC`/`CADLOT` nunca é exercitado por este caso. Adicionalmente, sob `UM1LFL` ativo não há garantia de que `CADLOT.LOT_LOCFIS` (esquema de localização única) reflita a localização real de um lote gerido por `LOTLOC` (esquema multi-localização) — um fallback ali seria especulativo, não verificado pelos dados reais. `untEntMercadorias.pas` fica **fora do escopo** desta correção.

## 2. Módulos e entidades envolvidos

- Módulo: movimentação de itens / entrada de mercadorias (devolução de cliente)
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/untEntSelItensDevolucao.pas` (`fGetSQL`, `fGetSQLJoins`, `fGetSQLCampos`)
  - `padra_atualizado/fontes/movimentacaoitens/untEntDigPedido.pas` (orquestrador — consumidor, sem alteração prevista)
  - `padra_atualizado/fontes/movimentacaoitens/untEntMercadorias.pas` (`pAdicionaItem`) — investigado, **fora de escopo** (ver seção 1)
- Tabelas/entidades:
  - `MOVDET` (detalhe do documento de venda original) — chave `AUTOINCREM`
  - `DETLOC` (localização física por lote/documento) — chave lógica `DTL_INCDET` (FK para `MOVDET.AUTOINCREM`)
  - `LOTLOC` (localização física por lote/item/empresa) — chave `LLC_NUMLOT`+`LLC_CODITE`+`LLC_CODEMP`
  - `CADLOT` (cadastro de lote) — chave `LOT_CODITE`+`LOT_CODEMP`, campo `LOT_LOCFIS`

## 3. Requisitos funcionais

- RF01 — A tela de seleção de itens para devolução (`TfrmEntSelItensDevolucao`) deve listar todos os itens do documento de venda com saldo disponível para devolução, independentemente de existir ou não registro em `DETLOC` para aquele item.
- RF02 — Para itens sem `DETLOC`, a quantidade, o lote e os valores fiscais/financeiros exibidos e usados na devolução devem ser os do `MOVDET`/`MOVTRI` originais (comportamento equivalente ao de uma empresa sem `UM1LFL` ativo).
- RF03 — Para itens com `DETLOC`, o comportamento atual (rateio por localização/lote) deve permanecer inalterado.

## 4. Regras de negócio

- RN01 — `AConsiderarDETLOC` continua determinado por `fUsaMaisDeUmaLocalizacaoFisicaPorLote` (config `UM1LFL`) + `MANEND = 'S'` + ausência de `strAutDev` — não há mudança nesse cálculo.
- RN02 — O `JOIN` com `DETLOC` passa de `INNER` para `LEFT`; toda coluna hoje calculada a partir de `DETLOC` (unitário líquido, `DET_QTDITE`, `QTDORI`, `DET_NUMLOT`, campos fiscais rateados via `fRetCampo`) deve ter fallback para o valor original do `MOVDET`/`MOVTRI` quando não houver `DETLOC` correspondente (linha resultante do `LEFT JOIN` com `DTL_*` nulos).
- RN03 — A subtração de quantidade já devolvida (`fRetQtdDevolvida`) continua funcionando sem alteração, pois já recebe o `DET_NUMLOT` resultante (com ou sem fallback) como parâmetro.
- RN04 — (descartada) Cogitou-se fallback de `LOCFIS` para `CADLOT.LOT_LOCFIS` em `pAdicionaItem` quando `LOTLOC` não retornasse valor; verificado que o caso real não exercita esse ramo (`DET_NUMLOT` nulo → `strNumLot` vazio → `pAdicionaItem` já usa `ITE_LOCFIS`), e que a garantia de correção do fallback não é verificável (`CADLOT` é do esquema de localização única). Não implementada — ver seção 1.

## 5. Requisitos técnicos / não-funcionais

- Sem impacto de performance relevante esperado (troca de `INNER` por `LEFT JOIN` na mesma consulta já existente).
- Sem impacto em auditoria, permissão ou transação — o fluxo de gravação da entrada (`TfrmEntMercadorias`) não muda de forma.
- Sem impacto fiscal na regra em si — o objetivo é preservar os valores fiscais originais do documento de venda quando não há rateio por localização a aplicar.

## 6. Critérios de aceitação

- [ ] NF 000000207774 (empresa 001, cliente 10034715) aparece corretamente na tela de seleção de itens para devolução, com os itens e quantidades da venda original.
- [ ] A devolução da NF 000000207774 é concluída com sucesso.
- [ ] Um documento de venda com `DETLOC` já gravado (empresa com `UM1LFL` desde a origem) continua funcionando exatamente como antes (quantidade, lote e valores fiscais idênticos ao comportamento pré-correção).
- [ ] Um documento parcialmente devolvido continua bloqueando apenas os itens já devolvidos, não o documento inteiro.

## 7. Fora de escopo

- Popular retroativamente `DETLOC`/`LOTLOC` para documentos antigos.
- Alterar a regra de quando `AConsiderarDETLOC` é ativado (RN01).
- Rotinas de relatório/espelho de devolução que eventualmente também dependam de `DETLOC` (não identificadas nesta análise — revisitar se surgir durante a implementação).

## 8. Dependências e riscos

- Risco: fallback incorreto em algum campo fiscal rateado gerar valor fiscal divergente do documento de venda original — mitigar validando os totais (ICMS/IPI/PIS/COFINS) nos casos de teste antes de liberar.
- Risco: outras rotinas dependentes do fan-out por `DETLOC` não cobertas nesta análise.
- Sem dependência de outros módulos/serviços além dos já listados.

## 9. Referências

- Ciclo de vida de `DETLOC`/`LOTLOC` na entrada (por que um item recém-entrado também pode não ter `DETLOC`, não só documento antigo): `IA\know\detloc_geracao_localizacao_fisica_lote.md`.
