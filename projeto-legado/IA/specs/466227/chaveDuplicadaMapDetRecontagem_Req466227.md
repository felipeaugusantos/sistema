# Análise de Requisito — Req. 466227

**Título:** Chave duplicada na tabela MAPDET ao recontar divergências do Mapa de Inventário para Coletores
**Solicitante:** Caio Daniel (Logística) — ticket Zendesk 1692077
**Data da análise/implementação:** 2026-10-02

## 1. Contexto de negócio

A tela **ÚTIL > OPERAÇÕES REFERENTES A PRODUTOS > BALANÇO DE ESTOQUE POR AJUSTE > MAPA DE INVENTÁRIOS PARA
COLETORES** (unit `untMapaDeInventarioParaColetores.pas`, pasta `padra_atualizado/fontes/Util_DLL/OpeRefProd`,
compilada na DLL `libOpeRefProd.dll`) gerencia o inventário feito por coletores. Cada mapa (`MAPGER`) tem
detalhes por item/localização/lote (`MAPDET`) e um número de contagem (`MPD_NUMCON`). Quando uma contagem
termina com divergência (`MPD_STATUS = 'D'`), o operador usa "Recontar divergências do mapa": o sistema
gera novas linhas em `MAPDET` com `MPD_NUMCON` = maior contagem + 1, status `N` (não iniciado), quantidade 0
e o operador de recontagem escolhido na tela "Troca Operador".

Os identificadores de `MAPDET` (campo `AUTOINCREM`, `varchar(20)`, PK única) seguem o padrão do sistema:
empresa física (3) + sequencial (14 dígitos) + código da empresa (3). O próximo sequencial vem da tabela
`PROINC` (`PRO_NOMARQ = 'MAPDET'`, campo `PRO_AUTINC`), via `fRetAutoIncrem(tabela, empresa, intervalo)`.
Quando se informa `intervalo`, a função reserva uma faixa de IDs de uma vez e devolve o primeiro.

## 2. Problema e causa raiz

### 2.1 Sintoma

Mensagem "Chave Duplicada na Tabela: MAPDET — #23000 Duplicate entry '...' for key 'PRIMARY'" ao informar o
operador de recontagem. Segundo o cliente é "aleatória": fechando e reabrindo o Autcom uma ou duas vezes a
operação passa. Pilha do madExcept: `fGeraInventarioDivergentes` (INSERT em MAPDET) chamada de
`TfrmGravando.FormActivate`, a partir de `pInsereNovaContagemInventario` e do botão da coluna do grid.

### 2.2 Causa

Em `fGeraInventarioDivergentes` a reserva de IDs era feita assim (linha 839):

```pascal
strAutIncDet := fRetAutoIncrem('MAPDET', VS_StrCodEmp, qryFiltroMapDet.RecordCount -1)
```

O loop seguinte insere **RecordCount** linhas (primeiro ID da reserva + incrementos por
`pIncrementaAutoIncrem`), mas a reserva cobria só **RecordCount − 1** IDs. Em `fRetAutoIncrem`, com
`intervalo > 1` o contador `PROINC.PRO_AUTINC` avança `intervalo`; com `intervalo <= 1` avança 1. Resultado:
após o lote, o contador aponta exatamente para o **último ID já gravado**. A próxima solicitação de ID de
`MAPDET` (próxima recontagem, ou qualquer outra rotina que grave em MAPDET) recebe esse ID e o INSERT viola
a PK.

Por que o erro chega ao INSERT: o cliente usa `CFG_FDGINC = 'S'` (empresa 001) → `fRetAutoIncremFireDac`
(`genericos/untProximoCodigo.pas`), que após o commit faz `exit` sem checar se o ID já existe
(`blnForcaValidaExistencia = False`, padrão). O caminho antigo (`fRetAutoIncremInterno`,
`CFG_FDGINC = 'N'`) repete o sorteio até achar ID inexistente e mascararia o problema (checa só o primeiro ID).

Por que parece aleatório: a tentativa que falha já avançou o contador (a reserva é commitada em conexão
própria, independente do INSERT). A tentativa seguinte recebe um ID livre e passa — sem necessidade de
fechar o Autcom. O defeito aparece sempre que há uma recontagem com 2 ou mais itens seguida de outra
solicitação de ID de MAPDET.

### 2.3 Evidências coletadas (base do cliente, somente leitura)

| Verificação | Resultado |
|---|---|
| `PROINC` MAPDET / maior ID em MAPDET | `64397` / `...64396001` — coerentes hoje |
| ID do 1º erro (`...61883001`) | último ID do lote da contagem 2 do mapa 268 (17 linhas contíguas 61867–61883) |
| ID do 2º erro (`...63256001`) | último ID do lote da contagem 3 do mapa 275 (13 linhas contíguas 63244–63256) |
| Triggers em MAPDET | nenhum |
| PK de MAPDET | somente `AUTOINCREM` |
| `CFG_FDGINC` empresa 001 | `S` (caminho FireDac, sem validação de existência) |

Padrão comprovado: nos dois casos o ID duplicado é o último do lote anterior, exatamente o que a reserva
com `RecordCount - 1` produz.

### 2.4 Comparação com outros chamadores

