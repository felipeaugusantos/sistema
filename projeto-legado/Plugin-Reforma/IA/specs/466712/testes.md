# Roteiro de testes — Requisito 466712

**Dono:** analista. Rodar nas 5 versões (72, 74.111, 150, 150.45, 150.100), em base de teste.
**Preparação:**
- compilar o `autcom.exe` e a `libReformaPrecos.dll` do contrato 12 e copiá-los **juntos** para
  `<versão>\padra_atualizado`;
- antes das baterias do Convert, guardar um dump de `ITEGER` (e `PREPRO` no 150.x), `CADITE`, `CFGSIS`
  (`CFG_REFCIS`), `CADEMP` (`EMP_REFCON`), `ABFRTE` e `REGPRO`/`PROALT` ou `REGPRE`/`PREALT`;
- para repetir do zero: apagar as linhas de `ITEREO`, `ITEREF`, `REFCON` e `REFDIV` e voltar `EMP_REFCON`/`CFG_REFCIS`.

Amostra de itens por versão: (a) com REFPRE (DPISCO 6,97, DESOPE e margem diferentes do cadastro); (b) sem REFPRE;
(c) com `IMPFED`/`SUBFED` > 0; (d) em dólar (`PREDOL`); (e) com fator de preço; (f) de grupo de preços
(`ITE_CODGPR`); (g) com `PREVE` = 0 em alguma tabela; (h) 150.x com TARE (`PRO_USATAR`); (i) 74.111 Suframa com
`FRMCUS = 4`.

---

## 1. Estrutura do banco (subida do autcom)
| # | Cenário | Esperado |
|---|---|---|
| 1.1 | Banco sem as tabelas; abrir o autcom e logar | Existem IMPTRI (linha 9/1/0), REFPRE (tabelas 1 a 7), ITEREO, ITEREF, REFCON, REFDIV e `CADEMP.EMP_REFCON` |
| 1.2 | ITEREO/ITEREF | Colunas `ITE_*` com o tipo do ITEGER deste banco; coluna que o ITEGER não tem não aparece |
| 1.3 | Uma coluna apagada à mão (ex.: `REFDIV.DIV_ENCONT`), subir de novo | A coluna volta |
| 1.4 | Subir sem nada faltando | Nenhum DDL roda |
| 1.5 | Sem a DLL na pasta | O autcom sobe normalmente; nada é criado |

## 2. Simulação com `CFG_REFCIS = 'N'`
| # | Cenário | Esperado |
|---|---|---|
| 2.1 | Aba 2, bloco Novo | "Desconto PIS/COFINS 2027(-)" e "Preço Líquido com Desconto" (somente leitura) abaixo do Preço Compra, sem sobreposição; TAB na ordem |
| 2.2 | PRECOM 1.000,00 e desconto 6,97 | Preço líquido 930,30; custo, margem e preços sobre ele; desconto 0 → igual ao PRECOM; 99,99 sem erro |
| 2.3 | Desconto negativo, 100 ou mais | "O Desconto de PIS/COFINS deve ser maior ou igual a Zero e menor que 100!" e o valor anterior volta; vazio = 0 |
| 2.4 | Campos digitáveis | Aba 2 Novo e aba 3: só desconto, despesa operacional, margem/preço/comissão (aba 3: 7 tabelas) e **Preço de Venda com Impostos**; os demais travados |
| 2.5 | Digitar o Preço de Venda com Impostos (abas 2 e 3, clássica e grid) | Preço de venda e margem recalculam; gravar e reabrir: REFPRE com o preço e a margem; o preço com impostos volta igual (diferença só de arredondamento) |
| 2.6 | Mudar a aba 1 (preço de compra, desconto 01, ICMS de saída) | O Novo e a aba 3 acompanham; o que foi digitado nas abas 2/3 fica; `CFG_VENMAR` 1 mantém a margem, 2 mantém o preço |
| 2.7 | Produto sem linha na REFPRE | Desconto 0 e valores do produto; mudar só a aba 1 e gravar não cria linha |
| 2.8 | Alterar e gravar | Uma linha na REFPRE com os valores da tela; reabrir traz o mesmo; gravar de novo mantém uma linha |
| 2.9 | Inclusão (código gerado ao gravar) e inclusão por herança | Linha da REFPRE com o código certo; herança preenche Novo e aba 3 |
| 2.10 | Replicação | Grupo de preço e empresas do preço da matriz recebem a linha; com `CFG_INFMAT`, margem pela configuração da empresa mantendo o preço; responsável pelo fornecedor recebe só o desconto; falha desfaz a gravação do produto |

