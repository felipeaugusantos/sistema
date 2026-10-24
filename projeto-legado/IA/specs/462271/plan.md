# Plano de Execução — Req. 462271

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Portar para a cópia `379.48.2.30.74.150.45` a funcionalidade de cálculo de giro de vendas por empresa (3/6/12 meses), já existente e validada na cópia `379.48.2.30.72` (Req. 363961, SVN revisões 408064 e 408973), adaptando o ponto de inserção ao código já divergente desta cópia (esta cópia já tem colunas adicionais como `ITE_SDPDBF`/`ITE_QTPDBF` que a origem não tem).

Componentes portados:
1. Função utilitária `fGetSqlGiroProdutoPeriodo` (monta SQL de giro por período/ano, com filtro opcional por empresa via `blnCodEmp`), em `untFuncoesSimples.pas`.
2. `procedure pCalculaGiroMeses` em `untFatMostraEstoqueEmp.pas`, que usa a função acima para preencher os campos `ITE_GIRO03/06/12` do `cdsSalEmp`, chamada ao final do `FormShow`.
3. Colunas de grid `gdITE_GIRO03/06/12` no `.pas` (declaração) e `.dfm` (grid `cxGridDados`).
4. Colunas `(0.000) ITE_GIRO03/06/12` adicionadas aos dois `SELECT`s de `fGetSql` (função que monta a consulta base do grid), para que os campos existam no dataset antes do cálculo.

Deliberadamente **não portado**: a refatoração de `untCadProdutos.pas` (`fGetSqlGiro` → `fGetSqlGiroProdutoPeriodo`) feita na origem, pois a `fGetSqlGiro` desta cópia já diverge significativamente (colunas extras, integração com Pasta de Compras) e não é usada pelo formulário deste requisito.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untFatMostraEstoqueEmp.pas` | `padra_atualizado/fontes/faturamento/untFatMostraEstoqueEmp.pas` | alterar |
| `untFatMostraEstoqueEmp.dfm` | `padra_atualizado/fontes/faturamento/untFatMostraEstoqueEmp.dfm` | alterar |
| `untFuncoesSimples.pas` | `padra_atualizado/fontes/genericos/untFuncoesSimples.pas` | alterar |

## 3. Sequência de implementação

1. `untFuncoesSimples.pas`: adicionar declaração de `fGetSqlGiroProdutoPeriodo` na seção de interface e sua implementação (idêntica à da cópia de origem).
2. `untFatMostraEstoqueEmp.pas`:
   - Adicionar `DateUtils` ao `uses` da interface (necessário para `MonthOf`/`YearOf`).
   - Declarar os 3 novos campos de grid (`gdITE_GIRO03/06/12: TcxGridDBColumn`).
   - Declarar `procedure pCalculaGiroMeses` na seção `private`.
   - Adicionar as 3 colunas `(0.000) ITE_GIRO0x` nos dois blocos `SELECT` de `fGetSql`.
   - Implementar `pCalculaGiroMeses` (monta períodos, executa `fGetSqlGiroProdutoPeriodo` por empresa, grava em `cdsSalEmp`).
   - Chamar `pCalculaGiroMeses` ao final do `FormShow`.
3. `untFatMostraEstoqueEmp.dfm`: adicionar os 3 objetos `TcxGridDBColumn` (`gdITE_GIRO03/06/12`) ao grid `cxGridDados`, antes de `cxGridNivel`.
4. Validação manual no formulário (já executada pelo usuário nesta sessão).

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian style mantido (`strSQL`, `intMes`, `stlCamGir`), prefixos `p`/`f` mantidos, sem uso de componentes proibidos.
- Acesso a dados: `TUniQuery` via `fCriaQuery()`, `ParamByName` — sem concatenação de SQL com valores de usuário.
- Sem uso de `Now()`/`NOW()` direto — utiliza `fNow()`.
- Sem `.SetFocus` direto, `Application.CreateForm`, `ActiveControl :=` ou outros padrões proibidos pelo pre-commit.
- Nenhuma alteração em `.dproj`/projeto — apenas units já existentes no `autcom.groupproj`.

## 5. Estratégia de testes

- Suite: validação manual no ERP desktop (não há suite DUnit específica para este formulário de consulta).
- Casos cobertos:
  - Abrir "Estoque das Empresas" para item com vendas recentes → colunas de giro com valores > 0.
  - Abrir para item sem vendas no período → colunas com `0`.
  - Confirmar que as demais colunas/comportamentos do formulário (saldos, preços, ML) permanecem inalterados.
- Executado e confirmado pelo usuário nesta sessão ("já testei a alteração ficou correto").

## 6. Riscos e mitigação

- Dados de `GIRITE` desatualizados/ausentes em homologação → fora do controle deste requisito (é dependência de dados, não de código); mitigação: se persistir vazio após esta correção, validar carga da tabela `GIRITE` no banco de homologação.
- Divergência futura entre `fGetSqlGiroProdutoPeriodo` desta cópia e da cópia de origem, caso uma seja alterada sem a outra → mitigação: nenhuma automática; ficará registrado neste `plan.md` para referência futura.
