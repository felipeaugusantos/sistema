# Especificação — Req. 465544

**Título:** Erro no cálculo do IQF sem configuração em CADIQF e ajuste da tela de configuração
**Objetivo:** Eliminar o `EVariantTypeCastError` no cálculo do Índice de Qualidade do Fornecedor (IQF) quando a empresa não possui registro em `CADIQF`, e ajustar a tela de configuração para gravar `N` sem validar quando o índice não é utilizado.
**Zona:** Legado
**Data:** 2026-10-09

## 1. Contexto / problema atual
- Na entrada de mercadorias (`untEntDadosFiscais.btnConfirmaClick`), o cálculo do IQF (`TIndiceQualidadeFornecedor.pUpdateQualidadeFornecedor`) gera `EVariantTypeCastError` ("Could not convert variant of type (OleStr/UnicodeString) into type (Double)") quando não há registro em `CADIQF` para a empresa.
- `fGetCfgIQF` devolvia o inteiro `0` quando a consulta a `CADIQF` vinha vazia. Esse Variant numérico era comparado com `'M'` (`fSQLCalculaQualidadeFornecedor`) e somado a uma string (`'    LIMIT ' + fGetCfgIQF('IQF_QTDCMP')` em `fSQLTMPENT`, `fSQLDISEST`, `fSQLPRECOS`), provocando a conversão da string para `Double`.
- O cálculo roda dentro de `TfrmGravando.fExecuta` → `ShowModal` → `FormActivate`. A exceção levantada no `FormActivate` é consumida pelo `TWinControl.MainWndProc` (`Application.HandleException`) e não chega ao `Except` do chamador; `fExecuta` apenas retorna `False`, ignorado por `pCalculaQualidadeFornecedorLocal`.
- Na tela `TfrmCfgIndDesempenhoForn`, mesmo com "Utiliza índice" = "Não", as validações dos demais campos são executadas e o `INSERT` em `CADIQF` é tentado com campos vazios.
- A configuração `CFG_IQFATI` tem como padrão um `SELECT` baseado em `CFG_PROCOT`.

## 2. Módulos e entidades envolvidos
- Módulo(s): movimentacaoitens (IQF), configuracoes.
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/untIndiceQualidadeFornecedor.pas`
  - `padra_atualizado/fontes/configuracoes/untCfgIndDesempenhoForn.pas`
  - `padra_atualizado/fontes/configuracoes/untCfgRepositorio.pas`
- Tabelas/entidades: `CADIQF` (chave `IQF_CODEMP`), `CFGSIS` (configuração `IQFATI`).

## 3. Requisitos funcionais
- RF01 — O cálculo do IQF não deve gerar `EVariantTypeCastError` quando não há registro em `CADIQF`.
- RF02 — Falha no cálculo executado via `TfrmGravando.fExecuta` deve ser sinalizada ao chamador por exceção, com a mensagem original do erro, chegando ao `Except` de `fConfirmaEntradaMercadorias`, sem alterar a unit `untGravando`.
- RF03 — Na tela de configuração, com `rdgUtiInd` = "Não", não realizar as validações de tela e gravar `IQFATI` = `N`.
- RF05 — Com o filtro por últimas compras, as consultas de TMPENT/DISEST/PRECOS não devem gerar erro MySQL "LIMIT & IN/ALL/ANY/SOME subquery".
- RF04 — O valor padrão da configuração `CFG_IQFATI` deve ser `'N'`.

## 4. Regras de negócio
- RN01 — `fGetCfgIQF` sem registro retorna a string `'0'` (`'1'` para `IQF_QTDCMP`, evitando `LIMIT 0`; valor nulo também usa o padrão; as colunas de `CADIQF` são `int`, então a concatenação do `LIMIT` usa `VarToStr`).
- RN02 — A comparação do tipo de filtro usa `VarToStr(fGetCfgIQF('IQF_TIPFLT')) = 'M'`; sem configuração, o filtro não é por meses.
- RN03 — `fCalculaQualidadeFornecedorPrg` captura a exceção (guardando a mensagem em `recDadosIQF.strErro`) e retorna `False`; `pCalculaQualidadeFornecedorLocal` levanta exceção com essa mensagem quando `fExecuta` retorna `False`.
- RN07 — Em `fSQLTMPENT` (consulta sobre PCMDET/MOVDET), o filtro por últimas compras compara `PCMDET.AUTOINCREM IN (SELECT DET_SEQPED FROM (... LIMIT n) ITQF)`: `DET_SEQPED` pertence ao `DETPON` e guarda o `AUTOINCREM` do item do pedido; `PCMDET`/`MOVDET` não têm essa coluna (erro "Unknown column DET_SEQPED").
- RN08 — `IQF_QTDCMP` gravado como `0` ou negativo em `CADIQF` também assume `1` em `fGetCfgIQF`, pois `LIMIT 0` zeraria o IQF e classificaria o fornecedor como `D` (pode acionar a trava de liberação).
- RN05 — O `LIMIT` de `IQF_QTDCMP` fica em subquery derivada (`IN (SELECT DET_SEQPED FROM (... LIMIT n) ITQF)`), pois o MySQL não aceita `LIMIT` direto em subquery de `IN`.
- RN04 — Com "Não": `pSalvaDados` grava apenas `IQFATI` = `N`; `DELETE`/`INSERT` em `CADIQF` somente quando o valor é `S`. Registro existente em `CADIQF` é preservado.

## 5. Requisitos técnicos / não-funcionais
- Arquivos em cp1252 (Latin-1); edição apenas via Python com encoding explícito, preservando o padrão de quebra de linha.
- Transação: gravação de `IQFATI` e de `CADIQF` na mesma transação (`fStartTransaction`/`fCommit`/`fRollBack`).
- Sem impacto fiscal/financeiro direto.

## 6. Critérios de aceitação
- [ ] Entrada de mercadorias com `IQFATI` = `S` e `CADIQF` vazio não gera `EVariantTypeCastError`.
- [ ] Falha no cálculo do IQF chega ao `Except` de `fConfirmaEntradaMercadorias` (mensagem via `pMensagensErro`).
- [ ] Ao falhar o cálculo do IQF, o form "Calculando IQF, aguarde..." fecha normalmente e a mensagem de erro (com o texto original) é exibida pelo `Except` do chamador.
- [ ] Tela com "Não": confirma sem exibir mensagens de validação, grava `IQFATI` = `N` e não altera `CADIQF`.
- [ ] Tela com "Sim": validações e `DELETE`/`INSERT` em `CADIQF` como antes.
- [ ] `CFG_IQFATI` nova instalação com padrão `N`.
- [ ] Mesmo resultado nas working copies `74.150.100` e `74.150`.

## 7. Fora de escopo
- Qualquer alteração em `untGravando.pas` (unit genérica usada em muitas rotinas; o efeito colateral seria difícil de mensurar).
- Alterar o valor padrão de `CFG_IPISOU` (descartado; não pertence a este requisito).
- Apagar o registro de `CADIQF` ao escolher "Não".

## 8. Dependências e riscos
- Sem registro em `CADIQF` e com `IQFATI` = `S`, o cálculo usa valores padrão (último pedido via `IQF_QTDCMP` = `1`; demais parâmetros `0`) e não reflete a configuração da empresa; o cadastro em `CADIQF` continua necessário para um IQF fiel.
- A exceção do cálculo é capturada dentro da própria rotina executada pelo `fExecuta` e relançada após o form fechar; se for necessário tratar outras exceções (fora dessa rotina), elas seguem o caminho padrão do `FormActivate`.
