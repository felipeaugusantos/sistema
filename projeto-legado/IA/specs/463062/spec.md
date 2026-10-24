# Especificação — Req. 463062

**Título:** Baixa de pedido de compra não grava documento fiscal em PCMDET quando a entrada passa pela efetivação do movimento fiscal em duas etapas
**Objetivo:** Corrigir a perda dos dados fiscais (número, série e espécie do documento) na baixa de pedido de compra quando a entrada de mercadoria segue o fluxo de efetivação do movimento fiscal em duas etapas (`fConferenciaDepoisDaEntrada`), e reparar o pedido reportado no ticket.
**Zona:** Legado
**Data:** 2026-09-23

## 1. Contexto / problema atual

O cliente (G&B, solicitante Diego Guimarães/Compras) reportou que a entrada da NF `000000027257` baixou o pedido de compra `019000010338`, mas os campos `PCMDET.PCD_DOCEMI` (e, por confusão do relato, `PCD_DOCORI`) não foram gravados com o número da nota fiscal. O relatório de compras do cliente usa esse campo para mostrar qual documento baixou o pedido, e como ele está vazio, o relatório não traz a informação.

Investigação em produção (leitura, banco `AUTCOM`, profile ad-hoc informado pelo usuário) confirmou:

- `MOVDET` (item 38425, `DET_PEDCOM='019000010338'`): `DET_NUMDOC='000000027257'`, `DET_CODEMP='019'`, `DET_CODFOR='60000053'`, `DET_ESPDOC='NF'`, `DET_SERIE_='1'`, `DET_SEQGER='00100000001432152019'`.
- `MOVGER` (`AUTOINCREM = DET_SEQGER`): `GER_NUMDOC/GER_CODEMP/GER_CODFOR/GER_ESPDOC` idênticos aos de `MOVDET` acima.
- `GERELE`: existe registro casando `GER_DOCENT/GER_EMPENT/GER_CODFOR/GER_ESPENT` com os dados acima, `AUTOINCREM='00100000000125611019'` (mesmo valor do `PEL_SEQELE` citado no ticket).
- `PCMDET` (20 linhas do pedido `019000010338`, `PCD_CODEMP='001'`): todas com `PCD_BAIXAD=1`, mas `PCD_DOCEMI`, `PCD_SEREMI`, `PCD_ESPEMI` **vazios** (`PCD_DOCORI` é `NULL`, mas isso é esperado — ver seção 4).
- Log de auditoria `LOGREP_ARQUIV_20260912` (2026-09-11 14:50:02) mostra o UPDATE real executado contra `PCMDET`:

  ```sql
  UPDATE PCMDET SET PCD_BAIXAD = 1,
    PCD_DOCEMI = IF(IFNULL(PCD_DOCEMI,"") = "", '', PCD_DOCEMI),
    PCD_SEREMI = IF(IFNULL(PCD_SEREMI,"") = "", '', PCD_SEREMI),
    PCD_ESPEMI = IF(IFNULL(PCD_ESPEMI,"") = "", '', PCD_ESPEMI)
  WHERE PCD_NUMCTN = 0 AND PCD_NUMPED = '019000010338' AND PCD_ESPDOC = "PD"
    AND PCD_CODEMP = '001' AND PCD_QTDBAI >= PCD_QTDITE
  ```

  Os parâmetros `:NUMDOC`/`:SEREMI`/`:ESPDOC` chegaram como string vazia literal (`''`), confirmando que o dado se perde em trânsito antes de chegar ao SQL — não é ausência de dado na origem (MOVDET/MOVGER/GERELE têm os valores corretos).

**Causa raiz:** `fBaixaPedidosAtendidosDepoisDaEntrada` ([untPcmGer.pas:14983-15074](../../padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas)) é chamada por `TEfetivaMovimentoFiscal.pEfetiva` ([untEfetivaMovimentoFiscal.pas:1250](../../padra_atualizado/fontes/movimentacaoitens/untEfetivaMovimentoFiscal.pas)) quando `fConferenciaDepoisDaEntrada = True`. Internamente, ela monta `qryEntMer` (join `MOVDET`+`MOVTRI`) com os campos fiscais corretos e calcula `strAutEle` via `fCarregaAutoIncremNotaFiscal`, mas na hora de baixar o pedido chama a versão **curta** de `fBaixaPedidos` (`untPcmGer.pas:3318-3332`):

```pascal
function fBaixaPedidos(oleItensPedidos : oleVariant; cdsPedidos : TUniClientDataSet;
                       blnEntradaDeMercadorias : Boolean = True):Boolean;
  Var
    strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie, strAutEle : String;
    objEmbala: TEntEmbalagens;
Begin
  objEmbala := Nil;
  Result := fBaixaPedidosEmbalagem(oleItensPedidos, cdsPedidos, strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie, strAutEle,
                                   objEmbala, blnEntradaDeMercadorias);
End;
```

Essas variáveis locais nunca são inicializadas — chegam vazias em `fBaixaPedidosEmbalagem`, que repassa para `fBaixaPcmDet` (grava `PCD_DOCEMI`/`PCD_SEREMI`/`PCD_ESPEMI`) e `fBaixaPcmGer`. O SQL de `fBaixaPcmDet` protege contra sobrescrever valor já preenchido (`IF(IFNULL(PCD_DOCEMI,"")="", :NUMDOC, PCD_DOCEMI)`), mas como o campo já estava vazio, permanece vazio.

## 2. Módulos e entidades envolvidos