## 3. Simulação com `CFG_REFCIS = 'S'`
| # | Cenário | Esperado |
|---|---|---|
| 3.1 | Abrir o cadastro | Sem os campos novos; abas iguais à versão anterior |
| 3.2 | Gravar um produto | REFPRE e ITEREF não mudam (simulação só em memória) |

## 4. Menu e acesso
| # | Cenário | Esperado |
|---|---|---|
| 4.1 | Sem a DLL, ou DLL de outro contrato | Menu "Ativar Preços Reforma Tributária" invisível; cadastro sem as abas do plugin, sem erro |
| 4.2 | Operador 998, data antes de 26/12/2026 | Menu visível em Útil, entre o separador e "Operações Referentes a Produtos" |
| 4.3 | Outro operador em 25/12/2026 ou antes | Menu invisível (também na pesquisa de menu) |
| 4.4 | Outro operador com a data do sistema em 26/12/2026 ou depois | Menu visível |
| 4.5 | Empresa com `EMP_PREMAT = 'S'` | Menu invisível |
| 4.6 | Sem direito em `frmCadProdutos` / empresa fora de `EMPRESAS_NESTE_SERVIDOR` / Cadastro de Produtos aberto | Mensagem correspondente; a tela não abre |

## 5. Tela e grupos de preço
| # | Cenário | Esperado |
|---|---|---|
| 5.1 | Abrir a tela | Rádio Opção pela `CFG_VENMAR`; Origem dos Impostos = Tabela Estática; Somente Itens Ativos = Sim; foco na linha do grupo da logada |
| 5.2 | Grid | Uma linha por grupo de preço; conjunto repetido uma vez; contido em outro some; detalhe com as empresas, bolinha Convertida e Situação |
| 5.3 | Grupos que se cruzam / empresa fora do servidor / grupo convertido / `CFG_REFCIS` ligada sem conversão | Checkbox não marca; motivo no clique e na Observação |
| 5.4 | Marcar 2 grupos e Confirmar | O da logada primeiro; troca de empresa e volta à original; lista com o resultado de cada grupo |
| 5.5 | Confirmar e responder Não | Nada é gravado |
| 5.6 | Operador 998 | Campo "Somente os itens" ao lado dos rádios; outro operador não vê o campo |

## 6. Cálculo (abrir cada item da amostra na aba 1 depois e conferir)
| # | Verificação | Esperado |
|---|---|---|
| 6.1 | Preço de compra | (a): `RoundTo(PRECOM_ant × (1 − 0,0697), −DECUNI)`; (b): igual ao anterior |
| 6.2 | Despesa operacional | (a): a da REFPRE; (b): a do cadastro |
| 6.3 | Federais | `IMPFED = SUBFED = 0` (e `ALQFED = 0`) em L e nas F; 150.x também na PREPRO |
| 6.4 | Custo | `ITE_PRECUS` = o que a aba 1 calcula com os mesmos campos |
| 6.5 | Recalcular Preço de Venda | Margem da REFPRE quando houver (tabela por tabela), senão a do ITEGER; preço = o que a aba 1 calcula com essa margem e o custo novo |
| 6.6 | Recalcular Margem + Tabela Estática (IMPTRI 9/1/0) | `PREVEn = RoundTo(PREVEn_ITEGER / (1 + (1 − ICMSAI/100) × 0,10), −4)` (o preço da REFPRE não entra); margem recalculada |
| 6.7 | Abreviação do Item | `ITEREF.ITE_CBS/IBS/IS` = o que a procedure devolve; item sem alíquota: a conversão para antes de calcular e lista o item com o `RET_MENSAGEM` |
| 6.8 | Comissão | REFPRE quando houver, senão ITEGER; nas F a de L; nas R a própria |
| 6.9 | (e) Fator / tabelas inativas | Fator: tabela 1 × fator com qualquer rádio; inativas seguem o rádio |
| 6.10 | F com `CFG_INFMAT` e `INFOPE ≠ 2` | F mantém o DESOPE próprio; preço = o de L; margem pela configuração da F |
| 6.11 | R (responsável pelo fornecedor) | Recebe o custo; preço, IMPFED e DESOPE próprios; margem recalculada; `CFG_REFCIS` da R não muda |
| 6.12 | (f) Grupo de preços | Todos os itens do grupo com os valores do item de maior código; sem divergência `GRUPO` |
| 6.13 | Somente Itens Ativos = Sim / Não | Item inativo fora / dentro da ITEREF; conferência sem `CONTAGEM` |

