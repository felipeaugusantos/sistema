# Especificação — Req. 458688

**Título:** Encargos bancários (tarifas) na carteira Itaú via API
**Objetivo:** fazer a carteira 341 - Itaú via API lançar automaticamente as tarifas de cobrança no retorno, como o Banco do Brasil via API (Req. 272323), usando o valor cobrado informado pela API de francesinha do Itaú.
**Zona:** Legado
**Data:** 21/10/2026
**Cliente de origem:** SERFLEX (CLI 1937), release em uso 379.48.2.30.74.111.189

## 1. Contexto / problema atual

Caminho: `PRINCIPAL > CONTROLE FINANCEIRO > GERAÇÃO DE LAYOUT BANCÁRIO > CONTAS A RECEBER > ONLINE > 341 - ITAU > Configurações`.

A carteira Itaú via API foi criada em r339539 (04/10/2023) sem suporte a tarifa, com duas travas deliberadas:

- `TfrmConfigItauAPI.Carregadados` faz `tbsEncBan.TabVisible := False` depois que o `FormShow` aplicou `fCfgSis('ENCBAN')`, então a aba "Encargos Bancários" nunca aparece;
- `RetornaSeOBancoLancaTarifaNaConfirmacao` exclui `CONFIG341API`.

A causa de fundo é a consulta de boletos usada na importação (`CONSULTAR_LISTA_BOLETO_PROD`, `boleto/v1/boletos`), que não traz tarifa. O retorno grava `RET_TARIFA = 0`, e a baixa (`pBaixaAtuDup`) só lança tarifa a partir de `RET_TARIFA`/`RET_CUSCAR`. O `VALOTAR` da aba serve de conferência, não de valor lançado.

Em `pBaixaAtuDup`, a lista de bancos que carregam as ocorrências de tarifa (`strOcoTar`/`objCnfDao`) inclui `001API`, mas não `341API`.

O BB via API resolve com uma consulta de detalhe por boleto (`RetornaDetalheBoleto`). No Itaú, a tarifa só existe na API de francesinha (movimentações da cobrança: lista de operações com a descrição "TARIFA DE COBRANÇA").

## 2. Módulos e entidades envolvidos

- Módulo: `autban` (libAutban.dll) e `padra_atualizado\fontes\genericos`
- Units: `autban\Itau API\untConfigItauAPI.pas`, `autban\Itau API\untTBancoItauAPI.pas`, `autban\genericos\untRetBcoAPI.pas`, `autban\genericos\untPrincipal.pas`
- Tabelas: `LNKBCO` (links das APIs, chave `LNK_CODBCO` + `LNK_ROTINA` + `LNK_TIPAMB` + `LNK_CHAVE_`), `RETBCO` (`RET_TARIFA`), `CFGSIS` (`CFG_ENCBAN`), `CNFOCO` (ocorrências de tarifa da carteira)

## 3. Requisitos funcionais

- RF01 — Com `CFG_ENCBAN = S`, a aba "Encargos Bancários" aparece na configuração da carteira Itaú via API, em todas as carteiras (troca de aba de carteira inclusive), e grava valor da tarifa, portador, plano de contas, fornecedor e o grid de tarifas auxiliares.
- RF02 — Na importação do retorno Itaú via API, com `CFG_ENCBAN = S`, o sistema consulta a francesinha do período importado e grava em `RET_TARIFA` a tarifa de cada boleto, cruzando pelo nosso número.
- RF03 — A baixa (`TBaixaDuplicatas.pBaixaEAtualizacaoDuplicatas('341API')`, em `autban\Autban_dll\untBaixaMovimentacaoBancaria.pas`) lança a tarifa e as tarifas auxiliares configuradas no grid, como nos demais bancos (`341API` na lista de ocorrências de tarifa).
- RF03a — O relatório do retorno do Itaú via API, com `CFG_ENCBAN = S`, abre o modelo com taxas (`frxRetBcoTarifa`), como o Sicoob via API (Req. 426667).
- RF04 — Se a francesinha falhar (sem permissão, erro HTTP, link não cadastrado), a importação segue e, ao final, o operador recebe um aviso único (`fMensagem`) dizendo que as duplicatas do retorno podem ficar sem tarifa, com o motivo devolvido pelo banco. Os dias consultados antes da falha mantêm a tarifa.
- RF05 — O link da francesinha é entregue por script de dados no Diário (aba "Script após DDL"), em `LNKBCO`, com `LNK_CODBCO = '341'`, `LNK_ROTINA = 'BOLETO'`, `LNK_TIPAMB = 'P'` e `LNK_CHAVE_ = 'CONSULTAR_FRANCESA_PROD'`. URL **sem filtro de movimentação**: `https://boletos.cloud.itau.com.br/boletos/v3/francesas/[BENEFICIARIO]/movimentacoes?data=[DATA]&page=[PAGINA]&page_size=50`. O código acrescenta `&tipo_movimentacao=liquidacoes` (tarifa) ou `&tipo_cobranca=boleto_descontado` (descontadas).

