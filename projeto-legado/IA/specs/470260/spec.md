# Especificação — Req. 470260

**Título:** Chave duplicada em PREPRO na inclusão de produto (`TPrecoProduto.fSalvaDados`)
**Objetivo:** Garantir que, na inclusão, todas as linhas de PREPRO recebam `AUTOINCREM` novo, `PRO_CODITE` e `PRO_CODEMP`.
**Zona:** Legado
**Data:** 2026-10-15

## 1. Contexto / problema atual
Na gravação de produto (`TfrmCadProdutos.fGravaItem` → `TPrecoProduto.fSalvaDados` → `fIncluiComplementos` → `TZClient.fSalva`) ocorreu `#23000 Duplicate entry '002-1' for key 'PRIMARY'` em PREPRO (cliente RR Parafusos, versão 48.2.30.74.150).

Em `fSalvaDados` o filtro `AUTOINCREM IS NULL` decidia quais linhas recebiam `AUTOINCREM`, `PRO_CODITE` e `PRO_CODEMP`. Na inclusão, `fCarregaDados('', True)` carrega do banco as linhas de PREPRO com `PRO_CODITE = ''`. A base do cliente tinha 56 linhas inválidas assim (8 empresas × 7 tabelas), todas com `AUTOINCREM` preenchido. Elas ficavam fora do filtro e seguiam com `PRO_CODITE` vazio. `fIncluiComplementos` copia `PRO_CODITE` de `Self` para as demais empresas e gerava `''/002/1`, que colidia com a linha inválida da empresa 002.

Causa raiz: dado inválido no banco do cliente (linhas com código de item vazio). O cliente apagou as linhas (conferido: 0 linhas com `PRO_CODITE` vazio ou nulo). O ajuste no código garante que a inclusão não dependa de o dado estar íntegro.

## 2. Módulos e entidades envolvidos
- Módulo: cadastros (preço de produto).
- Units: `padra_atualizado/fontes/cadastros/untPrecoProduto.pas` (`TPrecoProduto.fSalvaDados`, `TPrecoProduto.pAdicionaPrecosInclusao`).
- Tabela: PREPRO — PK `(PRO_CODITE, PRO_CODEMP, PRO_NROTAB)`; índice único `IDX_PREPRO_05 (AUTOINCREM)`. `AUTOINCREM` é `char(20)`, `PRO_CODITE` `varchar(5)`, `PRO_CODEMP` `char(3)`.

## 3. Requisitos funcionais
- RF01 — Na inclusão (`FInclusao = True`), `fSalvaDados` não filtra o dataset: todas as linhas visíveis recebem `AUTOINCREM` novo, `PRO_CODITE` = `strCodIte` e `PRO_CODEMP` = `VS_strCodEmp`.
- RF02 — Na alteração (`FInclusao = False`), o comportamento permanece idêntico ao anterior (filtro `AUTOINCREM IS NULL`).
- RF03 — `pAdicionaPrecosInclusao` libera `cdsCopia` mesmo em caso de exceção (`Try/Finally`).

## 4. Regras de negócio
- RN01 — Na inclusão o `AUTOINCREM` é sempre novo, nunca reaproveitado da linha carregada.
- RN02 — `fRetAutoIncrem('PREPRO', VS_strCodEmp, Self.RecordCount)` reserva intervalo para todas as linhas; cada linha consome um valor via `fNextAutoIncremInt64`.
- RN03 — Sem filtro, a linha continua visível após o `Post`; por isso o laço avança com `Self.Next` na inclusão.

## 5. Requisitos técnicos / não-funcionais
- Arquivo em cp1252 (Windows-1252): edição apenas via Python com encoding explícito, nunca com `Edit`.
- Comentário curto no fonte com `Req. 470260`; sem número de requisito em identificadores.
- Sem componentes/chamadas proibidos pelo pre-commit.
- Transação inalterada (`blnConTransacao`).

## 6. Critérios de aceitação
- [ ] Inclusão de produto novo grava PREPRO com `PRO_CODITE`, `PRO_CODEMP` e `AUTOINCREM` preenchidos.
- [ ] Cenário empresa 002 / tabela 1 não gera `Duplicate entry`.
- [ ] Na inclusão, todas as linhas recebem `AUTOINCREM` novo.
- [ ] Alteração de produto existente mantém o comportamento anterior.
- [ ] Arquivo decodifica em cp1252 e não contém `\xef\xbf\xbd`; diff contém só a alteração pretendida.

## 7. Fora de escopo
- Origem das 56 linhas inválidas (não identificada).
- Alteração de `fIncluiComplementos`.
- Aplicar a mudança de filtro/atribuição no fluxo de alteração.

## 8. Dependências e riscos
- Em outra base com linhas de `PRO_CODITE` vazio, a linha carregada vira o registro do produto novo (`UPDATE`) e deixa de existir como estava.
- Se `strCodIte` vier vazio, as linhas são gravadas com código vazio, como antes (sem validação).
- A mesma alteração foi replicada nas working copies `74.150`, `74.150.45` e `74.150.100`.
