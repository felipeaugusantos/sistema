# Plano de Execução — Req. 454895

**Referência:** `specs.md`, e `analysis.md` para o detalhe de cada decisão com as citações de código
**Zona:** Mista — Moderna em `padra_atualizado/Services/`, Legado em `padra_atualizado/fontes/`

## 1. Abordagem técnica

O motor de giro **não é alterado**. Todo o trabalho é construir ao redor dele duas coisas que não existem: um orquestrador sem interface gráfica e um ciclo de vida assíncrono.

**Assincronismo — modo novo do binário, não infraestrutura paralela.** O executável já despacha por parâmetro entre `start` (servidor HTTP) e `worker` (worker de pool). Entra um terceiro modo, `task`, que executa uma tarefa e encerra. O controller grava a linha na `SSATSK`, dispara o processo separado em background e responde 202. O pool de workers não participa.

Três razões para esse desenho em vez de um segundo pool:

- `FInstance` é `class var` declarada na base do manager, ou seja, um único slot compartilhado por todos os descendentes. Um segundo manager sobrescreveria o existente e desviaria os endpoints em produção para a fila errada.
- O protocolo do pool interpreta qualquer resposta diferente de `DONE` como mensagem de erro, então não há como sinalizar "aceitei, estou processando" sem alterar o caminho síncrono.
- O processo em background é reparentado para o init, então reiniciar a API não interrompe giro em andamento — propriedade que um pool não dá.

**Camadas (zona Moderna).** Controller delega para o service e trata HTTP; o orquestrador concentra a montagem do `TRecOpcoesGiro` e a chamada do motor; DTOs em unit própria de types. Sem lógica de negócio no controller.

**Zona Legado.** As duas units do autcom seguem o estilo existente — Hungarian, sem refatoração em volta da alteração. São mudanças cirúrgicas: uma guarda na rotina de exclusão do rascunho e a remoção da dependência de form modal no saldo reservado.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|---|---|---|
| `api.controller.cotacao.pas` | `Services/Suprimento.Services.API/Source/api/controller/` | criar |
| `Suprimento.Services.Cotacao.Giro.pas` | `Services/Core/suprimento/services/` | criar |
| `Suprimento.Services.Cotacao.Types.pas` | `Services/Core/suprimento/services/types/` | criar |
| `SuprimentoServicesAPI.dpr` | `Services/Suprimento.Services.API/Target/Linux/` | alterar — modo `task` e units novas |
| `Services.Core.Worker.pas` | `Services/Core/` | alterar — disparo de tarefa, progresso, correção do parser |
| `Suprimento.Services.Workers.pas` | `Services/Core/suprimento/services/` | alterar — registro do serviço de giro |
| `untFuncoesGenerica.pas` | `fontes/genericos/` | alterar — recebe `pCopiaClientDataSet` e `fAtualizaSaldoReservado`, que vieram do `untFuncoesSimples`; é compilada pelo autcom e pelos Services |
| `untFuncoesSimples.pas` | `fontes/genericos/` | alterar — os dois corpos saíram e ficaram delegando para o `untFuncoesGenerica` |
| `SuprimentoServicesTEST.dpr` + `Test_Cases/` | `Services/Suprimento.Services.API/Target/Linux/` | criar |
| `Services.Tests.groupproj` | `Services/` | alterar — registrar o projeto de teste novo |

**Banco de dados**