## 4. Regras de negócio

- RN01 — A tarifa é lançada na **liquidação**. A exclusão de `CONFIG341API` em `RetornaSeOBancoLancaTarifaNaConfirmacao` permanece.
- RN02 — A francesinha só é consultada com `CFG_ENCBAN = S`. Com `N`, a importação fica idêntica à de hoje, sem chamada extra.
- RN03 — A francesa detalhada aceita **uma data por chamada** (`GET {base}/francesas/{id_francesa}/movimentacoes?data=AAAA-MM-DD&tipo_movimentacao=liquidacoes`). O período da importação vira uma chamada por dia, cada uma paginada até a última página (`page_size` máximo 50; não presumir página única: o caso do fórum ACBr perdeu 24 liquidações). Não fazer uma chamada por boleto. `id_francesa` = agência (4) + conta (7) + DAC (1), o mesmo `id_beneficiario` que a carteira já monta. Base de produção: `https://boletos.cloud.itau.com.br/boletos/v3`. Dia sem movimento volta 204 **ou 422** com `campos[].campo = "data"` e mensagem "Não existe movimentações para a data informada" (medido em 21/10/2026): os dois são "dia sem dado", e qualquer outro 422 é erro (RF04). Só há dados de liquidações dos últimos 45 dias: importação de período mais antigo fica sem tarifa (aviso de RF04).
- RN04 — A tarifa é a que a francesa informar, para qualquer `tipo_cobranca` (`Boleto` ou `BoleCode`): na resposta real da SERFLEX (20/10/2026), os títulos `BoleCode` também trazem tarifa. Boleto sem operação de tarifa, ou fora da francesa, grava 0.
- RN08 — A tarifa do boleto é o valor absoluto do item de `operacoes_cobranca` cuja `descricao` contém "tarifa" (sem diferenciar maiúsculas de minúsculas). O `codigo` não identifica a operação: a documentação usa `"1"` para juros, e a resposta real usa `"1"` para a tarifa. O cruzamento com o boleto da importação é pelo `nosso_numero` (8 dígitos com zeros à esquerda, ex.: `"01008362"`; a consulta de boletos devolve 9, com o DAC). A carteira não entra na chave: a consulta é por conta. A conta vinculada fica fora (uma falha de permissão nela derrubaria a tarifa da conta principal). A consulta vai do início do período (limitado a 45 dias atrás) até o fim do período + 5 dias (limitado a hoje), porque boleto pago em outro banco entra na francesa na data da liquidação. Os links de `pagination` apontam para um host interno do Itaú: paginar montando `page` na URL própria, nunca seguindo `next`.
- RN05 — Tarifa cobrada diferente do `VALOTAR` da carteira segue a regra dos demais bancos: a duplicata não é baixada e aparece como divergência.
- RN06 — Falha da francesinha é aviso ao operador, nunca exceção que interrompa a importação. Sem log novo.
- RN07 — O valor pago (`RET_VALPAG`) continua vindo da consulta de boletos atual. O líquido da francesinha não substitui o valor pago.

