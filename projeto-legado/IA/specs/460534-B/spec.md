# Contexto de execução no LOGERR dos robôs Linux

**Chave:** `460534-B` — continuação do Req. 460534, cujo registro consolidado está em `IA\specs\460534\record.md`
**Data:** 2026-09-16
**Zona:** Legado (`padra_atualizado/fontes/genericos/`) + Moderna (`padra_atualizado/Services/Core/`)

---

## 1. Problema

Erro gravado por robô Linux hoje não permite chegar até a origem. Exemplo real:

```
AUTOINCREM  LOG_LOGOPE  LOG_DTAERR  LOG_HORERR  LOG_DESCRI                                                                      LOG_CODEMP  LOG_RELERR  LOG_ULTSQL
      1385  AUT         2026-09-16  09:37:23    [fFaturaPedidosVenda] Cannot connect to server on host '192.168.0.1':
                                                Connection timed out - [[fGravaArquivos]]                                        001         (NULL)
```

O que falta para o suporte agir:

- **Qual binário** errou. São 38 serviços Linux; a linha não diz qual.
- **Em qual máquina** e contra **qual banco** — o `192.168.0.1` vem do driver, mas não se sabe qual configuração apontava para lá.
- **Qual chamada** originou: rota REST, task de worker ou gatilho.
- **Sem `LOG_RELERR`** — nos robôs Linux não há madExcept, então não existe stack nem bug report.

A cadeia `[fFaturaPedidosVenda] ... - [[fMarcaOrcPed]] - [[fGravaArquivos]]` é rótulo manual, camada a camada, montado por `pMensagensErro(E.Message, '[fNome]')`. Dá uma noção do caminho, não é captura.

---

## 2. Escopo

### Dentro da v1

Gravar, em **todo** erro que chegue ao `TDBUtils.pGravarLogErr` rodando em Linux, um bloco de contexto no início do `LOG_RELERR`, dividido em duas camadas:

**Camada ambiente** — o gravador monta sozinho, sem nenhum entry point ser alterado. Vale de uma vez para todo erro que passe pelo `TDBUtils.pGravarLogErr`: API REST, gatilho de informação, worker e daemon.

> **Fulfillment é exceção, e não estava escrito aqui até 16/09/2026.** O robô de fulfillment tem logger próprio — `TFulFillmentLogRepositorio.pSalvarLog` grava em `FULL_LOGERR`, não em `LOGERR` —, então o log de negócio dele **não** ganha o bloco. Ver 12.

**Camada origem** — só o entry point sabe; entregue por `threadvar` preenchida na entrada e limpa na saída. Inclui o **payload de entrada**, mascarado e truncado (ver 3.5).

### Fora da v1 — explicitamente

| Item | Motivo |
|------|--------|
| `LOG_ULTSQL` | Decisão do João: tratar depois. A fachada Linux `pGravarErro` hoje nem tem o parâmetro |
| Aplicação desktop (`autcom.exe`) | O "programa" lá é sempre o mesmo; o problema é outro |
| Colunas novas em `LOGERR` | **Vetado pelo João.** Nenhuma alteração de schema, nenhum script de migração |

---

## 3. Decisões e o porquê

### 3.1 Tudo no `LOG_RELERR`, sem coluna nova

Decisão do João. Consequências aceitas: não dá para filtrar por coluna — achar "todos os erros do `MonitorarGatilhos`" vira `LIKE`. Em troca: zero migração nas bases instaladas, e as telas que já leem `LOG_RELERR` mostram o bloco sem alteração.

O bloco vai **antes** do relatório que o chamador já passava, e os dois convivem — `TFaturamentoAutomatico` ([Faturamento.Classes.TFaturamentoAutomatico.pas:742](../../../padra_atualizado/fontes/faturamento/Faturamento.Classes.TFaturamentoAutomatico.pas)) continua mandando o log dele.

### 3.2 `threadvar`, não parâmetro novo

Há ~1.500 chamadas de `pGravarErro`/`pMensagensErro` espalhadas, e o erro estoura doze camadas abaixo, dentro de código legado compartilhado com o Windows que não conhece `TWebContext`. Passar contexto por assinatura é inviável.

`threadvar` já é o mecanismo da casa: [untDBUtils.pas:252](../../../padra_atualizado/fontes/genericos/untDBUtils.pas), [untFuncoesSimples.pas:5385](../../../padra_atualizado/fontes/genericos/untFuncoesSimples.pas), [untProximoCodigo.pas:70](../../../padra_atualizado/fontes/genericos/untProximoCodigo.pas). No DMVC/Indy uma thread atende uma requisição, então não há ambiguidade.

### 3.3 Inversão por `class var` de `TDBUtils`

