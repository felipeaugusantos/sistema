# Geração de DETLOC / LOTLOC na entrada de mercadorias

> Como o sistema decide, numa **entrada normal** de mercadoria com `CFG_UM1LFL = 'S'`
> (múltiplas localizações físicas por lote), se a linha de `DETLOC` é gravada de imediato
> ou não. Documentado a partir da investigação do Req. 460755 — a pergunta original era
> se o lote `'A DEFINIR'` gera `DETLOC` na hora da entrada ou só um pedido de reserva.

## Resposta curta

**Não gera.** Numa entrada normal (fora do fluxo de garantia/recebimento de cliente), a
efetivação da entrada só atualiza o **saldo agregado** em `LOTLOC` no bucket
`'A DEFINIR'`, e dispara um **pedido de reserva de estoque** para o endereçamento físico
posterior. A linha de `DETLOC` (que vincula a localização a um `MOVDET.AUTOINCREM`
específico via `DTL_INCDET`) só é gravada mais adiante, quando a localização física real
é confirmada — nunca com lote `'A DEFINIR'`.

Consequência prática (relevante para quem lê `AConsiderarDETLOC` em
`untEntSelItensDevolucao.pas`): **um item recém-entrado, com `UM1LFL='S'`, pode não ter
`DETLOC` ainda** — não é só um problema de documento anterior à ativação da config. A
correção correlata (`LEFT JOIN` + fallback) está registrada no Req. 460755.

## Os dois métodos de `TDetLoc` e o que cada um faz

`padra_atualizado/fontes/faturamento/untDetLoc.pas` — encoding **latin-1 + CRLF**.

| Método | O que grava | Quando |
|--------|-------------|--------|
| `pAtualizaEstoqueLocalizacao(AEntSai, ACodIte, ACodEmp, ANumLot, ALocFis, AQtdIte)` | Só o **saldo agregado** por (item, lote, localização) — não vincula a nenhum documento específico | Toda entrada/saída de estoque com `fUsaMaisDeUmaLocalizacaoFisicaPorLote`, inclusive para o bucket `'A DEFINIR'` |
| `fGravarDetLoc(AIncDet, ACodIte, ACodEmp, ANumLot, ALocFis, ALocSep, AQtdIte)` | A linha de `DETLOC` propriamente dita, vinculada ao `MOVDET.AUTOINCREM` (`AIncDet` → `DTL_INCDET`) | Só quando a localização já é definitiva — nunca com `ALocFis = 'A DEFINIR'` |

Ambos existem porque o agregado (`LOTLOC`) precisa refletir o saldo em tempo real mesmo
antes do endereçamento físico acontecer; o vínculo por documento (`DETLOC`) só faz sentido
quando há uma localização real para apontar.

## O caminho de uma entrada normal (`untPcmGer.pas`)

Bloco de atualização de estoque na efetivação da entrada
(`untPcmGer.pas:7379-7409`, dentro do trecho geral que roda para qualquer entrada, não só
devolução):

```pascal
If (Result and (Not fEmptyStr(strNumLot)) And fUsaMaisDeUmaLocalizacaoFisicaPorLote) Then
Begin
  strLocFis := 'A DEFINIR';
  if blnRecCliGarantia And (strNumLot <> 'A DEFINIR') then
  begin
    strLocFis := TCadLot.fLocalizacaoFisicaLoteC(...);
    if fEmptyStr(strLocFis) then strLocFis := 'GARANTIA';
  end;

  TDetLoc.pAtualizaEstoqueLocalizacao('E', ITE, EMP, NUMLOT, LOCFIS, QTD);  // sempre roda

  if blnRecCliGarantia And (strNumLot <> 'A DEFINIR') then
    TDetLoc.fGravarDetLoc(strAutIncTmp, ITE, EMP, NUMLOT, LOCFIS, '', QTD);  // só aqui
End;
```

- `pAtualizaEstoqueLocalizacao` **sempre** roda quando há `UM1LFL='S'` + `NUMLOT`
  preenchido — inclusive com `strLocFis = 'A DEFINIR'`, que é o caso comum de entrada.
- `fGravarDetLoc` só roda dentro de `blnRecCliGarantia` (recebimento de cliente/garantia)
  **e** com lote já definido (`<> 'A DEFINIR'`). Numa entrada normal essa condição nunca é
  satisfeita — a chamada não é sequer alcançada.

## O que acontece depois: pedido de reserva, não DETLOC

`untEnderecamentoProduto.pas` é quem processa o endereçamento após a entrada. Quando ainda
não há localização definida, ele só move o saldo agregado entre os dois lados do bucket
`'A DEFINIR'` e gera um pedido:

```pascal
if LEhMaisDeUmaLocFisPorLote then
begin
  TDetLoc.pAtualizaEstoqueLocalizacao('S', CODITE, EMP, NUMLOT, LOCFIS, QTDEND);
  TDetLoc.pAtualizaEstoqueLocalizacao('E', CODITE, EMP, NUMLOT, 'A DEFINIR', QTDEND);
end;
...
If objEnderecamento.fQtdItens > 0 Then
  Result := objEnderecamento.fGerarPedidoParaReservarEstoque;
```

`fGerarPedidoParaReservarEstoque` (`untEnderecamentoProduto.pas:1487`) monta um documento
com mensagem do tipo `'PEDIDO DE RESERVA DE ESTOQUE PARA ENTRADA REF. AO FULFILLMENT...'`
— um pedido de trabalho para o armazém alocar fisicamente o produto. Não grava `DETLOC`.

## Onde `DETLOC` é finalmente gravado

`fGravarDetLoc` é chamado, sempre com localização já concreta (nunca `'A DEFINIR'`), em:

| Unit | Fluxo |
|------|-------|
| `untTransferenciaArmazens.pas` | Transferência entre localizações — é aqui que o saldo sai do bucket `'A DEFINIR'` para uma localização real, tipicamente quando o operador do WMS confirma o endereçamento |
| `untAjusteEstoque.pas` / `untAjusteEstoqueGarantia.pas` | Ajuste de estoque |
| `untOrdPro.pas` | Apontamento de ordem de produção |
| `untGerenciaPerdaEntrada.pas` | Ajuste de perda na entrada |
| `untPcmGer.pas` | Só no ramo `blnRecCliGarantia` com lote definido (ver acima) |

Do lado da venda (saída), a geração de `DETLOC` é feita por
`TDetLoc.pGerarDETLOC`/`pGerarDETLOC_LocacaoEquipamentos`, chamadas a partir de
`Faturamento.Classes.TFatVendaBase.pas` — fluxo de separação/expedição, fora do escopo
desta nota (que é sobre entrada).

## O caso do lote vazio na digitação (`TfrmEntMercadorias.pAdicionaItem`)

Quando quem chama `pAdicionaItem` passa `strNumLot = ''` (ex.: devolução de item cujo
`MOVDET.DET_NUMLOT` original é `NULL` — caso do Req. 460755), o código cai em:

```pascal
If fEmptyStr(strNumLot) Then
  ParamByName('LOCFIS').AsString := qryConIte.FieldByName('ITE_LOCFIS').AsString
```

Isto é, `LOCFIS` recebe a localização física **padrão do cadastro do item** (`ITEGER.ITE_LOCFIS`).
Rastreado até o fim, esse valor **não é usado**:

1. `LOCFIS` só é gravado em `TMP_ENTMER.ENT_LOCFIS` (tabela temporária de digitação —
   DDL em `untFuncoes.pas:3045`). **`MOVDET` não tem coluna `DET_LOCFIS`.**
2. O `NUMLOT` vazio não fica vazio até o fim: uma rotina posterior em
   `untEntMercadorias.pas` (~10270-10440), que roda **depois** de todos os itens
   digitados, filtra `TMP_ENTMER` por `ENT_NUMLOT IS NULL OR ''` e, com
   `fUsaMaisDeUmaLocalizacaoFisicaPorLote` ativo e o item tendo lote `'A DEFINIR'`
   cadastrado, substitui por `ENT_NUMLOT := 'A DEFINIR'`.
3. Na efetivação (`untPcmGer.pas`), `ENT_LOCFIS` **nunca é lido** — `strLocFis` é
   atribuída direto à constante `'A DEFINIR'` (ver bloco citado acima). O valor que
   `pAdicionaItem` calculou fica órfão em `TMP_ENTMER`, sem efeito no que é gravado.

**Conclusão:** para entrada normal com `UM1LFL='S'` e lote não informado na digitação, o
resultado final é sempre lote `'A DEFINIR'` + localização `'A DEFINIR'` (bucket agregado em
`LOTLOC`) + pedido de reserva — nunca a localização-padrão do item (`ITE_LOCFIS`), mesmo
que ela tenha sido calculada e gravada no staging.

## Pontos de atenção

- Não presumir que "config `UM1LFL` ativa" implica "todo item tem `DETLOC`". A ausência é
  esperada tanto para documentos anteriores à ativação da config quanto para itens
  recém-entrados ainda não endereçados fisicamente.
- Qualquer rotina que faça `INNER JOIN DETLOC` a partir de um `MOVDET` de entrada corre o
  mesmo risco que motivou o Req. 460755 — considerar `LEFT JOIN` + fallback.

## Alterações documentadas

| Data | Requisito | O que motivou |
|------|-----------|----------------|
| 2026-09-10 | Req. 460755 | Investigação de por que a devolução de uma NF antiga não encontrava itens disponíveis — levou a mapear todo o ciclo de vida de `DETLOC`/`LOTLOC` na entrada |