| Objeto | Ação |
|---|---|
| `SSATSK` | 3 colunas novas: `SST_ASSINC`, `SST_CODOPE` e `SST_STATUS` — todas nuláveis. O `SST_STATUS` é JSON em `LONGTEXT` e carrega etapa e progresso, no lugar de três colunas. Regra: nada que apareça em `WHERE` entra no JSON. Sem coluna para o rascunho — o 409 usa advisory lock nomeado pelo rascunho |
| `FSATSK` e `FNATSK` | 1 coluna cada: `FST_CODOPE` e `FNT_CODOPE`. Decidido: a coluna de operador entra nas três tabelas de tarefa, porque a infra é compartilhada |
| Tabelas de cotação (`COTGER`, `COTITE`, `COTFOR` e as `_RES`) | **sem alteração de estrutura** — a API apenas popula as `_RES` |
| `CADINT` / `CADINTTUD` | sem alteração de estrutura, uso existente |
| `MENREP` | DDL da equipe REPOR+, já definida — a API apenas insere |
| `CADOPE` | sem alteração, consultada no POST para validar o usuário responsável |

**Regra de edição de projeto:** para units, alterar apenas o `.dpr` (cláusula `uses`) — a IDE sincroniza o `.dproj`. Mexer no `.dproj` só se for necessário alterar opção de compilador ou deploy.

## 3. Sequência de implementação

Dez fases, cada uma com fechamento verificável. A ordem é desenhada para que o item que depende de outra equipe fique por último e isolado.

**Fase 1 — Banco.** Colunas novas na `SSATSK` e no `COTGER_RES`.
*Fecha quando:* script aplicado e os endpoints existentes seguem funcionando.

**Fase 2 — Portabilidade Linux.** Mover `pCopiaClientDataSet` e `fAtualizaSaldoReservado` de `untFuncoesSimples.pas` para `untFuncoesGenerica.pas`, que é compilada pelo autcom **e** pelos Services, deixando `untFuncoesSimples` delegando — uma implementação só, em vez de um corpo por plataforma. O motor de giro já compila para Linux; `untRecalculaSados.pas` não entra.
*Fecha quando:* o `.dpr` compila para Linux com as units novas no `uses` e nenhum outro serviço quebrou com a mudança em `Services.Core.Types.pas`.

**Fase 3 — DTOs e mapeamento.** DTO de filtros espelhando a tela do autcom, com os enums fechados; mapeamento DTO → `TRecOpcoesGiro`, incluindo a reconstrução do dataset de empresas a partir dos dois flags e os campos derivados pela API.
*Fecha quando:* teste unitário monta o record a partir de um JSON de exemplo, sem banco.

**Fase 4 — Orquestrador.** Três datasets, chamada do motor com os parâmetros posicionais, cópia do dataset, atualização do saldo reservado, devolução do resultado. Sem interface gráfica em nenhum ponto.
*Fecha quando:* o cálculo roda e devolve itens para um conjunto de filtros conhecido.

**Fase 5 — Gravação no rascunho.** Substituição total de itens e fornecedores em transação única.
*Fecha quando:* critérios 09 e 10.

**Fase 6 — Modo `task` e disparo.** Terceiro modo no binário reusando o ciclo de execução de tarefa existente; disparo em background com PID em arquivo e log próprio.
*Fecha quando:* critérios 01, 03 e 04.

**Fase 7 — Endpoints REST, operador logado e persistência de filtros.** POST e GET, headers `Empresa` e `OperadorLogado`, validação do operador contra `CADOPE`, o mecanismo de operador logado em três pontos da infra compartilhada (middleware, enfileiramento e `ProcessTask`, todos via `pDefinirUsuario`), status derivado, progresso com throttle; gravação dos filtros em `CADINT`/`CADINTTUD` e nas colunas de giro da capa.
*Fecha quando:* critérios 02, 11, 14, 15, 16, 18 e 19.

**Fase 8 — Concorrência.** 409 por advisory lock, teto de processos com 429, varredura de órfãs.
*Fecha quando:* critérios 05, 06, 07 e 08.

**Fase 9 — REMOVIDA DO ESCOPO.** Era a guarda no autcom contra exclusão do rascunho. Saiu porque a versão do autcom instalada no cliente é desconhecida e pode ser anterior à entrega — guarda que só existe na versão nova dá falsa segurança. Nenhuma alteração no autcom e nenhuma em tabela de cotação. Ver bloco [ 10 ] do `analysis.md`.
*Fecha quando:* critério 17.