## 5. Requisitos técnicos / não-funcionais

- Fontes em cp1252 com acento: editar só pelo `.claude\scripts\fonte_delphi.py`.
- Valores da API com ponto decimal: converter com `fStrToFloat` (padrão de `RetornaValorImportacaoDouble`).
- Token: reutilizar o fluxo de token já existente da carteira (`TOKEN_BOLETO_PROD`). Se a francesinha exigir escopo diferente, isso é tratado no pré-requisito.

## 6. Critérios de aceitação

- [ ] CA01 — Com `CFG_ENCBAN = S`, a aba aparece no Itaú via API na abertura e na troca de carteira; com `N`, não aparece.
- [ ] CA02 — A configuração gravada na aba persiste ao reabrir a tela.
- [ ] CA03 — Na importação, um boleto liquidado com tarifa na francesinha grava `RET_TARIFA` igual ao valor do banco.
- [ ] CA04 — Um boleto pago por Pix grava `RET_TARIFA = 0` sem erro.
- [ ] CA05 — Com a francesinha indisponível, a importação conclui e mostra um aviso único com o motivo. Dia sem movimento (204 ou 422 "Não existe movimentações") não gera aviso.
- [ ] CA06 — A baixa lança a tarifa (contas a pagar ao fornecedor/portador configurados) e as tarifas auxiliares do grid.
- [ ] CA07 — Tarifa divergente do `VALOTAR` gera "não baixado" com divergência.
- [ ] CA08 — Sem regressão: Itaú por arquivo (341), BB via API (001API) e Itaú via API com `CFG_ENCBAN = N` se comportam como antes.

## 7. Fora de escopo

> **Atualização 21/10/2026:** o desconto deixou de estar em avaliação e foi especificado na **seção 9**. A regra é seguir o arquivo de retorno. O histórico da avaliação continua abaixo.
>
> **Em avaliação (21/10/2026):** o desconto de duplicatas via API (entrada, liquidação e volta para cobrança simples das descontadas, com juros, IOF e tarifas) fica **neste requisito**, por decisão do usuário. A entrega junto com a tarifa ou separada depende de alinhamento com Camila Atelli. O porte para as outras versões aguarda essa decisão. Medido até aqui: a resumida de 19/10/2026 traz as custas do desconto só em total do dia; a detalhada de liquidações (20/10/2026) traz `LZ`/`BY` com `operacoes_desconto` códigos 27 e 30. Falta a detalhada de **entradas** para decidir entre lançamento por duplicata ou por operação.
>
> **Detalhada de entradas (19/10/2026, `codigo_status` `EZ`) — por duplicata, como o arquivo:** `operacoes_desconto` traz 21 "Tarifa por boleto descontado" (2,25), 24 "Juros desconto DP", 28 "IOF desconto DP" e 32 "Tarifa de contratação desconto DP" (rateada por título), e `valor_liquido_lancado` = `valor_titulo` + `valor_decrescimo` (= soma das quatro). Conferido: 3.202,51 − (2,25 + 20,12 + 15,48 + 7,87) = 3.156,79. Mapeamento para o retorno do arquivo (ocorrência 02, RET_DUPDES='S'): 21 → RET_TARIFA, 24 → RET_JUROPE, 28 → RET_IOFDES, 32 → RET_TXADES (no arquivo, a taxa é justamente o resto calculado) e líquido → RET_VALLAN. Eventos: `EZ` = entrada (02), `LZ` = liquidação da descontada (06; atraso traz juros em `operacoes_cobranca` e 27 "Valor pago desconto DP"), `BY` = baixa com débito (≈ 48; 30 "Acertos de desconto DP" é **devolução** de juros, não custo).

