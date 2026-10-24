# Especificação — Req. 465458

**Título:** CFOP de entrada inválido na entrada de transferência de estoque (devolução)
**Objetivo:** Evitar que `pDeterminaClafis` gere CFOP de entrada com menos de 4 caracteres e cobrir os CFOPs 5209 → 1209 e 6209 → 2209 no fallback de `fTrocaClaFis`.
**Zona:** Legado
**Data:** 2026-09-30

## 1. Contexto / problema atual
Ao processar a entrada de transferência de estoque (Documento 000000102401-NF-003-1, Fornecedor 00067813, empresa de origem 003 - ABRAFER COMERCIAL LTDA), o log registra:

> Foi encontrado uma falha ao definir o CFOP da Entrada. Favor, verificar no cadastro da empresa de origem 003 ... as classificações de entrada definidas na Aba 2 - Configuração de Transf. de Estoque

Documento emitido com CFOP 5209 e `FblnDevolu = True`.

A mensagem é gerada em `untRecTransfEstoque.pas` (~linha 4523) quando `Length(strClaFisDet) < 4`. O valor vem de `TfrmRecTransfEstoque.fTrocaClaFis`, que chama `pDeterminaClafis` (`untFuncoesGenerica.pas`).

No ramo `blnForFil = True` de `pDeterminaClafis`, o código faz `'1' + RightStr(strClaFis, 3)` (ou `'2' + ...`) sem validar `strClaFis`. Com `strClaFis` vazio, o resultado tem 1 caractere e a validação de 4 dígitos falha.

O fallback final de `fTrocaClaFis` (`FblnDevolu` e `Result` vazio) só cobre os CFOPs 5401, 5405, 6401 e 6405. Os CFOPs 5209 e 6209 não são tratados.

## 2. Módulos e entidades envolvidos
- Módulo(s): movimentação de itens (transferência de estoque), genéricos.
- Units:
  - `padra_atualizado/fontes/genericos/untFuncoesGenerica.pas` — `pDeterminaClafis`
  - `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas` — `TfrmRecTransfEstoque.fTrocaClaFis`
- Tabelas/entidades: `CADEMP` (configuração de transferência, EMP_CLATE*/EMP_CLTEV*/EMP_CETDF*), `CADCFO` (CFO_CLAENT/CFO_CLASUB), `CFOCEM`. Nenhuma alteração de estrutura.

## 3. Requisitos funcionais
- RF01 — Em `pDeterminaClafis`, no ramo `blnForFil`, só prefixar `'1'`/`'2'` quando `strClaFis` não for vazio e tiver exatamente 4 caracteres.
- RF02 — Em `fTrocaClaFis`, no fallback de devolução, incluir os CFOPs `'5209'` com resultado `'1209'` e `'6209'` com resultado `'2209'`.

## 4. Regras de negócio
- RN01 — `strClaFis` vazio ou com tamanho diferente de 4: não montar CFOP; manter o valor de entrada para o fluxo seguir e o fallback de `fTrocaClaFis` atuar.
- RN02 — Mapeamento de fallback (devolução, `Result` vazio): 5401→1410, 5405→1411, 6401→2410, 6405→2411, **5209→1209**, **6209→2209**.
- RN03 — O resultado final de `fTrocaClaFis` continua sendo validado com `Length >= 4` antes de gravar o movimento.

## 5. Requisitos técnicos / não-funcionais
- Arquivos em cp1252: edição via Python com encoding explícito; validar ausência de U+FFFD.
- Comentários no fonte com referência ao Req. 465458; identificadores sem número de requisito.
- Impacto fiscal: define o CFOP da nota de entrada de transferência.

## 6. Critérios de aceitação
- [ ] Entrada de transferência/devolução com CFOP de saída 5209 não gera mais a mensagem de falha de CFOP.
- [ ] CFOP de saída 5209 resulta em CFOP de entrada 1209 no fallback.
- [ ] CFOP de saída 6209 resulta em CFOP de entrada 2209 no fallback.
- [ ] Os mapeamentos 5401/5405/6401/6405 continuam iguais.
- [ ] Fluxos que já resolviam o CFOP corretamente não mudam de resultado.

## 7. Fora de escopo
- Guard no trecho `IIF(strEstFor = fCadEmp('ESTADO'), '1', '2') + RightStr(...)` (linha ~13116).

- Alteração pré-existente no log de falhas do gravamento do movimento (`untRecTransfEstoque.pas`, ~linhas 2225-2250), incluída junto por decisão do usuário e sem relação com o CFOP; detalhada no `.md` de análise (seção 5.1).

## 8. Dependências e riscos
- `pDeterminaClafis` é genérica e usada em outras telas. O guard só altera o caso em que `strClaFis` é vazio ou tem tamanho diferente de 4, que hoje já gera CFOP inválido.
