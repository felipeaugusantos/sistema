# untICadLote

> Unit genérica compartilhada. Documenta apenas o que já foi tocado por alguma rotina.

## Responsabilidade

Interface de `TCadLot` — contrato consumido por cadastros, genericos e relatorios. Toda mudança de
assinatura em [untCadLote.md](untCadLote.md) tem que ser espelhada aqui, ou a unit não compila.

## Caminho

`padra_atualizado/fontes/cadastros/untICadLote.pas`

## Rotinas que consomem

| Rotina | O que usa daqui |
|--------|-----------------|
| [balanço de estoque](balanco_de_estoque/balanco_de_estoque.md) | Declaração de `fZeraContagemLote` e `fZeraContagemLoteRodada` |

## Métodos declarados (recorte tocado)

| Método | Assinatura atual |
|--------|------------------|
| `fZeraContagemLote` (overload) | `(strArmazens: string; strCodIte: String; blnLimpar: Boolean = True; strFilExt: string = ''; event_Parametros: TSetaParametros = nil; AblnAtualizaIteger: Boolean = True): Boolean` |
| `fZeraContagemLoteRodada` | `(const AstrConId, AstrCodCon: String): Boolean` |

## Pontos de atenção

Este arquivo é só contrato — nenhuma lógica. Alterar aqui sem alterar `untCadLote.pas` (ou o
contrário) quebra a compilação de todos os consumidores da interface, não só do balanço.

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-08-20 | Req. 456948-B (Parte B) — alterações locais | `fZeraContagemLote` perdeu `blnTableTmp` e ganhou `AblnAtualizaIteger`; declarada `fZeraContagemLoteRodada` |
