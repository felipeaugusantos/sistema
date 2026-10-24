# Req. 455094 — roteiro manual da planilha

Critérios **22** (Microsoft Excel) e **23** (LibreOffice Calc) da `spec.md`. Existem separados porque
o desenvolvimento foi verificado só no LibreOffice — não há Excel na máquina onde o requisito foi
implementado, e é o maior risco residual da entrega.

O que a suíte automatizada já afirma sobre o arquivo está em `casos-a-cobrir.md`. Este roteiro cobre
o que só se vê abrindo: **comportamento de interface**.

## Como obter a planilha

Cotação âncora `02200000000000150022` (número 000149) da empresa 022, base `2_30_BELAT_TC`, três
fornecedores. Os cinco itens têm `COT_GERPED = 'N'` e **preço diferente por fornecedor** — é o que
permite conferir que cada planilha trouxe os preços do seu.

```
POST /api/login                    jwtusername: QUALIDADE   jwtpassword: QUALIDADE@2024
POST /api/cotacao/exportacao/gerar {"sequencialCotacao":"02200000000000150022",
                                    "fornecedores":["28001426"],"enviarEmail":false,
                                    "opcoes":{"todosOsItens":true}}
GET  /api/cotacao/exportacao/{id}                      -> aguardar CONCLUIDO
GET  /api/cotacao/exportacao/{id}/28001426             -> accept do MIME do XLSX
```

`Authorization: Bearer <token>` e `Empresa: 022` vão em **todas** as requisições depois do login,
não só nele. `OperadorLogado: OP1` vai **só no POST** — os dois GET respondem 200 sem ele. Medido em
06/09/2026 contra a API no ar; é também o que o Swagger declara.

| | Authorization | Empresa | OperadorLogado |
|---|---|---|---|
| POST gerar | obrigatório | obrigatório (400) | obrigatório (400) |
| GET andamento | obrigatório | obrigatório (404) | não usado |
| GET download | obrigatório | obrigatório (404) | não usado |

A falta de `Empresa` **não** dá 400: a empresa vira `000` e o erro sai como registro inexistente —
sequencial de cotação no POST, planilha no GET. Despista, porque o problema não está no que o erro
aponta. `OP1` é o comprador da cotação âncora; operador fora da `CADOPE` é recusado no pré-voo.

O `accept` **precisa** ser
`application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`: a rota declara `MVCProduces`
com esse MIME e o DMVCFramework não roteia requisição cujo `Accept` não case.

## Coluna por coluna

A trava e a faixa vêm do `fExportarExcelNovoPrg` em `untCotacao.pas` — o parâmetro depois do
alinhamento é `ABloquear`. **A tabela abaixo é o comportamento da TELA**, e é contra ela que a
planilha da API é conferida. Divergir da tela é o defeito; ser estranho igual à tela, não.

| Coluna | Campo | Esperado | Faixa | 22 Excel | 23 Calc |
|---|---|---|---|---|---|
| Código | `COT_CODITE` | recusa edição | — | ☐ | ☑ 06/09 |
| Código Fábrica | `CODFAB` | recusa edição | — | ☐ | ☑ 06/09 |
| Descrição | `DESITE` | recusa edição | — | ☐ | ☑ 06/09 |
| Observação do Item | `OBSITE` | **aceita** | sem faixa | ☐ | ☑ 06/09 |
| UN | `UNICOM`/`SIGUNI` | recusa edição | — | ☐ | ☑ 06/09 |
| Quant. | `QTDTOT` | aceita | 0 a 99999999 | ☐ | ☑ 06/09 |
| Preço Unit. | `PRECOM_FOR` | aceita | 0 a 99999999 | ☐ | ☑ 06/09 |
| % I.P.I. | `IPI_FOR` | aceita | 0 a 100 | ☐ | ☑ 06/09 |
| Subs. | `ST_FOR` | aceita | 0 a 100 | ☐ | ☑ 06/09 |
| Frete | `FRETE_FOR` | aceita | 0 a 100 | ☐ | ☑ 06/09 |
| Valor Total | `VALTOT` | **aceita** | 0 a 99999999 | ☐ | ☑ 06/09 |
| Obs. do Fornecedor | `COT_OBSITE` | aceita | 0 a 99999999 | ☐ | ☑ 06/09 |
| Divisor | `DIVISO` | aceita | 0 a 99999999 | ☐ | ☑ 06/09 |

