# Req. 458948 — Checklist de execução

Detalhe técnico de cada passo em `plan.md`. Contrato e critérios em `spec.md`.
Este arquivo é checklist, não diário — narrativa e decisões vão para o `record.md`.

## Fase 1 — Banco

- [x] Criar `IA/specs/458948/alterar_tabela_fxcasa.sql`
- [ ] Executar o `ALTER TABLE` na base de desenvolvimento — **pendente, exige escrita no banco**
- [ ] Conferir `SHOW COLUMNS FROM FXCASA LIKE 'FAI_PERJUR'`
- [ ] Conferir que as faixas existentes seguem legíveis

## Fase 2 — Cadastro (Zona Legado)

- [x] `.dfm`: alturas — form 156, `pnlDados` 86, `pnlBotoes.Top` 86, `pnlStatus.Top` 111
- [x] `.dfm`: `lblPerJur` e `edtPerJur` dentro de `pnlDados`
- [x] `.pas`: declarar `lblPerJur` e `edtPerJur` na classe
- [x] `.pas`: `DisplayLabel` e `DisplayFormat` em `pFormatarCamposFaixas`
- [x] `.pas`: `stlCampos.Add('FAI_PERJUR')` antes de `AUTOINCREM`
- [x] `.pas`: ramo de `edtPerJur` em `fValidaCampos` (vazio é válido)
- [x] `.pas`: `fValidaCampos(edtPerJur)` em `fValidaFaixaCompleta`
- [x] `untConsultas.pas`: coluna no SQL e nos dois arrays de `fPesqFaixasParcelamentoCartaoAppSales`
- [ ] Compilar `autcom.groupproj`
- [ ] Roteiro manual abaixo
- [ ] Commit SVN — `Req. 458948` + token DelphAI

### Roteiro manual do cadastro

Não há teste automatizado em `fontes/`. Conferir na tela:

- [ ] Abrir o cadastro: os quatro campos aparecem, nada sobreposto, botões e barra de status no lugar
- [ ] Incluir faixa com percentual `10,00` → grava; conferir no banco
- [ ] Incluir faixa **sem** percentual → grava com `FAI_PERJUR` nulo
- [ ] Alterar o percentual de uma faixa → grava o novo valor
- [ ] Informar percentual negativo → mensagem e gravação recusada
- [ ] Abrir faixa cadastrada antes do `ALTER TABLE` → abre sem erro, campo vazio
- [ ] Pesquisa (F3 / botão): a coluna `% Juros a.m.` aparece na grade
- [ ] Faixa em conflito de valores → mensagem de sobreposição continua funcionando

## Fase 3 — Simulação (Zona Moderna)

- [x] `...ParcelamentoCartao.Types.pas`: `System.Generics.Collections` no `uses`
- [x] `...Types.pas`: constante `PCC_MAX_OPCOES = 60`
- [x] `...Types.pas`: classe `TParcelamentoCartaoOpcao`
- [x] `...Types.pas`: `percentualJurosMes` e `opcoesParcelamento` no result
- [x] `...Types.pas`: construtor, destrutor e `NovaOpcao`
- [x] `...ParcelamentoCartao.pas`: `System.Math` no `uses`
- [x] `...ParcelamentoCartao.pas`: `FAI_PERJUR` no `SELECT`
- [x] `...ParcelamentoCartao.pas`: inicializar `percentualJurosMes`
- [x] `...ParcelamentoCartao.pas`: laço de montagem das opções, limitado por `Min` com `PCC_MAX_OPCOES`
- [x] `api.controller.parcelamentocartao.pas`: atualizar `PCC_SWAGGER_SUMMARY`
- [ ] Compilar `Services.groupproj` para Linux
- [ ] Conferir o schema em `/swagger`
- [ ] Commit SVN — `Req. 458948` + token DelphAI

### Conferência rápida do endpoint

- [ ] `GET /cartao/parcelamento/limite-parcelas?valor=1000.00` numa faixa com `FAI_PERJUR = 10` e
      `FAI_QTDPAR = 6` devolve 6 opções, a 3ª com `valorParcela` 433,33 e `valorTotal` 1300,00
- [ ] Mesma chamada numa faixa com percentual nulo devolve as opções com `juros` zero
- [ ] `valorConsultado`, `limiteParcelas` e `faixa` inalterados em relação ao comportamento anterior

## Fase 4 — Baixa (Zona Moderna)

- [x] `...Cobranca.Baixa.Types.pas`: constante `BXA_MSG_JUROS_PARC_SEM_BASE`
- [x] `...Cobranca.Baixa.Types.pas`: `jurosParcelamento` em `TBaixaCartaoItem`, e `valor` documentado
      como já incluindo o juros
- [x] Confirmar que **nada** foi acrescentado a `TBaixaDuplicataItem`
- [x] `...Cobranca.Baixa.pas`: `SomaJurosParcelamento`
- [x] `...Cobranca.Baixa.pas`: `ValidarSomaContraMovimentos` soma o juros dos cartões
- [x] `...Cobranca.Baixa.pas`: validação de `jurosParcelamento` dentro de `ValidarCartao`
- [x] `...Cobranca.Baixa.pas`: `RatearJurosParcelamento`, `RateioDoLote`, `SomaRateioAte` e
      `RateioNoIndice`
