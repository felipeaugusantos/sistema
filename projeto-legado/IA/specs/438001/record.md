# Registro — Req. 438001

**Assunto:** Crédito de ICMS do Simples Nacional (`pCredSN`) — manter a alíquota só nos itens que podem virar CSOSN
101; item com substituição tributária (e demais) volta a sair com alíquota de ICMS zerada quando o ICMS é zero.
**Período:** 03/09/2026 (implementação original, r492964 e r493014, banzato) · 15/10/2026 (correção, joao.catarino)
**Zona:** Legado (`padra_atualizado/fontes/faturamento/Impostos/IcmsSt/`), compartilhado com os Services Linux
**Decisão de negócio:** André Reis Maximiano (fiscal), via Rafaela (analista), em 15/10/2026: *"entendo que a
alteração deve ocorrer somente quando a CSOSN = 101"*; *"no requisito o exemplo é csosn 101, não tem para outras
situações"*. O Banzato confirmou que implementou exatamente o que o requisito pedia.

Documento de memória do requisito. Aqui fica o porquê, a base legal, a jornada e o que ficou de fora.

---

## 1. Contexto de negócio

A ME/EPP optante pelo Simples Nacional não destaca ICMS próprio. Mas, quando vende para contribuinte **não
optante** que vai revender ou industrializar, ela deve informar na nota o percentual e o valor do crédito de ICMS
que o comprador pode aproveitar (LC 123/2006, art. 23; Res. CGSN 140/2018, arts. 58 a 62). Na NF-e isso vai nos
campos `pCredSN` (alíquota) e `vCredICMSSN` (valor), que só existem nos grupos `ICMSSN101`, `ICMSSN201` e
`ICMSSN900` do leiaute.

### 1.1 O requisito original

Solicitante: Tais (fiscal), cliente 00000001, NF 129476 de 28/04/2026, item 03740, CSOSN **0101**, valor R$ 0,11.
O crédito de 0,11 × 3,97% arredonda para R$ 0,00, e o sistema mandava `pCredSN = 0.00`. Pedido: enviar o
percentual (3,97) mesmo com `vCredICMSSN` zero.

### 1.2 O que a implementação original fez (r492964)

Em `TCalculoImpostoIcms.ValidarSeDeveZerarValoresIcms` (`untCalculoImpostoIcms.pas`) existe a regra que zera
alíquota, base e valor do ICMS do item quando o valor calculado é zero. O r492964 criou
`fSimplesNacionalCreditoDeIcms` e passou a sair dessa regra **antes de zerar** para qualquer item de empresa do
Simples (a menos que a configuração de troca para x41 esteja ativa). O caso do requisito ficou resolvido, mas a
condição não olhava o CST/CSOSN do item.

O r493014 (mesmo dia) acrescentou em `CalcularValorIcms` o piso de zero para base, alíquota e valor negativos. Não
tem relação com este assunto e não foi tocado.

---

## 2. O problema

Efeito colateral: item de **ST** de empresa do Simples (CST 060 → CSOSN 500) passou a sair do cálculo com
`aliquotaICMS` = alíquota interna (2,42 na base de teste) e base/valor zerados. Antes de 03/09 saía com tudo zero.

Evidência: os casos da suíte da API de Faturamento `TEST_ICMS_EMP_020_08`, `_09`, `_11` e `_12` (ids 279, 280,
282 e 283, rota `POST /api/pedido/calcular-impostos`, empresa 020, item 56314, CFOP 6108, `cstICMS` "060")
passaram até 02/09/2026 e falham desde então com:

```
Pedido.items[0].aliquotaICMS is [2,42] when [0] expected.
```

Os casos **não foram ajustados para 2,42 de propósito**: ajustar o esperado esconderia um possível defeito fiscal
que também atinge o autcom desktop. Em 03/10/2026 a análise foi para a Rafaela, que levou ao Banzato e ao André.

---

## 3. Base legal

Fonte primária: Resolução CGSN nº 140/2018, texto consolidado (visão multivigente) do portal de normas da Receita
Federal, impresso em 14/05/2026. Os trechos abaixo são transcrição literal.

