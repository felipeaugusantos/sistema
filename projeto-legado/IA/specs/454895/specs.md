# Especificação — Req. 454895

**Título:** Geração assíncrona de sugestão de compra por giro para rascunho de cotação
**Objetivo:** Expor via REST, na Suprimento.Services.API, a geração da sugestão de itens de compra por giro de estoque, em execução assíncrona, gravando o resultado no rascunho da cotação.
**Zona:** Mista — Moderna em `padra_atualizado/Services/`, Legado em `padra_atualizado/fontes/`
**Data:** 2026-08-12

> **Fonte de verdade do levantamento:** `analysis.md`, nesta mesma pasta. Este documento é a visão estruturada; o detalhe de cada decisão, com as referências de código que a sustentam, está lá.

## 1. Contexto / problema atual

O REPOR+ (produto em Flutter) também trabalha com cotação de compra e já realiza criação e manutenção. A tela "Adicionar via giro" precisa da sugestão de itens calculada por giro de estoque — regra consolidada no autcom e compartilhada entre pedido de compra e cotação.

Para que o resultado seja idêntico nos dois produtos e a regra continue com um único dono, o cálculo permanece onde está e passa a ser exposto via REST. A Suprimento.Services.API exerce para cotação o mesmo papel que a Faturamento.Services.API já exerce para vendas.

O cálculo é pesado e pode levar vários minutos, então o usuário não pode ficar preso na tela: dispara, continua usando o sistema, e é avisado quando o resultado fica pronto.

**Ponto de partida favorável:** a Suprimento.Services.API já é o único projeto Linux que compila `untFuncoesPedido.pas`, onde vive o motor `fCalculaGiroEstoque`, e seus workers são o mesmo executável em outro modo. O motor já está dentro do binário que vai executar o cálculo. O trabalho não é portar o cálculo — é construir ao redor dele um orquestrador sem interface gráfica e um ciclo de vida assíncrono.

## 2. Módulos e entidades envolvidos

**Módulos:** Suprimento (API REST), Movimentação de Itens / Cotação (autcom), Movimentação de Itens / Pedido de Compra (portabilidade)

**Units e serviços:**

| Caminho | Papel |
|---|---|
| `padra_atualizado/Services/Suprimento.Services.API/` | Controller REST e projeto Linux |
| `padra_atualizado/Services/Core/suprimento/services/` | Orquestrador e DTOs |
| `padra_atualizado/Services/Core/Services.Core.Worker.pas` | Disparo de tarefa e ciclo de execução |
| `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untFuncoesPedido.pas` | Motor de giro (leitura, não alterado) |
| `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untFuncoesPedidoSimples.pas` | `TRecOpcoesGiro` e builders de SQL |
| `padra_atualizado/fontes/genericos/untFuncoesGenerica.pas` | Recebeu `pCopiaClientDataSet` e `fAtualizaSaldoReservado` — é a unit compartilhada entre autcom e Services |
| `padra_atualizado/fontes/genericos/untFuncoesSimples.pas` | Passou a delegar as duas funções acima; só o autcom a compila |
| `padra_atualizado/fontes/movimentacaoitens/Cotacao/untCotacao.pas` | Referência de comportamento (leitura, **não alterado**) |

**Tabelas e entidades:**

| Tabela | Chave | Uso |
|---|---|---|
| `SSATSK` | `AUTOINCREM` | Tarefa assíncrona — 3 colunas novas, sendo `SST_STATUS` um JSON com etapa e progresso |
| `FSATSK` / `FNATSK` | `AUTOINCREM` | Tarefas do faturamento e do financeiro — 1 coluna cada, só o operador |
| `COTGER_RES` | `AUTOINCREM` | Capa do rascunho — leitura de comprador e digitador. **Sem alteração de estrutura** |
| `COTITE_RES` | `COT_SEQGER` + `COT_CODITE` | Itens do rascunho — destino do resultado |
| `COTFOR_RES` | `COT_SEQGER` + `COT_CODITE` + `COT_CODFOR` | Item × fornecedor do rascunho |
| `CADINT` / `CADINTTUD` | `INT_VALKEY` | Filtros de giro salvos, chave/valor |
| `MENREP` | `AUTOINCREM` (VARCHAR, não auto_increment) | Notificações do REPOR+ — estrutura definida pela equipe REPOR+, a API apenas insere |
| `CADOPE` | `OPE_CODOPE` | Consultada no POST para validar o usuário responsável |

Não existe tabela `COTDET` no sistema.

## 3. Requisitos funcionais