A própria `TDBUtils` já resolve exatamente este problema, e com mais de vinte casos: `fRetAutoIncrem`, `fCfgSisL`, `fGetCampoTabela`, `fGetEmpresaLogada`, `GetComputerNetName` e companhia são `class var` de ponteiro de função ([untDBUtils.pas:32-40](../../../padra_atualizado/fontes/genericos/untDBUtils.pas)), atribuídos no `initialization` de `Services.Core.Connection.Manager` ([:5822-5845](../../../padra_atualizado/Services/Core/Services.Core.Connection.Manager.pas)) no Linux e em `untFuncoesSimples` ([:61688](../../../padra_atualizado/fontes/genericos/untFuncoesSimples.pas)) no Windows.

O contexto entra como mais um desses, **declarado só no ramo `{$IFDEF LINUX}`**. Windows não ganha o campo, então não há como o comportamento dele mudar — a garantia é estrutural, não por convenção.

**A alternativa descartada** foi acrescentar a unit nova ao `services.core.uses.inc` e chamá-la direto: funcionaria, porque `untDBUtils` já importa o Core inteiro na interface sob `{$IFDEF LINUX}`, mas mudaria o grafo de compilação dos 38 serviços para não ganhar nada. O `class var` linka a unit nova apenas por quem a referencia no `initialization`.

### 3.4 O que NÃO pode entrar no ambiente

**`fRetNomeDesteServidor`, `fRetNumIpDesteServidor`, `fRetPortaDesteServidor`, `fRetBancoDesteServidor` estão proibidos neste caminho.** Os quatro fazem `fTabelaExiste('EMPLOJ')` + `fCampoTabela(...)` ([Services.Core.Connection.Manager.pas:5494-5519](../../../padra_atualizado/Services/Core/Services.Core.Connection.Manager.pas)) — até 8 queries por erro logado. No caso que originou este trabalho o erro **é** falha de conexão: chamá-los ali daria outro timeout ou perderia o log.

Substituídos por `TConnectionsManager.ConnectionParams` ([Services.Core.Connection.Manager.pas:27](../../../padra_atualizado/Services/Core/Services.Core.Connection.Manager.pas)), `class var` em memória com `Server`, `Port`, `Database`, `UserName`. É dado melhor: responde qual configuração apontava para o host que falhou.

`GetComputerNetName` ([Services.Core.Utils.pas:1610](../../../padra_atualizado/Services/Core/Services.Core.Utils.pas)) é `ShellExecute('hostname')` — um processo novo por chamada. Lido **uma vez** na subida e guardado; nunca dentro do handler.

### 3.5 Payload de entrada — decisão revista

A versão original desta spec deixava o body fora. **O João decidiu incluir**, ciente de que ele carrega credencial e dado pessoal. Registrado aqui porque a decisão é dele e a ressalva foi feita antes.

Campo único `Payload`, não "body": body existe só no REST. Worker tem parâmetros de task, gatilho tem a configuração dele. Um campo só, preenchido por cada entry point com o que tem, mantém os quatro robôs simétricos e evita um campo vazio em três deles.

Duas travas, que **não** são opcionais:

**Máscara.** Antes de guardar, substituir por `***` o valor de qualquer chave cujo nome contenha, sem diferenciar maiúsculas: `senha`, `password`, `pass`, `token`, `authorization`, `secret`, `apikey`, `api_key`, `bearer`, `client_secret`, `pwd`. A máscara é aplicada tanto em JSON quanto em query string. Motivo: `LOGERR` é tabela que o suporte inteiro lê, e a alternativa é distribuir credencial de produção por descuido.

**Teto.** `Payload` truncado em 8192 caracteres, com marca explícita do corte. Sem isso, um pedido com centenas de itens transforma o `LOGERR` em depósito, e a tabela cresce em toda base instalada.

O que a máscara **não** cobre: CPF, e-mail, endereço e nome do destinatário continuam em texto claro, porque não têm nome de chave previsível e mascarar por heurística de conteúdo daria falso positivo em código de produto e número de documento.

**Isso foi levantado e dispensado pelo João em 16/09/2026** — "gravar as informações no LOGERR não é um problema". Decisão tomada com a consequência à vista: quem tem acesso ao `LOGERR` passa a ter acesso a dado pessoal de cliente. Não reabrir sem falar com ele.

A dispensa vale para dado pessoal, **não** para credencial: a máscara de senha e token permanece obrigatória. Senha de banco e JWT numa tabela que o suporte inteiro lê não é exposição de dado, é concessão de acesso.

---

## 4. Contrato — o bloco gravado

Formato fixo, uma informação por linha, rótulos alinhados, delimitado para não se confundir com o relatório do chamador:

