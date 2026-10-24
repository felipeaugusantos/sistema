# Roteiro de testes — Req. 462714 (CBS / IBS / IS no Pedido de Compra e na Cotação)

**Referência:** spec.md (RF, RN e CA), tasks.md (Fase 9)
**Versões:** 150, 150.100, 150.45, 74.111, 72. Rodar o roteiro inteiro em cada versão e marcar o resultado na tabela do §9.

## 1. Antes de começar

- [ ] DDL `script_462714.sql` aplicado no banco da versão. Conferir:
  ```sql
  SHOW COLUMNS FROM PCMDET LIKE 'PCD_%CBS';   -- PCD_ALQCBS, PCD_VALCBS
  SHOW COLUMNS FROM PCMGER LIKE 'PCG_VAL%';   -- PCG_VALCBS, PCG_VALIBS, PCG_VAL_IS
  SHOW COLUMNS FROM COTFOR LIKE 'COT_ALQ%';   -- COT_ALQCBS, COT_ALQIBS, COT_ALQ_IS
  ```
- [ ] Compilados **os dois**: `autcom.exe` (cotação) e `libPedidoDeCompra.dll` (a tela do pedido fica na DLL). Se só o exe
  for compilado, o pedido continua com o código antigo.
- [ ] `AutcomTestes` compilado e o teste `TestuntImpostosReformaCompra` passando (CA00).
- [ ] Hash de `PedidoDeCompra\untImpostosReformaCompra.pas` igual nas 5 versões (CA16):
  `02175E2C4BC92EDCC5C0B8352CE6C20F4C48D6D2CA8F693FC03EE35F85C94AD1`.

### Configurações usadas

A regra fica **ligada** quando `CFG_REFCIS <> 'N'` e não (`CFG_SIMPAU = 'S'` e `CFG_SIMHIB = 'N'`).

```sql
SELECT SIS_CODCFG, SIS_VALCFG FROM CFGSIS
WHERE SIS_CODEMP = '003' AND SIS_CODCFG IN ('CFG_REFCIS', 'CFG_SIMPAU', 'CFG_SIMHIB');
```

| Cenário | REFCIS | SIMPAU | SIMHIB | Regra |
|---------|--------|--------|--------|-------|
| C1 | S | N | qualquer | ligada |
| C2 | S | S | S | ligada |
| C3 | S | S | N | desligada |
| C4 | N | qualquer | qualquer | desligada |

A tela avalia a regra ao abrir. Depois de trocar a configuração, feche e reabra o pedido ou a cotação.

No 74.111 e no 72 a `CFG_SIMHIB` é nova: conferir que ela aparece no grupo DADOS FISCAIS da tela de configurações, com
editor Sim/Não, e que alterar ela não desalinha o editor das configurações vizinhas.

## 2. Massas de teste

### Massa A — base completa (conta da spec)

Item com quantidade 10 × 100,00 (total 1.000,00), frete 50,00, despesas acessórias 10,00, IPI 10% e ICMS 12% sobre base
1.000,00. Usar um produto cuja tributação gere esse ICMS. O ICMS não aparece na tela: conferir pelo cadastro fiscal do
produto.

Alíquotas: CBS 0,90 / IBS 0,10 / IS 1,00.

| Conta | Valor |
|-------|-------|
| Base = 1.000 + 50 + 10 − 120 | 940,00 |
| IS = 940,00 × 1% | **9,40** |
| Base CBS/IBS = 940,00 + 9,40 | 949,40 |
| CBS = 949,40 × 0,9% | **8,54** |
| IBS = 949,40 × 0,1% | **0,95** |
| Soma da reforma | 18,89 |
| Unitário c/ Imp. = 100 + (IPI 100,00 + 18,89) / 10 | **111,89** |

### Massa B — produto sem ICMS (mesma do teste de 09/10 na 150)

Item 90401, empresa 003, quantidade 10 × 100,00, IPI 20%, sem frete e sem despesas. Alíquotas: CBS 10 / IBS 11 / IS 12.

| Campo | Regra ligada | Regra desligada |
|-------|--------------|-----------------|
| IS (1.000 × 12%) | 120,00 | oculto |
| CBS ((1.000 + 120) × 10%) | 112,00 | oculto |
| IBS ((1.000 + 120) × 11%) | 123,20 | oculto |
| IPI | 200,00 | 200,00 |
| Unitário c/ Imp. | **155,52** | 120,00 |
| TOTAL do rodapé | **1.555,20** | 1.200,00 |
| Vr. Unitário Liq. | 100,00 | 100,00 |

