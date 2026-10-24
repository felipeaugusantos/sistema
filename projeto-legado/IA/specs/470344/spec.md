# Especificação — Req. 470344

**Título:** Alteração de Número de Lote — erro `Unknown column 'LGL_CODEMP'` em `LOGLLC_ARQUIV`
**Objetivo:** Impedir que a rotina de alteração de número de lote tente atualizar tabelas `LOGLLC_*`, que possuem campo `xxxxNUMLOT` mas não possuem `xxxxCODEMP`.
**Zona:** Legado
**Data:** 16/10/2026

## 1. Contexto / problema atual
Menu: Útil > Operações referentes a Produtos > Alteração de Número de Lote (`TfrmAltNumLote`, DLL `libOpeRefProd`).

Ao confirmar a alteração, é exibida a mensagem `LOGLLC_ARQUIV #42S22Unknown column 'LGL_CODEMP' in 'where clause'`. É o mesmo problema do Req. 463357.

Causa: `pRetornaFields` lista toda tabela do banco que tenha campo `xxxxNUMLOT`. Em `fGravaAltNumLote`, para tabelas fora das exceções, o SQL é montado com `AND <ABREV>CODEMP = :CODEMP`. `LOGLLC_ARQUIV` tem `LGL_NUMLOT`, mas não tem `LGL_CODEMP`, então o UPDATE falha, a transação sofre rollback e a alteração não é feita.

Cenário de simulação: empresa 003, item 11546, lote atual `LC-11546`, novo lote `LC-11546+`.

## 2. Módulos e entidades envolvidos
- Módulo: Útil / Operações referentes a Produtos
- Units:
  - `padra_atualizado/fontes/util/operacoesrefitens/untAltNumLote.pas`
  - `padra_atualizado/fontes/Util_DLL/OpeRefProd/libOpeRefProd.dpr` (sem alteração; a unit já está no projeto)
  - `padra_atualizado/fontes/Util_DLL/OpeRefProd/untOpeProd.pas` (chamador, sem alteração)
- Tabelas: `CONFIG_ALTNUMLOT` (regras; colunas `TABELA_REGRA`, `AJUSTE_SQL`, `IGNORA_TABELA`, `SEM_CADEMP`, `SEM_CODITE`, `REJEITA_TABELA`), `LOGLLC_ARQUIV` e demais `LOGLLC_*`. Chave primária de `CONFIG_ALTNUMLOT` não verificada neste levantamento.

## 3. Requisitos funcionais
- RF01 — `pRetornaTables` deve ler de `CONFIG_ALTNUMLOT` as regras com `REJEITA_TABELA = 1` e não incluir em `cdsTables` as tabelas cujo nome case com alguma `TABELA_REGRA` (máscara com `*` e `?`, via `MatchesMask`).
- RF02 — Tabelas rejeitadas não podem aparecer em `cdsFields`, e portanto não geram UPDATE.
- RF03 — Continua valendo a exclusão fixa de `TMP_*` e `LOGDOR`.
- RF04 — A alteração de lote do cenário de simulação deve concluir sem exibir mensagem de erro.

## 4. Regras de negócio
- RN01 — A regra é configurada no banco, sem recompilar. Configuração para o cliente (dado, não script de código):
  `INSERT INTO CONFIG_ALTNUMLOT (SEM_CADEMP, TABELA_REGRA, IGNORA_TABELA, AJUSTE_SQL, SEM_CODITE, REJEITA_TABELA) VALUES ('0','LOGLLC_*','0',NULL,'0','1');`
- RN02 — Regra de rejeição diferente de `IGNORA_TABELA`. Em `IGNORA_TABELA`, `fLocalteIgnoraTabela` usa `Locate` por nome exato, sem máscara, e atua em `pRetornaFields`. `REJEITA_TABELA` atua antes, em `pRetornaTables`, com máscara.
- RN03 — Máscara em branco ou `*` rejeita todas as tabelas; é responsabilidade do cadastro.
- RN04 — `MatchesMask` ignora diferença de maiúsculas/minúsculas.

## 5. Requisitos técnicos / não-funcionais
- Backport da r434316 (Req. 398922) da 74.150.45 para a 74.111 e a 74.111.191.
- Encoding: `untAltNumLote.pas` está em Windows-1252, CRLF, sem BOM. A r434316 converteu o arquivo para UTF-8 com BOM; essa conversão **não** foi trazida.
- Uma única leitura de `CONFIG_ALTNUMLOT` no carregamento (sem consulta por tabela) e `DisableControls`/`EnableControls` em `cdsTables`.
- Sem alteração de `.dproj`/`.dpr`.

## 6. Critérios de aceitação
- [x] Com a regra `LOGLLC_*` cadastrada, a alteração (empresa 003, item 11546, `LC-11546` → `LC-11546+`) conclui sem erro. (Testado manualmente pelo usuário: OK.)
- [ ] Nenhuma tabela `LOGLLC_*` aparece em `cdsTables` nem em `cdsFields`.
- [ ] As demais tabelas com `xxxxNUMLOT` continuam sendo atualizadas.
- [ ] Sem regras com `REJEITA_TABELA = 1`, o comportamento anterior é mantido.
- [ ] `untAltNumLote.pas` decodifica em cp1252, sem BOM e sem bytes `EF BF BD`.

## 7. Fora de escopo
- Script de criação/alteração da coluna `REJEITA_TABELA` (não é necessário, segundo o solicitante).
- Conversão do arquivo para UTF-8.
- Mudanças em `IGNORA_TABELA`, `SEM_CADEMP`, `SEM_CODITE` e `fGravaAltNumLote`.

## 8. Dependências e riscos
- A coluna `REJEITA_TABELA` precisa existir em `CONFIG_ALTNUMLOT` do banco do cliente; sem ela, o `SELECT` falha ao abrir a tela. Não há proteção no código.
- Sem o cadastro da regra `LOGLLC_*` no cliente, o erro persiste. O cliente do ticket (Zendesk 1711996) precisa receber o `INSERT` da RN01.
- Máscara ampla demais pode excluir tabelas que deveriam ser atualizadas.
- Versões em manutenção: o patch foi aplicado em 74.111 e 74.111.191; outras versões não foram tratadas.
