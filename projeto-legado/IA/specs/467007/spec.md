# Especificação — Req. 467007

**Título:** Frete sugestão do pedido na API de Faturamento: `calcular-frete-sugestao` + `validar-frete`
**Objetivo:** O Citel Sales obtém, na finalização do pedido, o frete que o Autcom sugeriria para aquele pedido e, se quiser, a informação de que o frete escolhido exige liberação.
**Zona:** Moderna (`padra_atualizado/Services/`) + Legado (`padra_atualizado/fontes/faturamento/`, a regra sai da `TFatVenda` para a `TFatVendaBase`)
**Versão:** só a `02.30.74.150`. As APIs dos Services saem sempre dela. O `vepeal` lista `ESPECIFICO`
**Envolvidos:** Felipe Damacena (abertura) · consumidor: backend do Citel Sales (`svn://10.0.0.205/App_CitelSales_Backend/trunk`)
**Data:** 2026-10-19

## 1. Contexto e porquê

Na finalização do pedido, o vendedor do Citel Sales já escolheu cliente, endereço de entrega, itens, transportadora e tipo de frete. Hoje o Sales manda o `valorFrete` pronto ao `simular-emissao`, e não tem como saber o valor que o Autcom sugeriria. No Autcom, a tela de fechamento do pedido (aba da transportadora, `untDadosFechamentoPedidoTransportadoraFrame`) calcula esse valor e o oferece ao operador.

O cálculo depende do **pedido inteiro** (peso bruto, valor dos produtos, itens de entrega × retira, cidade/região de entrega), e não só de transportadora e tipo de frete. Por isso a entrada é o pedido completo, no formato do `simular-emissao`.

O que o Sales faz com o valor sugerido é regra **dele**: ele pode ou não usá-lo no `valorFrete` que envia depois. O papel da API é fornecer o sugerido e, se o Sales quiser, dizer se o frete escolhido exige liberação.

### O que existe hoje

- **Cálculo:** `TFatVenda` (`fontes/faturamento/untFuncFat.pas`), só Windows. Nenhum `.dpr` dos Services usa essa unit.
  - `fCalculaSugestaoFreteTransportadora` — modos cidade (`FRETRA`/`FREFXP`) e região (`TRAREG`/`TRAFXP`)
  - `fCalculaSugestaoFreteProdutos` — por produto (`CADITE.ITE_TIPFRE`/`ITE_VLCFRE` + `CADTRA.TRA_VALFRE`)
  - `fCalculaSugestaoFreteFaixaFaturamento` — por faixa (`CADFRG`/`CADFRD`), a única que usa o tipo de frete
  - auxiliares `fRetPerDescFreteFaixaFat` / `fRetValIsencaoFreteFaixaFat` em `fontes/genericos/untFuncoesSimples.pas` (`FREFAI`), também fora do Linux
- **Validação:** `TFatVenda.fValidaFreteSugestao` (`untFuncFat.pas`). Exige liberação quando o frete digitado difere do sugerido, com direito `FREMAI` / `FREMEN` / `FRETRA` conforme `CFG_TRAFRE`. É chamada só pelas telas.
- **Na API:** nada calcula nem valida frete. `POST /faturamento/faturar` recusa pedido não liberado (`CFG_LIBPED` → `fPedLiberado`), mas não compara frete com sugestão (medido em 19/10/2026).
- **No Sales:** a decisão "grava liberado ou não" é do backend Java (`PedidoServiceImpl.atribuirLiberacao`/`atribuirLiberacaoComercial`). Para regras do Autcom ele chama endpoints pequenos (`validar-valor-minimo`, `validar-unitario`). **Não** chama `/pedido/validar-pedido`.

## 2. Decisões tomadas no levantamento

