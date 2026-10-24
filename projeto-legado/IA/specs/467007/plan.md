# Plano técnico — Req. 467007 (frete sugestão na API de Faturamento)

> **Para quem executa:** seguir tarefa a tarefa, marcando o `tasks.md`. O contrato e as regras estão no `spec.md`. Este plano diz **onde** e **com que assinatura**; o corpo é de quem implementa.

**Objetivo:** dois endpoints, `POST /pedido/calcular-frete-sugestao` e `POST /pedido/validar-frete`, que devolvem o frete que o Autcom sugeriria e se o frete escolhido exige liberação.

**Arquitetura:** a regra sai da `TFatVenda` (`untFuncFat.pas`, só Windows) e vai para a `TFatVendaBase`, que compila nas duas pontas. Na API, o `TSimularEmissaoService`, que já monta o pedido a partir do mesmo corpo, ganha dois métodos que chamam a regra. Os dois rodam no worker filho.

**Stack:** Delphi Seattle (VCL + Linux/DMVCFramework), UniDAC, MySQL. Suíte REST `FaturamentoServicesTEST`.

**Spec:** `IA\specs\467007\spec.md`

## Restrições globais

- Só a versão `02.30.74.150`.
- Encoding: os cinco arquivos tocados têm acento. `untFuncFat.pas`, `Faturamento.Classes.TFatVendaBase.pas`, `Faturamento.Services.Pedido.pas` e `Faturamento.Services.Pedido.Types.pas` são cp1252; `untFuncoesSimples.pas` é UTF-8 com BOM. Alterar **só** por `.claude\scripts\fonte_delphi.py` (`conferir` antes, `substituir` para alterar). **Nunca** Edit/Write.
- Comportamento do desktop **inalterado** (spec RF05): mover, não reescrever.
- Os dois métodos novos do worker: sobrecarga tipada com `fExecuteTask` **e** `AddMethod` (`IA\rules\services-workers.md`).
- `fNow()`, nunca `Now`. Mensagens e Swagger só com o que o código faz.
- Compilar Linux pelo `ci.py`, um build por vez. O desktop é compilado pelo João na IDE.

## Foco da revisão (o que nenhum teste unitário pega sozinho)

1. **Efeitos colaterais do desktop:** `fValidaFreteSugestao` recalcula para `strCodTra` e `strCodTraAnt` **antes** de decidir pelo `CFG_TRAFRE` (`untFuncFat.pas` ~6680). Isso sobrescreve `fltFreSug`, `fltFreSugCal`, `fltVlMinF` e `strRegFre`, que vão para o `FGO_FRESUG`. A refatoração deve manter essas chamadas na mesma ordem → Tarefa 2, passo de verificação do desktop.
2. **Tipo de frete na faixa:** o Sales manda o código (`1`); a função espera a descrição (`fDescricaoFrete`). Passar o código faz a faixa nunca casar e devolver 0 sem erro → caso de teste FRETRA=4 com tipo permitido (Tarefa 4).
3. **`valorFrete` do corpo contaminando a faixa** → caso "valorFrete preenchido, FRETRA=4" (Tarefa 4).
4. **Endereço de entrega:** se `enderecoEntregaID` não popular `enderecoEntrega.strCodCid`/`strCodReg`, o cálculo cai na cidade do cliente em silêncio → caso FRETRA=2 com endereço de entrega em cidade diferente da do cliente (Tarefa 4).
5. **Config `CFG_TXJCNI=2` + `CNDVEN=I`:** o `TSimularEmissaoService` recusa com 422 no construtor. Os endpoints de frete herdam isso, e é aceito: o total de produtos depende do juros. O controller trata 422 como o `SimularEmissao` (Tarefa 3).

---

### Tarefa 0: Linha de base do desktop (antes de tocar código)

Sem ela, o critério "o Autcom segue sugerindo o mesmo frete" não tem com o que comparar.