### 3.1 Item de ST (CST 060 / CSOSN 500): crédito vedado

**Art. 25, § 8º, I.** Na revenda de mercadoria com ICMS já retido, o ICMS sai do cálculo do Simples:

> "o substituído tributário, assim entendido o contribuinte que teve o imposto retido, e o contribuinte obrigado
> à antecipação com encerramento de tributação deverão segregar a receita correspondente como 'sujeita à
> substituição tributária ou ao recolhimento antecipado do ICMS', quando então será desconsiderado, no cálculo do
> valor devido no âmbito do Simples Nacional, o percentual do ICMS"

**Art. 61, II.** Sem ICMS devido no Simples, o crédito não pode ser consignado:

> "A ME ou a EPP optante pelo Simples Nacional não poderá consignar no documento fiscal a expressão mencionada no
> caput do art. 60, ou caso já consignada, deverá inutilizá-la, quando: [...] II - tratar-se de operação de venda
> ou revenda de mercadorias em que o ICMS não é devido na forma do Simples Nacional"

**Art. 62, III e parágrafo único.** O comprador não pode se creditar, e o crédito indevido gera estorno e sanção:

> "O adquirente da mercadoria não poderá se creditar do ICMS consignado em nota fiscal emitida por ME ou EPP
> optante pelo Simples Nacional [...] quando: [...] III - a operação enquadrar-se nas situações previstas nos
> incisos I a VI do art. 61."
>
> "Na hipótese de utilização de crédito [...] de forma indevida ou a maior, o destinatário da operação estornará o
> crédito respectivo conforme a legislação de cada ente, sem prejuízo de eventuais sanções ao emitente"

**Leiaute da NF-e.** O grupo `ICMSSN500` não tem `pCredSN` nem `vCredICMSSN`; traz os campos de ST retida
anteriormente (`vBCSTRet`, `vICMSSTRet` e afins). Ou seja, nem há onde informar o crédito.

**Conclusão:** a alíquota 2,42 no item de ST não corresponde a nenhum crédito que a empresa possa informar. Não
chega ao XML (o grupo 500 não tem o campo), mas fica gravada no item e diverge da regra.

### 3.2 Item tributado normalmente (CSOSN 101): crédito obrigatório

**Art. 58, § 1º.** O não optante tem direito ao crédito sobre aquisições de optante para comercialização ou
industrialização.

**Art. 60, caput e § 5º.** O emitente deve informar a alíquota e o valor do crédito; na NF-e, "nos campos próprios
do documento fiscal". A alíquota do crédito é a efetiva da faixa de receita (§ 1º).

**Art. 62, I.** Sem a alíquota informada, o comprador perde o crédito. Isso ampara o requisito da Tais: o
percentual tem de ir mesmo quando o valor arredonda para zero.

---

## 4. A correção

Escopo, por decisão do João (15/10/2026): ater-se ao requisito e à decisão do André — **somente CSOSN 101** —,
fazer os casos de ST passarem e **não** abrir alteração nova. O que estiver fora disso, o André abre em requisito
próprio.

A regra final passou por três versões, todas revisadas pelo DelphAI. Ficam registradas porque as duas primeiras
são exatamente os erros que alguém pode repetir.

### 4.1 Por que a correção não pode filtrar pelo CSOSN

O CSOSN **não existe no momento do cálculo**. Ele é decidido na emissão da NF-e, em `TNFEFit400.fRetornaCSTSimples`
(`fontes/libNfe/untNFEFit400.pas`), a partir do CST do item e de configurações da NF-e e dados do destinatário que o
motor de cálculo não tem. Leitura **completa** da função (linhas ~5976–6120):

| CST do item (2 últimos dígitos) | CSOSN resultante na NF-e |
|---|---|
| 00, 20 | **101** (config `strCstSimTrib` = 101 e destinatário contribuinte não consumidor final), 102 ou 103 |
| 10, 30, 60, 70 (ST) | `strCSOSNSubs` (config `APCSOS`), 103, 500, 201 ou 202 — nunca 101 |
| 40, 50 | 103 |
| 41, 51 | 103 ou 400 |
| 90 | 400 (bonificação a não contribuinte, CFOP x910), **101 (confirmação de cupom, CFOP x929, config `CSTSTC` = 101)** ou 900 |
| (antes de tudo) | 300/900/400/102 por CFOP de entrada, exportação, transferência, devolução |

