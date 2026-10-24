# untConstantes

> Unit genérica compartilhada. Documenta apenas o que já foi tocado por alguma rotina.

## Responsabilidade

Constantes globais do ERP desktop — nomes de travas, de tabelas auxiliares e demais literais
compartilhados.

## Caminho

`padra_atualizado/fontes/genericos/untConstantes.pas`

## Rotinas que consomem

| Rotina | O que usa daqui |
|--------|-----------------|
| [balanço de estoque](balanco_de_estoque/balanco_de_estoque.md) | `STR_TRAVA_CONDET` — trava global que serializa a gravação do balanço em toda a base |

## Constantes (recorte tocado)

| Constante | Papel |
|-----------|-------|
| `STR_TRAVA_CONDET` | Nome da trava usada por `fLock_Unlock`. Enquanto uma estação a detém, as outras recebem "Uma tarefa de balanço está sendo feita em outra estação" |
| ~~`TMP_ITEGER_CONTAGEM`~~ | **Removida.** Era o nome da temporária de contagem de item |
| ~~`TMP_CADLOT_CONTAGEM`~~ | **Removida.** Era o nome da temporária de contagem de lote |

## Pontos de atenção

As duas temporárias foram removidas porque o único leitor delas gerava **DML replicada citando
tabela temporária** — comandos que falhavam na réplica (280 por rodada de balanço). Não
reintroduzir: comando replicado não pode citar tabela temporária.

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-08-20 | Req. 456948-B (Parte B) — alterações locais | Removidas `TMP_ITEGER_CONTAGEM` e `TMP_CADLOT_CONTAGEM`, com o motivo registrado em comentário no lugar |