## 7. Gravação, histórico e LOGREP
| # | Verificação | Esperado |
|---|---|---|
| 7.1 | ITEREO | Idêntica ao dump de antes, para L, F e R |
| 7.2 | ITEREF | Idêntica ao produto depois; `REF_APLICADO = 'S'` |
| 7.3 | 150.x | Um REGPRO "REFORMA TRIBUTARIA - CONVERT" por execução; PROALT da logada com antes/depois; PREPRO = ITEGER; `PRO_CUSTAR` igual ao que o trigger calcularia |
| 7.4 | 72/74.111 | PREALT (trigger com `CFG_RESPRE`, ou `fGravaPreAlt`); na base com trigger ITEGER→PREPRO, a PREPRO igual ao ITEGER |
| 7.5 | CADITE | `ITE_DTAALT`/`ITE_HULALT`/`ITE_CODOPE` atualizados |
| 7.6 | Comparação com a efetivação | Mesma base restaurada duas vezes (Convert × efetivação dos mesmos valores): ITEGER/PREPRO/CADITE/histórico iguais, exceto o texto do local |
| 7.7 | LOGREP | Comandos presentes com os valores (parâmetros já substituídos); um `LOG_IDTRAN` por transação; replay numa 2ª base gera o mesmo resultado |
| 7.8 | ABFRTE (Tabela Estática ou Abreviação) | Todas as linhas com CBS = `IMPTRI.CBS` e IBS UF = `IMPTRI.IBS`; IS, diferimento e redução sem mudar |
| 7.9 | Tempo (registrar) | Itens, tempo da preparação, da aplicação e da conferência; volume da LOGREP |

## 8. Falhas e retomada
| # | Cenário | Esperado |
|---|---|---|
| 8.1 | Matar o autcom no meio da preparação | `REFCON = 'P'`; Continuar prepara só o que falta; resultado igual ao de uma execução contínua |
| 8.2 | Erro forçado no lote 2 (travar uma linha do ITEGER em outra sessão) | Lote 1 aplicado, lote 2 desfeito, mensagem com o lote; Continuar conclui sem duplicar |
| 8.3 | Falha na preparação sem lote aplicado | Tudo da chave apagado; tela volta a "Não convertida" |
| 8.4 | Alterar o preço de um item em outra estação entre a preparação e a aplicação | REFDIV `ALTERADO`; Continuar recalcula e conclui |
| 8.5 | Item excluído entre a preparação e a aplicação | Ativa; REFDIV `EXCLUIDO` |
| 8.6 | Duas estações clicam Confirma | A segunda recebe "já está em execução em outra estação" |
| 8.7 | Retomar | Rádios e filtro voltam com o gravado na REFCON, desabilitados |

## 9. Conferência e ativação
| # | Cenário | Esperado |
|---|---|---|
| 9.1 | Sem divergência | `CFG_REFCIS = 'S'` e `EMP_REFCON = 'S'` em L e nas F; `REFCON = 'C'`; mensagem "Conversão concluída."; grupo não marca mais |
| 9.2 | Divergência forçada (alterar `ITE_PREVE1` por SQL depois da aplicação) e Conferir | `REFCON = 'D'`, REFDIV `VALOR`, nenhuma `CFG_REFCIS` alterada |
| 9.3 | Empresa afetada sem a linha `CFG_REFCIS` | A conversão não começa; nada alterado |
| 9.4 | Incluir um produto depois e Conferir | `CONTAGEM` |
| 9.5 | Loja (outra base) depois da replicação | Ao subir o autcom, `CFG_REFCIS = 'S'` nas empresas com `EMP_REFCON = 'S'` |
| 9.6 | NF-e depois da ativação | Valor contábil soma CBS/IBS/IS (validar com o fiscal) |