**Atenção — há duas tabelas CST→CSOSN.** `fRetornaCSTSimplesUtil` (`libNfe/untUtil.pas` ~2647) é a do **SAT/CF-e**
(único chamador: `untSATCFE.pas`) e difere da NF-e: nela o CST 20 cai no 900. Para `pCredSN` vale a da NF-e. O
DelphAI usou a do SAT numa das revisões.

Onde o `pCredSN` nasce na NF-e: grupos 101 e 201 gravam `item.fltAlqIcm` como `pCredSN` quando
`fltBasIcmSimples = 0` (`untNFEFit400.pas` ~4930-4980). O grupo 500 não grava alíquota; o 900 grava `pCredSN` = 0
fixo.

### 4.2 As três versões

| Versão | Regra para manter a alíquota (Simples, ICMS = 0) | Resultado da revisão do DelphAI |
|---|---|---|
| 1 — r500171 | CST 00/20 | **Reprovada (porte .45):** o CSOSN 101 também nasce de CST 90 + CFOP x929 (confirmação de cupom); a versão zerava esse item e reabria o defeito do requisito. A análise tinha lido `fRetornaCSTSimples` só até o ramo de ST |
| 2 — flag de ST | qualquer item que não seja de ST | **Reprovada (150 e .45):** preserva alíquota em 40/41/50/51 e no 90 sem x929, que não geram 101 — vai além do "somente 101" e, em relação à base do 150 (r500171), é mudança de comportamento |
| 3 — final | CST 00/20 **ou** CST 90 com CFOP x929 | é exatamente o conjunto de caminhos que geram CSOSN 101 na NF-e |

Na revisão da versão 2 o DelphAI também apontou o CSOSN 201 (que grava `pCredSN`) e, na seguinte, aceitou que está
fora do escopo do diff. Ver seção 6.

### 4.3 Versão final

`fSimplesNacionalCreditoDeIcms` só devolve `True` (mantém a alíquota com ICMS zero) quando `fItemPodeVirarCsosn101`
confirma: CST terminado em 00 ou 20, ou CST terminado em 90 com CFOP do item terminado em 929. A condição ficou numa
função com o nome da regra para que a chamada (`If Not fItemPodeVirarCsosn101 Then Exit;`) se leia sem comentário.

| Arquivo | Alteração líquida (contra a revisão anterior ao r500171) |
|---|---|
| `untTypesIcms.pas` | `TParametrosCalculoIcms` ganha `CodigoDaSituacaoTributaria` e `ClassificacaoFiscalDoItem` (no fim do record) |
| `untCalcularIcmsSt.pas` | `TCalcularIcmsSt.ParametrosCalculoIcms` preenche os dois (CST das regras de tributação; CFOP de `FParametros`) |
| `untCalculoImpostoIcms.pas` | `System.StrUtils` no uses da implementação; função privada nova `fItemPodeVirarCsosn101`, chamada em `fSimplesNacionalCreditoDeIcms` |

`TCalcularIcmsSt.ParametrosCalculoIcms` é o **único** ponto que monta `TParametrosCalculoIcms` (grep em `fontes/` e
`Services/`). A configuração `CSTSTC`/`strCstSimTrib` da libNfe **não** é consultada: a regra é condição
necessária para o 101, não suficiente — ver seção 7.

Confirmação de cupom: `ZerarIcmsGeral` já zera o ICMS de documento `CI` **antes** desta função quando a configuração
`CFG_ZERAR_BASES_ICMS_E_IPI` está ligada (`fConfirmacaoDeCupomFiscalEZerarBaseIcmsEIpi`). Sem ela, o item 90/x929
chega aqui — por isso o ramo é necessário.

Comportamento resultante (empresa do Simples, ICMS calculado = 0):

