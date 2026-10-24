# Gravação de PREPRO na inclusão de produto — Req. 470260

## 1. Contexto de negócio

PREPRO guarda os preços do produto por empresa e por tabela de preço (`PRO_NROTAB`, 1 a 7). Ao gravar um produto em
`TfrmCadProdutos.fGravaItem`, `TPrecoProduto.fSalvaDados` completa os registros de preço com `AUTOINCREM` (sequencial
único de `fRetAutoIncrem`), `PRO_CODITE` e `PRO_CODEMP`, e depois os persiste via `fSalva` / `fIncluiComplementos`.

PK de PREPRO: `(PRO_CODITE, PRO_CODEMP, PRO_NROTAB)`; índice único `IDX_PREPRO_05` em `AUTOINCREM`. Tipos: `AUTOINCREM`
`char(20)`, `PRO_CODITE` `varchar(5)`, `PRO_CODEMP` `char(3)`.

## 2. Problema e causa raiz

Erro (cliente RR Parafusos, versão 48.2.30.74.150): `#23000 Duplicate entry '002-1' for key 'PRIMARY'`, na pilha
`fGravaItem → fSalvaDados → fIncluiComplementos → TZClient.fSalva → ApplyUpdates/Reconcile`.

Causa raiz: dado inválido no banco do cliente. Havia 56 linhas em PREPRO com `PRO_CODITE` vazio (8 empresas × 7 tabelas,
`AUTOINCREM` consecutivos em formato diferente do de produtos reais). Mecanismo:

1. Na inclusão, `fCarregaDados('', True)` faz `SELECT` com `PRO_CODITE = ''` e traz essas linhas (empresa logada) para `Self`.
2. O filtro `AUTOINCREM IS NULL` de `fSalvaDados` não as pegava (`AUTOINCREM` já preenchido), logo ficavam sem `PRO_CODITE`.
3. `fIncluiComplementos` insere para as demais empresas (`EMP_CODEMP <> :CODEMP`) copiando `PRO_CODITE` de `Self`. O
   insert saía com código vazio e colidia com a linha inválida da empresa 002, tabela 1.

O cliente apagou as linhas inválidas; consulta em leitura confirmou 0 linhas com `PRO_CODITE` vazio ou nulo. A origem
dessas linhas não foi identificada (as rotinas de importação `untImportaCadProdutosConfirmacao.pas` e
`untConfirmaProdutosEmMassa.pas` fazem `INSERT INTO PREPRO` com `PRO_CODITE` explícito; não foram abertas em detalhe).

## 3. Investigação

- Código lido: `fSalvaDados`, `fIncluiComplementos`, `fCarregaDados`, `pAdicionaPrecosInclusao`, `pCarregaHerancaItem`,
  `fSQLDados`, `fSQLEmpresasInclusao`, `TZClient.fSalvaPrg` e `fRetAutoIncrem`.
- Banco (somente leitura): índices e tipos de PREPRO; linhas com `PRO_CODITE` vazio antes e depois da limpeza.
- `TZClient.fSalvaPrg` só chama `ApplyUpdates(0)`; linha lida do banco e editada vai como `UPDATE`, não `INSERT`.

## 4. Abordagens testadas e descartadas

1. Filtro ampliado (`AUTOINCREM`, `PRO_CODITE` ou `PRO_CODEMP` vazio, só na inclusão) com `If` por campo. Descartada:
   uma linha carregada do banco com código vazio mantinha o `AUTOINCREM` da linha inválida (já existente) e o código novo
   era gravado por cima dela por `UPDATE`.
2. Mesmo filtro, `PRO_CODITE` vazio gerando `AUTOINCREM` novo e as demais com `If`. Descartada por ser mais complexa do que
   o necessário.
3. Versão final: na inclusão, sem filtro e com atribuição incondicional, o que garante que toda linha receba os valores.

## 5. Solução aplicada

Unit `padra_atualizado/fontes/cadastros/untPrecoProduto.pas`:

`TPrecoProduto.fSalvaDados`:
```pascal
If FInclusao Then
  Self.Filtered := False
Else
Begin
  Self.Filter   := 'AUTOINCREM IS NULL';
  Self.Filtered := True;
End;
...
While Not Self.Eof Do
Begin
  Self.Edit;
  Self.FieldByName('AUTOINCREM').AsString := strAutInc;
  Self.FieldByName('PRO_CODITE').AsString := strCodIte;
  Self.FieldByName('PRO_CODEMP').AsString := VS_strCodEmp;
  Self.Post;
  strAutInc := fNextAutoIncremInt64(strAutInc);
  If FInclusao Then
    Self.Next;
End;
```
`Self.Next` é necessário porque, sem filtro, a linha continua visível após o `Post` e o laço não avançaria sozinho.
`fRetAutoIncrem(..., Self.RecordCount)` reserva intervalo para todas as linhas.

`TPrecoProduto.pAdicionaPrecosInclusao`: `cdsCopia := Nil` e corpo dentro de `Try/Finally` com `FreeAndNil(cdsCopia)`,
para não vazar o objeto se `Append`/`Post`/`BeforePost` lançarem exceção (achado de revisão, preexistente).

Replicado nas working copies `379.48.2.30.74.150`, `379.48.2.30.74.150.45` e `379.48.2.30.74.150.100`. Arquivos em cp1252
com CRLF, editados via Python; validados sem `\xef\xbf\xbd` e sem LF solto.

## 6. Achados colaterais (não corrigidos)

- Origem das 56 linhas com `PRO_CODITE` vazio não identificada.
- Se `strCodIte` vier vazio, as linhas são gravadas com código vazio (sem validação).
- Em outra base com linhas de código vazio, a linha carregada vira o registro do produto novo e deixa de existir como estava.
- `fIncluiComplementos` não foi alterado.

## 7. Resultado

Validado pelo solicitante na versão inicial do ajuste (filtro ampliado). A versão final (sem filtro na inclusão) foi
aplicada em seguida e ainda não foi validada em execução.

## 8. Notas referenciadas no código-fonte

Nenhuma. Os comentários no fonte são curtos e autoexplicativos (`Req. 470260`), sem remissão a nota.
