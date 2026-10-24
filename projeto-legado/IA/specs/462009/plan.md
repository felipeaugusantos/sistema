# Impressão do pedido no faturamento pelo coletor — Plano de implementação

> **Para agentes:** executar tarefa a tarefa (superpowers:executing-plans ou subagent-driven-development). Passos com `- [ ]`.

**Objetivo:** `POST /api/faturamento/faturarpedidos` passa a aceitar `imprimirPedido`/`pontoImpressaoPedido` e, com `true`, enfileira na SPOIMP o PDF de cada pedido do request, em segundo plano.

**Arquitetura:** quarta impressão pós-faturamento em `Faturamento.Services.Faturamento.pas`, no molde exato do FF (`pDispararImpressaoFF` + `TThreadImprimirFF`). O PDF vem de `TPedidoService.fPedidoGerarPdf`, o mesmo do `GET /pedido/.../pdf`. Teste num método novo da suíte, com espera própria pela linha na SPOIMP, para não alterar o assert dos 42 casos de `FaturarPedidosTest`.

**Stack:** Delphi Seattle, DMVCFramework, Linux (PAServer/`ci.py`), MySQL; suíte DUnitX `FaturamentoServicesTEST`.

**Spec:** `IA\specs\462009\spec.md` (aprovada em 16/10/2026).

## Restrições globais

- Zona Moderna. Sem `Now` (usar `fNow`), sem `StrToFloat`, sem nada da lista do pre-commit.
- **Os dois `.pas` alterados são cp1252 com acento:** nunca Edit/Write. Usar `python .claude\scripts\fonte_delphi.py conferir|substituir` (regra 9 da citel-devRequisito). Conferir com `svn diff | wc -l` depois.
- `const` em parâmetro não alterado. Comentário só onde diz o porquê, sem narrar a mudança nem citar o número do requisito em identificador.
- Nenhuma rota nova, e `fFaturarPedidos` já despacha ao worker (`AddMethod('TFaturamentoService.fFaturarPedidos', ...)`), então `IA\rules\services-workers.md` está atendida.
- Sem commit: o commit é do João, pelo DelphAI. **Só a `.150`**: API e robôs Linux saem dela, então não há porte.
- Teste-primeiro não se aplica (decisão de 30/09/2026): os casos saem dos critérios de aceitação e são escritos junto com a implementação.

## Fatos medidos (16/10/2026, base de CI `2_30_BELAT_TC`:53307, profile `apiteste`)

- O `BodyAs` do DMVC ignora chave desconhecida, e o risco de ordem de implantação está descartado.
- A SPOIMP da CI recebe hoje linhas `TThreadImprimirFF` e `TThreadImprimirEtiquetaDespacho` da empresa 069, com **`SPO_PONIMP` e `SPO_NOMIMP` vazios**. O ponto `004` não existe na PONIMP. **Não congelar `SPO_PONIMP` no assert.**
- `fRetornaNomeImpressora` devolve o próprio nome quando não acha o ponto, então só o ponto vazio impede a impressão.
- Maior id de caso: **1337**. Reconferir na hora de inserir, porque outra sessão pode ter usado.

## Foco de revisão

1. **Pedido de outra empresa (o 1168: pedido da 068 faturado na 069).** `fPedidoGerarPdf` recebe `empresa = '068'` e o `FatImpressao` roda com `VS_strCodEmp = '069'`. Se o PDF não sair por layout da 068, a folha não imprime. O caso positivo é exatamente esse cenário, então ele prova o comportamento.
2. **Dois pedidos no mesmo request.** Uma thread por pedido, cada uma com o seu PDF (o nome do arquivo é `<doc>_<esp>_<emp>.pdf`, sem colisão). Coberto pela regra "uma linha por pedido" do assert, que itera `pedidos[]`.
3. **Faturamento que levanta exceção.** Nada é disparado, porque a chamada fica depois do `Execute`. Coberto pelos 42 casos existentes, que continuam verdes (nenhum manda `imprimirPedido`).
4. **`fPedidoGerarPdf` com `sucesso = False` ou exceção** (timeout de 30 s, pedido inexistente). A thread registra e sai, sem derrubar o worker. Validação por leitura do código na revisão; não há como provocar na CI sem quebrar o ambiente.
5. **Execução repetida do caso.** O `sql_before` apaga as linhas `TThreadImprimirPedido` do pedido, senão o positivo passa com a linha da execução anterior e o negativo reprova.