- [x] `...Cobranca.Baixa.pas`: `LJurosParc` calculado antes do laço de gravação
- [x] `...Cobranca.Baixa.pas`: `CTR_VALREC` soma o rateio
- [x] `...Cobranca.Baixa.pas`: `CTR_VALJUR` soma o rateio
- [x] Confirmar que `LParams.ValorPago := LItem.valorRecebido` **não** foi alterada
- [ ] Compilar `Services.groupproj` para Linux
- [ ] Commit SVN — `Req. 458948` + token DelphAI

### Conferência rápida da baixa

- [ ] Lote de 1.000,00 em duplicatas + `jurosParcelamento` 400,00 + cartão 1.400,00 → aceita
- [ ] Mesmo lote com cartão 1.000,00 → 400 apontando a diferença
- [ ] Lote sem `jurosParcelamento` → resultado idêntico ao de antes da alteração
- [ ] Baixa parcial de 500,00 numa duplicata de 1.000,00 com juros 200,00 → título de saldo
      **500,00**, não 300,00

## Fase 5 — Massa e casos de teste

- [x] Aplicar o `ALTER TABLE` na base de teste
- [x] `007_INFRA_FAIXA_CARTAO.sql` atualizado com `FAI_PERJUR` + faixa 300–500 + bloco `PREPARE`
      que adiciona a coluna em base que já tinha a tabela
- [x] Três faixas cobrindo juros real (6,00) e juros zero explícito (0,00), com dois vãos
      preservados para o caso 37

> **O `007` não era opcional.** Ele faz `REPLACE`, que é delete+insert: rodar a versão antiga
> depois do `ALTER` apagaria o `FAI_PERJUR` das faixas e derrubaria todos os casos de juros, sem
> sintoma óbvio. Coluna nova na `FXCASA` tem de entrar na lista do `REPLACE`, sempre.

### Casos automatizados — escritos nesta sessão a pedido do solicitante

Registro para o histórico: o CLAUDE.md atribui os casos ao analista. Foram escritos aqui por
decisão explícita do solicitante, com todos os valores esperados medidos contra a API real.

- [x] `0044_TEST_PARCELAS_COM_JUROS_01` — tabela de parcelamento com 6% a.m.
- [x] `0045_TEST_PARCELAS_JUROS_ZERO_01` — regra R5
- [x] `0046_TEST_BAIXA_JUROS_PARC_PARCIAL_01` — **regra B1**, saldo 36,33 e não 28,33
- [x] `0047_..._LOTE_NAO_FECHA` / `0048_..._NEGATIVO` / `0049_..._MAIOR_QUE_CARTAO` — recusas
- [x] `0050_TEST_BAIXA_JUROS_PARC_TOTAL_01` — caminho feliz, sem saldo
- [x] `0009_TEST_BAIXA_LOTE_NAO_FECHA_01` — esperado atualizado (ver Fase 6)
- [x] Registrados nos `.inc` de Cartao e Cobranca
- [x] `validar_casos.py` — 50 arquivos, 50 ids distintos
- [x] **Suíte completa: 50 de 50 verdes em 28/08/2026 16:19**

### Duas armadilhas encontradas, já registradas nos arquivos

1. **A comparação de array é POSICIONAL.** O caso 45 nasceu declarando a 1ª e a 6ª opção e
   reprovou com `parcelas is [2] when [6] expected`. Subconjunto só funciona como **prefixo**.
2. **O caso 9 reprovou por mudança de contrato**, não por defeito — ver Fase 6.

## Fase 6 — Fechamento

> **BREAKING CHANGE a comunicar.** A mensagem de erro do fechamento do lote mudou de texto:
>
> ```
> antes:  A soma dos valorRecebido das duplicatas (X) difere da soma dos movimentos (Z).
> agora:  A soma dos valorRecebido das duplicatas (X) mais o jurosParcelamento dos cartoes (Y)
>         difere da soma dos movimentos (Z).
> ```
>
> A validação é a mesma; só o texto mudou, e ele mudou **inclusive quando o juros é zero**. Quem
> compara a string quebrou. Foi o caso 9, do Req. 454631, que pegou isso — ele afirmava a frase
> antiga. Optou-se por atualizar o esperado em vez de condicionar o texto no código (decisão do
> solicitante, 28/08/2026). **Levar ao Felipe junto com a regra de fechamento.**

- [ ] `/review` antes de submeter ao DelphAI
- [ ] DelphAI e token na mensagem de commit
- [ ] Entregar a `analysis.md` (texto de entrega, CAIXA ALTA)
- [ ] `/resumoAnaliseRequisito` para gravar o `record.md`

## Bloqueios em aberto

Nenhum impede começar a Fase 1. Detalhe na seção 9 da `spec.md`.

- [ ] Aval do financeiro: percentual por faixa é global, uma política para todas as lojas
- [ ] Definir quem preenche `FAI_PERJUR` nas faixas de produção
- [ ] Alinhar a regra de fechamento (spec 6.2) com o Felipe antes de ele codificar o app
- [ ] Confirmar o tratamento de duplicata de crédito no rateio (spec 6.3)