## 10. Filtro de itens e Reverter
| # | Cenário | Esperado |
|---|---|---|
| 10.1 | 998 com filtro `'90401', '90402', '90403'` | "Iniciar conversão de 3 item(ns)?"; ITEREF só com esses itens (L e F); `CON_FILITE` gravado; sem `CONTAGEM`; ativação normal |
| 10.2 | Reverter o grupo do 10.1 | ITEGER e PREPRO iguais à ITEREO; histórico "REFORMA TRIBUTARIA - REVERSAO"; ITEREO/ITEREF/REFDIV/REFCON sem linhas da chave; `CFG_REFCIS = 'N'`, `EMP_REFCON = 'R'`; grupo "Revertida" e pode ser marcado |
| 10.3 | Item alterado depois da conversão, Reverter respondendo Não | A lista mostra o item; ele fica como está; os outros voltam |
| 10.4 | Igual, respondendo Sim | Todos voltam, inclusive o alterado |
| 10.5 | Derrubar a conexão no meio da reversão e Reverter de novo | Continua dos lotes que faltam; no fim desativa |
| 10.6 | Loja depois da replicação do 10.2 | `CFG_REFCIS = 'N'` na empresa com `EMP_REFCON = 'R'`; empresa com `'N'` não muda |
| 10.7 | Converter de novo o grupo revertido | Nova chave; conversão normal |
| 10.8 | ABFRTE depois do Reverter | Continua com os valores da IMPTRI |

## 11. Aba 4 "Cálculo Convert"
| # | Cenário | Esperado |
|---|---|---|
| 11.1 | Operador 998 com `CFG_REFCIS = 'N'` | Aba "4 - Cálculo Convert" visível; Ctrl+4 entra nela; outro operador ou empresa convertida: aba ausente e atalhos a pulam |
| 11.2 | Abrir um produto gravado | Campos da aba 3, somente leitura, com o resultado do Convert; rádios Opção e Origem dos Impostos |
| 11.3 | Mudar a aba 3 ou um rádio | A aba 4 recalcula |
| 11.4 | Mudar a margem na aba 3 com Recalcular Preço de Venda | A aba 4 usa a margem da aba 3; produto sem REFPRE e sem edição usa a do ITEGER |
| 11.5 | Converter o item com o filtro do 998 | A aba 1 depois bate com o que a aba 4 mostrava |
| 11.6 | Produto em inclusão, sem PREPRO ou sem alíquota | Campos zerados e o motivo em vermelho |
| 11.7 | Falha ao montar as abas do plugin | Mensagem curta e cadastro como sem o plugin (sem cabeçalho de abas no 150.x) |

## 12. Consulta da conversão (`CFG_REFCIS = 'S'`, base convertida)
| # | Cenário | Esperado |
|---|---|---|
| 12.1 | Abrir o cadastro de produtos | Só as abas 1 e 2 (sem a 3 e sem a 4) |
| 12.2 | Ctrl+3 / Ctrl+PgDn / Ctrl+PgUp | Ctrl+3 não troca de aba; PgDn/PgUp alternam entre 1 e 2 |
| 12.3 | Aba 2 | Títulos "Antes da Conversão" e "Após Conversão"; nenhum campo editável em consulta, inclusão ou alteração |
| 12.4 | 3 produtos da amostra contra `SELECT` na ITEREO/ITEREF (empresa logada, última conversão aplicada) | Antes = ITEREO e Após = ITEREF, campo a campo, inclusive CBS/IBS/IS |
| 12.5 | Calculados | Antes: preço de compra líquido, custo real e custo de venda iguais aos que a aba 1 mostrava antes da conversão; Após: preço com impostos = preço de venda + CBS/IBS/IS da ITEREF |
| 12.6 | `CFG_PCMPRO = '1'` e `CFG_MARIDE` ligada | Margem Ideal não aparece no Antes |
| 12.7 | Inclusão de produto | Os dois grupos em branco, sem mensagem nem erro |
| 12.8 | Navegar entre produtos sem abrir a aba 2 (monitor SQL) | Nenhum SELECT na ITEREO/ITEREF |
| 12.9 | Alterar o produto na aba 1 e voltar à aba 2 | A aba 2 não muda |
| 12.10 | Empresa que usa o preço da matriz (F) | Mostra a linha da própria empresa |
| 12.11 | Grupo revertido (CFG_REFCIS volta a 'N') | O cadastro volta a simular (Partes 1 e 2); abas 2 e 3 editáveis como antes |

---

## 13. Registro de resultados
| Versão | Data | Simulação | Convert | Reverter | Aba 4 | Consulta | Observações |
|---|---|---|---|---|---|---|---|
| 150.100 | | | | | | | |
| 150.45 | | | | | | | |
| 150 | | | | | | | |
| 74.111 | | | | | | | |
| 72 | | | | | | | |