| Decisão | Por quê | Quem |
|---|---|---|
| Entrada = pedido inteiro, mesmo formato do `simular-emissao` | o cálculo precisa de itens, peso e endereço; o Sales já monta esse corpo | João |
| Resposta só com o número, sem motivo | a tela do Autcom também não mostra motivo | João |
| A validação é um endpoint **separado** (`validar-frete`), não um campo do `/validar-pedido` | o Sales não chama o `/validar-pedido`, e o padrão dele é endpoint pequeno por regra. Assim ele escolhe se valida | João |
| Os dois endpoints entram neste requisito, como par | o Sales escolhe se usa a validação | João |
| A regra **sai** da `TFatVenda` para a `TFatVendaBase`, sem duplicar | a `TFatVendaBase` existe para compartilhar código entre Autcom e API: um cálculo só | João |
| O `faturar` não muda | trava de frete no faturamento só recusaria a nota, sem chance de liberar. A liberação fica na inclusão, e o faturar já respeita `CFG_LIBPED` | João |

### Decididas na implementação (19-20/10/2026)

| Decisão | Por quê |
|---|---|
| A condição de pagamento (juros/desconto, `CFG_CNDVEN`) é aplicada antes de totalizar, na ordem do `simular-emissao` | o total decide isenção, faixa e percentual; a tela também a aplica antes (achado da revisão; caso 1360) |
| `enderecoEntregaID` carrega cidade e região do endereço (`objEndEnt.pRetEnderecoEntrega`), sem o `pEnderecoToFatVenda` | sem isso o frete sairia pela cidade do cliente; o `pEnderecoToFatVenda` trocaria transportadora e tipo de frete pelos do endereço |
| Venda presencial sem `CFG_FREPRE` devolve 0 (`fPermitirFreteNoFaturamento`) | é o comportamento da tela |
| Casos da suíte em empresas com `CFG_*` de frete fixas (029, 030, 032, 033, 034, 045, 048, 049, 022, 060) | os Services guardam a `CFGSIS` em cache por worker/empresa; trocar a configuração no `sql_before` não é visto (medido pelo `general_log`) |
| Depende do UniDAC corrigido em `C:\componentes` | o SQL da faixa (`WHERE` ⏎ `:VALTOT`) quebrava no bind do Linux — ver `IA/know/unidac_linux_bind_offset.md` |

## 3. Contrato

### 3.1 `POST /api/pedido/calcular-frete-sugestao`

- **Corpo:** `TSimularEmissaoParams`, exatamente o do `simular-emissao`. Campos que pesam no frete: `codigoCliente`, `enderecoEntregaID`, `codigoTransportadora`, `tipoFrete`, `descontoEspecial`, `items[]` (`codigoItem`, `quantidade`, preços, `entregaRetira`). Os demais são aceitos e usados só no que a montagem do pedido já usa.
- **Header:** `Empresa`, como os irmãos.
- **Resposta 200:**

| Campo | Tipo | Significado |
|---|---|---|
| `valorFreteSugestao` | number | frete que a tela de fechamento do Autcom carregaria no campo de frete para este pedido, em reais, 2 casas |

- **400:** parâmetros inválidos (`EInvalidParams`), como no `simular-emissao`.

### 3.2 `POST /api/pedido/validar-frete`

- **Corpo:** `TSimularEmissaoParams` com `valorFrete` = o frete que o vendedor escolheu.
- **Resposta 200:**

| Campo | Tipo | Significado |
|---|---|---|
| `valorFreteSugestao` | number | o mesmo valor que o `calcular-frete-sugestao` devolve para o pedido (a comparação interna usa o sugerido cru: RF03) |
| `exigeLiberacao` | boolean | o frete informado exige liberação |
| `direitoAcesso` | string | `FREMAI`, `FREMEN` ou `FRETRA`; vazio quando não exige |
| `mensagem` | string | o texto da liberação no Autcom (ex.: `Alterar valor do frete de sugestão com valor Maior.`); vazio quando não exige |

- O sugerido é **sempre recalculado**: a API não aceita um valor sugerido vindo do consumidor.