---

### Tarefa 1: contrato — dois campos no DTO

**Arquivos:**
- Modificar: `padra_atualizado/Services/Core/faturamento/services/types/Faturamento.Services.Faturamento.Types.pas` (`TSolicitacaoFaturamentoPedidosParams`, ~linha 142)

**Produz:** `property imprimirPedido: Boolean` e `property pontoImpressaoPedido: string` em `TSolicitacaoFaturamentoPedidosParams`.

- [ ] **Passo 1:** `fonte_delphi.py conferir` no arquivo e anotar encoding e EOL.
- [ ] **Passo 2:** adicionar os campos privados `FimprimirPedido: Boolean` e `FpontoImpressaoPedido: string`, e as propriedades publicadas logo depois de `pontoImpressaoBoleto`, cada uma com `MVCSwagJsonSchemaField`:
  - `imprimirPedido`: `stBoolean`, descrição "Imprimir o pedido de venda de cada pedido faturado, no ponto pontoImpressaoPedido, após o faturamento".
  - `pontoImpressaoPedido`: `stString`, descrição "Ponto de impressão do pedido de venda (PON_NOMPON de PONIMP). Vazio: não imprime".
  - Não mexer no construtor: `False` e `''` são os defaults de campo.
- [ ] **Passo 3:** `svn diff` do arquivo: só as linhas novas, sem mojibake e sem EOL trocado.

### Tarefa 2: impressão do pedido pós-faturamento

**Arquivos:**
- Modificar: `padra_atualizado/Services/Core/faturamento/services/Faturamento.Services.Faturamento.pas`. Thread e procedure novas entre `pDispararImpressaoFF` (~561) e `{ TPedidoService }`; a chamada em `TFaturamentoService.fFaturarPedidos` (~644).

**Consome:** Tarefa 1. `TPedidoService.fPedidoGerarPdf(Pedido: TPedidoGerarPdfParams): TPedidoGerarPdfResult` (`Faturamento.Services.Pedido.pas:1214`), que já está no `uses`? Conferir; se não estiver, incluir `Faturamento.Services.Pedido` no `uses` da implementation.

**Produz:**
- `TThreadImprimirPedido = class(TThread)`, com `constructor Create(const ANumero, AEspecie, AEmpresa, APontoImp: string)` e os campos `FNumero`, `FEspecie`, `FEmpresa`, `FPontoImp`, `FOperador`.
- `procedure pDispararImpressaoPedido(AParams: TSolicitacaoFaturamentoPedidosParams)`.

- [ ] **Passo 1:** `TThreadImprimirPedido`, espelhando `TThreadImprimirFF`. Construtor `inherited Create(True)`, `FreeOnTerminate := True`, `FOperador := strLoginUsuarioLogado`, `Start`. `Execute`:
  - `BeginThreadConnection`; `fAssumirOperadorDaRequest(FOperador, 'TThreadImprimirPedido')`.
  - Precondições, saindo calado: `FPontoImp` vazio, `not fCfgSis('SPOIMP', varBoolean)`, `FatImpressao` ausente.
  - `fPedidoGerarPdf` com documento, espécie e empresa do pedido. `sucesso = False`: `WriteLog('TThreadImprimirPedido: PDF nao gerado - ' + mensagem)` e sai.
  - Senão, `TSpoolImpressaoCitel.fEnviarPDFParaImpressao('TThreadImprimirPedido', 'Pedido ' + FNumero + FEspecie + FEmpresa, FPontoImp, LResult.arquivo)`.
  - `except on E: Exception do pMensagensErro(E.Message, 'TThreadImprimirPedido', False)`; no `finally`, `pLimparVariaveis` + `EndThreadConnection`. Liberar `LParams`/`LResult` em `try/finally`.