```
========== CONTEXTO DE EXECUCAO ==========
Executavel : FaturamentoServicesAPI (/opt/autcom/bin/FaturamentoServicesAPI)
Modulo     : bplShared260.so
Argumentos : -p 8080 --config /opt/autcom/etc/fat.conf
Host       : srv-autcom-01
PID/Thread : 3412 / 3419
Banco      : 192.168.0.1:3306/AUTCOM (usuario: autcom)
Empresa    : 001
Operador   : AUT
Origem     : REST POST /api/faturamento/faturarpedidos
Inicio     : 2026-09-16 09:37:21
Payload    : {"empresa":"001","documento":"000123456","especie":"PD",
              "token":"***","itens":[...]}
             [TRUNCADO EM 8192 CARACTERES - ORIGINAL 41307]
==========================================
<relatorio que o chamador ja passava, se houver>
```

A linha `[TRUNCADO ...]` só aparece quando houve corte.

### 4.1 Origem de cada campo

| Campo | Fonte | Toca banco? |
|-------|-------|-------------|
| `Executavel` | `ParamStr(0)` | não |
| `Modulo` | `System.SysUtils.GetModuleName(HInstance)` — já usado em Linux em [Services.Core.Task.Monitor.pas:120](../../../padra_atualizado/Services/Core/Services.Core.Task.Monitor.pas) | não |
| `Argumentos` | `ParamStr(1..ParamCount)` | não |
| `Host` | `GetComputerNetName`, **lido uma vez na subida** | não |
| `PID/Thread` | `GetCurrentProcessId` / `GetCurrentThreadId` ([Services.Core.Utils.pas:1620](../../../padra_atualizado/Services/Core/Services.Core.Utils.pas)) | não |
| `Banco` | `TConnectionsManager.ConnectionParams` — `Server`, `Port`, `Database`, `UserName`. **`Password` nunca** | não |
| `Empresa` | `VS_strCodEmp` | não |
| `Operador` | `strLoginUsuarioLogado` | não |
| `Origem` | `threadvar` preenchida pelo entry point | não |
| `Inicio` | `threadvar`, marcada na entrada | não |
| `Payload` | `threadvar`, preenchida pelo entry point, mascarada e truncada conforme 3.5 | não |

### 4.2 Quem preenche `Origem` e `Payload`

| Entry point | Onde | `Origem` | `Payload` |
|-------------|------|----------|-----------|
| API REST | `TConnectionMiddleware.OnBeforeRouting` ([api.core.middleware.pas:68](../../../padra_atualizado/Services/Core/api/core/api.core.middleware.pas)); limpeza em `OnAfterRouting` (`:55`), junto do `EndThreadConnection` que já está lá | `REST <VERBO> <rota>` | body + query string |
| Worker | `TWorkerServerBase.ProcessTask` ([Services.Core.Worker.pas:2129](../../../padra_atualizado/Services/Core/Services.Core.Worker.pas)), junto de `pDefinirUsuario` e `pDefinirTarefa` — que já estabelecem contexto de tarefa naquele exato ponto (`:2111` e `:2116`) | `WORKER <SERVIC>.<METHOD> id=<autoincrem>` | coluna `<prefixo>_PARAMS`, o mesmo JSON entregue ao método |
| Daemon/monitor | `Services.Core.Task.Monitor.pas` | `MONITOR <nome>` | argumentos de linha de comando |
| Gatilho | `Services/GatilhosInformacao/.../untGatilhos.pas` | `GATILHO <identificação>` | configuração do gatilho |

Entry point que não preencher: a linha simplesmente não sai. Não é erro.

O `id=<autoincrem>` na `Origem` do worker não é enfeite: ele leva à linha da tabela de tarefas, onde o `_PARAMS` está inteiro. É a saída quando o `Payload` do log vier truncado.

**Ler o body no `OnBeforeRouting` não pode consumir o stream da requisição** — se consumir, o controller recebe body vazio e a alteração quebra todos os endpoints. Verificar o comportamento do `AContext.Request.Body` do DMVC neste ponto antes de implementar; se ele não for relido com segurança, mover a captura para `OnBeforeControllerAction` ([api.core.middleware.pas:62](../../../padra_atualizado/Services/Core/api/core/api.core.middleware.pas)), que hoje está vazio e roda depois do parse.

---

## 5. Regras invioláveis