**Fase 10 — Notificação.** Gravação da linha em `MENREP`, incluindo o caso de tarefa órfã.
*Fecha quando:* critérios 12 e 13.

> **Fase 10 é a última e isolada** — por sequenciamento, não por dependência: a estrutura da `MENREP` já está definida. As fases 1 a 9 devem ser desenvolvidas, testadas e poder ser entregues sem ela. Nada nas fases anteriores pode depender da notificação existir.

## 4. Conformidade com padrões do projeto

**Zona Moderna** (`Services/`) — dot-notation nos nomes de unit; Controller → Service sem lógica no controller; atributos `MVCPath` / `MVCHTTPMethod` / `MVCSwagSummary` em cada action; `MVCRequiresAuthentication` na classe; header `Empresa` obrigatório; registro em `initialization` via `TControllersRegister`.

**Zona Legado** (`fontes/`) — manter Hungarian e o estilo das units alteradas; não refatorar em volta da alteração.

**Chamadas do projeto** — `fNow()` em todo timestamp persistido; `fCriaQuery` e `ParamByName()` em todo SQL novo; `fStartTransaction` / `fCommit` / `fRollBack` com `raise` sem parâmetros após rollback.

**Dois cuidados específicos deste requisito:**

- O código vizinho monta SQL por concatenação de string — a rotina que atualiza o código de giro na capa e o `SELECT` do ciclo de tarefa são exemplos. É padrão existente, **não** modelo a seguir: o código novo usa `ParamByName()`.
- O comando de disparo é string entregue ao shell. Validar que o identificador é numérico antes de concatenar.

**Pre-commit** — não há UI nova, então nenhum componente proibido se aplica. Sem `Now()`, sem `StrToFloat`, sem `FOREIGN_KEY_CHECKS` nos scripts.

**Correção recomendada, independente deste requisito:** o parser do comando de tarefa usa offset fixo de 6 caracteres para o nome da tabela. Trocar por cálculo a partir do tamanho do nome. Hoje funciona por coincidência de nomenclatura e é armadilha silenciosa para quem criar outra tabela de tarefa.

## 5. Estratégia de testes

**Divisão de papel — ler antes de distribuir tarefa.** Os casos de teste são escritos por **analista humano**, não por quem implementa. O que a implementação entrega é o contrato e a lista de casos a cobrir. Teste-primeiro não se aplica: na zona legada por não haver infraestrutura, na moderna por essa divisão de papel.

| Item | Dono |
|---|---|
| Criar `SuprimentoServicesTEST.dpr` com `Test_Cases/` e registrar no `Services.Tests.groupproj` | Implementação — é trabalho de projeto Delphi |
| Escrever os casos de teste | Analista |
| Entregar o contrato e a lista de casos a cobrir | Implementação |
| Executar a suite e validar os critérios | Analista |
| Roteiro de verificação manual dos critérios de processo | Implementação escreve o roteiro; analista executa |

O projeto de teste do Suprimento **não existe** — hoje o Faturamento é o único serviço com projeto de teste REST. Criá-lo é trabalho novo, não "escrever alguns testes". Se o prazo apertar, é o candidato natural a virar entrega separada; nesse caso os critérios 02, 11, 14 e 17 passam a ser verificação manual.

**Lista de casos a cobrir — entregue pela implementação ao analista:**

- Mapeamento DTO → `TRecOpcoesGiro`: cada grupo de filtros, campos derivados, reconstrução das duas listas de empresas a partir dos flags.
- Enums restritos: cada um dos três campos divergentes aceita as opções do autcom e responde 400 para valor fora do conjunto.
- Contrato do POST: 202 com identificador; 400 para rascunho inexistente e parâmetro ausente; 409 para segunda geração no mesmo rascunho.
- Contrato do GET: 404 para identificador inexistente; as quatro faixas de status derivado, **incluindo o caso em que só `SST_TYPERR` está preenchido**.
- Transação: falha injetada no meio da gravação deixa o rascunho com os itens originais.