**Duas linhas dessa tabela surpreendem.** `Valor Total` é editável embora seja calculado — a tela
permite, e um fornecedor pode querer declarar o total.

A outra é **defeito, não esquisitice**: `Obs. do Fornecedor` é texto e valida como número de 0 a
99999999. Os parâmetros do `AddCampo` são **posicionais**, e em `untCotacao.pas:14946` entrou faixa
numérica numa coluna de texto. A coluna existe para o fornecedor escrever, e recusa escrita — não há
leitura em que isso seja intencional. Mesmo caso em `FABFOR`, "Códigos Fábrica Fornecedor"
(`untCotacao.pas:14887`), que só aparece quando a opção de conteúdo correspondente está ligada.

**O defeito é da tela, não da API.** O `TEscreveHTML.pCriaValidacao`
(`untGeraExcelHtml.pas:1034-1044`) percorre a mesma lista de campos e aplica o mesmo mínimo e máximo
via COM. A planilha que sai da tela hoje recusa texto ali do mesmo jeito. Corrigir só do lado da API
faria divergir da tela, que é o único desvio que a spec proíbe; corrigir a declaração conserta os
dois de uma vez, porque a chamada é compartilhada — e por isso é decisão de escopo, não de
implementação. **Em aberto:** entra no 455094 ou vira requisito separado.

## Estrutura e proteção

| Item | Esperado | 22 Excel | 23 Calc |
|---|---|---|---|
| Abre sem aviso de formato ou de arquivo corrompido | — | ☐ | ☑ 06/09 |
| Desproteger a planilha pede senha | — | ☐ | ☐ |
| Célula travada continua selecionável e copiável | ver nota | ☐ | ☐ |
| Valor fora da faixa recusado com a mensagem declarada | — | ☐ | ☑ 06/09 |

**A nota da célula travada:** a primeira versão declarava `selectLockedCells="1"`, mais restritiva
que a produção — o usuário não conseguia nem clicar. Foi retirado após o spike de 31/08. O
`<sheetProtection>` omite `selectLockedCells` e `selectUnlockedCells` de propósito: o default do
schema é permitir seleção, que é o que o `Worksheet.Protect` do autcom faz.

## Conteúdo

| Item | Esperado | Conferido |
|---|---|---|
| Preço de cada item = `COTFOR.COT_VALUNI` daquele fornecedor | cinco valores **distintos** | ☑ 06/09, contra o banco |
| `TOTAL GERAL` | soma das quantidades | ☑ 06/09 (79) |
| `VALOR TOTAL` | soma de quantidade × preço | ☑ 06/09 (R$ 260,84) |
| Cabeçalho traz número da cotação e comprador | `COTAÇÃO DE PREÇOS: 000149` | ☑ 06/09 |

**O preço é a afirmação que mais importa** e a que quase não foi feita. Se o `AfterScroll` do
dataset não estiver instalado, a planilha sai com o preço de **um item só, repetido em todas as
linhas**, e sem erro nenhum. Conferir contra o banco pega isso e mais três defeitos que a simples
"os valores são diferentes entre si" não pega: preços do fornecedor **errado**, linhas
**deslocadas**, e quantidade errada com preço certo.

## Comparação com a planilha da tela

O teste que decide as pendências abertas. Exportar **os mesmos fornecedores da mesma cotação** pela
tela do autcom e comparar com os arquivos da API.

| O que comparar | Por que | Resultado |
|---|---|---|
| Preço de um item em **dois** fornecedores diferentes | Decide o defeito de posicionamento — ver abaixo | ☐ |
| Digitar texto em `Obs. do Fornecedor` na planilha **da tela** | Confirma que a validação numérica é da tela e não da API | ☐ |
| Digitar texto em `Código Fábrica Fornecedor`, se a opção estiver ligada | Mesmo defeito, segunda ocorrência | ☐ |
| `Observação do Item` aceita edição na planilha da tela | `ABloquear=False` em `untCotacao.pas:14891`; confirmar que a tela faz igual | ☐ |
| Largura das colunas | Diverge por RN15 e não reprova; anotar só se a da tela for **melhor** | ☐ |