- [ ] Na base da suíte (`2_30_BELAT_TC`, 53307), escolher uma empresa e montar, só por consulta (`citel-conectarBanco`), os dados de cada modo: transportadora com linha em `FRETRA` para a cidade de entrega (modo 2, e com `FREFXP` se `CFG_FREFXP`), linha em `TRAREG` (modo 5), itens com `ITE_TIPFRE`/`ITE_VLCFRE` (modo 3), `TRA_CODFRG` com `CADFRG`/`CADFRD` (modo 4). Faltando dado, levar ao João o script de inserção, que ele aplica.
- [ ] **João:** no Autcom compilado **antes** da mudança, para cada `CFG_FRETRA` (1 a 5), montar o mesmo pedido, trocar a transportadora na tela de fechamento e anotar o valor carregado e o `FGO_FRESUG` gravado. Incluir um pedido isento e um só de retira com `CFG_ZERFRE=S`.
- [ ] Gravar a tabela (modo, pedido, cliente, endereço, itens, transportadora, tipo de frete → valor) na seção "Linha de base" do `tasks.md`. Essa tabela é o valor esperado dos casos da Tarefa 4.

### Tarefa 1: Mover o cálculo para a `TFatVendaBase`

**Arquivos:**
- Modificar `padra_atualizado/fontes/faturamento/untFuncFat.pas`:
  - remover as declarações de 506 (`fRetFreSugCal`), 629-633 (as três `fCalculaSugestaoFrete*`) e 635 (`pZeraFreteSugerido`);
  - remover as implementações de 6024-6067, 6291-6627, 9722-9729 e 13879-13896.
- Modificar `padra_atualizado/fontes/faturamento/Faturamento.Classes.TFatVendaBase.pas`: declarações públicas junto de `fRetornaFreteSugestaoCidadePeso` (~5319) e implementações junto dela (~40583).
- Modificar `padra_atualizado/fontes/genericos/untFuncoesSimples.pas`: remover `fRetPerDescFreteFaixaFat`/`fRetValIsencaoFreteFaixaFat` (4057-4058 e ~50449-50494). O único chamador é o código que se move.

**Interfaces produzidas** (mesmos nomes e assinaturas, agora em `TFatVendaBase`):
- `function fCalculaSugestaoFreteTransportadora(strCodTransp: String; blnCalcPeso: Boolean = False; blnRegiao: Boolean = False): Double;`
- `function fCalculaSugestaoFreteProdutos(strCodTransp: String; blnCalcPeso: Boolean = False): Double;`
- `function fCalculaSugestaoFreteFaixaFaturamento(Const strCodTransp, strTipFre: String): Double;`
- `function fRetFreSugCal: Double;`
- `procedure pZeraFreteSugerido;`
- privadas: `fRetPerDescFreteFaixaFat(const strCodTra, strCodCid: String; const fltValFat: Double): Double` e `fRetValIsencaoFreteFaixaFat(const strCodTra, strCodCid: String): Double`

- [ ] `fonte_delphi.py conferir` nos três arquivos.
- [ ] Listar o que os corpos usam e conferir que existe na `TFatVendaBase` ou em unit do `FaturamentoServicesAPI.dpr`. A revisão de 19/10 confirmou as dependências de cálculo. O que faltar vai ao João antes de duplicar.
- [ ] Mover os corpos **byte a byte** (`fonte_delphi.py trecho` para extrair, `substituir` para gravar), trocando só `TFatVenda.` por `TFatVendaBase.`. Se `fCalculaSugestaoFreteTransportadora` em modo Linux precisar de `{$IFDEF}`, avisar o João.
- [ ] Conferir: `grep -n "fCalculaSugestaoFrete\|fRetFreSugCal\|pZeraFreteSugerido\|fRetPerDescFreteFaixaFat" untFuncFat.pas` só mostra **chamadas**, nenhuma declaração. `fonte_delphi.py conferir` OK nos três arquivos. `svn diff | wc -l` proporcional (sem diff de EOL).
- [ ] Compilar `FaturamentoServicesAPI` pelo `ci.py`. Esperado: compila.
- [ ] **João:** compilar o `autcom` na IDE. Esperado: compila sem erro de identificador.

### Tarefa 2: Extrair a decisão de liberação para a base

**Arquivos:** `untFuncFat.pas` (`fValidaFreteSugestao`, 6628-6790) e `Faturamento.Classes.TFatVendaBase.pas`.