1. **Montar o contexto não pode tocar no banco.** Nenhum `fCampoTabela`, `fTabelaExiste`, query ou abertura de conexão. O erro mais comum a logar é justamente falha de banco.
2. **Montar o contexto não pode falhar.** Todo o bloco dentro de `try/except` que engole a exceção — um erro ao logar um erro apaga o erro original. Falhou a montagem, grava-se o `LOG_RELERR` como era antes.
3. **Nunca gravar credencial.** O `Password` do `ConnectionParams` nunca entra. No `Payload`, a máscara de 3.5 é aplicada **antes** de qualquer gravação — não depois, não opcionalmente.
4. **Sem alteração de schema.** Nenhuma coluna nova em `LOGERR`.
5. **Windows não muda.** Callback não atribuída ⇒ comportamento byte a byte igual ao de hoje.
6. **Tudo tem teto.** `Payload` truncado em 8192 caracteres; o bloco inteiro, incluindo o `Payload` já truncado, em 12288 caracteres. Corte sempre com marca explícita, nunca silencioso.
7. **`const` em parâmetro não alterado**, conforme padrão do projeto.

---

## 6. Pontos de código impactados

| Arquivo | Alteração |
|---------|-----------|
| `padra_atualizado/fontes/genericos/untTypesSistema.pas` | Declarar o tipo da callback e a global `VS_fGetContextoExecucao`; zerá-la junto das demais (`:7470`) |
| `padra_atualizado/fontes/genericos/untDBUtils.pas` | Em `TDBUtils.pGravarLogErr` (`:576`), prefixar `strRelatorio` com o retorno da callback, sob `try/except` |
| `padra_atualizado/Services/Core/Services.Core.ContextoExecucao.pas` — **nova** | Montagem do bloco + `threadvar` da origem + captura única do host na subida; atribuição da callback |
| `padra_atualizado/Services/Core/api/core/api.core.middleware.pas` | Preencher origem em `OnBeforeRouting` (`:68`), limpar em `OnAfterRouting` (`:55`) |
| `padra_atualizado/Services/Core/Services.Core.Worker.pas` | Preencher origem com o nome da task |
| `padra_atualizado/Services/Core/Services.Core.Task.Monitor.pas` | Preencher origem com o nome do monitor |
| `padra_atualizado/Services/GatilhosInformacao/Target/Linux/MonitorarGatilhos/untGatilhos.pas` | Preencher origem com a identificação do gatilho |

Unit nova exige `svn add`.

---

## 7. Critérios de aceitação

1. Erro gravado por serviço REST Linux produz `LOG_RELERR` não nulo, contendo executável, módulo, host, PID/thread, banco com servidor e porta, empresa, operador e `Origem` com verbo e rota.
2. Erro gravado por worker, monitor ou gatilho produz o mesmo bloco, com a `Origem` correspondente. Ausência de `Origem` não impede o restante.
3. Nenhuma consulta adicional ao banco é emitida pela montagem do contexto — verificável com `general_log` ligado ou pelo próprio log de queries.
4. Erro cuja causa é falha de conexão com **outro** host — o caso que originou este trabalho — é gravado normalmente pela conexão de log, e o bloco traz o `Server:Port` configurado do processo, permitindo confrontá-lo com o host que aparece na mensagem do driver. Se a própria conexão de log estiver fora, nada é gravado, como hoje: a alteração não cria caminho de persistência novo.
5. Falha proposital dentro da montagem do contexto não impede a gravação do erro original.
6. `Password` não aparece em nenhum `LOG_RELERR`. Payload contendo `senha`, `token`, `authorization` ou congêneres de 3.5 é gravado com o valor substituído por `***` — chave visível, valor não.
7. Desktop Windows: `LOG_RELERR` idêntico ao de antes da alteração.
8. Relatório passado pelo chamador continua presente e legível depois do bloco — validado no faturamento automático, que já preenche o `LOG_RELERR`.
9. `Payload` acima de 8192 caracteres e bloco acima de 12288 são truncados com marca visível.
10. Ler o `Payload` na API **não** altera o comportamento de nenhum endpoint — o controller continua recebendo o body íntegro. Verificável rodando a suíte de testes REST existente sem regressão.

---

## 8. Casos a cobrir — entrega do implementador

Os **casos** de teste são escritos por analista humano; abaixo está a lista que a implementação entrega como contrato, derivada dos critérios acima.

| # | Caso | Verificação |
|---|------|-------------|
| 1 | Erro em endpoint REST | bloco presente, `Origem = REST <verbo> <rota>`, `Payload` com body + query string |
| 2 | Erro em worker | `Origem = WORKER <servic>.<method> id=<n>`, `Payload` com o JSON de `_PARAMS` |
| 3 | Erro em monitor/daemon | `Origem = MONITOR <nome>`, `Argumentos` e `Payload` preenchidos |
| 4 | Erro em gatilho de informação | `Origem = GATILHO <id>`, `Payload` com a configuração |
| 5 | Erro sem entry point registrado | bloco presente, sem `Origem` nem `Payload` |
| 6 | Erro de conexão com o banco | bloco traz `Server:Port` configurado; nenhuma query extra |
| 7 | Montagem do contexto lança exceção | erro original gravado, sem bloco |
| 8 | Chamador já passa relatório | bloco + relatório do chamador, nessa ordem |
| 9 | `Payload` > 8192 caracteres; bloco > 12288 | truncados com marca |
| 10 | Execução Windows | `LOG_RELERR` inalterado |
| 11 | Body com `senha`, `token`, `Authorization` | chaves visíveis, valores `***` |
| 12 | Endpoint com body grande, sem erro | controller recebe body íntegro; suíte REST sem regressão |

