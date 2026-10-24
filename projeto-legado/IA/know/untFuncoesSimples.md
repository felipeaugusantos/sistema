# untFuncoesSimples

> Unit genérica compartilhada. Este documento cresce por acúmulo — cada requisito acrescenta
> **apenas** o que tocou. A unit tem mais de 20 mil linhas e **não** deve ser mapeada por inteiro.

## Responsabilidade

Biblioteca central de funções do ERP desktop: transação global, autoincremento, sequenciais,
configurações (`CFGSIS`), replicação e as globais `VS_*` compartilhadas por todo o sistema.

## Caminho

`padra_atualizado/fontes/genericos/untFuncoesSimples.pas`

Encoding: **UTF-8 com BOM** (diferente da maioria das units legadas, que são latin-1).

## Rotinas que consomem

| Rotina | O que usa daqui |
|--------|-----------------|
| [balanço de estoque](balanco_de_estoque/balanco_de_estoque.md) | `fStartTransaction`/`fCommit`/`fRollBack`, `fRetAutoIncrem`, `fRetSequencial`, `fCfgSis`, `fLock_Unlock`, `fGetIDTransacao`, lote de saldos (`VS_objBatchSaldos`), cache do `@VS_ID_TRANSACAO` |
| [GNRE - Entrada](gnre_entrada/gnre_entrada.md) | `fStartTransaction`/`fCommit`/`fRollBack` (gravação das guias após a entrada, em `TListGNRE.fGravaGnreInterna`), `fRetAutoIncrem` (`CADGNR`/`GNRTCI`/`GNR_TS`, `FISAJD`, `CADPAG`), `fCfgSis`, `fStrToFloat` |

## Globais relevantes

| Global | Tipo | Papel |
|--------|------|-------|
| `VS_objBatchSaldos` | `TBatchSQL` | Lote dos `UPDATE` de saldo. `Nil` = desarmado, e o caminho antigo (execução imediata) vale |
| `VS_objConexaoIDTran` | `TUniConnection` | Conexão que armou o cache do `@VS_ID_TRANSACAO`. `Nil` = desarmado |
| `VS_intIDTransacaoCache` | `UInt64` | Valor do ID de transação em cache. `0` = desarmado |
| `VS_blnNotificaSaldoAbaixMinimo` | Boolean | Liga a notificação de saldo mínimo; o balanço a guarda e restaura para adiar a notificação |
| `VS_ConnectionID` | String | `CONNECTION_ID()` da sessão, lido uma vez. Só é preenchido quando `LOGREP` tem a coluna `LOG_CON_ID` |

## Métodos usados pelo balanço de estoque

### Lote de saldos

| Método | Tipo | O que faz | Efeito colateral |
|--------|------|-----------|------------------|
| `pLigaBatchSaldos` | procedure | Cria `VS_objBatchSaldos` (`BatchSize = 500`) com query própria. Libera a instância anterior se houver | A partir daí os `UPDATE` de saldo passam a acumular |
| `fUsouBatchSaldosSQL` | function | Se o lote está armado, acumula o SQL e devolve `True`; desarmado, devolve `False` e o chamador executa como antes | Acumula comando |
| `pDescarregaBatchSaldosSeCheio` | procedure | Executa e limpa o lote quando `CommandCount` atinge o limite informado | Vai ao banco |
| `pDescarregaBatchSaldos` | procedure | Executa o lote | Vai ao banco |
| `pDescarregaEDesligaBatchSaldos` | procedure | Executa o que houver e libera a instância | Vai ao banco e desarma |
| `pDesligaBatchSaldos` | procedure | Limpa e libera **sem** executar — caminho de erro | Descarta o acumulado |

**Regra de ordem:** o flush tem que acontecer **antes** de qualquer leitura de saldo que dependa do
valor novo. No balanço, o leitor crítico é a auditoria (`F_AUDITORIA_GRAVACAO_SALDO`).