- **RF01** — Criar o recurso REST `/cotacao` na Suprimento.Services.API, com dois endpoints: `POST /cotacao/giro/gerar` e `GET /cotacao/giro/{idProcessamento}`. O POST exige dois headers: `Empresa`, já existente, e `OperadorLogado`, novo e no mesmo padrão.
- **RF02** — O POST valida, persiste os filtros, grava a linha da tarefa com empresa e operador em suas colunas, dispara o processo separado e responde HTTP 202 com o identificador, em tempo de milissegundos.
- **RF03** — Acrescentar ao binário um terceiro modo de execução, `task`, simétrico aos modos `start` e `worker` existentes, que executa uma tarefa e encerra o processo.
- **RF04** — O GET informa status, etapa, progresso, datas, quantidade de itens gerados e mensagem.
- **RF05** — O DTO de filtros espelha a tela de giro do autcom, não a tela do REPOR+.
- **RF06** — Persistir os filtros recebidos em `CADINT`/`CADINTTUD` e nas colunas de giro da capa `COTGER_RES`.
- **RF07** — Implementar orquestrador do cálculo de giro sem dependência de interface gráfica.
- **RF08** — Gravar o resultado no rascunho por substituição total de itens e fornecedores, em transação única.
- ~~**RF09** — Impedir que o autcom apague rascunho criado pelo REPOR+ nos caminhos silenciosos de exclusão.~~ **REMOVIDO DO ESCOPO EM 12/08/2026.** A versão do autcom instalada no cliente é desconhecida e pode ser anterior à entrega; guarda que só existe na versão nova dá falsa segurança. O autcom pode apagar o rascunho, e isso passa a ser comportamento conhecido e declarado. Nenhuma alteração no autcom e nenhuma em tabela de cotação.
- **RF10** — Controlar concorrência: um giro em andamento por rascunho, teto de processos simultâneos, e detecção de tarefas órfãs.
- **RF11** — Propagar exceção do cálculo para o estado da tarefa, sem falha silenciosa.
- **RF12** — Gravar notificação de conclusão na `MENREP`, tabela do REPOR+ cuja estrutura já está definida. **Último item da implementação, isolado dos demais** — por sequenciamento, não por dependência.

## 4. Regras de negócio

- **RN01 — Status derivado.** A `SSATSK` não possui coluna de status. O status é derivado de `SST_DTAINI`, `SST_DTAFIN`, `SST_SUCESS` e `SST_TYPERR`. A condição de erro **precisa** considerar `SST_TYPERR`: quando o disparo falha, o tratamento existente grava `SST_RESULT` e `SST_TYPERR` mas não grava `SST_SUCESS`, e um status derivado apenas de `SST_SUCESS` deixaria esse caso eternamente como processando.

- **RN02 — Substituição total.** A geração apaga **todos** os itens e **todos** os fornecedores do rascunho e regrava a partir do resultado, espelhando `fInsereItensGiro`. Não é acréscimo. Não causa perda no fluxo do REPOR+ porque a tela só permite inclusão manual depois da geração, nunca antes. Consequência a respeitar no REPOR+: uma segunda geração sobre o mesmo rascunho apaga os itens incluídos manualmente na primeira rodada.

- **RN03 — Transação única.** Todo o DELETE mais INSERT dentro de `fStartTransaction` / `fCommit` / `fRollBack`, com `raise` sem parâmetros após o rollback. Sem isso, falha no meio do cálculo deixa o rascunho sem nenhum item, tendo apagado os que existiam.

- **RN04 — Comprador e digitador vêm da capa.** Não vêm do DTO. São lidos de `COTGER_RES` (`COT_CODCMP` e `COT_CODDIG`), escolhendo entre comprador e digitador conforme `fCfgSis('DIGCOT')`, exatamente como o autcom faz no fluxo de cotação.

- **RN05 — Empresas.** O DTO recebe lista de empresas com dois flags, marcada e visível, e a API reconstrói o dataset internamente. `strEmpCal` recebe as marcadas; `strEmpGir` recebe as marcadas mais, quando a coluna de visualização estiver ativa por configuração, as visíveis. Não expor `OleVariant` no contrato REST.

- **RN06 — Campos derivados pela API.** `blnConsTLoj` (mais de uma empresa marcada), `intMesMos` (depende de `fCfgSis('MESGIR')`), `blnCotacao` (sempre verdadeiro neste fluxo) e a data base do giro. O consumidor não envia nenhum deles.