| CST | Antes de 03/09 | Produção (r492964) | Versão final |
|---|---|---|---|
| 00, 20 | zera | mantém | **mantém** |
| 90 + CFOP x929 | zera | mantém | **mantém** |
| 10, 30, 60, 70 (ST) | zera | mantém | **zera** |
| 40, 41, 50, 51 | zera | mantém | **zera** |
| 90 sem CFOP x929 | zera | mantém | **zera** |
| Fora do Simples, ou config troca para x41 | zera | zera | zera |

Com ICMS calculado maior que zero nada muda: a regra de zerar só age com valor zero.

### 4.4 Revisão final (15/10/2026) — caminhos em que o CST ou o CFOP poderiam divergir da NF-e

Feita antes do commit, para não deixar brecha. Nenhum ponto exigiu mudança.

| Ponto | Verificação | Resultado |
|---|---|---|
| Quem monta `TParametrosCalculoIcms` | grep em `fontes/` e `Services/`; consumidores externos: `TFatVendaBase` (autcom), `untCalculaImpostoPedido` (API), `untFactoryImpostos` | todos passam por `TCalcularIcmsSt.ParametrosCalculoIcms` |
| CFOP | autcom: `item.strClaFis` (`fGetInputCalculoIcmsSt`); API: `FDO_CLAFIS` | é o mesmo `strClaFis` que `fRetornaCSTSimples` testa para o x929 |
| CST: regras trocam x00→x20 (redução por cliente) | cálculo vê 20, NF-e vê 00 | os dois podem virar 101 — mesma decisão |
| CST: regras trocam x00→x51 (redução RICMS-PR, decreto 5141/2001) | a NF-e identifica esses itens por CST gravado 090 e exige `fltValIcm > 0` (`fItemCalculaReducaoBaseConfRICMPR`) | a regra desta correção só age com ICMS calculado zero; não se cruzam |
| CST: NF-e troca ST→x00 (`pRecalculaIcmsParaEstadoDestino`, empresa do Simples) | só em base sem `ABFICM`, interestadual, destinatário sem IE e consumidor final | esse destinatário gera CSOSN 102, nunca 101 |
| CST: regras trocam ST→x00 (diferimento de ST, ato declaratório DF) | cálculo mantém a alíquota; NF-e emite 500/201 | 500 não grava alíquota; 201 recebe a alíquota (sem prejuízo) |
| Confirmação de cupom zerada antes desta função | `ZerarIcmsGeral` → `fConfirmacaoDeCupomFiscalEZerarBaseIcmsEIpi` só com `CFG_ZERAR_BASES_ICMS_E_IPI` ligada | sem a config, o item 90/x929 chega aqui — o ramo é necessário |
| Testes unitários antigos (`TestesUnitarios/Faturamento/Impostos/IcmsSt/TestuntCalculoImpostoIcms.pas`, 2023–2025) | 22 casos de Simples com ICMS zero esperam alíquota 0 (sem CST informado ou item de ST) | passam com a regra final; com o r492964 falhariam. Não rodam em CI |

O recorte em que tudo isto importa é estreito: a regra só age quando o ICMS calculado arredonda para zero (item de
valor muito baixo, como o R$ 0,11 da Tais, ou sem base/alíquota).

---

## 5. Avaliação de risco

1. **O requisito continua atendido em todo caminho que gera CSOSN 101**, inclusive a confirmação de cupom.
2. **Fora do 101, o comportamento volta ao de antes de 03/09/2026** (vigente por anos), que é também o que os casos
   da suíte esperam.
3. **Nada foi construído em cima do r492964.** Histórico de `untCalculoImpostoIcms.pas` depois dele: só o r493014
   (piso de negativos, do próprio autor).
4. **Nenhum caso de teste depende do que muda.** Varredura de 15/10/2026 nos 940 casos de
   `faturamento_services_api_test` (base `2_30_BELAT_TC`): nenhum item com alíquota > 0 e `valorICMS` = 0 além dos
   que esta correção trata. Os casos da empresa 020 com CST 040/041/090/030 já esperam alíquota 0.