- [ ] **Passo 2:** `pDispararImpressaoPedido`: sai se `not AParams.imprimirPedido` ou se `AParams.pontoImpressaoPedido` estiver vazio. Resolve o ponto uma vez por `TLibNfe.fRetornaNomeImpressora` (igual a `pDispararImpressaoFF`). Para cada `TSolicitacaoFaturamentoPedido` de `AParams.pedidos`, `TThreadImprimirPedido.Create(numeroPedido, especie, empresa, LPontoImp)`.
- [ ] **Passo 3:** em `fFaturarPedidos`, chamar `pDispararImpressaoPedido(AParams)` **depois** do `for` que monta o resultado e **antes** do `finally` de `LParFatList`. Comentário curto no ponto: uma folha por pedido do request, não por nota, porque um pedido pode virar mais de uma nota.
- [ ] **Passo 4:** `svn diff` do arquivo, como na Tarefa 1.
- [ ] **Passo 5 — Você:** compilar e implantar a API local (Linux) pelo `ci.py`, um build por vez. Esperado: compila sem hint novo no arquivo.

### Tarefa 3: assert de impressão na suíte

**Arquivos:**
- Banco `apiteste`: procedure `pProcessoImpressaoPedidoResponse`, depois exportada para `padra_atualizado/Services/Faturamento.Services.API/Scripts/testes/002_INFRA_PROCEDURES.sql` pelo `exportar_casos.py --procedures`.
- Criar: `padra_atualizado/Services/Faturamento.Services.API/Target/Linux/Test_Cases/faturamento/FaturarPedidosImprimirTest.inc`
- Modificar: `padra_atualizado/Services/Faturamento.Services.API/Source/api/controller/api.controller.faturamento.test.pas`

**Produz:**
- Procedure `pProcessoImpressaoPedidoResponse(IN strNumDoc CHAR(12), IN strEspDoc CHAR(2), IN strCodEmp CHAR(3), OUT RETORNOJSON LONGTEXT)`. Devolve `{"SPOIMP":[...], "RESUMO":{"QTD_SPOIMP":"<n>"}}`. O bloco SPOIMP vem por `pTesteMontarJsonTabela('SPOIMP', <filtro>, @out)` com filtro `SPO_NOMPRO = 'TThreadImprimirPedido' AND SPO_DESPRO = CONCAT('Pedido ', strNumDoc, strEspDoc, strCodEmp)`. O `RESUMO` traz a contagem, que é o teto (o array só prova piso). Marcador `-- VERSAO_PROCEDURE: 1`.
- Método `FaturarPedidosImprimirTest(ATestID: Integer)` e o assert `AssertFaturarPedidosImprimirResponseDTO` (assinatura dos irmãos).

- [ ] **Passo 1:** criar a procedure na base `apiteste` (escrita: `citel-conectarBanco`, modo master com token, com autorização do João) e exportar.
- [ ] **Passo 2:** `AssertFaturarPedidosImprimirResponseDTO`:
  1. `CompareJson` da resposta, como em `AssertFaturarPedidosResponseDTO`.
  2. Sai se `AJsonValidate` estiver vazio.
  3. Lê `AjsonRequest` como `TSolicitacaoFaturamentoPedidosParams`.
  4. Para cada pedido, faz polling até **20 s** (1 s por volta) em `SELECT COUNT(0) FROM SPOIMP WHERE SPO_NOMPRO = 'TThreadImprimirPedido' AND SPO_DESPRO = :desc`, e para assim que achar ≥ 1. Com `imprimirPedido` falso ou ponto vazio, espera o tempo inteiro, porque o negativo precisa dar à thread a chance de errar.
  5. `CALL pProcessoImpressaoPedidoResponse` e `CompareJson` contra `AJsonValidate`.
  - Medir a duração com `TStopwatch`. Wall clock em espera de teste não grava dado (exceção do `Now` no CLAUDE.md).