### Massa C — cotação

Item com quantidade 10, preço 100,00, sem IPI, sem frete. Alíquotas: CBS 10 / IBS 1 / IS 1. Na cotação o cálculo é por
unidade e sem arredondar; o total multiplica pela quantidade.

| Campo | Sem crédito de ICMS | Com crédito de ICMS 12% (onde a versão tem crédito) |
|-------|---------------------|------------------------------------------------------|
| Base por unidade | 100,00 | 88,00 (100 − 12) |
| IS por unidade | 1,00 | 0,88 |
| CBS por unidade | 10,10 | 8,888 |
| IBS por unidade | 1,01 | 0,8888 |
| Unitário c/ impostos (`UNITOT`) | 100,00 (não muda) | 88,00 (não muda) |
| Footer CBS / IBS / IS | 101,00 / 10,10 / 10,00 | 88,88 / 8,89 / 8,80 |
| Valor total do fornecedor | **1.121,10** | **986,57** (880,00 + 106,57) |

## 3. Pedido de Compra

### T01 — Regra ligada, massa A (CA01, CA02)
Cenário C1, depois repetir em C2.
1. Abrir um pedido novo, incluir o item da massa A e informar as alíquotas no painel do item.
2. Conferir no painel: Valor IS 9,40, Valor CBS 8,54, Valor IBS 0,95.
3. Confirmar o item. Conferir no grid as colunas de alíquota e valor (sem edição) e o Unitário c/ Imp. 111,89.
4. Conferir o rodapé: CBS, IBS e IS antes do TOTAL. O TOTAL é o mesmo do cenário C4 mais 18,89.

### T02 — Regra desligada (CA03, CA04, RN03)
Cenários C3 e C4, massa B.
1. Abrir um pedido novo e incluir o item.
2. Os campos de alíquota, as colunas do grid e os totais CBS/IBS/IS do rodapé ficam ocultos.
3. TOTAL 1.200,00; Unitário c/ Imp. 120,00.
4. Abrir um pedido gravado com a regra ligada (o do T01): os valores não aparecem e não somam no total, mas continuam
   gravados no banco (§8).

### T03 — Recálculo (CA05)
Cenário C1, massa A. Alterar um campo por vez e conferir que CBS/IBS/IS, o Unitário c/ Imp. e o rodapé acompanham:
- quantidade de 10 para 20: os valores dobram;
- preço unitário;
- cada desconto (%Des.1 a %Des.6) e o desconto adicional;
- frete e despesas acessórias;
- alíquotas (inclusive voltar para 0).

O valor da prévia no painel tem de ser igual ao do item depois de confirmar.

### T04 — Validação da alíquota (RN07)
- 0,00 e 100,00: aceitos.
- −0,01 e 100,01: recusados com mensagem.
- Campo vazio: vale 0.

### T05 — ICMS desonerado (CA06)
Só onde houver Zona Franca. Não se aplica ao 72.
1. Empresa em estado da regra de Zona Franca e item com ICMS desonerado (`ITE_CICMDE = 'S'`).
2. O ICMS **não** sai da base: na massa A, base 1.060,00, IS 10,60, CBS 9,64, IBS 1,07.
3. Os campos ICMS DESON e DESC. PIS aparecem no rodapé.

### T06 — Pedido de importação (CA07)
1. Marcar Pedido de Importação. Informar II e PIS/COFINS do item.
2. Base = total + frete + despesas + II − PIS − COFINS − ICMS.
3. Conferir a digitação, os totais e a tela `untPedidoCompraImportacao`.

### T07 — Gravar e reabrir (CA08)
1. Gravar o pedido do T01. Fechar e reabrir.
2. Alíquotas, valores, Unitário c/ Imp. e rodapé iguais aos de antes de gravar.
3. Conferir por SQL (§8): `PCD_ALQ*`, `PCD_VAL*`, `PCG_VAL*` e `PCG_TOTGER` com os três impostos.

### T08 — Multi-loja (CA09, RN08)
Massa B com duas empresas: 6 unidades para a loja 1 e 4 para a loja 2.

