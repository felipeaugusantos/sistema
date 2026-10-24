# Endpoint dos Services roda no worker filho — sempre

**Regra:** todo método novo de `T<Dominio>ServiceWorker` tem de despachar para o processo filho
**e** estar registrado na tabela de despacho. As duas coisas, não uma.

```pascal
// 1. a sobrecarga TIPADA despacha
class function TPedidoServiceWorker.fXxx(const AParams: TXxxParams): TXxxResult;
begin
  Result := TApiUtils.JsonAs<TXxxResult>(
    TFaturamentoWorkersManager.fExecuteTask('TPedidoService', 'fXxx', TApiUtils.ToJson(AParams)));
end;

// 2. e o registro existe, senao o filho recusa o metodo
AddMethod('TPedidoService.fXxx', TPedidoServiceWorker.fXxx);
```

A sobrecarga de **string** é a que o filho executa — ela sim chama `TPedidoService.fXxx` direto, e
está certa assim. Quem não pode chamar direto é a **tipada**, que roda no lado do pai.

## Por que isto não é preciosismo

Chamar `TPedidoService.fXxx(AParams)` na sobrecarga tipada **compila, roda e passa em quase todo
teste**. A execução acontece no processo pai e ninguém percebe.

O sintoma só aparece com **item de tinta**: o pai tenta carregar `libAutcomTinta.so` mais a `.so` da
marca, e o processo **morre** — derrubando o serviço para todos os consumidores, não só para quem
mandou a requisição.

> Caso real, Req. 461523, 28/09/2026. O `POST /pedido/simular-emissao` passou um dia inteiro com **33
> casos de aceitação verdes** rodando no pai, cada um conferido contra pedido real do AUTCOM. Nada
> denunciava. A primeira requisição com `siglaTinta` matou o serviço. O diagnóstico custou quatro
> hipóteses erradas antes de alguém ler o log certo.

## Como reconhecer a queda

| Sinal | Onde |
|---|---|
| `RemoteDisconnected` / "connection closed without response" — **não** um 500 | cliente |
| `Carregando Precos da Tinta [...]` seguido de vários `TWorkerInfo.Destroy: kill -9 pid=...` | `logs/test.log` do pai |
| A requisição **não aparece** no log | `logs/*.dmvcframework.log` |

Os `kill -9` são a **finalização** do processo, não exceção — por isso não há erro tratado em lugar
nenhum, e por isso o buffer do log do DMVC morre antes de gravar a entrada da requisição.

## O discriminador, quando houver dúvida

Mandar o **mesmo payload de tinta** para um endpoint irmão que já esteja em produção
(`/pedido/calcular-impostos` serve). Se ele responder `200` e o serviço sobreviver, o caminho
compartilhado está bom e o problema é o despacho do endpoint novo.

Foi este teste que separou "defeito meu" de "defeito do AUTCOM" no Req. 461523 — e refutou a
suspeita, então registrada, de que os seis endpoints de produção estariam derrubando o serviço.

## Conferência

Antes de dar endpoint novo por pronto, comparar com um irmão — é mais rápido que ler esta regra:

```
grep -n "fExecuteTask(" Faturamento.Services.Workers.pas
grep -n "AddMethod('TPedidoService" Faturamento.Services.Workers.pas
```

O método novo tem de aparecer nas duas listas.

Ver também `IA/specs/461523/spec.md` §7.5.4, que tem o log da queda e a cronologia do diagnóstico.