- Tarifa no Itaú por arquivo (já funciona).
- Outros bancos via API.
- Versão .72 e ramos `.CONFE` (a .72 também esconde a aba, fica só registrado).
- **Defeito à parte, para requisito próprio (registrado em 21/10/2026):** no cadastro de ocorrências (`autban\genericos\untCadOcoCartei`), o tipo é gravado pela posição no combo. Fora do Itaú, a tela remove "JUROS OPERAÇÃO" e "EST. DESCONTADA" passa a ser 4. No Itaú (arquivo e API), "EST. DESCONTADA" é 5, mas o estorno da descontada (`EstornoDuplicataDescontadaParaCobrancaSimples`, ocorrência 48) procura sempre o 4. Hoje o operador do Itaú tem de escolher "JUROS OPERAÇÃO" para o acerto da 48. Comportamento anterior a este requisito, mantido para seguir o arquivo.
- Lançar tarifa na confirmação de entrada do boleto.

## 8. Dependências e riscos

- **Pré-requisito — CUMPRIDO em 21/10/2026:** resposta real da francesa detalhada da SERFLEX (data 20/10/2026, `tipo_movimentacao=liquidacoes`, `page_size=50`): 10 liquidações, 1 página, campos em `snake_case`, tarifa de R$ 1,33 por boleto em `operacoes_cobranca` ("Tarifa de cobrança", valor `-1.33`, igual ao `valor_decrescimo`; `valor_titulo` − 1,33 = `valor_liquido_lancado`). A primeira tentativa voltou 403 do gateway; a seguinte, 200. O texto abaixo é o histórico da dúvida.
- Histórico — a fonte antes da resposta real era só: A documentação do portal Itaú (página "francesa" e coleção Postman "API Boletos (v3)", recebidas em 21/10/2026) confirma o endpoint, a paginação, o `id_francesa` e a janela de 45 dias. **Não confirma onde vem a tarifa por boleto na cobrança simples**: nos exemplos, `operacoes_cobranca` só traz juros, multa e desconto; tarifa aparece em `operacoes_desconto` (boleto descontado), no total diário da resumida (`deducoes` "Tarifas") e na `tarifacao_mensal`. O fórum ACBr relata "TARIFA DE COBRANÇA" em `operacoes_cobranca` em produção. A documentação também mistura `snake_case` (Postman) e `camelCase` (página) nos nomes de campo e no caminho (`movimentacoes_resumidas` × `movimentacoes-resumidas`).
- Cliente com **tarifação mensal** não tem tarifa por boleto. A SERFLEX é tarifada por boleto (resposta real). Para cliente mensal, vale o RN04: a tarifa grava 0.
- Versões: .111, .150, .150.45, .150.100 (Diário) e .111.189 (em uso no cliente, a incluir no `vepeal`).
- A baixa da .111 tem estrutura diferente da .150 (lista de bancos por `Or`, não `MatchStr`).

## 9. Ampliação — desconto de duplicatas via API (21/10/2026)

**Decidido em 22/10/2026:** o desconto entra na mesma entrega da tarifa, e o **Req. 469587** (VALPEMEC, CLI 2108, "desconto de duplicata no Itaú online igual ao arquivo texto") é baixado junto com este. O 469587 não tem pasta própria de spec; esta seção é a especificação dele. Versões no `vepeal` do 469587: .150, .150.45 e .150.100.

**Req. 469695** (TEKCOM VANPEC, CLI 2615), incluído em 22/10/2026 e baixado junto: mesmo pedido do 469587 — `CFG_ENCBAN` ativo e a carteira Itaú Online sem os campos de duplicata descontada. O print do cliente (`\\citel-fileserve\AutDbf\TEKCOM\13.10.2026`, carteira 1, contrato 110559) mostra a tela sem a aba "Encargos Bancários", que esta alteração libera. Versões no `vepeal`: .150, .150.45 e .150.100. Sem pasta própria de spec: esta seção vale para ele também.