5. **Alcance.** O cálculo é compartilhado: `autcom.dpr` (via `TFatVendaBase` e `untCalculaImpostoPedido`) e os
   Services Linux que incluem a unit (Faturamento.Services.API, FaturamentoAutomatico, Fulfillment, Citeldesk,
   Consulta.Preco.Tinta, Exporta.Tintometricos.Terceiros e Automotiva, Financeiro.Services.API).
6. **Regra duplicada, conscientemente.** A condição repete no cálculo uma parte da regra CST→CSOSN da libNfe. Se a
   libNfe passar a gerar 101 por outro caminho, as duas divergem. Mitigação: Nota 1 no fonte e os casos de teste.

---

## 6. Achado: CSOSN 201 (fora do escopo — decisão)

A resolução também prevê crédito na **operação própria do substituto tributário**. Art. 25, § 8º, II, a:

> "o substituto tributário deverá: a) recolher o imposto sobre a operação própria pelo Simples Nacional e segregar
> a receita correspondente como 'não sujeita à substituição tributária e não sujeita ao recolhimento antecipado do
> ICMS'"

Como o ICMS da operação própria é devido no Simples, o art. 61, II não veda o crédito. Na NF-e isso é o CSOSN
**201**, cujo grupo grava `pCredSN` a partir de `item.fltAlqIcm` (`untNFEFit400.pas` ~4971-4980).

O 201 nasce de CST de ST (10/70 com CST substituto configurado). Com a versão final, o item que vira 201 volta a
zerar a alíquota quando o ICMS calculado é zero — como antes de 03/09 —, então o `pCredSN` do 201 sai zerado nesse
caso. **É o mesmo defeito do requisito, no 201, e foi mantido fora de propósito:** o requisito traz o cenário do
CSOSN 101 e o André definiu "somente quando o CSOSN for 101". Se o 201 precisar de tratamento, há base legal, e o
André abre requisito próprio. Em 15/10/2026 a Rafaela levou o achado ao André.

**16/10/2026 — pergunta formal enviada ao André (via Rafaela)**, depois de liberada a correção nas três versões.
Pontos levados: o leiaute prevê `pCredSN`/`vCredICMSSN` no 201; o substituto recolhe o ICMS da operação própria pelo
Simples (art. 25 § 8º, II, a), então a vedação do art. 61, II não se aplica; hoje o 201 com crédito que arredonda a
zero sai com `pCredSN` 0 (como antes de 03/09 e como o defeito que a Tais relatou no 101); **entre 03/09 (r492964) e
esta correção esse caso saía com o percentual** e voltou a sair com 0. Pergunta: o 201 deve ter o mesmo tratamento
do 101? Se sim, abrir requisito próprio, com nota/item de cliente que use CSOSN 201. **Aguardando resposta.**

Para quem for implementar o 201: o CSOSN 201 nasce de CST de ST (x10/x70) com o CST substituto configurado
(`strCstSimSubs` = 201) ou por `strCSOSNSubs` com `APCSOS` = S em `fRetornaCSTSimples`. Acrescentar esse caminho a
`fItemPodeVirarCsosn101` (e renomeá-la) exige ler essas configurações no cálculo; o caso 1335 (CST 010 zera) terá de
ser revisto, porque hoje ele guarda exatamente o comportamento que o 201 mudaria.

---

## 7. Imprecisão aceita

A condição é **necessária, não suficiente** para o CSOSN 101: item CST 00/20 que na emissão vira 102/103 (consumidor
final, `strCstSimTrib` vazio ou 102, espécie IF), e item 90 + x929 com `CSTSTC` diferente de 101 (vira 900), também
mantêm a alíquota com ICMS zero. Não afeta o `pCredSN`: 102/103 não têm o campo e o 900 grava 0 fixo. Consultar as
configurações e os dados do destinatário traria para o cálculo o restante da regra da libNfe.

---

## 8. Validação e pendências