| Loja | IS | CBS | IBS |
|------|----|-----|-----|
| 1 (6 un.) | 72,00 | 67,20 | 73,92 |
| 2 (4 un.) | 48,00 | 44,80 | 49,28 |
| Total | 120,00 | 112,00 | 123,20 |

As duas lojas recebem as mesmas alíquotas. Conferir os totais por empresa na tela de resumo de lojas.

### T09 — Rodapé em linha corrida (RF03a)
1. Regra ligada: rodapé numa linha só, "RÓTULO: valor", rótulo vermelho em negrito e valor preto, CBS/IBS/IS antes do TOTAL.
2. Diminuir a largura da janela: a linha quebra e a altura do rodapé acompanha. Voltar ao tamanho: volta a uma linha.
3. Regra desligada: CBS/IBS/IS não aparecem.
4. Campos condicionais aparecem e somem com o texto certo: ST/FCP (pedido de importação), ICMS DESON / DESC. PIS
   (Zona Franca), LIT./QUI. ↔ GALÕES (`CFG_USATMQ`).
5. Alterar um valor que muda o total: o rodapé redesenha na hora.
6. Fechar o pedido várias vezes seguidas: sem erro de acesso à memória.

### T10 — Fluxos secundários (CA12)
Com um pedido da massa B gravado, conferir que alíquotas e valores são preservados e que `PCG_VAL*` / `PCG_TOTGER` são
recalculados em:
- [ ] Unificação de pedidos (o total unificado soma CBS/IBS/IS)
- [ ] Recuperação de pedido
- [ ] Distribuição por data de entrega / desmembramento
- [ ] Pasta de compra (o limite/saldo considera CBS/IBS/IS)
- [ ] Baixa e desfaturamento do pedido

### T11 — Impressão, exportação e valor mínimo (CA13, RN10)
- [ ] Impressão HTML do pedido: linhas Valor CBS / IBS / IS.
- [ ] Exportação Excel: alíquotas e valores disponíveis.
- [ ] Validação de valor mínimo do pedido: com a regra ligada, CBS/IBS/IS contam no valor.
- [ ] Parcelas (RN09): com a regra ligada, as duplicatas são geradas sobre o `PCG_TOTGER` com a reforma.

## 4. Cotação

### T12 — Diálogo de valores (RF05, CA10)
Cenário C1, massa C sem crédito.
1. Abrir o diálogo de valores do item × fornecedor e informar as alíquotas.
2. O total do diálogo mostra 1.121,10.
3. Alíquota fora de 0–100: recusada com mensagem.
4. Confirmar e conferir no grid as colunas `% CBS / % IBS / % IS`.

### T13 — Grid, footer e totais (RF06, RF07, CA10, CA14)
1. Massa C sem crédito: footer CBS 101,00 / IBS 10,10 / IS 10,00 e valor total 1.121,10.
2. Com crédito de ICMS 12% (150.x e 72): footer 88,88 / 8,89 / 8,80 e total 986,57.
3. O unitário c/ impostos (`UNITOT`) não muda e a escolha do melhor fornecedor é a mesma de antes do requisito.
4. Gravar, sair e reabrir: alíquotas preservadas e totais iguais.
5. Na lista de cotações, o valor total (`COT_VLRTOT`) inclui CBS/IBS/IS.
6. Regra desligada: colunas ocultas e totais sem os impostos.

### T14 — Exportar e importar arquivo (CA10a, RN10a)
1. Regra ligada: **Exportar Arquivo** gera as colunas `% CBS`, `% IBS` e `% I.S.`.
2. Regra desligada: exporta sem essas colunas.
3. Importar a planilha com as colunas preenchidas: as alíquotas são gravadas. Célula vazia grava 0.
4. Importar uma planilha antiga (sem as colunas): importa sem erro e mantém as alíquotas que já estavam na cotação.
5. Regra desligada: a importação ignora as colunas.

### T15 — Gerar pedido a partir da cotação (CA11, RN11)
1. Escolher o fornecedor da massa C e gerar o pedido.
2. O pedido traz as alíquotas do fornecedor escolhido (10 / 1 / 1).
3. Os valores são recalculados pela base do pedido. Produto sem ICMS: IS 10,00, CBS 101,00, IBS 10,10. Produto com ICMS:
   o ICMS do item sai da base e os valores ficam menores que os da cotação.
