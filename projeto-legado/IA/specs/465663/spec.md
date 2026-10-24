# Especificação — Req. 465663

**Título:** Devolução com documento de origem em NOTGER (documento de confirmação)
**Objetivo:** Fazer `TRecTransfEstoqueDevolucao.fExecutar` reconhecer devoluções cujo documento de origem está na NOTGER, guardar de qual tabela veio a nota de venda e usar essa informação para carregar o cliente consumidor da tabela correta.
**Zona:** Legado
**Data:** 2026-09-29

## 1. Contexto / problema atual

Na entrada de devolução em `untRecTransfEstoque.pas`, `pPreparaFlagsDevolucao` usa `TRecTransfEstoqueDevolucao.fExecutar` para descobrir se a nota é uma devolução e qual a nota de venda de origem (`GER_SAIDA_`).

Hoje `fExecutar` consulta apenas a MOVGER. Quando o documento devolvido é um documento de confirmação, a origem está na NOTGER e a consulta retorna vazio:

- `FDevolucao` fica `False` (a nota não é reconhecida como devolução);
- `FAutIncVenda`, `FEmpDev`, `FDocDev` e `FEspDev` ficam vazios;
- o cliente consumidor da venda original não é carregado.

Além disso, o `fCarregaClienteConsumidor(AAutInc)` busca sempre na MOVGER. O AUTOINCREM da NOTGER pode coincidir com o de outro documento da MOVGER.

**Evidência (banco AUTCOM, leitura, 2026-09-29)** — documento `MOVDET.DET_NUMDOC = '000000004374'`, `DET_DTADOC = '2026-01-16'`, `DET_SEQGER = 00100000001324782100`, CFOP 5411, origem NF 000000377763:

| Consulta | Resultado |
|---|---|
| Ramo atual (MOVGER) | vazio |
| Ramo novo (NOTGER) | `GER_SAIDA_ = 00100000000005845001`, NF 000000377763, espécie NF |
| AUTOINCREM `00100000000005845001` na MOVGER | outro documento: NF 000000004848, espécie FF, cliente "DR AUTO CENTER PECAS PARA VEICULOS EIREL" |
| AUTOINCREM `00100000000005845001` na NOTGER | o documento correto: NF 000000377763, cliente "SGS COMERCIO DE PECAS LTDA" |

Sem indicar a tabela, o `fCarregaClienteConsumidor` traria o consumidor errado, sem erro.

## 2. Módulos e entidades envolvidos