- **Versão 1 (r500171):** compilada pelo `ci.py`; o ciclo agendado da CI (r500143, 13:16, com
  `--atualizar --publicar`) compilou a working copy com ela e publicou. Faturamento 936/936, Financeiro 61/61,
  Suprimento 90/90. As 13 falhas transitórias em `/faturar` durante a rodada (`CLI_VRUCOM` de outro pedido,
  "próximo sequencial", `CLICON` com empresa trocada) eram concorrência entre runners e sumiram ao fim. **A suíte
  não pegou o erro do CST 90**: não há caso de confirmação de cupom.
- **Versão final:** `FaturamentoServicesAPI` compilado pelo `ci.py` (272s, sem aviso nas três units). Revisada pelo
  DelphAI: aprovada no 150 e no .100; no .45 o único apontamento foi o CSOSN 201, respondido como fora do escopo e
  então aprovado. **Commits: r500202 (02.30.74.150), r500207 (02.74.150.100) e r500215 (02.74.150.45).**
  **Executada na suíte em 16/10/2026 (r500288):** Faturamento 938/938, Financeiro 61/61, Suprimento 90/90. Casos
  da regra todos verdes: 279/280/282/283 (CST 060 zera), 1334 (CST 000 mantém), 1335 (CST 010 zera) e 1336 (CST 051
  zera) — os dois últimos na primeira execução. Casos 1335/1336 commitados em r500223.
- **Caso 1334 `TEST_ICMS_EMP_020_23`** (r500171) cobre o cenário da Tais: empresa 020 (Simples), cliente PJ
  04000329 dentro do estado, item 49357 CST 000, quantidade 1 a R$ 0,11. Esperado `aliquotaICMS` 2,42,
  `baseCalculoICMS` 0,11, `valorICMS` 0, CFOP 5102. O esperado saiu da resposta real da API de teste. Artefatos:
  `Scripts/testes/casos/1334_TEST_ICMS_EMP_020_23.sql`, linha em `CalcularImpostosTest.inc` e linha na base. Os
  casos 279/280/282/283 (CST 060) guardam o lado do item de ST.
- **Casos 1335 e 1336** (15/10/2026) guardam o lado "não amplia": item de empresa do Simples que **não** pode virar
  101, com alíquota de origem > 0 e ICMS que arredonda a zero, tem de sair com alíquota 0. Com o r492964 (ou com
  a versão 2, flag de ST) os dois reprovariam.

  | Caso | Empresa / cliente / item | CST / CFOP | Preço | Origem (preço normal) | Esperado |
  |---|---|---|---|---|---|
  | 1335 `TEST_ICMS_EMP_020_24` | 020 / 02000101 / 56314 | 010 / 6403 | 0,11 | alíquota 2,42 | alíquota 0, base 0, ICMS 0 (ST 0,19 / 0,02) |
  | 1336 `TEST_ICMS_EMP_024_03` | 024 / 00105626 / 56315 | 051 / 5102 | 0,03 | alíquota 12 | alíquota 0, base 0, ICMS 0 |

  Montados a partir dos casos irmãos 289 e 305 (mesmo `sql_before`; o 305 liga a configuração RICMS-PR, que é o
  cenário do CST 051); o esperado saiu campo a campo da resposta real da API de teste. Artefatos com `svn add`,
  linhas no `.inc` e linhas na base; `validar_casos.py` e `conferir_casos.py` sem divergência nos novos.
- **Lacuna de teste que a API não cobre:** CST 90 + CFOP x929 (confirmação de cupom → CSOSN 101). A API não monta
  confirmação de cupom (nenhuma referência a CFOP 929 nem à opção de documento `CI` no Faturamento.Services.API) —
  só validação manual no autcom. Também não há item com CST 020 na suíte. Os testes unitários de
  `TestesUnitarios/` foram descartados como meio: o projeto `AutcomTestes` não compila hoje (erros em
  `TestShared.Functions.Funcoes.Faturamento.pas`, alheios a este requisito) e não é alterado desde 04/04/2025.
- **Pendente:** validar no autcom desktop: (a) venda de empresa do Simples com item de ST (alíquota zerada); (b) item
  CSOSN 101 de valor baixo (`pCredSN` preenchido com `vCredICMSSN` zero); (c) confirmação de cupom com CST 90 e
  `CSTSTC` = 101.
