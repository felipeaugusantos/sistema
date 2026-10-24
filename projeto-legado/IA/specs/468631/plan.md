# Req. 468631 — Plano técnico

Zona legado (`padra_atualizado\fontes`): sem infraestrutura de teste; validação manual com o
roteiro dos critérios A1–A9 da spec.

## Fluxo

```
Expedição FATAUT ──► pImprimeEtiquetaDespacho(..., out resultado)
                       └─► TfrmImpEtiDespacho.Controller.fConfirmar
                             └─► fRetornaEtiquetMarketplaceZPL(..., out resultado)
                                   └─► TEtiquetaDespachoUnificada.fGerar  (.2.bmp → não unifica)
                 ◄── resultado = reuUnificada?  não → pImprimirDANFE(..., avisar)
```

## Units

| Unit | Mudança |
|---|---|
| `genericos\untTypesSistema.pas` | Tipo `TResultadoEtiquetaUnificada`, ao lado do `VS_arrMarketplaces` |
| `MarketPlace\EtiquetaDespachoUnificada\Marketplace.EtiquetaDespachoUnificada.pas` | `fGerar` apaga `etq-unif-<chave>*.bmp` antes de gerar; `.2.bmp` → apaga e devolve o original, sem mensagem |
| `...\Marketplace.EtiquetaDespachoUnificada.IProcessador.pas` | Comentário "fallback silencioso" corrigido — a falha é avisada, e a regra vive no `fGerar` |
| `MarketPlace\untMarketPlace.pas` | `fRetornaEtiquetMarketplaceZPL` ganha `out AResultadoUnificacao` (antes de `intTimeoutSec`). Os dois blocos EDUNIF idênticos viraram o procedimento local `pUnificarSeHabilitado` |
| `relatorios\financeiro\etiquetas\untImpEtiDespachoController.pas` | Campo público `tpeResultadoUnificacao`, zerado no `Create` e no início do `fConfirmar`, passado como `out` nas 7 chamadas |
| `faturamento\untFatExpedicaoItens.pas` | `pImprimeEtiquetaDespacho` ganha `out` antes dos defaults (10 chamadas); lê o Controller antes do `pFreeAndNil`. FATAUT: etiqueta → DANFE só se não unificou. `pImprimirDANFE` ganha `AblnEtiquetaUnificadaSemDanfe` (único chamador) |
| `libNfe\untImpressaoDiretaCitel.pas` + fachada `faturamento\untLibNfe.pas` | `class function fImpressoraEhParaImprimir`, expondo o `fEhParaImprimir` existente |
| `cadastros\untCfgRel.pas` | `class function fPrintTXT: Boolean` — True só se o texto foi ao spooler ou à impressora; `pPrintTXT` vira invólucro |
| `genericos\untFuncoesSimples.pas` | `fImprimirEtiquetaZPL` / `fImprimirArquivoZPL: Boolean`; as procedures `p…` viram invólucros |

## Decisões

- **Enum em vez de Boolean.** "Unificou?" não distingue "não tentou" de "tentou e não conseguiu".
  Sem isso, R5 dispararia em toda expedição de cliente sem EDUNIF que use ponto "não imprimir" de
  propósito.
- **Enum no `untTypesSistema`, não no orquestrador.** O `untMarketPlace` e o controller da etiqueta
  compilam também no Linux (Services); o orquestrador é só Windows.
- **`out` antes dos defaults**, não overload nem campo em `FParams` (o laço da seleção múltipla
  vazaria o valor entre notas).
- **Unificada só se foi impressa (revisão do DelphAI, 09/10).** Gerar o `.unificada.txt` não é
  imprimir: fila não cadastrada, escolha cancelada ou impressora ausente saem caladas. O
  `untMarketPlace` rebaixa `reuUnificada` para `reuNaoUnificada` quando `fImprimirEtiquetaZPL`
  devolve False, e a DANFE separada sai. Foi o que o teste de 08/10 mostrou sem a gente perceber:
  "Sair" na escolha da fila e o resultado ainda dizia UNIFICADA.