**Interfaces produzidas** em `TFatVendaBase`:
- `function fFreteDispensaLiberacao(const AfltFreteSugestao: Double): Boolean;` — as guardas de `fValidaFreteSugestao` que antecedem os efeitos colaterais: devolução com `CFG_ZVFDEV`, `CFG_FRETRA=1` (sem trava de devolução), `strOpcDoc` em `CF_CI_CT_CP_`, `strEspDoc` fora de `PD_OR_NF_EL_NS_MI_FF_DV_`, frete zero com isenção, sugestão negativa, frete não alterado (`fFormataFloat(...,2)`, com o caso `DV`) e `blnZerouFrete_CFG_ZERFRE`. True = não exige liberação.
- `function fDireitoLiberacaoFrete(const AfltFreteSugestao: Double; out AstrMensagem: String): String;` — a decisão por `CFG_TRAFRE`: `''` se `H` com sugestão ≥ frete ou `L` com sugestão ≤ frete; senão `'FREMAI'`/`'FREMEN'`/`'FRETRA'`, com `AstrMensagem` = o `strMsgSen` atual de cada ramo, texto **idêntico**.

- [ ] Se `FValorFreteOriginalParaDevolucao` não estiver na base, a guarda `DV` fica no desktop antes da chamada. Para a API, que só trata `PD`, ela não importa.
- [ ] Reescrever `TFatVenda.fValidaFreteSugestao` para: `If fFreteDispensaLiberacao(x) Then Exit;` → efeitos colaterais **inalterados e na mesma ordem** (margem, os dois `fCalculaSugestaoFreteTransportadora`) → `strDir := fDireitoLiberacaoFrete(x, strMsg); If strDir = '' Then Exit;` → `TLiberacao` com `strDirAce := strDir` e o resto do texto da liberação como hoje.
- [ ] Conferir pelo diff que nenhuma linha de efeito colateral mudou de posição em relação às guardas.
- [ ] Compilar o `ci.py`; **João** compila o `autcom`.

### Tarefa 3: Endpoints na API

**Arquivos:**
- `padra_atualizado/Services/Core/faturamento/services/types/Faturamento.Services.Pedido.Types.pas`: DTOs de resposta, perto de `TSimularEmissaoResult` (~1837).
- `padra_atualizado/Services/Core/faturamento/services/Faturamento.Services.Pedido.pas`: `TSimularEmissaoService` (172-211) e `TPedidoService` (10-…).
- `padra_atualizado/Services/Core/faturamento/services/Faturamento.Services.Workers.pas`: duas sobrecargas cada (string + tipada), mais `AddMethod` junto do de `fSimularEmissao` (1228).
- `padra_atualizado/Services/Faturamento.Services.API/Source/api/controller/api.controller.pedido.pas`: duas actions depois de `SimularEmissao`.

**Interfaces:**
- `TCalcularFreteSugestaoResult = class` → `property valorFreteSugestao: Double`
- `TValidarFreteResult = class` → `valorFreteSugestao: Double`, `exigeLiberacao: Boolean`, `direitoAcesso: string`, `mensagem: string`
- `TSimularEmissaoService`: `function fCalcularFreteSugestao: TCalcularFreteSugestaoResult;` e `function fValidarFrete: TValidarFreteResult;`
- `TPedidoService`: `class function fCalcularFreteSugestao(Pedido: TSimularEmissaoParams): TCalcularFreteSugestaoResult;` e `class function fValidarFrete(Pedido: TSimularEmissaoParams): TValidarFreteResult;`, no molde de `fSimularEmissao` (1717)
- Worker: `TPedidoServiceWorker.fCalcularFreteSugestao` / `fValidarFrete`, nas duas sobrecargas
- Rotas: `[MVCPath('/calcular-frete-sugestao')]` e `[MVCPath('/validar-frete')]`, `httpPOST`, corpo `TSimularEmissaoParams`, header `Empresa`; 400 `EInvalidParams`, 422 `EConfiguracaoNaoSuportada`, como `SimularEmissao`

