# Plano de Execução — Req. 465458

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Ajuste pontual em duas rotinas legadas, sem refatoração. Mantém o estilo existente (Hungarian, `fEmptyStr`, `Case AnsiIndexStr`).

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untFuncoesGenerica | padra_atualizado/fontes/genericos/untFuncoesGenerica.pas | alterar (`pDeterminaClafis`, ramo `blnForFil`, ~linha 13173) |
| untRecTransfEstoque | padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas | alterar (`fTrocaClaFis`, ~linha 2904) |

## 3. Sequência de implementação
1. `pDeterminaClafis`: envolver o `If (strEstFor = strEmpEst) Or blnPresencial Then strClaFis := '1' + ... Else '2' + ...` em `If (Not fEmptyStr(strClaFis)) And (Length(strClaFis) = 4) Then`.
2. `fTrocaClaFis`: incluir `'5209'` e `'6209'` na lista do `AnsiIndexStr` e os `Case 4 : Result := '1209';` / `5 : Result := '2209';`.
3. Validar encoding e diff.
4. Replicar as mesmas alterações nas working copies `379.48.2.30.74.150` e `379.48.2.30.74.150.100` (mesmos dois arquivos, mesmo caminho relativo), conferindo o código local antes de aplicar.

Observação: o diff da `74.150.45` também contém uma alteração pré-existente fora do escopo (log de falhas do gravamento do movimento em `untRecTransfEstoque.pas`), replicada na `74.150.100` (a `74.150` já a continha).

## 4. Conformidade com padrões do projeto
- Zona Legado: Hungarian style, sem refatorar.
- Chamadas: `fEmptyStr` já existente; nenhuma chamada proibida.
- Pre-commit: sem componentes/chamadas/SQL proibidos.
- Encoding: cp1252 + CRLF; edição via Python (`io.open(..., encoding='cp1252', newline='')`), nunca `Edit`.

## 5. Estratégia de testes
- Não há suite DUnit para essas rotinas; validação manual.
- Casos:
  - Entrada de transferência/devolução com CFOP 5209 (empresa 003, fornecedor 00067813), esperado 1209.
  - Devolução com CFOP 6209, esperado 2209.
  - Regressão com 5401/5405/6401/6405.
  - Transferência normal (não devolução), sem mudança de comportamento.

## 6. Riscos e mitigação
- `pDeterminaClafis` usada em outras telas → o guard só age em `strClaFis` vazio ou com tamanho diferente de 4; conferir os chamadores com ramo `blnForFil`.
- Código divergente entre as working copies → ler o trecho de cada cópia antes de aplicar; não copiar arquivo inteiro.
- Corrupção de encoding → Python + verificação de U+FFFD e diff.