Nomes dos campos e das rotas: decisão de quem implementa dentro do padrão dos irmãos. Os listados acima são a proposta.

## 4. Requisitos funcionais

- **RF01.** `calcular-frete-sugestao` devolve o mesmo valor que a tela de fechamento do pedido do Autcom carregaria no campo de frete para o mesmo pedido, na mesma empresa e com a mesma configuração.
- **RF02.** O modo de cálculo segue `CFG_FRETRA` da empresa logada. Referência: o que a tela de fechamento carrega **ao trocar a transportadora** (`untDadosFechamentoPedidoTransportadoraFrame.pas`, `fValidaCampos`) e pelo botão "calcular frete sugestão", que é o momento em que o vendedor do Sales está.

| `CFG_FRETRA` | Valor devolvido |
|---|---|
| `1` (não calcula) | `CADTRA.TRA_VALFRE` da transportadora, **sem** checar isenção (a tela não checa nesse modo) |
| `2` cidade / `5` região | `fCalculaSugestaoFreteTransportadora(transp, True, região)` → `fRetFreSugCal`; zero se isento |
| `3` produtos | `fCalculaSugestaoFreteProdutos(transp, True)` → `fRetFreSugCal`; zero se isento |
| `4` faixa de faturamento | `fCalculaSugestaoFreteFaixaFaturamento(transp, descrição do tipoFrete)` → `fRetFreSugCal`; zero se isento |

  - "Isento" = `fltTotPro - fltDesEsp >= fltVlMinF`, como a tela.
  - Zero também, em qualquer modo, quando `CFG_ZERFRE` está ligada e o pedido tem só itens de retira, ou `fPermitirFreteNoFaturamento` é falso.
  - **Minha decisão:** `fRetFreSugCal` em todos os modos que calculam. A tela usa `fltFreSug` ao abrir e `fRetFreSugCal` ao trocar de transportadora; o carrinho rápido usa `fRetFreSugCal` sempre. Só diferem com `CFG_RTFRSU = S` e pedido só de retira.
  - **Minha decisão:** `CFG_SUGFRE = 2` (tela só exibe a sugestão como dica) **não** muda o valor devolvido. A API devolve o sugerido; o que fazer com ele é do Sales.
  - **Minha decisão:** o `valorFrete` do corpo é **ignorado** (zerado) no cálculo. Na faixa de faturamento ele entraria no total e poderia mudar a faixa, e o sugerido não pode depender do frete que o consumidor mandou.
- **RF03.** `validar-frete` reproduz `TFatVenda.fValidaFreteSugestao` para pedido (`strEspDoc = 'PD'`, não devolução), comparando o informado com o **`fltFreSug` cru**, como a tela faz (antes do zeramento por isenção e sem o `CFG_RTFRSU`). Não exige liberação quando:
  - `CFG_FRETRA = 1`;
  - `CFG_SUGFRE = 2` (a tela não chama a validação nesse modo);
  - `CFG_ZERFRE` ligada e pedido só de retira (`blnZerouFrete_CFG_ZERFRE`);
  - o frete informado é zero e o pedido atinge a isenção;
  - o frete informado é igual ao sugerido cru (2 casas);
  - `CFG_TRAFRE = 'H'` e o informado é **menor ou igual** ao sugerido cru;
  - `CFG_TRAFRE = 'L'` e o informado é **maior ou igual** ao sugerido cru.

  Nos demais casos, exige liberação:
  - `FREMAI` com `CFG_TRAFRE = 'H'`;
  - `FREMEN` com `CFG_TRAFRE = 'L'`;
  - `FRETRA` em qualquer outra configuração.

  **Consequência conhecida, herdada do Autcom:** em pedido isento, o `calcular-frete-sugestao` devolve 0, mas a validação compara com o sugerido cru. Com `TRAFRE = H`, informar 30 contra um cru de 80 não exige liberação, como no Autcom. O sugerido cru é calculado com o `valorFrete` do corpo zerado, pelo mesmo motivo do RF02.
