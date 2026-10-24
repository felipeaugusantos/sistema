# Especificação — Req. 466227

**Título:** Chave duplicada na tabela MAPDET ao recontar divergências do Mapa de Inventário para Coletores
**Objetivo:** Eliminar o erro `#23000 Duplicate entry '...' for key 'PRIMARY'` (tabela MAPDET) ao executar "Recontar divergências do mapa".
**Zona:** Legado (`padra_atualizado/fontes/Util_DLL/OpeRefProd`)
**Data:** 2026-10-02

## 1. Contexto / problema atual
- Menu: ÚTIL > OPERAÇÕES REFERENTES A PRODUTOS > BALANÇO DE ESTOQUE POR AJUSTE > MAPA DE INVENTÁRIOS PARA COLETORES.
- Ao clicar em "Recontar divergências do mapa" e informar o operador, o sistema grava novas linhas de contagem em MAPDET (`TfrmMapaDeInventarioParaColetores.fGeraInventarioDivergentes`).
- O cliente (Telcabos, v. 48.2.30.74) reporta chave duplicada de forma "aleatória"; ao repetir a operação (ou fechar e reabrir o Autcom) a gravação passa.
- Causa identificada: os IDs do lote são reservados com `fRetAutoIncrem('MAPDET', VS_StrCodEmp, qryFiltroMapDet.RecordCount -1)`, mas o loop grava `RecordCount` linhas. O último ID do lote fica igual ao contador `PROINC` do MAPDET; a próxima solicitação de ID do MAPDET recebe esse mesmo ID e o INSERT viola a PK `AUTOINCREM`.
- O cliente usa `CFG_FDGINC = 'S'` (empresa 001), caminho `fRetAutoIncremFireDac`, que retorna sem validar a existência do ID (`blnForcaValidaExistencia = False`). Por isso a colisão chega ao INSERT.
- Evidência na base do cliente (leitura): os IDs das mensagens de erro (`...61883001`, `...63256001`) são o último ID de lotes anteriores contíguos (17 linhas 61867–61883 no mapa 268; 13 linhas 63244–63256 no mapa 275). Contador `PROINC` atual coerente (64397 vs. maior ID 64396). Sem triggers em MAPDET; PK única em `AUTOINCREM`.
- Todos os demais chamadores de `fRetAutoIncrem` com intervalo passam `RecordCount` (ou maior); MAPDET é o único com `-1`.
- Versão já corrigida: `74.150.45`, r451543 (danilo.stefaneli, 26/12/2025), alterou a linha para `RecordCount +1`. Versões `74.111` e `74.111.188` ainda com `-1`.

## 2. Módulos e entidades envolvidos
- Módulo: Operações referentes a produtos / Mapa de Inventário para Coletores.
- Unit: `padra_atualizado/fontes/Util_DLL/OpeRefProd/untMapaDeInventarioParaColetores.pas` (`fGeraInventarioDivergentes`, linha ~839).
- Funções de apoio (sem alteração): `fRetAutoIncrem` / `fRetAutoIncremFireDac` / `fRetAutoIncremInterno`, `pIncrementaAutoIncrem` (`genericos/untFuncoesSimples.pas`, `genericos/untProximoCodigo.pas`).
- Tabelas: `MAPDET` (PK `AUTOINCREM`, varchar(20)), `PROINC` (contador por tabela, `PRO_NOMARQ`/`PRO_AUTINC`).

## 3. Requisitos funcionais
- RF01 — A recontagem de divergências do mapa deve concluir sem exibir "Chave Duplicada na Tabela: MAPDET".
- RF02 — O comportamento funcional da recontagem (itens gerados, operador, status `N`, número da contagem) permanece inalterado.

## 4. Regras de negócio
- RN01 — O intervalo de IDs reservado para o lote deve cobrir todas as linhas inseridas, com ao menos `RecordCount` IDs.
- RN02 — O valor adotado deve ser o mesmo da correção já aplicada na `74.150.45` (`RecordCount +1`), para manter comportamento idêntico entre versões (porte, não nova implementação).
- RN03 — Reservar um ID a mais é inofensivo: gera apenas um "buraco" na sequência de `PROINC`.

## 5. Requisitos técnicos / não-funcionais
- Arquivo em cp1252 (acentos): edição somente via `.claude\scripts\fonte_delphi.py` ou Python com encoding explícito; nunca Edit/Write.
- Sem alteração em `fRetAutoIncrem` (função compartilhada por todo o sistema).
- Sem novas mensagens ao operador, sem gravação de log.
- Sem impacto fiscal/financeiro direto; afeta apenas a numeração de MAPDET.

## 6. Critérios de aceitação
- [ ] Recontar divergências de um mapa com 2 ou mais itens divergentes e, em seguida, repetir a operação (sem fechar o Autcom) não gera chave duplicada.
- [ ] Recontagem sequencial de vários mapas na mesma sessão não gera chave duplicada.
- [ ] Linhas geradas em MAPDET mantêm operador, `MPD_NUMCON`, `MPD_STATUS = 'N'` e `MPD_QTDCON = 0` como antes.
- [ ] A linha alterada nas versões afetadas é idêntica à da r451543 (`RecordCount +1`).

## 7. Fora de escopo
- Alterar `fRetAutoIncrem`/`fRetAutoIncremFireDac` (inclusive passar a validar existência do ID no caminho FireDac).
- Revisar outros pontos que inserem em MAPDET.
- Refatorar a rotina (SQL por concatenação, etc.), que é legado preexistente.

## 8. Dependências e riscos
- Dependência: porte da r451543 (`74.150.45`); definir pelo `vepeal` do 466227 quais versões recebem a correção e se alguma outra já a possui (regra de verificar todas as versões antes de alterar).
- Hipótese alternativa levantada (estado de variável/query não limpo entre operações repetidas na mesma sessão) não é sustentada pelos dados; será descartada pelo teste de repetir a operação sem fechar o Autcom.
- Risco baixo: alteração de uma linha, já validada em produção na `74.150.45`.