**Evidência do 469587** (arquivos do cliente em `\\citel-fileserve\AutDbf\VALPEMEC\08.10.2026`, contrato 302308, o mesmo da carteira 5 de teste na FIN_EMAIL):
- `DD07106B.RET` (EMPRESTIMO): ocorrência 06 das duplicatas citadas no requisito (000000341639C, 000000343139C, 000000035990A, 000000036099A) → `LZ` na API.
- `DD07106A.RET`: ocorrência 48 → `BY` na API.
- `CN07106C.RET` (cobrança): 06 com tarifa 1,09 e posição 254 = título − tarifa. Isso confirma que `RET_VALPAG` é o líquido quando há tarifa (correção de 22/10/2026 na importação via API).
- Nenhuma ocorrência 47 nos exemplos. O arquivo trata a 47 como entrada de desconto só com `TRAOC47A = S` ("Tratar ocorrência 47 como antecipação", tela do Itaú arquivo). Na API não há evento mapeado para ela: **fora de escopo**, até aparecer um caso real.

**Regra geral: comportamento igual ao retorno por arquivo do Itaú** (layout `EMPRESTIMO`, `untRetBco.fGeraRetornoBcoItau` + `untPrincipal.pBaixaAtuDup`), porque os clientes já estão acostumados a ele.

### 9.1 Origem dos eventos

A francesa detalhada do dia com `tipo_cobranca=boleto_descontado` (sem `tipo_movimentacao`) traz os três eventos, por duplicata:

| `codigo_status` | Evento | Ocorrência gravada no retorno (como o arquivo) |
|---|---|---|
| `EZ` | entrada no desconto | `02` |
| `LZ` | liquidação da descontada | `06` |
| `BY` | baixa da descontada / volta para cobrança simples | `48` |

### 9.2 Requisitos funcionais

- RF09 — Na importação do Itaú via API, consultar, dia a dia no período, a francesa detalhada de boletos descontados e gravar no retorno (`RETBCO`) um registro por evento `EZ` e `BY`, localizando a duplicata na CADREC pelo nosso número. Duplicata não encontrada entra no relatório de não encontradas, como hoje.
- RF10 — Evento `LZ`: a duplicata já vem na lista de liquidados da importação. Não criar um segundo registro: marcar o registro existente como descontada (`RET_DUPDES = 'S'`).
- RF11 — Tela da carteira Itaú via API: incluir os mesmos parâmetros de desconto da carteira Itaú por arquivo, que são **Portador Descontadas** (`PORTDES`) e **Utilizar Portador de Dupl. Descontada no Portador de Baixa** (`PORDESPORBAI`), e a opção **4 – JUROS OPERAÇÃO** no tipo de desconto do grid de tarifas auxiliares (`CNF_TIPDES`).
- RF12 — Baixa (`autban\Autban_dll\untBaixaMovimentacaoBancaria.pas`, a usada pela DLL): o filtro de ocorrências do Itaú via API (ramo `341API` de `fRetSQLOcoBancos`) passa a selecionar `RET_CODOCO = '48' AND RET_DUPDES = 'S'`, como o ramo `'341'`. O processamento de 02, 06 e 48 já é o do ramo `LeftStr(strCodBco, 3) = '341'` e serve ao `341API`.

### 9.3 Regras de negócio (mapeamento igual ao arquivo)

- RN09 — `EZ` → `02`, `RET_DUPDES = 'S'` (só com `CFG_ENCBAN = S`, como no arquivo), data da ocorrência = `data_movimentacao`.
  - Itens de `operacoes_desconto`, pela descrição:
    - "Tarifa por boleto descontado" (21) → `RET_TARIFA`;
    - "Juros desconto DP" (24) → `RET_JUROPE`;
    - "IOF desconto DP" (28) → `RET_IOFDES`;
    - "Tarifa de contratação desconto DP" (32) → `RET_TXADES`.
  - `valor_liquido_lancado` → `RET_VALLAN`.
  - Valores em módulo e em centavos (mesmo formato da tarifa, RN08).
  - Conferência: título − (21 + 24 + 28 + 32) = líquido.
- RN10 — `LZ` → `06`, `RET_DUPDES = 'S'` (com `CFG_ENCBAN = S`).
  - A tarifa de cobrança segue a RN08.
  - Pagamento com atraso (`valor_liquido_lancado` > 0) → `RET_JURMOR` = líquido e `RET_VALLAN` vazio, como o `DuplicataDescontadaPagaAposVencimento` do arquivo.
  - O item 27 "Valor pago desconto DP" não é gravado: o arquivo não tem equivalente.