4. Abrir o pedido gerado: rodapé, TOTAL e Unitário c/ Imp. com CBS/IBS/IS (como no T01).
5. Conferir por SQL (§8). Referência na 150: cotação 001430 gerou o pedido 000000006296 (emp 003) com CBS 112,00 /
   IBS 123,20 / IS 120,00 e `COT_VLRTOT` 1.355,20.

## 5. Diferenças por versão

| Versão | O que muda no teste |
|--------|---------------------|
| 150, 150.100, 150.45 | Cotação com detalhe por fornecedor; crédito de ICMS conforme a configuração da cotação |
| 74.111 | Cotação pivô (colunas por fornecedor 01..50): testar com o fornecedor na posição 01 e numa posição alta (5ª ou mais). Sem crédito de ICMS. Totais CBS/IBS/IS na linha de cima do painel de totais da aba 3. Modo `COTACAO_MODO_GRAVACAO_ANTIGA=S` fora do escopo (pedido nasce sem CBS/IBS/IS) |
| 72 | Cotação pivô com crédito de ICMS: testar posições 01 e alta, com e sem crédito. O total do diálogo é uma prévia **sem** o crédito; ao gravar, o grid recalcula com o crédito (diferença esperada quando há crédito). Sem ICMS desonerado (T05 não se aplica). No multi-loja, os itens por loja (`PCDDET`) não levam CBS/IBS/IS |

## 6. Encoding (CA15)

Para cada `.pas` / `.dfm` alterado: o arquivo não é UTF-8 válido (é cp1252) e o `svn diff` não mostra troca de quebra de
linha fora dos trechos alterados. Exceções que já eram UTF-8 com BOM no BASE: `autcom.dpr`, `untFuncoesSimples.pas` e
`untPcmGer.pas` dos 7x.

## 7. Build (CA17)

- [ ] `autcom.groupproj` compila (inclui `libPedidoDeCompra`).
- [ ] 150: `Services.groupproj` compila (a unit núcleo entra nos Services que usam `untFuncoesPedidoSimples`).

## 8. Consultas de conferência

```sql
-- Itens do pedido
SELECT PCD_CODITE, PCD_QTDITE, PCD_TOTITE, PCD_TOTIPI,
       PCD_ALQCBS, PCD_ALQIBS, PCD_ALQ_IS, PCD_VALCBS, PCD_VALIBS, PCD_VAL_IS
FROM PCMDET
WHERE PCD_NUMPED = '000000006296' AND PCD_CODEMP = '003';

-- Cabeçalho do pedido: PCG_TOTGER inclui CBS/IBS/IS quando a regra está ligada
SELECT PCG_TOTITE, PCG_TOTIPI, PCG_VALCBS, PCG_VALIBS, PCG_VAL_IS, PCG_TOTGER
FROM PCMGER
WHERE PCG_NUMPED = '000000006296' AND PCG_CODEMP = '003';

-- Alíquotas da cotação por item × fornecedor e valor total
SELECT G.COT_NUMCOT, G.COT_VLRTOT, F.COT_CODFOR, F.COT_CODITE, F.COT_VALUNI,
       F.COT_ALQCBS, F.COT_ALQIBS, F.COT_ALQ_IS
FROM COTGER G
JOIN COTFOR F ON F.COT_SEQGER = G.AUTOINCREM
WHERE G.COT_NUMCOT = '001430' AND G.COT_CODEMP = '003';
```

## 9. Resultado por versão

| Teste | 150 | 150.100 | 150.45 | 74.111 | 72 |
|-------|-----|---------|--------|--------|----|
| Pré-requisitos (§1) | | | | | |
| T01 regra ligada | | | | | |
| T02 regra desligada | | | | | |
| T03 recálculo | | | | | |
| T04 validação | | | | | |
| T05 desonerado | | | | | n/a |
| T06 importação | | | | | |
| T07 gravar/reabrir | | | | | |
| T08 multi-loja | | | | | |
| T09 rodapé | | | | | |
| T10 fluxos secundários | | | | | |
| T11 impressão/exportação | | | | | |
| T12 diálogo cotação | | | | | |
| T13 grid/totais cotação | | | | | |
| T14 exportar/importar | | | | | |
| T15 cotação → pedido | | | | | |
| CA15 encoding | | | | | |
| CA17 build | | | | | |
