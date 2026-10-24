# Especificação — Req. 463151

**Título:** Replicação de preço em lote pula itens (frete e outros campos)
**Objetivo:** Corrigir a rotina de replicação de valor para todos os itens da Ativação de Lote de Preços, que deixava itens sem receber o valor replicado (ex.: frete), sem qualquer aviso ou erro.
**Zona:** Legado (`padra_atualizado/fontes/movimentacaoitens/`)
**Data:** 22/09/2026

## 1. Contexto / problema atual

Na tela de Ativação de Lote de Preços, ao alterar o valor de um campo (ex.: frete) em um item e marcar "replicar para todos os itens", a rotina `TLotePrecos.pReplicaPrecoParaItens` percorre o dataset de itens do lote (`Dataset`) chamando `TLotePrecos.pAlterarPrecoMargem` para cada um, usando `Dataset.First` / `While not Dataset.Eof do ... Dataset.Next`.

O cliente relatou (via Zendesk 1655410, mesmo atendimento do Req. 461662) que, ao alterar o frete de um item e replicar para os demais, parte dos itens do documento não recebia o valor — sem nenhuma mensagem de erro. Inicialmente suspeitou-se de reordenação manual do grid pelo usuário, hipótese descartada em teste ao vivo: o grid já abria ordenado por "% Difer. Custo" e o usuário não alterou a ordenação durante o teste.

Diagnóstico com log temporário (removido ao final, nunca commitado) confirmado por teste ao vivo em documento com 30 itens: o laço processava a chamada de `pAlterarPrecoMargem` corretamente para o primeiro item, mas o `RecNo` do `Dataset` saltava sozinho de uma posição baixa (ex.: 1) para uma posição bem mais alta (ex.: 28) **durante** a própria chamada — antes do `Dataset.Next` seguinte ser executado. Como resultado, o `Next` continuava a partir da nova posição, pulando todos os itens que ficaram "para trás" na nova ordenação, e o laço terminava prematuramente (`Eof`) tendo processado só uma fração dos itens (ex.: 3 de 30).

Causa raiz identificada via `svn log`/`svn diff` das últimas revisões do arquivo: a revisão r494484 (Req. 461662, "trava e fecha sozinho ao ativar lote de preços") adicionou, dentro do mesmo laço, uma chamada a `Application.ProcessMessages` logo antes do `Dataset.Next`, para evitar que o Windows marcasse a tela como "não responde" em lotes grandes. Esse `ProcessMessages` libera a fila de mensagens do Windows no meio do laço, permitindo que a grade de itens (indexada/ordenada por uma coluna calculada a partir do próprio valor recém-alterado, como "% Difer. Custo") se reordene *ali mesmo*, movendo o registro do item recém-processado para outra posição. O `Dataset.Next` seguinte, por navegar por posição relativa, então pula os itens que ficaram entre a posição antiga e a nova.

Antes da r494484 esse `ProcessMessages` não existia nesse laço específico, então a grade nunca tinha chance de se reordenar no meio da iteração — por isso o problema de pulos de item só passou a se manifestar a partir dessa revisão, mesmo a fragilidade de fundo (navegação por `Next` num dataset que pode reordenar) já existindo antes.

Reverter a r494484 não é opção: ela corrige um travamento real ("tela não responde") relatado pelo mesmo cliente. A correção deste requisito precisa manter o `Application.ProcessMessages` e, ao mesmo tempo, tornar o laço imune à reordenação.

## 2. Módulos e entidades envolvidos

- Módulo: Movimentação de Itens — Ativação de Lote de Preços
- Units: `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas` (classe `TLotePrecos`)
- Procedures envolvidas: `TLotePrecos.pReplicaPrecoParaItens`, `TLotePrecos.pAlterarPrecoMargem`, `TLotePrecos.fReplicaPrecoParaItensPrg`
- Tabela: `LOTPRE` (lote de preços por item/documento; campos pares `_ANT`/atual/`_ALT` por campo de preço, ex. `LTP_FREENT`/`LTP_FREENT_ANT`/`LTP_FREENT_ALT`)
- Chave funcional usada para navegação estável: `ITE_CODITE` (código do item), presente no `Dataset` de itens do lote