- **Portes:** versões 02.74.150.100 e 02.74.150.45 recebem a mesma alteração líquida (conferida arquivo a arquivo).
  Na .45, `untTypesIcms.pas` e `untCalcularIcmsSt.pas` têm base diferente da do 150 (campos de outros requisitos),
  sem conflito com os trechos alterados.

### 8.1 Conferência na base do cliente (16/10/2026)

Cliente do requisito, identificado pelos XMLs anexos: **JOSE CARLOS SICHIERI** (SICHIERI FERRAGENS), CNPJ
01.012.635/0001-71, SP, CRT 1. Base `SICHIERI_FERRAGENS_LJ001_PROD_CLOUD_BR28` (10.0.1.237:12817, `AUTCOM`, host
`linuxdata028`, MySQL 8.0.40), empresas 001 e 002, ambas `CFG_SIMPAU` = S. Consulta só leitura pelo `autcom_db.py`.

**Configurações que decidem o CSOSN na NF-e (iguais nas duas empresas, salvo indicado):**

| Config | Valor | Efeito em `fRetornaCSTSimples` |
|---|---|---|
| `CFG_CSTSTR` (`strCstSimTrib`) | 101 | CST 00/20 para contribuinte não consumidor final → **CSOSN 101** |
| `CFG_CSTSSC` | 202 (001) / 500 (002) | item de ST para contribuinte → 202 ou 500 |
| `CFG_CSTSSB`, `CFG_CSTSSF`, `CFG_CSTNSF` | 500 | item de ST para consumidor / fora do estado → 500 |
| `CFG_APCSOS` | N | não usa `strCSOSNSubs` |
| `CFG_CSTSTC` (`strCstSimTribCI`) | 900 | confirmação de cupom → 900 (o caminho 90/x929 → 101 não se aplica) |
| `CFG_RICMPR` | N | sem redução RICMS-PR |

Ou seja: neste cliente o **CSOSN 201 não é gerado** e o 101 só nasce de CST 00/20.

**Documentos** — saídas (CFOP 5xxx/6xxx) em `NOTDET` e `MOVDET`, data `DET_DTAENT` (a `DET_DTAFAT` vem vazia),
CST em `DET_CODFIS`, a partir de 01/07/2026, itens com `DET_VALICM` = 0:

| Situação | Base | Efeito da versão final |
|---|---|---|
| CST 000, valor baixo, até 14/09 | alíquota 0 (o defeito do requisito) — ex.: NF 135640, 135789, 135971, 136096, 136285, 136444 | — |
| CST 000, valor baixo, desde 18/09 | alíquota mantida (3,99 na 001, 3,02 na 002): 47 itens em NF e FF, até 15/10 | **nenhum** — CST 00 continua mantendo |
| CST 060 | ~2.900 itens, **todos com alíquota 0**, inclusive depois de 18/09 | **nenhum** — o ramo de ST do cálculo já zera (sem importação direta nem benefício de redução de base ST) |
| CST 010 | 1 item (julho), alíquota 0 | nenhum |
| Qualquer outro CST com alíquota > 0 e ICMS 0 desde 15/09 | **nenhum item** | — |

O cliente recebeu a versão do r492964 entre 15 e 18/09. Entre os itens preservados está o próprio cenário do
requisito: **item 03740, cliente 00000001, NF 136689 (empresa 001), 18/09, alíquota 3,99, base 0,11, ICMS 0**.

**Conclusão:** a versão final não altera nenhum resultado deste cliente — o que o requisito corrigiu continua
corrigido, e os itens que a correção passa a zerar (ST e demais CSTs fora do 101) já saíam zerados aqui.

**Observação, sem relação com a correção:** na NF 130054 (28/04, antes do r492964) o item 03740 está gravado com
alíquota 0, mas o XML anexado ao requisito traz `pCredSN` 3,97. A NF-e tem um segundo caminho para o percentual:
com `dadosGerais.fltBasIcmSimples` > 0 os grupos 101/201 usam `item.fltAlqCreIcmSimples` em vez de
`item.fltAlqIcm` (`untNFEFit400.pas` ~4934 e ~4971). Não investigado.

