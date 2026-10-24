# Plano de Execução — Req. 465544

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Correções pontuais no estilo existente (Hungarian, `fCriaQuery`, `ParamByName`), sem refatoração:
1. `fGetCfgIQF` retorna `'0'` (string; `'1'` para `IQF_QTDCMP`; concatenação do `LIMIT` via `VarToStr`, pois as colunas são `int`) quando não há registro; comparação de `IQF_TIPFLT` via `VarToStr`; unit `Variants` no `uses`.
2. `fCalculaQualidadeFornecedorPrg` captura a exceção dentro do `Try/Except` (mensagem em `recDadosIQF.strErro`, campo novo em `TDadosIQF`) e retorna `False`, deixando o `FormActivate` terminar sem erro (o form fecha normalmente); `pCalculaQualidadeFornecedorLocal` verifica o retorno de `TfrmGravando.fExecuta` e levanta exceção com a mensagem original. `untGravando.pas` não é alterada.
2.1. `pCalculaQualidadeFornecedor`: `Try/Finally` ao redor da chamada, liberando `objPreNota` mesmo com a exceção levantada.
2.2. `fGetCfgIQF`: `IQF_QTDCMP` <= 0 também retorna `'1'`.
3. `btnConfirmaClick` sai antes das validações quando `rdgUtiInd.ItemIndex <> 0`, chamando `pSalvaDados`.
4. `pSalvaDados` grava `IQFATI` primeiro e só executa `DELETE`/`INSERT` em `CADIQF` quando `strValCfg = 'S'`.
5. `fSQLTMPENT`/`fSQLDISEST`/`fSQLPRECOS`: `LIMIT` do `IN (...)` encapsulado em tabela derivada (`ITQF`).
6. `fSQLTMPENT`: lado esquerdo do `IN` passa a `PCMDET.AUTOINCREM` (a coluna `DET_SEQPED` só existe em `DETPON`).
7. `CFG_IQFATI` em `untCfgRepositorio`: valor padrão `'N'` no lugar do `SELECT` com `CFG_PROCOT`.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untIndiceQualidadeFornecedor.pas | padra_atualizado/fontes/movimentacaoitens/ | alterar |
| untCfgIndDesempenhoForn.pas | padra_atualizado/fontes/configuracoes/ | alterar |
| untCfgRepositorio.pas | padra_atualizado/fontes/configuracoes/ | alterar |

Working copies: `379.48.2.30.74.150.100` (origem) e `379.48.2.30.74.150`.

## 3. Sequência de implementação
1. `untIndiceQualidadeFornecedor`: `Variants` no `uses`; `VarToStr` na linha do `IQF_TIPFLT`; `Result := '0'` em `fGetCfgIQF`; checagem do retorno de `fExecuta`.
2. `untCfgIndDesempenhoForn`: desvio no início de `btnConfirmaClick`; `DELETE`/`INSERT` condicionados a `'S'` em `pSalvaDados`.
3. `untCfgRepositorio`: valor padrão de `CFG_IQFATI` = `'N'`.
4. Aplicar o mesmo conjunto em `74.150` (via `svn patch`, validando offset/fuzz).
5. Validar encoding (decodifica em cp1252, sem U+FFFD) e `svn diff` com apenas as mudanças pretendidas.

## 4. Conformidade com padrões do projeto
- Zona Legado: Hungarian, prefixos `p`/`f`, SQL com `ParamByName()`.
- Identificadores sem número de requisito; comentários curtos no fonte (sem necessidade de "Nota N").
- Sem componentes/chamadas proibidos (`.SetFocus`, `StrToFloat`, `Now`, `TBitBtn`, etc.).
- Edição em cp1252 apenas via Python/`svn patch`; nunca pela ferramenta `Edit`.

## 5. Estratégia de testes
- Suite: teste manual (não há suite automatizada para o IQF).
- Casos a cobrir:
  - Entrada de mercadorias com `IQFATI` = `S` e `CADIQF` sem registro da empresa.
  - Falha forçada no cálculo: mensagem chega pelo `Except` do chamador.
  - Tela com "Não": confirma sem validar, `IQFATI` = `N`, `CADIQF` inalterado.
  - Tela com "Sim": validações e gravação como antes (inclusive recarga dos dados).
  - Nova instalação: `CFG_IQFATI` com padrão `N`.

## 6. Riscos e mitigação
- `LIMIT 0` sem configuração → IQF zerado → cadastrar `CADIQF` da empresa ou manter `IQFATI` = `N`.
- `untGravando.pas` é genérica e usada em muitas rotinas → não alterar; a exceção é tratada na rotina do IQF.
- `svn patch` com offset em `untCfgRepositorio` na `74.150` → conferir o `svn diff` após aplicar.