- Módulo: `movimentacaoitens` (entrada de mercadorias / pedido de compra)
- Units: `untPcmGer.pas` (alterar), `untEfetivaMovimentoFiscal.pas` (só leitura/confirmação do gate, não altera)
- Tabelas/entidades:
  - `PCMDET` (chave `AUTOINCREM`; filtro de baixa por `PCD_NUMPED`+`PCD_CODEMP`+`PCD_ESPDOC='PD'`+`PCD_NUMCTN=0`) — alvo do reparo
  - `MOVDET` (chave `AUTOINCREM`, agrupador `DET_SEQGER`) — fonte dos dados fiscais já disponíveis
  - `MOVGER` (chave `AUTOINCREM`) — confirma os mesmos dados fiscais de `MOVDET`
  - `GERELE` — resolve `strAutEle` (nota eletrônica vinculada)

## 3. Requisitos funcionais

- RF01 — Quando a baixa de pedido de compra ocorrer via `fBaixaPedidosAtendidosDepoisDaEntrada` (fluxo de efetivação do movimento fiscal em duas etapas), `PCMDET.PCD_DOCEMI`, `PCD_SEREMI` e `PCD_ESPEMI` devem ser gravados com o número, série e espécie do documento fiscal que efetivou a entrada.
- RF02 — O pedido `019000010338` (Req. 463062, NF `000000027257`) deve ter suas 20 linhas de `PCMDET` corrigidas retroativamente com os dados fiscais corretos.

## 4. Regras de negócio

- RN01 — Os dados fiscais para a baixa devem vir dos campos já carregados em `qryEntMer` (`DET_NUMDOC`, `DET_CODEMP`, `DET_CODFOR`, `DET_ESPDOC`, `DET_SERIE_`) e de `strAutEle`, sem necessidade de nova consulta ao banco.
- RN02 — O SQL de `fBaixaPcmDet` já protege contra sobrescrita de valor previamente gravado (`IF(IFNULL(...)="",...)`) — essa proteção **não deve ser alterada**.
- RN03 — `PCD_DOCORI` é um campo distinto, gravado na criação do pedido ([untPcmGer.pas:1206](../../padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas)) e representa o documento de origem do pedido (não o documento de baixa). `NULL` nesse campo é esperado quando o pedido não teve documento de origem — não faz parte deste defeito, apesar de citado no ticket.
- RN04 — O reparo retroativo deve atingir apenas as linhas de `PCMDET` do pedido `019000010338` com `PCD_BAIXAD=1` e os campos fiscais vazios — não deve sobrescrever nenhuma linha que já tenha esses campos preenchidos por outro fluxo.

## 5. Requisitos técnicos / não-funcionais

- Alteração restrita à zona Legado; manter Hungarian style e demais convenções já presentes na unit.
- Reparo de dados em produção deve seguir o protocolo de duas etapas (preview + confirmação explícita do usuário) da skill `citel-conectarBanco`, modo `--master`, com backup automático das linhas antes do UPDATE.
- Sem impacto em transação: a correção não altera a lógica de commit/rollback existente em `fBaixaPedidosAtendidosDepoisDaEntrada`.

## 6. Critérios de aceitação

- [ ] Reprocessar (ou simular) uma entrada de NF com a efetivação do movimento fiscal em duas etapas ativa e confirmar que `PCMDET.PCD_DOCEMI/PCD_SEREMI/PCD_ESPEMI` são gravados com os dados do documento fiscal.
- [ ] Confirmar, via log de auditoria (`LOGREP_ARQUIV_*`), que o UPDATE em `PCMDET` passa a receber os parâmetros com valor real (não mais `''` literal).
- [ ] As 20 linhas de `PCMDET` do pedido `019000010338` passam a ter `PCD_DOCEMI='000000027257'`, `PCD_SEREMI='1'`, `PCD_ESPEMI='NF'`.
- [ ] Nenhuma linha de `PCMDET` com esses campos já preenchidos por outro fluxo é alterada pelo reparo retroativo.

## 7. Fora de escopo

- `TRetornoFornecedor.pBaixarPedidos` ([untTGarantiaRetornoFornecedor.pas:459](../../padra_atualizado/fontes/Garantia/untTGarantiaRetornoFornecedor.pas)) — também chama a versão curta de `fBaixaPedidos`, mas `FNumDoc`/`FEspDoc` são vazios por desenho nesse fluxo (nunca atribuídos fora de `pInicializar`, que fixa `FNumDoc := EmptyStr; FEspDoc := 'GR'`). Não é o mesmo defeito — investigado e descartado.
- Reparo em massa de outros pedidos históricos com o mesmo padrão (não foi dimensionado quantos existem).
- Correção de `PCD_DOCORI` (campo com semântica diferente, não relacionado a este defeito).
- Riscos adicionais identificados na análise técnica mas não corrigidos agora (ver seção 8).

## 8. Dependências e riscos

- **Try/except externo silencioso** em `fBaixaPedidosAtendidosDepoisDaEntrada` — engole qualquer erro e retorna `Result := False`, sem log. Não será alterado neste requisito, mas dificulta diagnosticar falhas futuras na mesma rotina.
- **Vazamento potencial de `qryConsulta`** — é criada antes do bloco `try/finally` externo; se `fCfgSis('CNVEMB')` lançar exceção antes da criação, não há vazamento (a variável só existe após a criação), mas o padrão é frágil a mudanças futuras na função.
- **`fCarregaAutoIncremNotaFiscal` sem `Result := ''` explícito** no caminho de `Exit` quando `GERELE` não tem registro — contrato implícito, funciona hoje pois Delphi inicializa `String` como vazio, mas não é explícito.
- Dependência de `fDefinePedidosABaixar` (não alterada) — mudanças futuras nela podem impactar esta correção.