- Módulo: movimentação de itens (recebimento de transferência de estoque / entrada de devolução).
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoqueDevolucao.pas`
  - `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas`
- Consumidor indireto (sem alteração de código): `untEfetivaMovimentoFiscal.pas` usa `fEntradaDevolucao`.
- Tabelas: `MOVGER`, `NOTGER`, `MOVDET`, `CADEMP`. Chave: `AUTOINCREM` (MOVGER/NOTGER); `DET_SEQGER` liga a MOVDET à MOVGER.

## 3. Requisitos funcionais

- RF01 — `fExecutar` deve incluir um terceiro SELECT, ligado por `UNION ALL`, que localiza a nota de venda na NOTGER quando o documento devolvido é de confirmação.
- RF02 — Os três SELECTs devem retornar a coluna `ORIGEM_DOC`, fixa: `'MOVGER'` nos dois primeiros e `'NOTGER'` no terceiro.
- RF03 — `TRecTransfEstoqueDevolucao` deve guardar `ORIGEM_DOC` em um campo privado e expô-lo por método fluent com parâmetro `out`, no mesmo padrão de `fAutoincrementoVenda`.
- RF04 — `TfrmRecTransfEstoque` deve ter um campo para receber esse valor, resetado em `pPreparaFlagsDevolucao` e preenchido na cadeia fluent.
- RF05 — `fCarregaClienteConsumidor` deve receber o parâmetro `ATabelaOrigemDocDev` e consultar a NOTGER quando ele for `'NOTGER'`, ou a MOVGER nos demais casos.
- RF06 — A chamada em `fGravaMovGer` (bloco `With cdsConsulta, recTotais`) deve passar o valor guardado.

## 4. Regras de negócio

- RN01 — O terceiro SELECT segue a mesma lógica do primeiro, trocando `MOVGER` por `NOTGER` em `NFEENT` e `NFESAI`. `NFEDEV` continua na MOVGER.
- RN02 — Lista de CFOP parametrizada (`:CFOP`, igual a `VS_strClaDev + VS_strClaDVC`) e `:AUTOINCREM`; sem literais.
- RN03 — O terceiro SELECT usa `GROUP BY NFEDEV.AUTOINCREM, NFESAI.AUTOINCREM`, como o primeiro.
- RN04 — Os três SELECTs são ligados por `UNION ALL` (o `UNION` que existia entre os ramos 1 e 2 passou a `UNION ALL`, a pedido do usuário, sem efeito no resultado por causa do `LIMIT 1`). O o `ORDER BY GER_SAIDA_ IS NULL, GER_SAIDA_ DESC` e o `LIMIT 1` não mudam. Quando houver candidatos nos dois ramos, vale a ordenação atual.
- RN05 — `ORIGEM_DOC` deve ser a última coluna dos três SELECTs (a união é posicional; os nomes vêm do primeiro).
- RN06 — Se `ATabelaOrigemDocDev` vier vazio ou com valor desconhecido, usa-se a MOVGER (comportamento atual). A tabela do `FROM` é escolhida por comparação com valores fixos, nunca por concatenação do valor recebido.
- RN07 — O `pPreparaFlagsDevolucao` deve zerar o novo campo junto dos demais campos de devolução.

## 5. Requisitos técnicos / não-funcionais

- Nomes de identificadores sem o número do requisito.
- Nomes no padrão da unit: campo do form `FstrOrigemDoc`; campo da classe `FOrigemDoc`; parâmetro `ATabelaOrigemDocDev`; método da classe `fOrigemDocumento`.
- Encoding dos fontes `.pas`: Windows-1252, CRLF. Edição via Python com `encoding='cp1252', newline=''`; nunca a ferramenta Edit.
- SQL com `ParamByName`; sem `Now`, `StrToFloat`, `.SetFocus`, `Application.CreateForm` ou componentes proibidos.
- Sem impacto em transação ou auditoria (somente leitura).

## 6. Critérios de aceitação

- [ ] Devolução cujo documento devolvido está na NOTGER (exemplo: `DET_SEQGER 00100000001324782100`) é reconhecida: `FblnDevolu = True` e `FstrAutIncVenda = 00100000000005845001`.
- [ ] Para essa devolução com cliente consumidor, `FarrClienteConsumidor` é carregado da NOTGER (SGS COMERCIO DE PECAS LTDA) e não da MOVGER.
- [ ] Devolução com origem em MOVGER continua funcionando como antes (`ORIGEM_DOC = 'MOVGER'`).
- [ ] Devolução sem nota de venda encontrada não gera erro e mantém o comportamento atual.
- [ ] O `untEfetivaMovimentoFiscal.pas` continua compilando e reconhece a devolução com origem NOTGER.
- [ ] `git`/SVN diff mostra apenas as mudanças pretendidas e os arquivos continuam válidos em cp1252, sem `\xef\xbf\xbd`.

## 7. Fora de escopo

- Guard clause para `FstrAutIncVenda` vazia (PA2) e demais refatorações da análise (PA1, PA3, PA4, PA5, PA6, PA7).
- Renomear `fAutoIncremeto`.
- Alterar a ordenação/prioridade entre MOVGER e NOTGER.
- Cópias não listadas na Fase 4 de `tasks.md`, como a 74.111.

A replicação nas cópias 74.150.100, 74.150 e 74.150.45.67 está no escopo (Fase 4 de `tasks.md`).
- Tratar o retorno de `fCarregaClienteConsumidor` (hoje ignorado).

## 8. Dependências e riscos

- **Colisão de AUTOINCREM entre MOVGER e NOTGER**: o mesmo valor pode existir nas duas tabelas com documentos diferentes (comprovado no exemplo). Sem `ORIGEM_DOC` o consumidor sai errado e sem erro.
- **Ordenação entre tabelas**: `GER_SAIDA_ DESC` compara AUTOINCREMs de tabelas diferentes; a prioridade entre os ramos é apenas a ordem numérica.
- **Lista de CFOP**: a validação usou a lista do exemplo; em produção vale `VS_strClaDev + VS_strClaDVC`.
- **Colunas do consumidor na NOTGER**: as 11 colunas lidas por `fCarregaClienteConsumidor` foram confirmadas no banco.
- **Parâmetros repetidos**: `:AUTOINCREM` e `:CFOP` passam a aparecer 3 vezes; o `ParamByName` atende todas as ocorrências.