Algoritmo de `fCalcularFreteSugestao` (a tela, spec RF02):
```
fatVenda.fltValFre := 0          { RF02: valorFrete do corpo ignorado }
inserir itens; pCalcularTotais   { mesma sequência do fSimularEmissao, até o pCalcularTotais }
se not fPermitirFreteNoFaturamento ou (CFG_ZERFRE e fPossuiSomenteItensRetira): 0
caso CFG_FRETRA:
  '1': TRA_VALFRE da transportadora
  '2','5': fCalculaSugestaoFreteTransportadora(transp, True, FRETRA='5')
  '3': fCalculaSugestaoFreteProdutos(transp, True)
  '4': fCalculaSugestaoFreteFaixaFaturamento(transp, fDescricaoFrete(tipoFrete))
  para 2..5: se fltTotPro - fltDesEsp >= fltVlMinF → 0, senão fRetFreSugCal
```
`fValidarFrete`: calcula como acima, guardando o `fltFreSug` cru. Depois atribui `fatVenda.fltValFre := Pedido.valorFrete` e `blnZerouFrete_CFG_ZERFRE` conforme a tela. Se `CFG_SUGFRE='2'` ou `fFreteDispensaLiberacao(cru)` → não exige. Senão, `fDireitoLiberacaoFrete(cru, msg)`.

- [ ] Implementar DTOs, serviço, worker e controller, com Swagger (`MVCSwagSummary`, `MVCSwagJsonSchemaField`) descrevendo só o comportamento acima.
- [ ] `grep -n "fExecuteTask(" Faturamento.Services.Workers.pas` e `grep -n "AddMethod('TPedidoService" ...`: os dois métodos novos aparecem nas duas listas.
- [ ] Compilar `FaturamentoServicesAPI` pelo `ci.py`.

### Tarefa 4: Casos de teste (escritos por quem implementa)

**Arquivos**, cada caso = três artefatos (`Scripts/testes/README.md`):
- `padra_atualizado/Services/Faturamento.Services.API/Scripts/testes/casos/NNNN_<NOME>.sql` (NNNN = próximo `id` livre na tabela; consultar `MAX(id)`), com **`svn add` no ato**
- `Target/Linux/Test_Cases/pedido/CalcularFreteSugestaoTest.inc` e `ValidarFreteTest.inc`
- métodos `CalcularFreteSugestaoTest(ATestID: Integer)` e `ValidarFreteTest(ATestID: Integer)` em `Source/api/controller/api.controller.pedido.test.pas`, no molde de `SimularEmissaoTest` (237), com as constantes de rota novas

Casos: os 14 do `spec.md` §7. Valores esperados = linha de base da Tarefa 0, não o próprio código. Cenários extras do "Foco da revisão":
- FRETRA=4 com `tipoFrete:"1"` permitido na faixa → valor da faixa (≠ 0)
- FRETRA=2 com `enderecoEntregaID` em cidade diferente da do cliente → valor da `FRETRA` da cidade de entrega
- FRETRA=2 com transportadora sem linha na `FRETRA` para a cidade → 200 e o que a função devolve hoje, sem erro (spec RN03)
- [ ] `sql_before` ajusta `CFG_FRETRA`/`CFG_TRAFRE`/`CFG_ZERFRE`/`CFG_SUGFRE` da empresa (por `CODEMP`); restaurar conforme o README (`sql_after` roda **antes** do assert).
- [ ] `validar_casos.py` → OK.
- [ ] Aplicar os casos na base da suíte e rodar `--run` com o nome completo de cada caso. Esperado: todos verdes.
- [ ] Payload com item de tinta (`siglaTinta`) nos dois endpoints: o serviço sobrevive. Prova do worker.

### Tarefa 5: Validação do desktop e fechamento

- [ ] **João:** com o Autcom **novo**, repetir a Tarefa 0. Esperado: mesmos valores carregados e mesmo `FGO_FRESUG`. Repetir, num modo, o fluxo de liberação: frete maior com `TRAFRE=H` → pede `FREMAI` com o mesmo texto.
- [ ] Atualizar o README da suíte (contagem de casos), como no 462009.
- [ ] Review do diff (`code-review.md`) → DelphAI. O commit é do João.