### Cache do `@VS_ID_TRANSACAO`

| Método | Tipo | O que faz |
|--------|------|-----------|
| `pLigaCacheIDTransacao` | procedure | Lê `SELECT @VS_ID_TRANSACAO` uma vez e arma `VS_objConexaoIDTran` + `VS_intIDTransacaoCache`. Engole exceção: falhando, fica desarmado |
| `pDesligaCacheIDTransacao` | procedure | Zera as duas globais |
| `fGetIDTransacao` | function | Ganhou um `If` no topo: devolve o cache **somente** se a conexão for a mesma que armou, o valor for > 0 e a transação estiver aberta (`fInTransaction`). Fora disso, o corpo original roda inalterado |

**Por que as três condições:** o projeto cria conexão dinamicamente em vários pontos e um endereço
liberado pode ser reaproveitado. Exigir transação aberta garante que a entrada usada é a da mesma
transação que a gravou.

**Regra:** quem arma, desarma — inclusive nos caminhos de exceção (`Finally`). Cache armado fora da
janela pretendida faz o `LOG_IDTRAN` da replicação agrupar errado **em silêncio**.

### Outros

| Método | Tipo | Observação |
|--------|------|------------|
| `fRetSequencial` | function | Ganhou `AintQuantidade: Integer = 1`. Com o default, comportamento byte a byte igual ao anterior. Com N > 1, reserva um bloco de N números numa chamada — tira a linha `CFG_PRO_*` de `CFGSIS` do `FOR UPDATE` prolongado |
| `fRetAutoIncrem` | function | Reserva bloco de autoincremento em `PROINC` (`PRO_AUTINC = PRO_AUTINC + N`) num único comando. `PROINC` **não replica** |
| `fCfgSis` / `fCfgSisL` / `fAtuCfgSis` | function/procedure | Leitura e gravação de `CFGSIS` |
| `fMascaraSaldoBalanco` | function | Máscara de exibição de saldo do balanço (veio do trunk) |
| `fLock_Unlock` / `fGetHostLock` | function | Trava nomeada global e host que a detém |
| `fStartTransaction` / `fCommit` / `fRollBack` | — | Controle da transação global. O `fCommit` descarrega `objBatchReprocessarSaldo`; o `fRollBack` o descarta |

## Pontos de atenção

- Toda global `VS_*` armada por uma rotina tem que ser desarmada por ela, em `Finally`. O escopo é
  o processo inteiro.
- Encoding UTF-8 com BOM: editar esta unit com o mesmo cuidado das latin-1, mas com a codificação
  certa — misturar as duas corrompe acentuação silenciosamente.
- `fStrToFloat`/`fStrToFloatDef` e `fNow()` moram aqui e são os substitutos obrigatórios de
  `StrToFloat`/`Now` (trava do pre-commit SVN).

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-08-20 | Req. 456948 (Parte A) — alterações locais | Cache do `@VS_ID_TRANSACAO`: globais `VS_objConexaoIDTran`/`VS_intIDTransacaoCache`, `pLigaCacheIDTransacao`, `pDesligaCacheIDTransacao` e a guarda no topo de `fGetIDTransacao`. Lote de saldos: `VS_objBatchSaldos`, `pLigaBatchSaldos`, `pDescarregaBatchSaldos`, `pDescarregaBatchSaldosSeCheio`, `pDescarregaEDesligaBatchSaldos`, `pDesligaBatchSaldos`, `fUsouBatchSaldosSQL`. `fMascaraSaldoBalanco` vinda do trunk |
| 2026-08-20 | Req. 456948-B (Parte B) — alterações locais | `fRetSequencial` ganhou `AintQuantidade: Integer = 1` para reservar bloco de sequenciais numa chamada |
| 2026-10-16 | GNRE - Entrada — mapeamento, base r500183 | Sem alteração nesta unit; registrada a rotina GNRE - Entrada como consumidora |