- **RN07 — Enums restritos ao autcom.** Média do cálculo, vendas perdidas e itens sob encomenda aceitam apenas as opções que o autcom possui. Valor fora do conjunto é **recusado com mensagem clara**, nunca silenciosamente ignorado ou tratado como default.

  **Onde a recusa aparece — ajustado em 19/08/2026, com o comportamento medido.** A redação anterior exigia 400. A validação é feita por `fIndiceOpcao`, que levanta `ECotacaoGiroContrato`, mas roda no **mapeador**, dentro do processo da tarefa: o POST responde **202** e a tarefa encerra com o erro e a mensagem. Vale igual para período fora de 3/6/12, lista de empresas vazia e `saldo` ausente.

  O que esta regra protege continua atendido — a mensagem é clara e o valor não vira default silencioso. O que muda é o **momento** da recusa, e a decisão foi acompanhar o comportamento em vez de mudar o contrato: o REPOR+ já trata o 202 e consulta o GET, então o erro chega a ele de qualquer forma. Antecipar a validação para o controller fica como melhoria, não como pendência deste requisito — e exigiria rever o caso de teste 4, além de contornar a guarda `filtros = nil`, que é inalcançável por `BodyAs<T>` porque o construtor do DTO sempre aloca o objeto.

- **RN08 — Prova de vida por advisory lock.** O processo adquire `GET_LOCK` ao iniciar. "Está executando" é `IS_USED_LOCK` retornando algo. O 409 usa esse critério, não a simples existência de linha em aberto — senão tarefa morta travaria o rascunho para sempre. Linha com início preenchido, fim nulo e sem lock ativo está provadamente órfã.

- **RN09 — Notificação isolada.** Gravada em transação própria, **depois** do commit ou do rollback do giro; na mesma transação, o rollback apagaria justamente a notificação de erro. Falha ao gravar a notificação **não** derruba nem marca como erro uma geração que concluiu com sucesso — registrar em log e seguir. O estado da tarefa é a fonte de verdade; a notificação é aviso. Tarefa órfã detectada pela varredura também deve notificar, pois nunca chega ao final da execução.

- **RN10 — Progresso com throttle.** O motor incrementa a posição por item. Gravar a cada N itens ou N segundos, nunca por item.

- **RN11 — Operador logado atravessa o request, a linha da tarefa e o processo da tarefa.** O operador vem no header `OperadorLogado`, mesmo padrão do `Empresa` — não vai no body. O caminho é o mecanismo que já existe, `pDefinirUsuario` (`Services.Core.Settings.pas:323`), que alimenta a global `strLoginUsuarioLogado` lida pelo código legado:

  1. o middleware chama `pDefinirUsuario` com o header, **depois** do `BeginThreadConnection` — a função consulta banco, então não pode seguir a ordem do `Empresa`, que é tratado antes;
  2. o enfileiramento grava `<prefixo>_CODOPE` a partir dessa mesma global, junto do `_CODEMP`, de forma genérica sobre o prefixo;
  3. o processo que executa a tarefa chama `pDefinirUsuario` com o valor da coluna, senão o cálculo e a gravação rodam sob o operador default mesmo com o middleware ajustado;
  4. coluna ausente ou vazia mantém o default, que é `LOG_ADM = '999'` ou `fCfgSis('OPEAUT')` — comportamento de hoje.

  Consequências obrigatórias. **Validação:** `MEN_CODOPE` é `CHAR(3)` com FK para `CADOPE.OPE_CODOPE`; código inválido só falharia no insert da notificação, ao final de um giro que já rodou por minutos, então o POST valida contra `CADOPE` e responde 400. **Coluna, não `SST_PARAMS`:** contexto de execução mora em coluna, como o `SST_CODEMP`; parâmetro de negócio mora no `SST_PARAMS`. **`FindField` sempre**, na gravação e na leitura: o código é compartilhado pelas tabelas de tarefa dos outros serviços e um `FieldByName` em coluna inexistente derruba o processamento delas. **Colateral a confirmar na implementação:** `pDefinirUsuario` também define `strEmpAcessoUsuarioLogado` e, com `DACPOR` ligada, `strPortadoresOperador` — operador com acesso restrito a empresas pode filtrar diferente do default.

- **RN13 — Atribuição é requisito, não efeito colateral.** `strLoginUsuarioLogado` alimenta `LOG_CODOPE` e `LOG_LOGOPE` da LOGREP, `TRA_CODOPE`, `CTL_CODOPE`, o `CODOPE` dos locks e a variável de sessão `USUARIOLOGADO`. E o `fSalvaDados` do RF06 recebe o operador como parâmetro — é o que o autcom já faz passando `strLoginUsuarioLogado`. Sem o mecanismo da RN11, tudo que o REPOR+ gerar fica atribuído ao operador default.

