# Req. 462062 — Faturador Automático: não registrar impedimento de caixa na LOGERR

## Problema

O robô de faturamento automático grava na `LOGERR` toda desistência de faturamento,
com `LOG_RELERR = 'TFaturamentoAutomaticoMonitor.pExecute'` e
`LOG_DESCRI = 'Não foi possível faturar o documento.'`.

Caixa fechado (ou caixa do dia anterior ainda em aberto) impede o faturamento **todo
fim de tarde**. Não é defeito: é operação normal. O resultado é que a `LOGERR` acumula
dezenas de registros previsíveis por dia, afogando o erro que de fato precisa ser visto.

O motivo do impedimento já é registrado em `FATAUT.FAT_LOGMSG`, que é o log próprio do
faturador — nada se perde ao parar de duplicá-lo na `LOGERR`.

## Causa

A trava de caixa é avaliada **dentro** de `TFatVendaBase.fGravaArquivos`, junto das
outras 254 saídas por `Result := False`. Quando a recusa chega ao robô, já virou
`Exception.Create(MSG_ERRO_NA_GRAVACAO)` — genérica, indistinguível de erro real — e o
robô ainda gasta as cinco retentativas antes de desistir.

As demais validações do faturador não fazem assim: `TFaturadorBase.Validar` e
`ValidarFaturamento` validam **antes** de mandar gravar e recusam por `Abort`, que
`pExecute` já distingue de exceção (`On E: EAbort Do Raise`, sem `pGravarErro`).

## Regra

**RN1** — A trava de caixa passa a ser validada antes da gravação, no
`TFaturadorBase`, recusando por `Abort` como as demais validações. Consequência: não
grava na `LOGERR` e não consome as cinco retentativas.

**RN2** — A condição de impedimento é exatamente a de hoje, sem reinterpretação:
`fCaixaJaFoiFechado` **e não** `fPermiteFaturamentoComCaixaFechado`. Esta última
encadeia três exceções — expedição à vista, entrega futura e faturador automático com
adiantamento — e por isso a composição foi extraída para um método único
(`fTravaDeCaixaImpedeFaturamento`), usado nos dois pontos. Duas cópias divergiriam.

**RN3** — A checagem dentro de `fGravaArquivos` permanece, como rede de segurança.

**RN4** — Qualquer outro motivo de desistência continua gravando na `LOGERR` como hoje.
O critério é *rotineiro vs. nunca deveria acontecer*, e não *regra de negócio vs. erro
técnico*: `MSG_ERRO_CALCULAR_TOTAL`, por exemplo, também é recusa de validação, mas
nunca deveria ocorrer — logo permanece como erro.

**RN5** — Vale para o autcom (Windows) e para o serviço Linux `FaturamentoAutomatico`.

## Alcance

`ValidarFaturamento` é compartilhado por quatro consumidores, todos automáticos —
nenhuma tela de faturamento manual passa por ele:

| Consumidor | Onde |
|---|---|
| Faturador automático | `Faturamento.Classes.TFaturamentoAutomatico.pas` |
| Autoatendimento PagueFácil | `Autoatendimento.PagueFacil.Classes.pas:857` |
| Desmembramento de pedido PIX | `untTDesmembramentoPedidoRecebidoPIX.pas:258` |
| Desmembramento por link de pagamento | `untTDesmembramentoPedidoRecebidoLinkPagamento.pas:252` |

Para os quatro o desfecho é o mesmo de hoje — quem era barrado continua barrado, porque
a condição avaliada é a mesma. O que muda é *quando*: antes de tentar gravar.

## Critérios de aceitação

1. Pedido na `FATAUT` com caixa do dia anterior em aberto → monitor executa →
   `FAT_LOGMSG` recebe a mensagem da trava e **nenhuma** linha nova entra na `LOGERR`.
2. O mesmo cenário consome **uma** tentativa, não cinco.
3. Pedido que falhe por outro motivo (ex.: item sem lote informado) → **continua**
   gravando na `LOGERR`, com `LOG_RELERR` e `LOG_DESCRI` idênticos aos de hoje.
4. Faturador automático com caixa fechado **e adiantamento > 0** → continua faturando
   (`fPermiteFaturamentoAutomaticoComCaixaFechado`). Este é o caso que uma validação
   prévia mal feita quebraria.
5. As outras duas exceções de `fPermiteFaturamentoComCaixaFechado` — expedição à vista
   (`objExpedicao`) e entrega futura (`blnEmissaoEntFutPorFatPedEntCd`) — **não são
   testáveis por este fluxo**: dependem de estado preenchido apenas pelas telas de
   expedição, e nenhuma tela passa por `TFaturadorBase`. No faturador automático as
   duas já eram sempre `False` antes desta alteração. Testar pelas telas, que não foram
   tocadas, só para confirmar ausência de regressão em `fGravaArquivos`.
6. Autoatendimento PagueFácil e desmembramento PIX/link com caixa fechado → mesmo
   desfecho de hoje (não faturam), agora recusados antes da gravação.
7. Faturamento manual pelas telas → sem alteração de comportamento.
8. Vale nos dois binários (autcom e serviço Linux).

## Versões afetadas — duas gerações de código

A correção é a mesma nas cinco versões, mas o arquivo muda conforme a geração:

| Versão | Onde mora a trava | Arquivo alterado |
|---|---|---|
| 02.30.74.150 | `TFatVendaBase` | `Faturamento.Classes.TFatVendaBase.pas` |
| 02.74.150.100 | `TFatVendaBase` | idem |
| 02.30.74.111 | `TFatVenda` | `untFuncFat.pas` |
| 02.74.111.184 | `TFatVenda` | `untFuncFat.pas` |
| 02.74.150.45 | `TFatVenda` | `untFuncFat.pas` |

Em todas, o segundo arquivo é `Faturamento.Classes.TFaturador.Base.pas`. A condição
composta (`fCaixaJaFoiFechado` **e não** `fPermiteFaturamentoComCaixaFechado`), as três
exceções, o ciclo `CarregarDocumento → ValidarFaturamento → GravarFaturamento` e o
tratamento de `EAbort` no robô são idênticos nas duas gerações — só o arquivo e a classe
diferem.

### Uma regra que NÃO é igual entre as gerações

`fPermiteFaturamentoAutomaticoComCaixaFechado` diverge, e isso muda o critério 4:

| Geração | Condição | Critério 4 vira |
|---|---|---|
| 150, 150.100 | `fltValAdt > 0.00` | caixa fechado com **qualquer** adiantamento continua faturando |
| 111, 111.184, 150.45 | `fltValAdt >= fltTotGer` | caixa fechado com adiantamento **total** continua faturando |

Nenhuma das duas foi alterada. A divergência é anterior a este requisito — registrada
aqui só para que o teste use o caso certo em cada versão.

## Fora de escopo

- `pGravarErro` de `untExecutarFaturamentoAutomatico.pas` (`pExecutarMonitor`) — é falha
  do monitor inteiro, não de um documento.
- As outras 254 saídas por `Result := False` de `fGravaArquivos`. Se alguma delas também
  se mostrar rotineira, o caminho é o mesmo: antecipar a validação, não filtrar o log.