---

## 9. Referências

- Resolução CGSN nº 140/2018, texto consolidado da Receita Federal (via Tributarium):
  https://tributariumeditora.com.br/storage/FEDERAL/SIMPLES%20NACIONAL/Resol.%20CGSN%20n%C2%BA%20140-2018-14-05-26.pdf
  — arts. 25 § 8º, 58, 59 § 9º, 60, 61 e 62
- Portal de normas da Receita (fonte oficial do texto acima):
  https://normas.receita.fazenda.gov.br/sijut2consulta/link.action?idAto=92278
- LC 123/2006, art. 23 (crédito do adquirente): https://www.planalto.gov.br/ccivil_03/leis/lcp/lcp123.htm
- Receita Estadual RS — como o optante informa o crédito na NF-e:
  https://atendimento.receita.rs.gov.br/como-o-optante-inclui-o-credito-de-icms-no-documento-fiscal
- Leiaute dos grupos da NF-e (fonte secundária; a primária é o Manual de Orientação do Contribuinte da NF-e):
  - ICMSSN101: https://buscadorncm.com.br/nfe/tags-xml/icmssn101
  - ICMSSN500: https://buscadorncm.com.br/nfe/tags-xml/icmssn500
  - pCredSN: https://buscadorncm.com.br/nfe/tags-xml/pcredsn
  - vCredICMSSN: https://buscadorncm.com.br/nfe/tags-xml/vcredicmssn
- Commits: r492964 e r493014 (banzato, 03/09/2026); r500171 (versão 1 da correção, substituída); r500172
  (este registro); r500202, r500207 e r500215 (versão final nos três ramos)

---

## NOTAS REFERENCIADAS NO CÓDIGO-FONTE

### NOTA 1

**Onde:** `padra_atualizado/fontes/faturamento/Impostos/IcmsSt/untCalculoImpostoIcms.pas`,
`TCalculoImpostoIcms.fItemPodeVirarCsosn101` (chamada por `fSimplesNacionalCreditoDeIcms`).

`fSimplesNacionalCreditoDeIcms` decide se `ValidarSeDeveZerarValoresIcms` deixa de zerar a alíquota quando o ICMS
calculado é zero. Ela existe para que o CSOSN 101 leve o `pCredSN` mesmo com crédito arredondado a zero (Res. CGSN
140/2018, art. 60 § 5º e art. 62, I: sem a alíquota o comprador perde o crédito). Na NF-e o grupo 101 grava
`item.fltAlqIcm` como `pCredSN`.

O CSOSN só é definido na emissão (`TNFEFit400.fRetornaCSTSimples`). Ali, o 101 nasce de dois caminhos: CST 00/20, e
CST 90 com CFOP x929 (confirmação de cupom, config `CSTSTC` = 101). A condição reproduz esses dois caminhos e zera o
resto — em especial o item de ST (CSOSN 500), que saía com a alíquota interna e base/valor zero, embora o ICMS dele
não seja devido no Simples (art. 25 § 8º, I) e a lei vede consignar crédito (art. 61, II; art. 62, III).

**Não reduzir a CST 00/20:** foi a versão 1 (r500171) e quebrava a confirmação de cupom. **Não trocar pela flag de
ST:** foi a versão 2 e mantinha a alíquota em 40/41/50/51/90 que não geram 101. **Não usar `fRetornaCSTSimplesUtil`
como referência:** é a tabela do SAT, não da NF-e.

**Não remover a checagem:** os casos `TEST_ICMS_EMP_020_08/09/11/12` guardam o item de ST e o
`TEST_ICMS_EMP_020_23` guarda o CSOSN 101. **Não ampliar sem decisão fiscal:** o CSOSN 201 tem base legal para
crédito (art. 25 § 8º, II, a), mas ficou fora do escopo por decisão (15/10/2026). Se a libNfe passar a gerar 101 por
outro caminho, esta condição precisa acompanhar.