- **RN12 — A notificação não duplica estado.** A `MENREP` não tem coluna de resultado nem de quantidade de itens, e isso é deliberado. O estado autoritativo continua na `SSATSK`; a aplicação chega a ele pelo `MEN_WORKID` chamando o GET. A notificação é o aviso de "já pode olhar". A quantidade de itens aparece apenas como texto em `MEN_MENSAG`, não como campo consultável.

## 5. Requisitos técnicos / não-funcionais

- **Assincronismo real.** O caminho síncrono atual tem dois bloqueios de 120 segundos — o laço de polling e o `ReadLn` do despacho. Nenhum dos dois se aplica ao caminho novo.
- **Isolamento.** O processo separado é reparentado para o init, então reiniciar a API não interrompe giro em andamento e não sobra processo zumbi. Propriedade intencional.
- **Não degradar o que está em produção.** `/pedido-compra/calcular-impostos` e `/pedido-compra/pdf` compartilham a mesma API e a mesma tabela de tarefas. Nada do protocolo do pool nem do comportamento síncrono pode mudar.
- **Segurança.** Validar que o identificador é numérico antes de concatenar no comando de shell. Todo SQL novo com `fCriaQuery` e `ParamByName()`.
- **Auditoria e data.** Timestamps persistidos via `fNow()`.
- **Encoding.** Fontes Delphi em latin1 conforme `.editorconfig`; estes artefatos de análise em UTF-8.
- **Impacto fiscal/financeiro:** nenhum. O requisito não toca cálculo de imposto, título ou documento fiscal — apenas sugestão de compra em rascunho de cotação.

## 6. Critérios de aceitação

- [ ] 01 — POST com rascunho válido responde 202 em milissegundos e a chamada não permanece aberta durante o cálculo.
- [ ] 02 — GET imediatamente após o POST retorna pendente ou processando; após a conclusão retorna concluído, com quantidade de itens coerente com as linhas gravadas em `COTITE_RES`.
- [ ] 03 — Giro que ultrapassa 120 segundos conclui normalmente, sem timeout.
- [ ] 04 — Reiniciar o serviço da API com um giro em andamento não interrompe o giro: ele conclui e grava o resultado.
- [ ] 05 — Matar o processo do giro à força faz a tarefa ser detectada como órfã, passar a responder erro no GET, gerar notificação de erro e liberar o rascunho para nova geração sem intervenção manual.
- [ ] 06 — Segundo POST para o mesmo rascunho, com o primeiro em andamento, responde 409.
- [ ] 07 — Ultrapassar o teto de processos simultâneos responde 429 sem disparar processo.
- [ ] 08 — Durante um giro em execução, `/pedido-compra/calcular-impostos` e `/pedido-compra/pdf` respondem dentro do tempo normal.
- [ ] 09 — O resultado gravado em `COTITE_RES` e `COTFOR_RES` para um conjunto de filtros é equivalente ao que a tela de giro do autcom produz para os mesmos filtros.
- [ ] 10 — Falha forçada no meio do cálculo deixa o rascunho com os itens originais intactos: rollback completo, sem rascunho vazio.
- [ ] 11 — Falha forçada faz o GET responder erro com a mensagem da exceção, e não concluído com zero itens.
- [ ] 12 — Conclusão com sucesso gera linha em `MENREP` com `MEN_CODOPE` igual ao header `OperadorLogado` enviado no POST, `MEN_TIPO__ = 1`, `MEN_WORKID` igual ao identificador do processamento, `MEN_NUMDOC` apontando para o rascunho e `MEN_MENSAG` citando a quantidade de itens gerados. `MEN_LIDA__` fica `'N'` e `MEN_DTALEI` fica nulo — a API não escreve essas colunas.
- [ ] 13 — Falha gera linha em `MENREP` com a mensagem da exceção em `MEN_MENORI`, truncada em 255, e essa linha sobrevive ao rollback do giro. O GET pelo `MEN_WORKID` responde erro com a mensagem completa.
- [ ] 14 — Header `OperadorLogado` ausente, ou com código inexistente em `CADOPE`, responde 400 no POST, antes de disparar o processo — e não falha no insert da `MENREP` ao final de um giro já executado. Com o header válido, o operador chega à notificação mesmo após reinício da API, porque foi persistido em `SST_CODOPE`.
- [ ] 15 — O GET reflete etapa e progresso durante o cálculo, e a gravação de progresso não degrada o banco.
- [ ] 16 — Cotação gerada pelo REPOR+ abre no autcom com os filtros de giro visíveis: o código de giro da capa aponta para linhas existentes em `CADINT`.
- [ ] 17 — Abrir no autcom uma cotação cujo rascunho veio do REPOR+ pode descartar o rascunho, e isso é aceito. O teste confirma que o descarte não deixa estrago: a cotação oficial não é afetada, a linha da tarefa na `SSATSK` não fica eternamente como processando, e uma nova geração para o mesmo rascunho é aceita sem intervenção manual.
- [ ] 18 — Nos três campos divergentes, o DTO aceita apenas as opções do autcom; valor fora do conjunto é recusado com mensagem clara. **A recusa vem como 202 no POST, com a tarefa encerrando em `ECotacaoGiroContrato` e a mensagem no `SST_RESULT`** — não como 400. Ver RN07: a validação é do mapeador, que roda no processo da tarefa. Redação ajustada em 19/08/2026 para acompanhar o comportamento medido; a antecipação para o controller fica como melhoria fora deste requisito.
- [ ] 19 — O Swagger registra quais tipos de média a API suporta e quais existem hoje apenas no cálculo noturno do REPOR+, sem promessa de prazo.