- **RF04.** Os dois endpoints rodam no **worker filho**: sobrecarga tipada com `fExecuteTask` + `AddMethod` (`IA\rules\services-workers.md`). Montam o pedido em memória como o `simular-emissao`, e não gravam nada.
- **RF05.** O Autcom desktop continua devolvendo o mesmo frete sugerido de antes em todas as telas que o calculam:
  - fechamento do pedido
  - dados fiscais
  - mensagem genérica
  - mensagem de OS
  - carrinho rápido
  - locação de equipamento
  - dados do CT-e
  - expedição de itens

## 5. Regras de negócio

- **RN01.** A API não decide se o Sales usa o sugerido nem se ele chama a validação. Os dois endpoints só informam.
- **RN02.** `validar-frete` não grava liberação, não bloqueia nada e não altera pedido. Quem grava o pedido "aguardando liberação" é o Sales.
- **RN03.** Ausência de tabela de frete para a cidade, região ou faixa resulta no que a função do Autcom devolve hoje (tipicamente zero), **sem erro**.

## 6. Desenho técnico

### Parte legado — mover a regra (sem mudar comportamento)
- Mover `fCalculaSugestaoFreteTransportadora`, `fCalculaSugestaoFreteProdutos`, `fCalculaSugestaoFreteFaixaFaturamento`, `fRetFreSugCal`, `pZeraFreteSugerido` e a parte **de cálculo** de `fValidaFreteSugestao` da `TFatVenda` (`untFuncFat.pas`) para a `TFatVendaBase` (`Faturamento.Classes.TFatVendaBase.pas`). A `TFatVenda` herda, e os chamadores do desktop não mudam.
- Levar `fRetPerDescFreteFaixaFat` e `fRetValIsencaoFreteFaixaFat` para unit compilada no Linux.
- A parte de **UI** de `fValidaFreteSugestao` (`TLiberacao`, senha, margem de lucro) fica no desktop. A decisão "exige liberação? com qual direito?" vira função pura na base, usada pelas duas pontas.
- Tudo o que esses métodos usam e só existe na `TFatVenda` precisa ser listado no plano antes de mover. Revisão de 19/10/2026: as dependências de cálculo (`fItemEntrega`, `pCalculaPesBruLiq`, `fPossuiSomenteItensRetira`, `enderecoEntrega`, `strRegFre`, `fltFreAnt`, `fltFreSugCal`, `fltVlMinF`) já estão na base; `untTipoFreteAtc` (`fCalculaFrete`, `fDescricaoFrete`) já compila no Linux; `untFuncoesSimples` não.
- **Armadilha do desktop:** `fValidaFreteSugestao` chama `fCalculaSugestaoFreteTransportadora` para `strCodTra` **e** `strCodTraAnt` (`untFuncFat.pas`, ~6680), e essas chamadas sobrescrevem `fltFreSug`, `fltFreSugCal`, `fltVlMinF` e `strRegFre`, que alimentam o `FGO_FRESUG` gravado e a mensagem da liberação. A função pura da base **não** faz essas chamadas; o desktop as mantém, na mesma ordem.
- A faixa de faturamento espera o tipo de frete pela **descrição** (`fDescricaoFrete`), não pelo código que o Sales manda.
- Arquivos cp1252 com acento: regra 9 da skill (`fonte_delphi.py`), nunca Edit/Write.

### Parte Services
- `TPedidoController.CalcularFreteSugestao` / `ValidarFrete` → `TPedidoServiceWorker` → serviço que reaproveita a montagem do `simular-emissao` (`pIniciarPedido`, `pInserirProduto`, `pCalcularTotais`) e chama os métodos da `TFatVendaBase`.
- Swagger: `MVCSwagSummary` / `MVCSwagJsonSchemaField` descrevendo só o que o código faz.