Todos os demais chamadores de `fRetAutoIncrem` com intervalo passam `RecordCount` (ou mais): MOVDET, ITEGER,
MSGCFO, CFOPCST, ALTEST, CADLOT, ONDSEP, LOTDOR, SELCAM, CTPDET, CONDET, PREALT, LOGCLI, LGCEST, LOGEST etc.
`MAPDET` era o único com `RecordCount -1`. Isso confirma que a função compartilhada está correta e o defeito
está na chamada.

## 3. Histórico e outras versões

- Versão `74.150.45` já corrigida pela **r451543** (danilo.stefaneli, 26/12/2025): "Correção mapa de
  inventário, quando se faz a recontagem de vários mapas, estava gerando erro de duplicidade de AUTOINCREM".
  O diff é uma única linha: `RecordCount -1` → `RecordCount +1`.
- Versões `74.111` e `74.111.188`: defeito presente (`-1`), corrigidas nesta sessão com o mesmo `+1`.
- Pela regra de não duplicar correção, adotou-se exatamente o valor da r451543 (`+1`), e não `RecordCount`
  puro, para manter o comportamento idêntico entre versões. A diferença é só um ID a mais reservado por lote.

## 4. Investigação e hipóteses

1. **Estado de variável/query não limpo entre operações repetidas** (hipótese levantada pelo usuário):
   `qryCommand` e `qryFiltroMapDet` vivem no form (criadas em `FormCreate`) e são reutilizadas. Não foi
   comprovada: `pSelecionaReplicacoes` e `pSetSQLInsertMatDet` reescrevem o SQL a cada uso, `strAutIncDet` é
   local e o ID duplicado coincide sempre com o último ID do lote anterior — padrão que só a reserva
   explica. Teste para descartar de vez: repetir "Recontar divergências" sem fechar o Autcom; pela causa
   identificada, a segunda tentativa funciona. Se continuar falhando na mesma sessão, reabrir a análise.
2. **`fRetAutoIncrem` com defeito**: descartado (todos os outros chamadores funcionam; a função reserva
   corretamente o `intervalo` recebido).
3. **Trigger ou outra chave única em MAPDET**: descartado (sem triggers; PK só em `AUTOINCREM`).
4. **Contador `PROINC` defasado**: descartado como estado atual (coerente), e como causa (o desvio é de
   exatamente 1 por lote).
5. **Duplo disparo de `TfrmGravando.FormActivate`**: lido o código (controle por `intPrimeira`); não
   explica o padrão dos IDs.

## 5. Solução aplicada

Arquivo `padra_atualizado/fontes/Util_DLL/OpeRefProd/untMapaDeInventarioParaColetores.pas`, função
`TfrmMapaDeInventarioParaColetores.fGeraInventarioDivergentes`, linha 839:

```pascal
// antes
strAutIncDet := fRetAutoIncrem('MAPDET', VS_StrCodEmp, qryFiltroMapDet.RecordCount -1)
// depois
strAutIncDet := fRetAutoIncrem('MAPDET', VS_StrCodEmp, qryFiltroMapDet.RecordCount +1)
```

Aplicada em `AUTPAS\379.48.2.30.74.111` e `AUTPAS\74.Fechadas\74.111.Fechadas\379.48.2.30.74.111.188`.
Efeito colateral aceito: um ID a mais consumido por lote (buraco inofensivo na sequência). Sem comentário
no fonte (alteração de um literal, idêntica à r451543).

## 6. Decisões de escopo

- Não se alterou `fRetAutoIncrem` / `fRetAutoIncremFireDac` (função de uso global).
- Não se alterou nenhuma outra rotina que grava em MAPDET.
- Não foram verificadas as demais versões do `vepeal` do requisito (sem acesso ao Diário nesta sessão).

## 7. Achados colaterais (não corrigidos)

- `fRetAutoIncremFireDac` não valida existência do ID (`exit` logo após o commit quando
  `blnForcaValidaExistencia = False`); qualquer reserva subdimensionada vira chave duplicada em produção,
  em vez de ser absorvida pelo laço de validação como no caminho antigo.
- `untCadConciliacaoBancaria.pas`, linha ~5395: `fRetAutoIncrem('LOGCBA', VS_strCodEmp, LItens.Count - 1)`.
  Mesmo padrão de intervalo `n - 1`; não analisado (depende de como os IDs são consumidos ali).
- A rotina monta SQL por concatenação de string (UPDATE/DELETE de `fGeraInventarioDivergentes`), legado
  preexistente, fora do escopo.

## 8. Ressalvas e lições

- Arquivo `.pas` em cp1252 com CRLF: edição feita por `.claude\scripts\fonte_delphi.py` (nunca Edit/Write).
- A pasta `__recovery` da IDE na `74.111` contém cópia do fonte com a mesma linha; é backup automático e
  não é fonte.
- Nesta sessão a correção **não foi compilada nem validada** na tela. Roteiro de validação: recontar
  divergências de um mapa com 2+ itens, repetir sem fechar o Autcom e recontar vários mapas em sequência;
  conferir em MAPDET operador, `MPD_NUMCON`, `MPD_STATUS = 'N'` e ausência de colisão.
- Consultas ao banco do cliente feitas somente leitura, com sessão em `READ ONLY` e buscas por chave.
