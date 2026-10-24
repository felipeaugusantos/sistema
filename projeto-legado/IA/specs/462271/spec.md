# Especificação — Req. 462271

**Título:** Colunas de Giro 3/6/12 meses vazias no AUTCOM Homologação
**Objetivo:** Fazer as colunas "Giro 3 meses", "Giro 6 meses" e "Giro 12 meses" do formulário "Estoque das Empresas" exibirem dados no ambiente de homologação (cópia `379.48.2.30.74.150.45`), igualando ao comportamento já observado em produção.
**Zona:** Legado
**Data:** 2026-09-16

## 1. Contexto / problema atual

O formulário "Estoque das Empresas" (`untFatMostraEstoqueEmp`), acessado a partir de `[ JZ ] CONSULTAS DE PRODUTO`, exibe em produção (AUTCOM Produção) três colunas de giro de vendas por empresa: Giro 3 meses, Giro 6 meses e Giro 12 meses, com valores calculados. No ambiente de homologação (cópia `379.48.2.30.74.150.45`), essas colunas não existiam: a funcionalidade correspondente (Req. 363961 — implementada originalmente na cópia `379.48.2.30.72`, SVN revisões 408064 e 408973) nunca havia sido portada para esta cópia. O usuário relatou que, ao logar com o operador 265, as colunas apareciam sem nenhum dado — na prática, a coluna nem existia no `.dfm`/`.pas` desta cópia antes da correção.

## 2. Módulos e entidades envolvidos

- Módulo(s): faturamento (formulário de consulta), genéricos (função utilitária de SQL)
- Units:
  - `padra_atualizado/fontes/faturamento/untFatMostraEstoqueEmp.pas`
  - `padra_atualizado/fontes/faturamento/untFatMostraEstoqueEmp.dfm`
  - `padra_atualizado/fontes/genericos/untFuncoesSimples.pas`
- Tabelas/entidades: `GIRITE` (giro de itens por empresa/ano/mês, chave `GIR_CODITE` + `GIR_CODEMP` + `GIR_A_N_O_`), `CADEMP` (empresas, chave `EMP_CODEMP`)

## 3. Requisitos funcionais

- RF01 — O formulário "Estoque das Empresas" deve exibir as colunas "Giro 3 meses", "Giro 6 meses" e "Giro 12 meses" no grid principal (`cxGridDados`), com valores numéricos calculados por empresa.
- RF02 — O cálculo deve considerar as saídas (`_SAI`) dos últimos 3, 6 e 12 meses corridos a partir do mês/ano atual (`fNow()`), por item (`strCodIte`) e por empresa (`EMP_CODEMP`).
- RF03 — O comportamento deve ser equivalente ao já existente em produção e na cópia de origem `379.48.2.30.72` (Req. 363961).

## 4. Regras de negócio

- RN01 — O período de referência é sempre o mês/ano atual do servidor (`fNow()`), somando os últimos 3/6/12 meses de saída de cada empresa para o item selecionado.
- RN02 — Meses sem registro em `GIRITE` para o ano correspondente entram como `0.00` no SQL (não geram erro nem `NULL`).
- RN03 — O cálculo é reexecutado a cada abertura do formulário (`FormShow`), após a carga normal do grid de saldos (`pcdsSalEmp`), não sendo persistido em banco.
- RN04 — Em caso de erro durante o cálculo (ex.: falha de conexão/SQL), o erro é reportado via `pMensagensErro` e não deve interromper a exibição do restante do formulário (já carregado antes do cálculo).

## 5. Requisitos técnicos / não-funcionais

- Sem impacto de permissão, auditoria ou transação — consulta somente leitura.
- Sem impacto fiscal/financeiro direto — é uma consulta gerencial de estoque/giro.
- Mantém padrão de acesso a dados do projeto: `TUniQuery` via `fCriaQuery`, SQL montado com `ParamByName`.

## 6. Critérios de aceitação

- [x] Ao abrir "Estoque das Empresas" para um item com histórico de vendas, as colunas Giro 3/6/12 meses exibem valores não nulos condizentes com as saídas do item nos períodos.
- [x] Para itens sem vendas no período, as colunas exibem `0`.
- [x] Nenhuma outra coluna/comportamento existente do formulário foi alterado.
- [x] Validado manualmente pelo usuário nesta cópia (74.150.45).

## 7. Fora de escopo

- Alteração de `untCadProdutos.pas` (função `fGetSqlGiro`, tela de Cadastro de Produtos) — nesta cópia essa função já diverge da origem (colunas `ITE_SALDIS`, `GIR_QORC`, integração com Pasta de Compras) e não é usada pelo formulário "Estoque das Empresas"; unificação fica fora deste requisito.
- Redimensionamento cosmético do `.dfm` (Width/Height do formulário) feito na cópia de origem — não replicado, por ser puramente estético e não afetar a exibição dos dados.

## 8. Dependências e riscos

- Dependência: tabela `GIRITE` deve estar populada corretamente no ambiente de homologação (mesma estrutura usada em produção) — sem isso as colunas continuariam exibindo `0.00`, mesmo com o código correto.
- Risco mitigado: por reaproveitar a mesma lógica/SQL já validada na cópia de origem (Req. 363961), o risco de regressão é baixo.