- [ ] **Passo 3:** declarar o método com `[Test]` e `{$I '.\Test_Cases\faturamento\FaturarPedidosImprimirTest.inc'}`, no padrão das outras, e o corpo com `RunPostMethodTest(api_faturamento_faturar_pedidos, TestRunPrefix('FaturarPedidosImprimirTest'), ATestID, AssertFaturarPedidosImprimirResponseDTO)`.

### Tarefa 4: casos de teste

**Arquivos:** três `.sql` em `padra_atualizado/Services/Faturamento.Services.API/Scripts/testes/casos/` (ids a partir de 1338, reconferidos), as linhas na tabela `faturamento_services_api_test` da base `apiteste` e o `FaturarPedidosImprimirTest.inc`. Cada caso = `.sql` + `.inc` + método.

Base comum: copiar o 1168 (request, response e `sql_before`), acrescentando ao `sql_before` `DELETE FROM SPOIMP WHERE SPO_NOMPRO = 'TThreadImprimirPedido' AND SPO_DESPRO = 'Pedido 000000000004PD068';`.

| id | test_case | request (sobre o 1168) | json_validate |
|---|---|---|---|
| 1338 | `TEST_FATURAR_PD_IMPRIMIR_EMP_069_01` | `"imprimirPedido": true, "pontoImpressaoPedido": "004"` | `{"SPOIMP":[{"SPO_CODEMP":"069","SPO_NOMPRO":"TThreadImprimirPedido","SPO_DESPRO":"Pedido 000000000004PD068","SPO_NOMARQ":"000000000004_PD_068.pdf","AUTOINCREM":"NOT_EMPTY","SPO_DTAINC":"NOT_EMPTY"}],"RESUMO":{"QTD_SPOIMP":"1"}}` |
| 1339 | `TEST_FATURAR_PD_IMPRIMIR_EMP_069_02` | `"imprimirPedido": false, "pontoImpressaoPedido": "004"` | `{"RESUMO":{"QTD_SPOIMP":"0"}}` |
| 1340 | `TEST_FATURAR_PD_IMPRIMIR_EMP_069_03` | `"imprimirPedido": true, "pontoImpressaoPedido": ""` | `{"RESUMO":{"QTD_SPOIMP":"0"}}` |

- [ ] **Passo 1:** antes de fixar o json_validate do 1338, rodar uma vez e **ler a linha gravada** na SPOIMP (`SPO_NOMARQ`, `SPO_CODEMP`), sem derivar. Ajustar a tabela acima ao que foi gravado; se divergir do que a spec manda, parar e relatar.
- [ ] **Passo 2:** inserir os três casos na base (`exportar_casos.py` gera os `.sql`), validar cada `json_validate` com um parser JSON e rodar `validar_casos.py`.
- [ ] **Passo 3 — Você:** rodar na CI `FaturarPedidosImprimirTest` (3/3 verdes) e `FaturarPedidosTest` (42/42 verdes, sem regressão).
- [ ] **Passo 4:** atualizar `Scripts/testes/README.md` só na tabela de distribuição por `.inc`.

### Tarefa 5: entrega

- [ ] **Passo 1:** code review do diff (`code-review.md` da citel-devRequisito), depois o DelphAI, `Req. 462009`. O commit é do João.
- [ ] **Passo 2:** avisar o Rafael Casagrande para agendar o teste no cliente. Orientar o suporte a ligar na loja 008 a configuração do coletor criada no 463255 (o nome não está confirmado: a análise sugeriu `CFG_FAGIPD` e a conclusão não o cita; perguntar ao time do coletor) e conferir `CFG_SPOIMP` e o `FatImpressao` na API do cliente.
