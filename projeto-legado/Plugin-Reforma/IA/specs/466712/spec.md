# Requisito 466712 — Reforma Tributária: preços de 2027 no cadastro, conversão definitiva e consulta da conversão

**Origem:** une as etapas de trabalho REFTRI-01 (desconto PIS/COFINS 2027 e REFPRE), REFTRI-02 (Convert, "Ativar
Preços Reforma Tributária") e REFTRI-03 (consulta da conversão no cadastro). Esta pasta é a documentação única do requisito: `spec.md`, `plan.md`, `tasks.md`,
`testes.md` e `tabelas.sql`.
**Versões:** 72, 74.111, 150, 150.45 e 150.100. Referência de implementação: 150.100.
**Componentes:** plugin `libReformaPrecos.dll` (external SVN `svn://10.0.0.205/Plugin-Reforma`, o mesmo nas 5 versões) e
os 5 `autcom.exe`.
**Zona:** plugin no padrão moderno (dot-notation, interfaces, sem Hungarian); hosts na zona Legado.
**Contrato exe/DLL atual:** 12. A DLL e os 5 exes são distribuídos juntos.
**Situação em 2026-10-07:** código pronto nas 5 versões; a DLL compila nas 5; os exes ainda não foram compilados nem
testados (ver seção 13).

---

## 1. Contexto

A Reforma Tributária troca PIS/COFINS e impostos federais por CBS, IBS e IS a partir de 2027. O plugin já acrescenta
ao Cadastro de Produtos as abas de simulação de 2027 (REFTRI):

- aba 1: formação de custo atual (do próprio cadastro);
- aba 2: comparativo de custos 2026 × 2027;
- aba 3: formação de custo futura.

A configuração `CFG_REFCIS` (CFGSIS, por empresa) diz se a empresa já opera na reforma. Ela é fiscal: com `'S'` a NF-e
soma CBS/IBS/IS no valor contábil.

O requisito tem três partes:

1. **Antes da conversão (`CFG_REFCIS = 'N'`):** o usuário prepara os preços de 2027 produto a produto, nas abas 2 e 3,
   com um desconto PIS/COFINS 2027 sobre o preço de compra. O que ele digita fica guardado na tabela `REFPRE`, sem
   tocar no produto.
2. **Conversão (Convert):** uma rotina converte de uma vez custo e preço de todos os produtos de um grupo de preço,
   usando o que foi preparado na `REFPRE`, guarda backup antes e depois, confere o resultado e só então liga a
   `CFG_REFCIS`. A conversão pode ser revertida.
3. **Depois da conversão (`CFG_REFCIS = 'S'`):** o cadastro deixa de simular. A aba 3 some e a aba 2 vira consulta,
   somente leitura, do que a conversão fez com o produto: "Antes da Conversão" (ITEREO) ao lado de "Após Conversão"
   (ITEREF).

---

## 2. Visão geral do fluxo

```
Cadastro de Produtos (CFG_REFCIS = 'N')
  abas 2 e 3: desconto PIS/COFINS, despesa, margem, preço, comissão  ──>  REFPRE (por empresa e item)
  aba 4 (só operador 998): simula o que o Convert gravaria para o item

Menu "Ativar Preços Reforma Tributária" (operador 998, ou a partir de 26/12/2026)
  escolhe os grupos de preço  ──>  para cada grupo, logado na empresa do grupo:
    0. ABFRTE recebe CBS e IBS da IMPTRI
    P. Preparação: calcula todos os itens em memória  ──>  ITEREF (novo) + ITEREO (backup)
    A. Aplicação: grava ITEREF no produto, por lote de 100 itens
    C. Conferência: produto × ITEREF  ──>  REFDIV
       sem divergência: CFG_REFCIS = 'S' e EMP_REFCON = 'S' nas empresas do grupo
  Reverter: ITEREO de volta no produto, CFG_REFCIS = 'N', EMP_REFCON = 'R', apaga as tabelas da conversão

Lojas (outras bases): o CADEMP.EMP_REFCON replica; na subida do autcom a sanitização liga ou desliga a CFG_REFCIS

Cadastro de Produtos (CFG_REFCIS = 'S')
  aba 3 oculta; aba 2 somente leitura: Antes da Conversão (ITEREO) × Após Conversão (ITEREF), última conversão aplicada
```

**Convenções:** **L** = empresa logada (a do grupo). **F** = empresa que usa o preço de L (`EMP_PREMAT = 'S'`, de
`fRetEmpresasUsamPrecoMatriz`). **R** = empresa fora do grupo que recebe custo como responsável pelo fornecedor
(`CFG_INFMAT = 'S'`).

---

## 3. Parte 1 — Simulação com desconto PIS/COFINS e REFPRE (origem: REFTRI-01)

Tudo nesta parte vale só com `CFG_REFCIS = 'N'`. Com `'S'` vale a Parte 3 (seção 5); a simulação continua existindo
só em memória, sem ler nem gravar nada (a `ITEREF` passou a ser do Convert).

### 3.1 Telas
- **Aba 2, bloco Novo:** campo "Desconto PIS/COFINS 2027(-)" (%) abaixo do Preço de Compra, editável, e "Preço Líquido
  com Desconto", somente leitura.
- **Aba 3:** o Preço de Compra mostra o Preço Líquido com Desconto e continua editável.
- **Abas 2 e 3:** são digitáveis só os campos gravados na REFPRE (desconto, despesa operacional e, por tabela 1 a 7,
  margem, preço de venda e comissão) e o **Preço de Venda com Impostos** (incluído em 2026-10-06). Digitado, o preço com
  impostos vira preço de venda e margem pela mesma conta da calculadora; são eles que a REFPRE grava.

### 3.2 Regras
- **Preço líquido:** `PRELIQ = RoundTo(PRECOM × (1 − DPISCO/100), −DECUNI)`. Ex.: 1.000,0000 com 6,97% → 930,3000.
  O preço líquido passa a ser a base do custo e de toda a formação nova.
- **Validação do desconto:** `0 ≤ DPISCO < 100`; vazio vale 0. Fora da faixa: "O Desconto de PIS/COFINS deve ser maior
  ou igual a Zero e menor que 100!".
- **Preço de compra digitado na aba 3:** vira o preço líquido; o preço de compra é refeito de trás para frente
  (`PRELIQ / (1 − DPISCO/100)`), o desconto não muda e o preço líquido fica como digitado.
- **Carga:** com linha na REFPRE, desconto, despesa e as 7 tabelas vêm dela (tabela com valor nulo segue o produto);
  sem linha, desconto 0 e o resto do produto. Preço de compra e descontos de fornecedor vêm sempre do produto.
- **Gravação:** dentro da transação do cadastro, upsert pela chave empresa + item (`ogSubstituir`), só quando algum
  campo gravado mudou. Falha desfaz a gravação do produto. O código do item vem do host na gravação (na inclusão ele só
  existe ao gravar).
- **Replicação:** a linha gravada acompanha o que o cadastro faz com os preços nas outras empresas do grupo de preço e
  no responsável pelo fornecedor (`Reforma.Simulacao.Replicacao`).

### 3.3 REFPRE
Uma linha por empresa e item: `REF_ID` (PK auto), `ITE_CODEMP`, `ITE_CODITE` (único juntos), `ITE_DPISCO`,
`ITE_DESOPE` e, por tabela 1 a 7, `ITE_MARBRn`, `ITE_PREVEn`, `ITE_COMTBn`. Sem FK. Criada pela sanitização do plugin
(seção 6). Nada desta parte grava `ITEGER`/`PREPRO`.

---

## 4. Parte 2 — Convert (origem: REFTRI-02)

### 4.1 Menu e acesso
- Menu `mnuConvertReforma` "Ativar Preços Reforma Tributária", em Útil, entre o separador e "Operações Referentes a
  Produtos", nos 5 hosts.
- **Visível** quando: a DLL carrega com o contrato certo; a empresa logada não recebe preço da matriz (`Not fPreMat`);
  e a DLL libera — **operador 998 ou data do sistema a partir de 26/12/2026** (`TConvertServico.Liberado`; o exe só
  passa operador e data, então mudar a data é trocar só a DLL). A tela confere a mesma regra ao abrir ("Disponível a
  partir de 26/12/2026.").
- **Ao clicar**, o host confere, nesta ordem: direito de acesso ao `frmCadProdutos`; empresa que gerencia preço;
  empresa deste servidor (`EMPRESAS_NESTE_SERVIDOR`); Cadastro de Produtos fechado; DLL carregada.

### 4.2 Tela e grupos de preço
- Rádios: **Opção** (Recalcular Preço de Venda / Recalcular Margem; padrão pela `CFG_VENMAR`), **Origem dos Impostos**
  (Tabela Estática = IMPTRI / Abreviação do Item = procedure `pRefTrib_CalculaAliquotasEfetivasItens`) e **Somente
  Itens Ativos** (Sim/Não). Ficam gravados na REFCON e, na retomada, aparecem desabilitados com o valor gravado.
- **Grid por grupo de preço** (`Reforma.Convert.Grupos`): uma linha por grupo, como a coluna Empresas do Preço do
  monitoramento de preço da matriz; conjunto repetido aparece uma vez, conjunto contido em outro some, grupos que se
  cruzam ficam bloqueados. Detalhe com as empresas do grupo, bolinha Convertida e Situação.
- **Checkbox** na 1ª coluna; só marca o grupo que pode ser convertido. Motivos de bloqueio na coluna Observação:
  configuração inconsistente, empresa fora do servidor, grupo já convertido, `CFG_REFCIS` ligada sem conversão.
- O foco abre na linha do grupo da empresa logada (ou na 1ª linha).
- Botões: Confirma (Continuar, quando há conversão em andamento), Conferir, Reverter e Cancela.
- **Processamento:** os grupos marcados, o da logada primeiro. Para cada grupo de outra empresa o host troca a empresa
  logada sem senha (`TrocarEmpresa`, mesmo caminho da rotina automática do autcom); no fim, ou em falha, volta à
  original. Um grupo que falha não para os outros; com mais de um grupo o resultado sai numa lista.
- **Mensagens curtas:** a caixa de mensagem corta texto longo. Mensagem final de sucesso: "Conversão concluída.";
  detalhes vão para a tela de log do host (`MostrarLista`).

### 4.3 Fases e retomada
- **Fase 0 — abreviações:** antes do cálculo, todas as linhas da `ABFRTE` (entrada e saída) recebem `RTE_CBSALQ` =
  `IMPTRI.CBS` e `RTE_IBSUFA` = `IMPTRI.IBS` (1ª linha). IS, diferimento e redução ficam. Sem tabela, coluna, linha na
  IMPTRI ou com valor nulo, aquele campo não muda. Assim a opção Abreviação do Item já calcula com as alíquotas novas.
- **Fase P — preparação (sem efeito em preço):** confere a estrutura e a `CFG_REFCIS` de L e das F; carrega os itens
  do ITEGER de L (ativos, ou todos); no 150.x confere antes que todo item tem PREPRO nas tabelas ativas; calcula cada
  item pelo motor nativo do host, só em memória; grava `ITEREF` (novo) e, na mesma transação, `ITEREO` (backup), em
  blocos de 250 linhas. Itens divididos em lotes de 100.
- **Fase A — aplicação:** por lote, numa transação: confere que o produto não mudou desde a preparação (senão grava
  `ALTERADO`, desfaz o lote e os lotes não aplicados voltam a ser preparados), grava o lote no produto (4.5) e marca o
  lote como aplicado.
- **Fase C — conferência e ativação:** compara o produto com a `ITEREF` e grava `REFDIV`. Sem divergência bloqueante:
  numa transação, `CFG_REFCIS = 'S'` e `EMP_REFCON = 'S'` em L e nas F, `REFCON = 'C'`. Com divergência: `REFCON = 'D'`
  e nada é ativado. O botão Conferir refaz só esta fase.
- **Retomada:** pela `REFCON.CON_FASE` de L — `'P'` prepara só o que falta; `'A'`/`'D'` preparam itens novos, aplicam
  os lotes pendentes e conferem; `'C'` não executa. Falha na Fase P ou A **sem lote aplicado** apaga tudo da chave e
  volta ao início.
- **Trava entre estações:** `GET_LOCK('REFTRI_CONVERT_<empresa>')`.

### 4.4 Origem dos valores e regra de preço (RN09)

| Elemento | Origem |
|---|---|
| Preço de compra | ITEGER.PRECOM × (1 − DPISCO/100); DPISCO da REFPRE (sem linha ou fora de 0 a 100: 0) |
| Despesa operacional | REFPRE.DESOPE quando o item tem linha; senão ITEGER |
| IMPFED, SUBFED, ALQFED | Zerados em L e nas F (R: SUBFED e ALQFED zeram, IMPFED fica) |
| ICMS de saída e demais campos de custo | ITEGER de L |
| Preço de custo | Motor nativo do host (fórmula da versão, Suframa, TARE no 150.x) |
| CBS/IBS/IS | Tabela Estática: 1ª linha da IMPTRI. Abreviação do Item: procedure por item (todos têm de calcular) |
| Comissão por tabela | REFPRE quando houver; senão ITEGER |
| Margem por tabela | Só no rádio Recalcular Preço de Venda: REFPRE quando houver; senão ITEGER |
| Preço de venda por tabela | Só no rádio Recalcular Margem: ITEGER. O preço da REFPRE nunca entra |

| | Recalcular Preço de Venda | Recalcular Margem |
|---|---|---|
| Fica fixo | A margem (REFPRE, senão ITEGER) | O preço com impostos = PREVEn atual do ITEGER |
| Entra no cálculo | Custo novo + margem + comissão | Preço sem impostos = PREVEn / (1 + (1 − ICMSAI/100) × (CBS+IBS+IS)/100), 4 casas |
| É recalculado | O preço de venda | A margem |

Regras por cima do rádio:
- **Fator de preço (`CFG_FATPRE`):** a tabela com fator ativo fica tabela 1 × fator, com a margem recalculada.
- **Tabelas inativas:** seguem o rádio, não a `CFG_VENMAR` (decisão do usuário).
- **Grupo de preços (`ITE_CODGPR`):** os itens do grupo recebem os valores do item de maior código, como o cadastro.
- **F:** preço, preço de compra e campos de custo de L; DESOPE/ICMSAI de L, salvo `INFMAT` com `INFOPE`/`INFSAI` ≠ 2;
  margem de L, ou recalculada pela configuração da F mantendo o preço com `INFMAT`.
- **R:** só os campos de custo de L; mantém o próprio preço, IMPFED e DESOPE; margem pela configuração dela; não liga
  a `CFG_REFCIS`.

A regra fica numa unit só da DLL (`Reforma.Convert.Regra`); o cálculo é sempre do motor nativo do host (150.x:
`TPrecoProduto` em memória; 72/74.111: rotina não visual que reproduz o `untCadProdutos` da versão).

### 4.5 Gravação no produto
Mesmo efeito da efetivação de preços, por conjunto e sem a estrutura lenta dela.

- **150.x (PREPRO é a mestre):** um comando por lote: `SET @_PREPRO_ATUALIZA_ITEGER = 'NAO'` (nenhum trigger de cópia
  age), `UPDATE PREPRO JOIN ITEREF` com o `PRO_CUSTAR` (TARE) calculado no próprio comando, `UPDATE ITEGER JOIN ITEREF
  JOIN CADITE` (campos que o trigger copiava, ALQFED/ALQENT, última alteração do item) e a variável de volta a NULL.
  Histórico: `REGPRO` ("REFORMA TRIBUTARIA - CONVERT") + `PROALT` pelo trigger, só da logada.
- **72/74.111 (ITEGER é a mestre):** `UPDATE ITEGER JOIN ITEREF JOIN CADITE`; na base com trigger ITEGER→PREPRO, a
  PREPRO recebe os mesmos campos num `UPDATE PREPRO JOIN ITEGER` com a variável em `'NAO'`. Histórico pelo trigger
  PREALT (`pPreAltDefineVariaveisAltPre`) ou `fGravaPreAlt` por item.
- Motivo da gravação sem cascata: no 150.100 a cascata de triggers custava 291 s dos 334 s da Fase A (cada linha da
  PREPRO regravava o ITEGER e lia 4 configurações).
- Valores sempre por parâmetro; o comando começa com SET e vai inteiro para a LOGREP, que leva os valores.

### 4.6 Conferência (REFDIV)
Bloqueantes (tolerância 0,000001): `CONTAGEM` (itens do ITEGER × linhas aplicadas, com o filtro de ativos e de itens),
`PENDENTE`, `VALOR` (ITEGER × ITEREF), `PREPRO` (150.x), `FEDERAL`, `PRECOM` e `GRUPO`. Alertas (não bloqueiam):
`EXCLUIDO`, `ALTERADO`, item de F sem linha (`SEM_PREPRO`/`SEM_LINHA`), margem negativa, preço zerado, DPISCO fora da
faixa.

### 4.7 Lojas (outras bases)
A `CFGSIS` não replica; o `CADEMP` sim. Na subida do autcom, a sanitização do plugin liga a `CFG_REFCIS` das empresas
com `EMP_REFCON = 'S'` e desliga a das empresas com `EMP_REFCON = 'R'` (revertidas), só quando há o que mudar.

### 4.8 Reverter
- Botão Reverter, para o grupo selecionado com conversão aplicada; entra na empresa do grupo e volta à original.
- Itens alterados depois da conversão: a lista vai para a tela de log e a pergunta é "Reverter também esses itens?".
  Não: ficam como estão.
- Lote a lote, com progresso "Revertendo preços": a `ITEREO` volta ao produto pela mesma gravação da Fase A (sem
  cascata, ALQFED/ALQENT de antes, histórico com o local "REFORMA TRIBUTARIA - REVERSAO"), e as linhas do lote saem da
  `ITEREO`/`ITEREF`. Parou no meio: Reverter de novo continua.
- No fim, numa transação: `CFG_REFCIS = 'N'`, `EMP_REFCON = 'R'` e `DELETE` da chave em `ITEREO`, `ITEREF`, `REFDIV`
  e `REFCON`. O grupo aparece como "Revertida" e pode ser convertido de novo.
- A `ABFRTE` não volta (não tem empresa e vale para todos os grupos).

### 4.9 Filtro de itens (operador 998)
Campo "Somente os itens" (códigos separados por vírgula, ponto e vírgula, espaço ou linha, com ou sem aspas). A
conversão processa só esses itens (Fase P, pré-checagem e contagem); o filtro fica em `REFCON.CON_FILITE` para a
retomada; a confirmação diz "Iniciar conversão de N item(ns)?". A ativação é a normal; para desfazer, Reverter.

### 4.10 Aba 4 "Cálculo Convert" (operador 998)
- Quarta aba do cadastro, só para o 998 e só antes da conversão. Mostra, somente leitura, o que o Convert gravaria
  para o produto em tela, com os rádios Opção e Origem dos Impostos.
- Base: a aba 3 em memória (preço de compra, desconto, despesa, comissões, custo); preço de venda atual da aba 1;
  margem da aba 3 quando ela estará na REFPRE (linha gravada ou alteração pendente), senão da aba 1 — a mesma regra do
  Convert.
- O cálculo é o do host (`IReformaCalculoConvert.CalcularItemBase`, o mesmo da Fase P, só a logada e sem gravar).
- Recalcula ao mudar a aba 3 ou um rádio. Sem cálculo possível (produto não gravado, sem PREPRO, sem alíquota), o
  motivo aparece em vermelho.
- Se o plugin falhar ao montar as abas, o cadastro fica como sem o plugin.

---

## 5. Parte 3 — Consulta da conversão no cadastro (origem: REFTRI-03)

Tudo nesta parte vale só com `CFG_REFCIS = 'S'` (lida uma vez, ao abrir o cadastro). Com `'N'` valem as Partes 1 e 2.

### 5.1 Abas
- **Aba 3 não aparece.** A DLL decide (`fReformaAbaVisivel(3)` = False com `'S'`) e o host obedece: não cria o frame e
  esconde a página (`tbsCustoFuturo.TabVisible := False`). A aba 4 também não aparece (ela é só antes da conversão).
- **Atalhos:** Ctrl+3 não faz nada com a aba oculta; Ctrl+PgUp/PgDn circulam só pelas abas visíveis (1 ⇄ 2).
- **Aba 2 somente leitura** em consulta, inclusão e alteração: nenhum campo recebe edição.

### 5.2 Conteúdo da aba 2
- O grupo "Cálculo Atual" passa a "**Antes da Conversão**", com os dados da `ITEREO`; o grupo "Cálculo Novo" passa a
  "**Após Conversão**", com os dados da `ITEREF`.
- **Linha lida:** a da empresa logada e do item, na **última conversão aplicada** (ITEREF com `REF_APLICADO = 'S'` e
  maior `REF_ID`); a ITEREO é lida com o mesmo `REF_CHAVE`, para Antes e Após saírem da mesma conversão. A empresa que
  usa o preço da matriz vê a linha dela (origem F).
- **Calculados:** o que as tabelas não guardam é refeito a partir dos valores lidos — Antes: preço de compra líquido,
  custo real, custo de venda e preço em dólar, pelo cálculo do host; Após: preço de compra líquido, custo real e preço
  de venda com impostos, pelo motor do plugin (`grCarga`, que não reescreve custo, preço, margem nem comissão gravados),
  com o CBS/IBS/IS gravado na ITEREF.
- **Campos e formatos:** os mesmos da aba 2, com as mesmas visibilidades por configuração e as mesmas máscaras. Não
  aparecem: Margem Ideal (não está na ITEREO) e Desconto PIS/COFINS / Preço Líquido (o `ITE_PRECOM` da ITEREF já tem o
  desconto aplicado).
- **Coluna ausente na base ou valor nulo:** mostrado como 0.
- **Sem linha** (inclusão, item não convertido, conversão revertida): os dois grupos em branco, sem mensagem.
- **Leitura sob demanda:** as tabelas são lidas ao entrar na aba 2 e só se o item mudou. Navegar sem abrir a aba 2 não
  faz SELECT na ITEREO/ITEREF.
- **Não acompanha a aba 1:** editar o produto não muda a aba 2; ela mostra o registro histórico da conversão.
- **Sem gravação:** com `'S'` as abas não gravam nada (`fReformaPendente` sempre False).

---

## 6. Tabelas

| Tabela | Situação | Chave | Uso |
|---|---|---|---|
| `REFPRE` | nova | `REF_ID`; único empresa + item | Parâmetros de 2027 digitados nas abas 2 e 3 |
| `ITEREF` | nova | `REF_ID`; único `REF_CHAVE` + empresa + item | Valores novos calculados e aplicados (lote, origem L/F/R, situação) |
| `ITEREO` | nova, estrutura igual à ITEREF | idem | Backup dos valores de antes |
| `REFCON` | nova | `CON_ID`; único `CON_CHAVE` + empresa | Estado da conversão por empresa: fase, opções, filtro, operador, datas, contagens |
| `REFDIV` | nova | `DIV_ID` | Divergências e alertas da conferência |
| `IMPTRI` | existente (REFTRI) | 1ª linha | Alíquotas CBS, IBS, IS da Tabela Estática |
| `ABFRTE` | existente | — | Abreviações da reforma; recebe CBS e IBS UF da IMPTRI na conversão |
| `CADEMP.EMP_REFCON` | coluna nova `CHAR(1)` default `'N'` | — | `'S'` convertida, `'R'` revertida; replica para as lojas |
| `CFGSIS.CFG_REFCIS` | existente | — | Liga a reforma na empresa (fiscal) |
| `ITEGER`, `PREPRO`, `CADITE` | existentes | — | Produto: destino da conversão e da reversão |
| `REGPRO`/`PROALT`, `REGPRE`/`PREALT` | existentes | — | Histórico de preço (150.x / 72-74.111) |

Nenhuma tabela nova tem FK, e o Convert não cria nem altera tabela: a **sanitização do plugin**
(`Reforma.Repositorio.Estrutura`, chamada pelo host logo depois do login) cria as que faltam e acrescenta colunas e
índices, com os tipos do ITEGER do próprio banco. A chave da conversão é um GUID gerado na DLL; nenhum valor gravado
vem de `NOW()`/`AUTO_INCREMENT` (a LOGREP reexecuta o texto nas filiais).

---

## 7. Contrato exe/DLL e arquivos

| Contrato | Mudança |
|---|---|
| 5 | Gravação recebe o código do item (REFPRE) |
| 6 | Estrutura do banco na subida do autcom; replicação da REFPRE |
| 7 | Convert: `IReformaConvertHost`, export `fReformaConvertDisponivel` |
| 8 | Consulta da conversão: `fReformaAbaVisivel` (a DLL decide se a aba aparece) |
| 9 | `MostrarLista` (lista na tela de log) |
| 10 | Grupos de preço: `EmpresasPrecoDe`, `TrocarEmpresa` |
| 11 | Aba 4 (`IReformaCalculoConvert`, `fReformaCriarAba4`), Reverter (`ReverterLote`, `DesativarReforma`) |
| 12 | `fReformaConvertDisponivel(Operador, Data)`: regra do menu na DLL |

Versão diferente entre exe e DLL é recusada pelo loader: o cadastro segue sem as abas do plugin e o menu some.

**Plugin:** `Contrato\Reforma.Contrato.*` (Convert novo), `Convert\Reforma.Convert.*` (Servico, Estrutura, Regra,
Processo, Conferencia, Grupos), `Repositorio\Reforma.Repositorio.*` (Refpre, Estrutura, Banco e Conversao, que lê a
ITEREO/ITEREF para a consulta), `Simulacao\Reforma.Simulacao.*` (Modelo, Replicacao, Convert), `Calculo\Reforma.Calculo.*`,
`View\Reforma.View.*` (Convert, CalculoConvert, Comparativo, Futura, FuturaGrid, Validacao, Hospedeira, Estilo),
`Plugin\Reforma.Plugin.pas`, `libReformaPrecos.dpr`.

**Hosts (×5):** `cadastros\untReformaConvertHost.pas` (novo: host do Convert, cálculo por família, gravação de lote,
reversão), `untReformaGravacaoHost.pas` (novo: porta de gravação, transação, consulta), `untReformaHostAdapter.pas`,
`untReformaPrecosLoader.pas`, `untCadProdutos.pas` (código do item na gravação, aba 3 oculta e atalhos com `'S'`,
aba 4), `untPrincipal.pas/.dfm` (menu), `autcom.dpr`. Só nos 150.x: `untPrecoProduto.pas` (2 wrappers de classe para métodos privados de cálculo pela
configuração da empresa).

---

## 8. Requisitos não funcionais

- **LOGREP e transações:** toda escrita pela porta do host (`IReformaGravacao`), com LOGREP; transações curtas (bloco da
  Fase P, lote da Fase A, ativação, lote da reversão); DDL fora de transação de dados; SQL sempre com parâmetros.
- **Fronteira exe/DLL:** nenhuma exceção atravessa; os métodos devolvem `TResultadoGravacao`.
- **Mensagens:** curtas (a caixa corta texto longo); listas e detalhes vão para a tela de log.
- **Pre-commit:** sem `TButton`/`TBitBtn`/`TDBGrid`/`TClientDataSet`, `.SetFocus`, `StrToFloat(`, `Now`,
  `Application.CreateForm(`, `ActiveControl :=`, `FOREIGN_KEY_CHECKS`. Na DLL, `SetFocus` da API do Windows só por
  apelido (`fFocarJanela`).
- **Encoding:** `.pas`/`.dfm`/`.dpr` em cp1252 com o EOL original; `.md` em UTF-8.
- **Desempenho:** preparação só lê o produto (motor reaproveitado para todos os itens); aplicação em poucos comandos
  por lote de 100; sem cascata de triggers.
- **Impacto fiscal e financeiro:** muda custo, preço e margem de todos os produtos e liga uma configuração que altera o
  valor contábil da NF-e. A reversão existe (4.8), mas o cliente deve ser avisado antes.

---

## 9. Critérios de aceitação (resumo)

Simulação (CFG_REFCIS = 'N'):
- [ ] Desconto e preço líquido na aba 2; 1.000,0000 com 6,97% → 930,3000 e custo sobre 930,3000; desconto fora da
      faixa recusado.
- [ ] Aba 3 com o preço líquido no Preço de Compra; editar refaz o preço de compra sem mudar o desconto.
- [ ] Preço de venda com impostos digitável nas abas 2 e 3; recalcula preço de venda e margem.
- [ ] Gravar e reabrir traz os mesmos valores da REFPRE; inclusão grava com o código gerado; uma linha por item.
- [ ] Com `CFG_REFCIS = 'S'`, abas 2 e 3 sem campos novos e sem gravar nada.

Convert:
- [ ] Menu só para o 998 antes de 26/12/2026; para todos a partir dessa data; invisível sem DLL ou em empresa que
      recebe preço da matriz.
- [ ] Grid por grupo, bloqueios com motivo, foco no grupo da logada; dois grupos convertidos com troca e volta de
      empresa.
- [ ] Item com REFPRE (DPISCO 6,97, DESOPE 12): PRECOM e DESOPE novos; sem REFPRE: iguais aos de antes.
- [ ] Federais zerados em L e nas F (e na PREPRO no 150.x); custo, preço e margem iguais aos que a aba 1 calcularia.
- [ ] Recalcular Preço de Venda usa a margem da REFPRE quando houver; Recalcular Margem parte do preço do ITEGER.
- [ ] Fator de preço, tabelas inativas e grupo de preços conforme 4.4.
- [ ] ITEREO igual aos valores de antes; histórico (REGPRO/PROALT ou PREALT) e CADITE atualizados.
- [ ] Erro no lote k: lotes anteriores aplicados; Continuar termina sem duplicar. Produto alterado entre P e A: lote
      desfeito com `ALTERADO`.
- [ ] Conferência limpa: `CFG_REFCIS = 'S'` e `EMP_REFCON = 'S'`; divergência forçada: `REFCON = 'D'` sem ativar.
- [ ] ABFRTE com CBS e IBS UF da IMPTRI depois de converter; IS, diferimento e redução intactos.
- [ ] Reverter: produto igual à ITEREO, histórico de reversão, `CFG_REFCIS = 'N'`, `EMP_REFCON = 'R'`, tabelas da
      chave vazias; item alterado respeita a resposta do operador.
- [ ] Loja: sobe o autcom e a `CFG_REFCIS` segue o `EMP_REFCON` ('S' liga, 'R' desliga).
- [ ] Filtro do 998 converte só os itens informados; aba 4 mostra o mesmo que a conversão grava para o item.
- [ ] Duas estações ao mesmo tempo: a segunda recebe a mensagem de trava.
- [ ] Exe e DLL de contratos diferentes: plugin recusado sem erro.

Consulta da conversão (CFG_REFCIS = 'S'):
- [ ] Só as abas 1 e 2; Ctrl+3 não troca de aba; Ctrl+PgUp/PgDn alternam entre 1 e 2.
- [ ] Títulos "Antes da Conversão" e "Após Conversão"; nenhum campo editável em consulta, inclusão ou alteração.
- [ ] Antes e Após batem campo a campo com a ITEREO e a ITEREF da última conversão aplicada (empresa logada + item),
      inclusive CBS/IBS/IS; calculados do Antes iguais aos que a aba 1 mostrava antes da conversão.
- [ ] Margem Ideal oculta; produto sem linha com os grupos em branco, sem mensagem.
- [ ] Navegar sem abrir a aba 2 não gera SELECT na ITEREO/ITEREF; editar a aba 1 não muda a aba 2.

Roteiro detalhado: `testes.md` desta pasta.

---

## 10. Fora de escopo

- Na consulta da conversão: tabelas de preço 2 a 7 (a aba 2 só tem a tabela 1), Margem Ideal, Desconto PIS/COFINS e
  Preço Líquido; linhas de outras empresas ou de conversões anteriores; reler a `CFG_REFCIS` durante a sessão.
- Trava de variação de preço da efetivação (`CFG_PCPRVE`).
- Prefixo "GRUPO DE PREÇOS - " na PROALT dos itens do grupo.
- Alíquota por NCM (fica a IMPTRI ou a abreviação).
- Bugs do levantamento não ligados ao Convert (`pAtualizaIteGer(True)` do 74.111, vazamentos no monitoramento de preço
  da matriz, `PrecosDaMatriz` fixo no adapter do 150.x).
- Atualizar o cache da `CFG_REFCIS` em estações já abertas (precisam sair e entrar).

---

## 11. Decisões do usuário

| Data | Decisão |
|---|---|
| 2026-10-02 | REFPRE só com `CFG_REFCIS = 'N'`; com `'S'` nada muda; preço de compra editável na aba 3 recalculando o PRECOM |
| 2026-10-03 | Tabelas criadas pela sanitização do plugin; ativação tudo ou nada; PROALT só da logada; tabelas inativas seguem o rádio; grupo de preços: vale o último processado |
| 2026-10-05 | Consulta da conversão: aba 3 oculta e aba 2 Antes/Após com `CFG_REFCIS = 'S'`; lê a última conversão aplicada ao item, com a ITEREO da mesma chave |
| 2026-10-05 | Rádio Recalcular Preço de Venda mantém a margem; rádios Origem dos Impostos e Somente Itens Ativos; sem `ITE_PEFAVE`; ALQFED/ALQENT zerados; comissão e DESOPE da REFPRE; falha sem lote aplicado volta ao início |
| 2026-10-06 | Conversão por grupo de preço com troca de empresa; `EMP_REFCON`; Fase A sem cascata de triggers; mensagem final curta; aba 4 do 998; Reverter (perguntar sobre alterados, gravar histórico, apagar as tabelas da chave); filtro de itens do 998; preço com impostos editável; margem da REFPRE no Recalcular Preço de Venda; ABFRTE com CBS e IBS UF da IMPTRI antes do cálculo, sem volta no Reverter |
| 2026-10-07 | Menu liberado para todos a partir de 26/12/2026 (inclusive) |

---

## 12. Riscos

- **Exe e DLL fora de sincronia:** o exe esquecido fica sem as abas e sem o menu, sem erro.
- **Reprodução por conjunto × rotina nativa:** mitigada pela conferência, que bloqueia a ativação, e pela aba 4.
- **Volume da LOGREP:** ITEREF/ITEREO geram bastante replicação; sem impacto funcional.
- **Cache da `CFG_REFCIS`:** estações abertas precisam sair e entrar depois da ativação ou da reversão.
- **Fiscal:** com `CFG_REFCIS = 'S'` a NF-e soma CBS/IBS/IS no valor contábil.

---

## 13. Situação e pendências (2026-10-07)

- [ ] Compilar os 5 `autcom.exe` no IDE com o contrato 12 e distribuir junto com a DLL.
- [ ] Testes manuais do `testes.md` nas 5 versões e revisão com o analista.
- [ ] Testes automatizados na suíte DUnit (há um DUnit isolado do cálculo do desconto, fora da suíte do projeto).
- [ ] Gate DelphAI e commit do plugin com os 5 hosts, primeira linha `Req. 466712`.
- Auditoria (`/citel-aprovaRequisito`, 2026-10-07): bloqueantes de código corrigidos (SQL por parâmetro, `try`/`finally`).
  Ficam para justificar no commit:
  - variáveis de unit em `Reforma.Plugin.pas`: a DLL exporta funções soltas sem objeto do host, então o estado das
    abas precisa ficar na unit (padrão já existente no plugin);
  - listas de empresas concatenadas para a rotina nativa `fSQLRecalculaItensResponsavelFornecedor`, que recebe a lista
    pronta (códigos do CADEMP, nunca digitados);
  - `pAjustarFundoTema` em `untPrecoProdutoFrame`/`untTabelasDoItemGrid`: é do RF11 (skin) do REFTRI, não deste
    requisito.
- Não commitar: `opcoes.ini`, `rev.inc`, `*.dproj.local`, a linha `Debugger_HostApplication` do
  `libReformaPrecos.dproj`, `review.diff`, `.delphAI`, `Prototipo`, `__recovery`, `dcu`.
- Pendências antigas de desempenho: medir o lote de 100 no 150.100 e testar a gravação sem cascata nas bases do
  72/74.111 (`2_30_72_COM`, `2_30_74_XX_COM`).