---

## 9. A verificar empiricamente — não presumir

**`GetModuleName(HInstance)` pode degenerar.** `HInstance` é resolvido por módulo em tempo de compilação. Se `untDBUtils` estiver estaticamente ligado dentro de cada `.so` — padrão das DLLs do projeto, com `ShareMem` e `pIniciaDllFuncoes` — o valor identifica a `.so` de verdade. Se o build usar runtime packages, e o deploy copia `bplShared*.so`, `bplNFe*.so` e `bplrtl260.so` ([FaturamentoServicesAPI.dproj:196-199](../../../padra_atualizado/Services/Faturamento.Services.API/Target/Linux/FaturamentoServicesAPI.dproj)), `untDBUtils` mora numa única `.so` compartilhada e o campo vira constante — sempre o mesmo, independente de quem errou.

Custa uma linha e não atrapalha em nenhum dos dois casos, então entra. Mas **conferir o valor no primeiro log gravado em ambiente real** antes de tratá-lo como confiável. Se vier constante, registrar isso aqui — não remover em silêncio.

**Confirmado por leitura de código, não presumido:** `System.SysUtils.GetModuleName(HInstance)` compila e roda em Linux nesta base ([Services.Core.Task.Monitor.pas:120](../../../padra_atualizado/Services/Core/Services.Core.Task.Monitor.pas)), na mesma rotina que já monta os argumentos com `ParamStr(1..ParamCount)`.

---

## 10. Riscos

| Risco | Mitigação |
|-------|-----------|
| Volume do `LOG_RELERR` cresce em toda base | Tetos de 8192 (payload) e 12288 (bloco) caracteres; só grava quando já há erro — a frequência de escrita não muda. Ainda assim é o maior risco desta spec: com o `Payload` dentro, o `LOG_RELERR` pode crescer uma ordem de grandeza em base com robô errando em laço |
| Dado pessoal de cliente no `LOGERR` | **Risco aceito explicitamente pelo João em 16/09/2026** (ver 3.5). A máscara cobre credencial, não cobre CPF, e-mail e endereço |
| Captura do body quebra endpoints por consumir o stream | Critério 12 e a verificação exigida em 4.2 antes de implementar |
| `threadvar` não limpa vaza contexto de uma requisição para a seguinte na mesma thread | Limpeza em `OnAfterRouting`, mesmo ponto do `EndThreadConnection` já existente; caso 5 cobre a ausência |
| Erro fora de qualquer entry point (inicialização, shutdown) | Camada ambiente funciona sozinha; só a `Origem` falta |
| `Password` vazar por descuido ao montar o `Banco` | Critério 6 e regra 3; montar campo a campo, nunca o record inteiro |

---

## 11. Implementado em 16/09/2026 — o que divergiu da spec

Quatro desvios. Os três primeiros foram forçados pelo código; o quarto resolveu por leitura uma incógnita que a spec tinha deixado para runtime.

### 11.1 Não há unit nova — o código mora no `Services.Core.Utils`

A seção 3.3 dizia que o `class var` evitaria tocar em `.dpr`. **Estava errado.** A pasta `Services/Core` não está no caminho de busca dos projetos: cada unit dela é resolvida por cláusula `in '..\..\..\Core\*.pas'` explícita, arquivo por arquivo, em cada `.dpr` — ver `FaturamentoServicesAPI.dpr:40-51`. A unit nova falhou o build com `F2613 Unit 'Services.Core.ContextoExecucao' not found` e só compilaria depois de uma linha acrescentada nos 38 `.dpr`.

O código foi para `Services.Core.Utils`, que já está em todos eles e já abriga `GetComputerNetName`, `GetCurrentProcessId`, `GetCurrentThreadId` e `fTime` — os vizinhos diretos do que o bloco monta. Custo: o contexto vive dentro de uma unit de 4.700 linhas em vez de uma própria. Benefício: zero churn em `.dpr`/`.dproj`.

Nomes ficaram prefixados para não colidir na unit grande: `pDefinirOrigemExecucao`, `pLimparOrigemExecucao`, `fMontarContextoExecucao`.

### 11.2 O `class var` continua válido, e ganhou um segundo motivo

