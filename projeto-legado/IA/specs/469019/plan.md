# Plano de Execução — Req. 469019

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Criar em `TfrmTransfCodFornecedor` a procedure `pApagaForGefDuplicado(strForOri, strForDes)`, no mesmo molde de `pApagaPreIteDuplicado` (`untTransfCodProduto.pas`), porém com `ParamByName()`:

```sql
DELETE FROM FORGEF
 WHERE FGE_CODFOR = :FORORI
   AND FGE_CODGEF IN (SELECT FGE_CODGEF FROM (SELECT FGE_CODGEF FROM FORGEF
                                              WHERE FGE_CODFOR = :FORDES) AS TAB)
```

Chamada em `fTransfereCodFornecedor`, logo após o bloco `TIntegridadeTransferenciaCodigo` e antes do `DELETE FROM FORNEO` e do loop de UPDATEs, dentro do `fStartTransaction`.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untTransfCodFornecedor | padra_atualizado/fontes/util/untTransfCodFornecedor.pas | alterar |

## 2.1 Working copies
| Working copy | Situação da unit |
|---|---|
| 379.48.2.30.74.150.100 | referência; ponto de inserção na linha 382 (`objInteg`) |
| 379.48.2.30.74.150 | arquivo idêntico à .100 (mesmo hash) |
| 379.48.2.30.74.150.45 | difere em 12 bytes; mesmas linhas de referência (76, 379, 382, 388); conferir o diff antes de aplicar |

Aplicar a mesma alteração nas três, sempre via Python em cp1252, relendo o contexto de cada cópia (não sobrescrever o arquivo inteiro com o conteúdo de outra).

## 3. Sequência de implementação
1. Declarar `procedure pApagaForGefDuplicado(strForOri, strForDes: String);` na seção `private`, junto de `pValidaCodCtaOriDes`.
2. Implementar a procedure com `fCriaQuery`, `try/finally` e `FreeAndNil`.
3. Chamar em `fTransfereCodFornecedor` após o bloco `objInteg` (antes do `DELETE FROM FORNEO`), com comentário curto.
4. Validar encoding (decodifica em cp1252, sem `\xef\xbf\xbd`) e `svn diff` só com as mudanças pretendidas.

## 4. Conformidade com padrões do projeto
- Zona Legado: Hungarian (`str`, `qry`), prefixo `p` em procedure, estilo `Begin/End`, `Try/Finally` da unit.
- Chamadas: `fCriaQuery`, `ParamByName()`; sem `Now`, `StrToFloat`, `.SetFocus`.
- Sem número de requisito no identificador; apenas comentário curto no fonte.
- Edição via Python em cp1252 (nunca `Edit`); preservar CRLF.

## 5. Estratégia de testes
- Sem suite DUnit para a unit; validação manual em homologação:
  - 00005920 → 00005989.
  - Origem com grupos diferentes do destino.
  - Origem sem grupos.
  - Falha forçada após o DELETE (rollback).
  - Importação por Excel.
  - Regressão: transferência de produto (EMPPRA/CADITE).

## 6. Riscos e mitigação
- DELETE em FORGEF → restrito ao fornecedor de origem e à transação; rollback existente cobre falhas.
- `DEL_FORGEF` com PK igual → fora de escopo; verificar se surgir novo chamado.
- Erro 1093 do MySQL → subselect aninhado.