- RN11 — `BY` → `48`, `RET_DUPDES = 'S'` (independe de `CFG_ENCBAN`, como no arquivo).
  - `RET_TXADES` = débito − título, só quando o débito (`|valor_liquido_lancado|`) passa do título: é o encargo, como a posição 280 do arquivo (caso real VALPEMEC, `DD07106A.RET`: débito 459,87, título 458,00 → 1,87).
  - Saindo antes do vencimento, o 30 "Acertos de desconto DP" é **devolução** de juros e o débito fica menor que o título (35969-B: 656,00 − 7,03 = 648,97). Nesse caso `RET_TXADES` fica vazio: o acerto não vira despesa. A baixa (comum a todos os bancos) continua debitando o valor de face; a diferença (7,03 no exemplo) fica para conciliação. Decisão do usuário em 22/10/2026 (opção 1: não mexer na baixa). Corrigido depois da 1ª validação, que lançava o acerto como despesa.
  - A baixa lança esse valor como conta a pagar (tipo 4, "Tarifa de estorno duplic. descontada") e debita o valor da duplicata no banco, **igual ao arquivo**, ainda que o Itaú o apresente como devolução de juros (decisão do usuário, 21/10/2026).
  - A tarifa de cobrança do `BY` não é lançada, igual à ocorrência 48 do arquivo.
- RN12 — A tarifa de cobrança e os eventos de desconto vêm da mesma consulta diária. Falha na consulta segue a RF04: aviso único, importação continua.
- RN13 — Dedup do retorno: a chave do `GravaRegistroRetBco` (banco + empresa + cliente + **ocorrência** + duplicata) separa o `02` da entrada no desconto de um `02` de boleto em aberto da consulta antiga (`ITAUVN = N`). Gravar o evento de desconto **antes** dos registros da consulta de boletos.

### 9.4 Critérios de aceitação

- [ ] CA09 — Importação de 19/10/2026 (conta com desconto): cada `EZ` vira `02` com `RET_DUPDES = 'S'` e tarifa, juros, IOF e taxa iguais aos da francesa. A soma bate com a resumida do dia (juros 2.010,23; IOF 726,50; contratação 260,00; por boleto 360,00).
- [ ] CA10 — Baixa da entrada: contas a pagar por tipo (1 IOF, 2 boleto, 3 descontada, 4 juros operação) conforme o grid, crédito do valor da duplicata no banco e duplicata marcada como descontada. Igual a um retorno por arquivo equivalente.
- [ ] CA11 — Liquidação `LZ` de descontada: baixa sem novo crédito no banco. Com atraso, juros de mora = líquido.
- [ ] CA12 — `BY`: estorno com débito do valor da duplicata e duplicata volta a não descontada; conta a pagar (tipo 4) só quando o débito do banco passa do título, pela diferença. Devolução de juros não gera conta a pagar.
- [ ] CA13 — Sem regressão: cobrança simples via API (tarifa, RN04/RN08) e retorno por arquivo do Itaú inalterados. Carteira sem desconto não gera evento nenhum.

### 9.5 Dependências e riscos

- Dado real: liquidações e baixas de 20/10/2026 e entradas de 19/10/2026 de uma conta com desconto (amostras coladas na sessão de 21/10/2026). A primeira página das entradas chegou cortada na mensagem, mas 30+ títulos conferidos.
- O `BY` cobre a volta para cobrança simples. Outros tipos de baixa de descontada (recompra, protesto) não apareceram na amostra: tratar como `48` só os `BY`, e qualquer outro status de descontada é **ignorado** (nada gravado no retorno) até ter amostra.
- Consulta extra por dia (`boleto_descontado`). **Proposta, a confirmar:** só com `CFG_ENCBAN = S` ou com `PORTDES` preenchido na carteira, para não onerar quem não usa desconto.