`TDBUtils.fGetContextoExecucao` existe só no ramo `{$IFDEF LINUX}` e é atribuído no `initialization` de `Services.Core.Connection.Manager`. Continua sendo a inversão certa: `untDBUtils` é compartilhado com o Windows, e o campo ausente no ramo `{$ELSE}` torna impossível — não improvável — que o desktop mude.

### 11.3 A tarefa do gatilho foi cancelada: estava no processo errado

A seção 4.2 mandava instrumentar `untGatilhos.pas` do `MonitorarGatilhos`. **Aquele processo não grava no `LOGERR`.** Ele tem cópia local de `untDBUtils` — `GatilhosInformacaoMonitor.dpr` faz `untDBUtils in 'untDBUtils.pas'`, arquivo da própria pasta —, e essa cópia não tem `pGravarLogErr`. O monitor apenas **lê** o `LOGERR`, em `untGatilhos.pas:916`.

Quem grava é o binário `GatilhosInformacao`, disparado por `ShellExecute`. Esse usa o `untDBUtils` real e o `Services.Core` inteiro, e roda sob `TTaskMonitor` (`untExecutarGatilhos.pas:149`) — portanto **já é coberto pela camada de ambiente mais a origem `MONITOR`**, sem uma linha a mais. O caso 4 da seção 8 passa a ser verificado por ali, com `Origem : MONITOR`, não `GATILHO`.

### 11.4 Ler o body no `OnBeforeRouting` é seguro — resolvido por leitura, não por experimento

A spec exigia verificar em execução se ler `AContext.Request.Body` consome o stream. A fonte responde: `TMVCWebRequest.Body` (`MVCFramework.pas:1438-1474`) memoiza em `FBody` e, no ramo `BERLINORBETTER`, lê por `ReadTotalContent` + `RawContent`, não por `ReadClient`. O define vale para `CompilerVersion >= 31` e este build usa Studio 20.0 — Delphi 10.3 Rio, versão 33. A captura ficou no `OnBeforeRouting`.

### 11.5 Prefixar o `LOG_RELERR` não quebra consumidor — auditado

Varredura em `fontes`, `Services` e `Monitors`. Os consumidores são:

| Consumidor | Por que o prefixo não afeta |
|------------|------------------------------|
| `untGatilhos.pas:916` | `LIKE "%GATILHOS_INFORMACAO%GATINF=..."` — curinga dos dois lados, continua casando |
| `Shared.Core.pas:733`, `untFuncoesSimples.pas:56272` e irmãos | Leem `LOGERR_AUDIT`, tabela diferente, e só exibem as linhas |
| `FulFillment.Classes.pas:118` | `{$IFNDEF LINUX}`, e escreve noutra tabela |

Nenhum faz parse posicional nem `LIKE` ancorado. Se algum dia alguém escrever um, é aqui que a decisão de prefixar está registrada.

---

## 12. Fulfillment — o que ganha e o que não ganha

Levantado em 16/09/2026, por pergunta do João. A spec original afirmava que a camada de ambiente cobria o fulfillment "de uma vez". **Não cobre**, e a afirmação foi corrigida na seção 2.

### 12.1 O que os binários são

| Projeto | Como roda | Publica origem? |
|---------|-----------|-----------------|
| `Services/Fulfillment.EnvFit/Target/Linux/Fulfillment_EnvFit.dpr` | Processo de execução única por linha de comando: `ParamStr(1)` = empresa, `ParamStr(2)` = complemento do lock. Sem `TTaskMonitor`, sem REST, sem worker | Não |
| `Services/Fulfillment.Services/Target/Linux/FulfillmentServices.dpr` | Idem quanto a entry point instrumentado | Não |

Ambos linkam o `untDBUtils` **real** (`..\..\..\..\fontes\genericos\untDBUtils.pas`), o `Services.Core.Utils` e o `Services.Core.Connection.Manager` — portanto o `initialization` que atribui o callback roda, e o `class var` está preenchido.

### 12.2 O que ganha

Todo erro que chegue ao `TDBUtils.pGravarLogErr` — tipicamente falha de infraestrutura vinda do próprio `untDBUtils` ou do `Services.Core` — recebe o bloco completo de ambiente. Sem `Origem` nem `Payload`, porque nenhum dos dois binários publica; é o caso 5 da seção 8, e está correto assim.

Para o `EnvFit` isso já rende bastante: `Executavel` diz qual robô, `Argumentos` traz empresa e lock, e `Empresa` vem preenchida pelo `pSetaEmpresaLogada(ParamStr(1))` do próprio `.dpr`.

### 12.3 O que NÃO ganha, e é o principal