## 3. Requisitos funcionais

- RF01 — Ao marcar "replicar para todos os itens" e alterar um campo de preço/margem/frete em um item, **todos** os itens elegíveis do lote (respeitando o filtro de grupo de preço, `strGrupoPrecoReplica`, quando aplicável) devem receber o valor replicado, independentemente de o próprio recálculo desse campo reordenar o dataset de itens durante o processamento.
- RF02 — A responsividade da tela durante a replicação em lotes grandes (corrigida no Req. 461662/460063 via `TfrmGravando` + `Application.ProcessMessages`) deve ser preservada — a correção deste requisito não pode reintroduzir o travamento/"tela não responde".

## 4. Regras de negócio

- RN01 — A navegação pelo dataset de itens durante a replicação deve ser feita por identificação estável do item (chave `ITE_CODITE`), não por posição relativa (`Next`), já que a posição de um registro pode mudar como efeito colateral do próprio processamento do item anterior.
- RN02 — A lista de itens a processar deve ser determinada **antes** de qualquer alteração ser aplicada ao lote (uma "foto" do estado inicial), para que a ordem/composição original do lote não seja afetada por reordenações disparadas durante o próprio processamento.
- RN03 — Se, ao tentar reposicionar em um item da lista (por `Locate`), o item não for mais localizado (ex.: removido/filtrado durante o processamento), esse item é simplesmente pulado, sem interromper o processamento dos demais.
- RN04 — O filtro por grupo de preço (`strGrupoPrecoReplica`/`ITE_CODGPR`), quando ativo, continua sendo aplicado por item, sem alteração de comportamento.

## 5. Requisitos técnicos / não-funcionais

- Sem alteração de schema, sem impacto em SQL/transação.
- Sem impacto de performance perceptível: `Locate` por chave sobre o mesmo dataset em memória tem custo equivalente ao `Next` para a ordem de grandeza de itens desses lotes (dezenas a poucas centenas de itens), já demonstrado nos testes reais.
- Encoding do arquivo (`cp1252`/CRLF) preservado — toda edição feita via script Python com encoding explícito, nunca pela ferramenta de edição de texto genérica.

## 6. Critérios de aceitação

- [x] Alterar o frete de um item e marcar "replicar para todos os itens" resulta em **todos** os itens do documento recebendo o valor (validado em documento real com 30 itens).
- [x] Alterar o preço de venda/margem (PREVE/MARBR) e replicar continua funcionando para todos os itens, sem regressão (validado no mesmo teste).
- [x] Nenhum travamento/"tela não responde" reintroduzido durante o teste com lote de 30 itens.
- [x] Arquivo `untLotePrecos.pas` permanece íntegro em cp1252/CRLF após a alteração (validado por checagem de bytes).

## 7. Fora de escopo

- Revisão ou otimização do mecanismo de reordenação/índice da grade de itens (a própria causa de a grade reordenar ao vivo durante o recálculo não foi alterada, apenas contornada).
- Qualquer alteração em `Application.ProcessMessages`/`TfrmGravando` (mecanismo de responsividade do Req. 461662/460063), que permanece intacto.
- Revisão de outros laços do sistema que também usem `Dataset.Next` sobre datasets potencialmente reordenáveis (fora do escopo deste requisito).

## 8. Dependências e riscos

- Dependência: comportamento introduzido pelo Req. 461662 (`Application.ProcessMessages` dentro do laço) — a correção deste requisito é complementar a ele, não o substitui.
- Risco residual: se, no futuro, o dataset de itens deixar de expor o campo `ITE_CODITE` (renomeação/reestruturação), o `Locate` passaria a falhar silenciosamente para todos os itens (RN03) — mitigado pelo fato de `ITE_CODITE` já ser usado como chave funcional em vários outros pontos da mesma unit.
