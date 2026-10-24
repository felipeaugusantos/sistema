# Plano de Execução — Req. 470260

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Alteração localizada em `TPrecoProduto.fSalvaDados` e `TPrecoProduto.pAdicionaPrecosInclusao`.

- `fSalvaDados`, `FInclusao = True`: `Filtered := False`; todas as linhas recebem `AUTOINCREM` novo, `PRO_CODITE` e `PRO_CODEMP` (atribuição incondicional, como no código original); `Self.Next` após o `Post`, porque a linha não sai mais do filtro.
- `fSalvaDados`, `FInclusao = False`: filtro `AUTOINCREM IS NULL` e laço exatamente como antes.
- `fRetAutoIncrem('PREPRO', VS_strCodEmp, Self.RecordCount)` mantido.
- `pAdicionaPrecosInclusao`: `cdsCopia := Nil` e corpo dentro de `Try/Finally` com `FreeAndNil(cdsCopia)`.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untPrecoProduto.pas | padra_atualizado/fontes/cadastros/ | alterar (`fSalvaDados`, `pAdicionaPrecosInclusao`) |

Replicado nas working copies `379.48.2.30.74.150`, `379.48.2.30.74.150.45` e `379.48.2.30.74.150.100`.

## 3. Sequência de implementação
1. Escolher filtro/sem filtro conforme `FInclusao`.
2. Manter atribuição incondicional e avançar com `Self.Next` na inclusão.
3. Incluir `Try/Finally` em `pAdicionaPrecosInclusao`.
4. Gravar via Python em cp1252 (`io.open(..., encoding='cp1252', newline='')`).
5. Validar: decodificação cp1252, ausência de `\xef\xbf\xbd`, sem LF solto.

## 4. Conformidade com padrões do projeto
- Zona Legado: Hungarian style, estilo e capitalização do bloco existente.
- Sem identificadores novos; `Req. 470260` apenas em comentário curto.
- Sem componentes, chamadas ou SQL proibidos pelo pre-commit; sem alteração de `.dfm`.

## 5. Estratégia de testes
- Não há suíte DUnit para `TPrecoProduto`; validação manual.
- Casos a cobrir:
  - Inclusão de produto novo (PREPRO com `PRO_CODITE`/`PRO_CODEMP`/`AUTOINCREM` preenchidos).
  - Cenário empresa 002 / tabela 1 sem `Duplicate entry`.
  - Todas as linhas da inclusão com `AUTOINCREM` novo.
  - Alteração de produto existente sem mudança de comportamento.

## 6. Riscos e mitigação
- Linha carregada do banco com código vazio vira registro do produto novo → dado inválido, removido no cliente.
- `strCodIte` vazio gravaria código vazio → sem validação; fora do escopo.
- Sem filtro, laço sem avanço travaria → `Self.Next` na inclusão.
- Corrupção de encoding → edição apenas via Python em cp1252, com validação.