**O log de negócio do fulfillment não passa pelo `pGravarLogErr`.** Ele tem repositório próprio: `TFulFillmentLogRepositorio.pSalvarLog` ([FulFillment.Classes.pas:95](../../../padra_atualizado/fontes/util/FulFillment.Classes.pas)) faz `SELECT * FROM FULL_LOGERR WHERE FALSE` + `Insert`, um gravador paralelo ao do `LOGERR`. Nada do que foi implementado toca nele.

E lá o problema é pior do que no `LOGERR`: o preenchimento do `LOG_RELERR` está dentro de `{$IFNDEF LINUX}` ([FulFillment.Classes.pas:115-122](../../../padra_atualizado/fontes/util/FulFillment.Classes.pas)), alimentado por `VS_CallStackFulfillment`. **No Linux a coluna é sempre NULL, por construção** — mesmo sintoma que originou este trabalho, numa segunda tabela, só que ali excluído de propósito por diretiva de compilação.

### 12.4 O que falta fazer, se for para cobrir

**Implementado em 16/09/2026**, aprovado pelo João na sequência do levantamento. Ver 12.5.

O conserto é pequeno e simétrico ao que já foi feito: no `pSalvarLog`, sob `{$IFDEF LINUX}`, prefixar `LOG_RELERR` com `Services.Core.Utils.fMontarContextoExecucao`, do mesmo jeito que o `pGravarLogErr` faz. As mesmas regras da seção 5 valem sem alteração, e a coluna já existe na tabela — o código atual só a preenche no Windows.

Ganho adicional barato, se for mexer ali: publicar `pDefinirOrigemExecucao` no início do `.dpr` do `EnvFit`, com o documento em processamento, daria `Origem` e `Payload` a um robô que hoje só teria ambiente.

### 12.5 Implementado

Duas edições, ambas compiladas.

**`FULL_LOGERR` passa a receber o bloco.** Em `pSalvarLog` ([FulFillment.Classes.pas:115](../../../padra_atualizado/fontes/util/FulFillment.Classes.pas)), o `{$IFNDEF LINUX}` que preenchia o `LOG_RELERR` com `VS_CallStackFulfillment` ganhou um `{$ELSE}`: no Linux a coluna recebe `Services.Core.Utils.fMontarContextoExecucao`. Windows segue idêntico. A chamada é direta, sem `uses` novo — sob `{$IFDEF LINUX}` a unit já inclui o Core inteiro pelo `services.core.uses.inc`.

**O `EnvFit` passa a ter `Origem`.** No `.dpr` ([Fulfillment_EnvFit.dpr](../../../padra_atualizado/Services/Fulfillment.EnvFit/Target/Linux/Fulfillment_EnvFit.dpr)), logo após o `pIniciarConexao`, um `pDefinirOrigemExecucao('FULFILLMENT EnvFit empresa=<codemp>', 'lock=<chave>')`. Definido uma vez e válido até o fim: o laço roda a integração inteira no mesmo processo, então não há o que limpar entre iterações — e por isso **não** há `pLimparOrigemExecucao` aqui, ao contrário dos demais entry points.

Origem por documento foi descartada: `pSalvarLog` já grava `LOG_NUMDOC`, `LOG_ESPDOC` e `LOG_SERIE_` em colunas próprias. Repetir o documento no bloco seria redundância, não informação.

**Builds:** `Fulfillment_EnvFit` ok — exercita as duas edições. `FaturamentoServicesAPI` ok, regressão do `FulFillment.Classes.pas`, que é compartilhado. `FulfillmentServices` falha em `untMovGer.pas:11` por `untTBatchSQL.Helper` ausente do `.dpr`; a unit existe em `fontes/genericos/BatchSQL/` e o `untMovGer.pas` não foi tocado — quebra **pré-existente**, mesmo padrão do `GatilhosInformacao`, e os dois estão fora do conjunto que a CI compila.

**Armadilha registrada:** a primeira versão do comentário no `pSalvarLog` continha `{$IFNDEF LINUX}` dentro de um comentário `{ }`. Comentário Pascal **não aninha** — o primeiro `}` fechou o comentário e o resto virou código, com treze erros em cascata a partir da linha 125. Ao citar diretiva de compilação dentro de comentário, escrever sem as chaves.

---

## 13. Correção de 16/09/2026 — máscara saiu do caminho quente

Defeito da primeira implementação, achado antes do deploy e corrigido.

`pDefinirOrigemExecucao` roda em **toda** requisição, worker e iteração de daemon. A versão original aplicava ali a máscara de 3.5 — 11 chaves × 2 `TRegEx.Replace` = 22 passadas sobre o payload inteiro, por requisição, para um dado que na esmagadora maioria dos casos é descartado sem nunca ser lido.