## 7. Fora de escopo

1. Acréscimo de itens preservando o que já está na cotação. A geração substitui a lista.
2. Endpoint de recálculo de sugestão dos itens existentes, equivalente ao fluxo `pCarregaGirosSimples` do autcom.
3. Alterar o protocolo do pool de workers ou o comportamento síncrono do despacho de tarefa.
4. Criar um segundo pool de workers.
5. Implementação Linux de `fChamaCalculoGiro`, `fCarregaDados` e `fAtualizaDados` — acoplados a form e desnecessários aqui.
6. Escrita nas tabelas oficiais `COTITE` e `COTFOR`. A API trabalha sempre sobre o rascunho.
7. Promoção do rascunho para a cotação oficial. É da aplicação Flutter, após a notificação de conclusão.
8. DDL da `MENREP`. Já definida, e criada pela equipe REPOR+.
9. Controle de leitura e exclusão da notificação — `MEN_LIDA__`, `MEN_DTALEI` e `MEN_EXCLUI`. São da aplicação; a API não escreve nessas colunas.
10. Tela do REPOR+ e backend Java.
11. Lock de cotação entre autcom e API. A arquitetura dispensa, pois a API não escreve no oficial.
12. Médias ponderadas, vendas perdidas por valor e as opções "incluir" / "excluir" de itens sob encomenda. Dependem do requisito de compatibilização do cálculo de giro do autcom com o da procedure do REPOR+.

## 8. Dependências e riscos

**Dependências externas**

| Dependência | Responsável | Bloqueia |
|---|---|---|
| Criação da `MENREP` no banco | Equipe REPOR+ | Nada — estrutura já definida; o RF12 segue último por sequenciamento |
| Arquivo com a estrutura final da `MENREP`, com inclusões além do `MEN_NUMDOC` já ajustado para VARCHAR(50) | Equipe REPOR+ | Só a gravação da notificação — reconferir o mapeamento contra ele |
| Adequação da tela às opções do contrato | Equipe REPOR+ | Nada do lado API |
| Criação da capa do rascunho antes do POST | REPOR+ | Uso em produção |
| Promoção do rascunho para o oficial | Aplicação Flutter | Uso em produção |
| Requisito de compatibilização dos tipos de giro | Análise / Suprimento | Apenas as opções do item 12 do fora de escopo |

**Riscos**

| Risco | Mitigação |
|---|---|
| Resultado divergente da tela do autcom (critério 09) | Rodar o mesmo conjunto de filtros nos dois lados e comparar `COTITE_RES`, com a tela do autcom como referência |
| `fCalculaGiroEstoque` tem mais de 60 parâmetros posicionais; um trocado compila e dá resultado errado em silêncio | Transcrever a chamada existente linha por linha e conferir contra ela |
| Giro longo prendendo recurso e degradando os endpoints em produção | Teto de processos, um giro por rascunho, e critério de aceitação 08 |
| Gravação de progresso item a item derrubando o banco | Throttle obrigatório (RN10) |
| Rascunho do REPOR+ apagado pelo ciclo de vida do autcom | **Risco aceito.** RF09 removido — a versão do autcom no cliente é desconhecida, logo não há guarda confiável. Mitigação de produto: o REPOR+ promove o rascunho cedo, encurtando a janela |
| Notificação acoplada ao orquestrador derrubando giro bom | Transação própria, após commit/rollback, falha não propaga (RN09) |