**O preço é o item que importa.** Todas as planilhas da API saíram com os preços do primeiro
fornecedor — cabeçalho certo, preço errado. A causa está mapeada: `pAfterScrollDadosExcel` posiciona
o `cdsPrecosItemfornecedor` com `FindKey` de **uma** chave num índice de dois campos
(`COT_CODITE;COT_CODFOR`), e o fornecedor não entra. Esse método é **pré-existente e compartilhado
com a tela**.

Se os arquivos da tela trouxerem preços diferentes entre si, o defeito é só do caminho da API e o
conserto é filtrar por fornecedor. Se vierem iguais, é defeito de produção que antecede este
requisito.

A validação numérica pode ser conferida manualmente, digitando na célula — não precisa de
ferramenta.

## Aparência

| Item | Situação |
|---|---|
| Largura de coluna | Defeito **corrigido** em 06/09 — ver abaixo. Falta reconferir com o próximo binário |
| Mesclagens do cabeçalho | 15 no arquivo de 06/09, cabeçalho legível |

## O que já rodou, e o que falta

Em **06/09/2026**, sobre a planilha real gerada pela API (`COT000149_022_28001426.xlsx`, 4.210
bytes), o critério **23 foi verificado no LibreOffice Calc** e as treze colunas se comportaram
exatamente como a tabela acima descreve.

Falta o critério **22**, no Microsoft Excel, e duas linhas do bloco de proteção que não foram
exercitadas em nenhum dos dois: **desproteger pedindo senha** e **célula travada copiável**.

## Larguras de coluna — defeito corrigido em 06/09/2026

Como estava, medido no arquivo real: coluna A com 4,71, que não comporta um código de 5 dígitos; as
colunas numéricas entre 4,7 e 8,7, mais estreitas que os próprios cabeçalhos; e as duas colunas de
observação com **109,29** cada, vazias. A RN15 aceita *divergência* de largura em relação à tela,
porque no Linux a medida é estimada — não cobre código de item cortado.

**A causa era uma só: duas unidades no mesmo inteiro.** O `AddCampo`
(`untGeraExcelHtml.pas:404-408`) inicia o `intWidth` com a largura do **título em pixels** e depois
o sobrescreve com o `Size` do campo do dataset, que o UniDAC devolve em **bytes** — 765 para um
`varchar(255)`, 300 para um `varchar(100)`. O ramo XLSX dividia tudo por 7 supondo pixel.

Isso explica as três anomalias de uma vez: `109,29 × 7 = 765 = 255 × 3` nas observações,
`42,86 × 7 = 300 = 100 × 3` na descrição, e as colunas sem `Size` ficando com o pixel do cabeçalho
dividido por 7. **O `AddCampo` não foi tocado** — ele alimenta o HTML do Windows, onde a largura é
atributo consultivo.

**Como ficou.** A largura sai do conteúdo que realmente atravessou a coluna, acumulado no
`TOOXMLWorkbook.pFechaLinha`. Célula mesclada não mede, senão o cabeçalho da empresa definiria a
coluna do código. A dica de 73 caracteres das linhas de formulário também não mede — cai na coluna
da descrição por acaso de layout. O rótulo e o valor dessas linhas **medem**: são eles que dizem ao
fornecedor o que preencher, e cortados não servem.

| Coluna | A | B | C | D | E | F | G | H | I | J | K | L | M |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| antes | 4,7 | 21,4 | 42,9 | 109,3 | 4 | 4,7 | 8,7 | 6,3 | 4,7 | 5,6 | 8,7 | 109,3 | 5,6 |
| depois | 24 | 17 | 56 | 20 | 5 | 8 | 13 | 10 | 8 | 9 | 13 | 26 | 9 |

A coluna A fica larga para um código de 5 dígitos porque precisa comportar
`CONDIÇÃO DE PAGAMENTO:`, o rótulo da linha 14. É troca consciente: o alternativo é o fornecedor ler
"CONDIÇ" e não saber o que digitar na célula ao lado.

Os valores até `L` foram conferidos no arquivo gerado; a linha "depois" com A=24 é a simulação da
última correção, ainda pendente de binário novo.