Agora o par é assimétrico, e de propósito:

| Operação | Onde | Por quê |
|----------|------|---------|
| Truncar | `pDefinirOrigemExecucao`, no caminho quente | Barato, e limita o que a `threadvar` segura em memória por thread |
| Mascarar | `fMontarContextoExecucao`, só quando há erro a gravar | Caro, e só o resultado gravado precisa estar mascarado |

A garantia da regra 3 não muda: nada mascarado sai do processo, porque o único ponto que publica o payload é o próprio `fMontarContextoExecucao`. O que muda é que o valor cru fica na `threadvar` até ser lido ou limpo — dentro do mesmo processo que já tinha o body inteiro em memória.

---

## 14. Primeiro deploy em produção — 16/09/2026, PALACIO_FERRAMENTAS

Cliente `PALACIO_FERRAMENTAS_..._MM_SLAVE_LOCAL`, base `AUTCOM` em 189.112.114.109:53306, MySQL 8.0.46. Bloco observado no `FULL_LOGERR` real:

```
========== CONTEXTO DE EXECUCAO ==========
Executavel : FulfillmentServices (./FulfillmentServices)
Modulo     : FulfillmentServices
Argumentos : 010 MLB -CANAL_01 --logsactive -f
Host       : srvServicos
PID/Thread : 4062661 / 2856749120
Banco      : :0/ (usuario: rb_fulfillment)
```

### 14.1 A incógnita da seção 9 está FECHADA

`Modulo` veio **igual** ao `Executavel`, não constante de runtime package. O `FulfillmentServices` é estaticamente ligado, e o campo identifica o binário de verdade. Não degenerou.

Bônus não previsto: uma das linhas trouxe `FulfillmentServices (deleted)` — processo antigo ainda vivo com o binário já substituído por um deploy em andamento. O campo detecta binário trocado sob processo rodando.

`Argumentos` entregou `010 MLB -CANAL_01 --logsactive -f`, que é exatamente o que distingue os processos `robo_importacao<empresa>_canal_<n>`. Era o objetivo do trabalho e funcionou.

### 14.2 Defeito: `Banco` saía vazio — corrigido

`Banco : :0/` — servidor, porta e base em branco.

Causa: eu lia `TConnectionsManager.ConnectionParams`, que são os parâmetros **declarados**. Serviço que chama só `pSetUsuarioConexaoFulfillment` declara apenas usuário e senha; servidor, porta e base são resolvidos dentro do `NewConnection` pela cadeia `NUMIP=` / `opcoes.ini` e vivem **só no objeto de conexão**, nunca voltam ao record.

Consequência: o único campo que existia para responder *qual configuração aponta para o host que falhou* era o único que não respondia.

Corrigido com `fDescreverBancoContexto`, que repete a mesma ordem do `TConnectionsManager.NewConnection`: conexão viva da thread (via `FindConnection`, consulta a dicionário em memória — não abre conexão, não viola a regra 1) → `ConnectionParams` → `NUMIP=` → `opcoes.ini`.

### 14.3 Defeito: o caminho sem documento não tinha bloco — corrigido

Só as linhas `Erro ao gravar o documento` traziam `RELERR`. As linhas `EUniError: Cannot connect to server on host '192.168.0.1'` vinham nulas, porque saem por `TFulFillmentLogRepositorio.pSalvaLogAvulso` ([FulFillment.Classes.pas:146](../../../padra_atualizado/fontes/util/FulFillment.Classes.pas)), que **não preenchia `LOG_RELERR` em sistema operacional nenhum**.

Era a metade mais difícil de diagnosticar, e era a cega. O `pSalvaLogAvulso` passou a receber o bloco sob `{$IFDEF LINUX}`, igual ao `pSalvarLog` irmão.

### 14.4 Contexto operacional do cliente

845 linhas no `FULL_LOGERR`, todas do dia — a tabela é limpa periodicamente. Os erros alternam entre o timeout de conexão e `Erro ao gravar o documento`, em empresas 001, 010 e 201, a cada um ou dois minutos.

O `192.168.0.1` **não vem de dado**: `EMPLOJ` do cliente tem o IP correto (189.112.114.109). Está no `opcoes.ini` do robô de fulfillment — confirmado pelo João. E `Argumentos` mostra que não há `NUMIP=` na linha de comando, o que é coerente: a cadeia cai no ini.

Diagnóstico em aberto: o binário do cliente é **anterior à r493381** (05/09/2026, Req. 460534), que trocou uma conexão nova por autoincremento — dezenas por documento — por uma conexão reaproveitada por thread. O comentário daquela revisão descreve o sintoma `Cannot connect to server` como consequência direta da churn que ela corrigiu. A atualização está em curso; se o erro cessar, foi isso.