### Deixado para quem implementa
- Nome da classe de serviço e dos DTOs de resposta, no padrão de `Faturamento.Services.Pedido.Types.pas`.
- Se o corpo do `simular-emissao` tiver campo que a montagem rejeite sem necessidade para o frete, tratar como no `simular-emissao`.

## 7. Casos de teste

**Implementados: 20 casos, 1341–1360** (`Scripts/testes/casos`), DDL `003_INFRA_SCHEMA_FRETE.sql`. A tabela abaixo é o levantamento original; os implementados acrescentam tinta (1352) e condição com juros (1360).

Escritos por quem implementa (CLAUDE.md, endpoints dos Services), na suíte `Faturamento.Services.API`: `.sql` + `.inc` + método por caso.

| Cenário | Afirma |
|---|---|
| `FRETRA=2` cidade, pedido de entrega com peso, sem isenção | `valorFreteSugestao` = valor calculado à mão a partir da `FRETRA` da base de teste |
| `FRETRA=2`, total acima do mínimo de isenção | 0 |
| `FRETRA=3` produtos | soma por `ITE_TIPFRE` + `TRA_VALFRE` |
| `FRETRA=4` faixa, tipo de frete permitido e não permitido | valor da faixa / 0 |
| `FRETRA=1` | `TRA_VALFRE` |
| `validar-frete`: informado = sugerido | `exigeLiberacao=false` |
| `validar-frete`: `TRAFRE=H`, informado > sugerido | `true`, `FREMAI` |
| `validar-frete`: `TRAFRE=L`, informado < sugerido | `true`, `FREMEN` |
| `validar-frete`: `TRAFRE` vazio, informado ≠ sugerido | `true`, `FRETRA` |
| `validar-frete`: pedido isento, `TRAFRE=H`, informado < sugerido cru | `false` (herdado do Autcom, RF03) |
| `validar-frete`: `ZERFRE` ligada, só retira, informado > 0 | `false` |
| `validar-frete`: `SUGFRE=2`, informado ≠ sugerido | `false` |
| `calcular-frete-sugestao` com `valorFrete` preenchido no corpo, `FRETRA=4` | mesmo valor que com `valorFrete` zero |
| Corpo inválido (sem itens / cliente inexistente) | 400 |

Valores esperados conferidos contra a tela do Autcom na mesma base, não só contra o próprio código.

## 8. Critérios de aceitação

- [ ] Para um mesmo pedido e configuração, `calcular-frete-sugestao` devolve o mesmo valor que a tela de fechamento do Autcom carrega, em cada `CFG_FRETRA` usado na base de teste.
- [ ] `validar-frete` aponta `FREMAI` / `FREMEN` / `FRETRA` nos mesmos casos em que o Autcom pede liberação.
- [ ] O Autcom desktop segue sugerindo o mesmo frete de antes na tela de fechamento do pedido (roteiro manual: mesmo pedido, antes e depois).
- [ ] Os endpoints rodam no worker (a requisição não derruba o serviço) e os casos de teste estão verdes.

## 9. Fora de escopo

- Mudar o `/validar-pedido` ou o `/faturamento/faturar`.
- Gravar liberação ou o frete sugerido (`FGO_FRESUG`) pela API.
- Lista de transportadoras com o frete de cada uma (`pCalculaTempFreteTransportadoraCidadeRegiao`).
- Integrações de cotação externa (Frenet, DataFrete, Intelipost).
- Mostrar o motivo do valor.
- Mudanças no Citel Sales.

## 10. Riscos a verificar

- **Autcom desktop:** a regra muda de classe. Erro na mudança altera o frete sugerido em produção para todos os clientes que calculam frete. Por isso o critério de aceitação com roteiro manual antes/depois.
- **Dependências escondidas:** os métodos podem usar campos ou funções só da `TFatVenda` ou de unit VCL. Se algum não portar, levar ao João antes de duplicar.