- **`fPrintTXT` testa a impressora antes de selecioná-la (revisão do DelphAI, 09/10).**
  `PrinterIndex := -1` seleciona a impressora padrão, e o `if PrinterIndex < 0 then Exit` legado,
  feito depois da atribuição, nunca barrava: com a impressora da fila ausente na estação, o ZPL saía
  na padrão — e, com a etiqueta unificada, a DANFE sairia em dobro. Efeito colateral aceito: em
  estação com fila apontando para impressora inexistente, etiquetas ZPL de qualquer chamador
  (Intelipost incluído) deixam de sair "por acaso" na padrão, como o código legado já pretendia.
- **DANFE no `Finally` do bloco FATAUT (revisão do DelphAI, 09/10).** Com a etiqueta antes, uma
  exceção nela (relançada no faturamento automático) pulava a DANFE da nota autorizada.
- **Detecção pela `.2.bmp`**, não por `PreviewPages.Count`: a contagem vive em outro processo
  (NFeImpressao) e o ExitCode é ignorado; o arquivo já é produzido hoje.
- **Não coube = sem mensagem** no `fGerar`: na expedição a DANFE sai logo em seguida; na tela
  manual o operador recebe a etiqueta original.
- **Ordem etiqueta → DANFE vale para todo cliente FATAUT**, não só para quem usa EDUNIF: antes de
  imprimir a etiqueta não se sabe se ela vai trazer a DANFE.
- **Regra "não imprimir" exposta, não copiada.** `fEhParaImprimir` já tem duas cópias
  (`untDicSis` e `untImpressaoDiretaCitel`); a expedição usa a segunda pela fachada do `untLibNfe`.
  Nome diferente (`fImpressoraEhParaImprimir`) para não sombrear a função de unit dentro da classe.
- **Sem mensagens fiscais na etiqueta unificada (09/10/2026).** A VIPASA pediu para retirá-las —
  ver R1 da spec. A DANFE simplificada separada continua com elas: é o documento completo. A
  versão unificada com fiscal segue na pasta, pronta, caso a obrigatoriedade seja confirmada.

## Entrega para o cliente

Os layouts são configuração do cliente (`IMPNFE`), não release. Os bytes seguem o padrão do
original (cp1252 num XML que se declara UTF-8) — importar o arquivo, nunca regravar por editor.

| Coluna | Arquivo em uso | Situação |
|---|---|---|
| `NFE_LAYUNI` (001, 002, 003) | `IA\specs\450454\vipasa-layuni\layuni_vipasa_pedido.fr3` (MD5 `8239a4c2…`) | o de 06/10, reimportado em 09/10 |
| `NFE_LAYSIM` (001) | `laysim_vipasa_fiscal.fr3` (MD5 `9b3d663b…`) | R6, importado em 08/10 |

`laysim_vipasa_fiscal.fr3` foi gerado a partir do de produção (`laysim_vipasa_original.fr3`):

- dados adicionais num `TfrxReportSummary` esticável, só no fim — pedido e-commerce + mensagens
  fiscais; sem o rótulo do pedido, o OBS inteiro;
- "Folha N de M" no quadro do cabeçalho (o relatório já usa `DoublePass`);
- destinatário e "Itens:" num `TfrxChild` da cadeia do cabeçalho de página, que repete por folha.
  Um `TfrxHeader` com `ReprintOnNewPage` não reimprimiu na 2ª folha;
- código de barras de ~20 mm para ~10 mm de altura, mesma largura.

Não usado desde 09/10, guardado: `layuni_vipasa_fiscal.fr3` (MD5 `21311d2c…`, banda `Fiscal` com
`memFiscalOnBeforePrint`).

A 002 tem simplificado sem itens e a 003 nenhum — não faturam marketplace.