**Verificação manual** — quatro critérios são de nível de processo e não cabem em teste automatizado. A implementação escreve o roteiro; a execução é do analista:

| Critério | Roteiro |
|---|---|
| 04 | Disparar giro longo, reiniciar o serviço da API, confirmar que o giro conclui e grava |
| 05 | Disparar giro, matar o processo à força, confirmar detecção de órfã e liberação do rascunho |
| 07 | Disparar acima do teto e confirmar 429 sem processo novo |
| 08 | Com giro em execução, medir a resposta dos dois endpoints existentes |

**Validação funcional do cálculo (critério 09)** — comparação lado a lado: mesmo conjunto de filtros na tela de giro do autcom e no endpoint, conferindo `COTITE_RES`. A tela do autcom é a referência.

## 6. Riscos e mitigação

| Risco | Mitigação |
|---|---|
| Resultado divergente da tela do autcom | Comparação lado a lado com os mesmos filtros; a tela é a referência de corretude |
| Mais de 60 parâmetros posicionais no motor — um trocado compila e erra em silêncio | Transcrever a chamada existente linha por linha e conferir contra ela; não reordenar |
| Alterar `Services.Core.Worker.pas` afeta os dois endpoints em produção | Só acrescentar caminho novo; não tocar no `fExecuteTask` nem no despacho síncrono. Critério 08 valida |
| Segundo pool criado por engano quebra os endpoints existentes | Registrado como fora de escopo e explicado no requisito; o modo `task` existe para não encostar nisso |
| Progresso item a item degradando o banco | Throttle obrigatório, a cada N itens ou N segundos |
| Rascunho do REPOR+ apagado pelo autcom | **Risco aceito, sem mitigação técnica.** Guarda no autcom saiu de escopo: a versão instalada no cliente é desconhecida e pode ser anterior à entrega, então proteção só na versão nova daria falsa segurança. Mitigação é de produto — o REPOR+ promove o rascunho cedo, encurtando a janela. Ver bloco [ 10 ] do `analysis.md` |
| Notificação acoplada derrubando giro bem-sucedido | Transação própria após commit/rollback; falha registra em log e não propaga |
| Criação da `MENREP` no banco atrasar a entrega | Fase 10 isolada; fases 1 a 9 entregáveis sem ela |
| Usuário responsável inválido só falhar no insert da notificação, ao final do giro | Validar contra `CADOPE` no POST e responder 400 (RN11) |
| Mudança no middleware ou no enfileiramento afetar os outros 37 serviços | Sem o header e sem a coluna nada muda; `FindField` obrigatório na gravação e na leitura; teste de regressão de enfileiramento nos demais serviços |
| Operador com acesso restrito a empresas alterar o resultado do giro via `strEmpAcessoUsuarioLogado` | Conferência explícita na Fase 7 antes de fechar; nenhuma unit do caminho do giro consome hoje, mas não está confirmado |
| Mapeamento da notificação divergir da estrutura final da `MENREP` | Reconferir o bloco [ 12 ] contra o arquivo final antes da Fase 10; `MEN_NUMDOC` já resolvido em VARCHAR(50) |
| Tela do REPOR+ enviar opção que a API não suporta | Enum restrito com 400 explícito (critério 17) e Swagger documentando o que existe só na procedure (critério 18) |
| Spike descartável ficar no commit e virar código morto permanente | Mantido de propósito até o fim do desenvolvimento como esqueleto do orquestrador. Remoção é item **bloqueante** da Fase 4, com os três pontos listados (unit, `uses`, ramo do `ParamStr(1)`) e recompilação depois. Não é alcançável em produção sem argumento explícito, então o risco é de higiene, não de comportamento |
