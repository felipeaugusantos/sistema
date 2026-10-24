# Análise — Req. 466712: preços da Reforma Tributária no cadastro, Convert e consulta da conversão

**Data do registro:** 2026-10-07
**Escopo:** etapas de trabalho REFTRI-01, REFTRI-02 e REFTRI-03, unificadas no requisito 466712.
**Versões:** 72, 74.111, 150, 150.45 e 150.100 (referência: 150.100).
**Componentes:** plugin `libReformaPrecos.dll` (external SVN `svn://10.0.0.205/Plugin-Reforma`, comum às 5 versões) e os
5 `autcom.exe`. Contrato exe/DLL final: 12.
**Documentos da pasta:** `spec.md` (requisito), `plan.md` (desenho técnico), `tasks.md` (andamento), `testes.md` e
`Roteiro_Teste_466712.txt` (testes), `tabelas.sql` (estrutura de referência). Este arquivo registra o caminho que levou
à solução: decisões, abordagens descartadas, problemas encontrados e pendências.

---

## 1. Contexto de negócio

- A partir de 2027 a Reforma Tributária substitui PIS/COFINS e impostos federais por CBS, IBS e IS. O preço de compra
  dos produtos deixa de carregar PIS/COFINS (daí o "desconto PIS/COFINS 2027"), os impostos federais de saída deixam de
  existir e o preço ao cliente passa a embutir CBS/IBS/IS.
- O plugin já existia (etapa REFTRI): sub-abas no cadastro de produtos com a formação atual (aba 1, do próprio
  cadastro), o comparativo 2026 × 2027 (aba 2) e a formação futura (aba 3), só como simulação.
- `CFGSIS.CFG_REFCIS` é a configuração fiscal "REFORMA TRIBUTÁRIA - Somar impostos CBS/IBS/IS no Valor Contábil do
  Documento?". Com `'S'` a NF-e muda; por isso ela só pode ser ligada quando os preços da empresa estão convertidos.
- Necessidade do cliente, em três momentos:
  1. **Preparar** (CFG_REFCIS = 'N'): definir produto a produto o desconto PIS/COFINS, a despesa operacional, a margem, o
     preço e a comissão de 2027, sem mexer no produto.
  2. **Converter**: aplicar tudo de uma vez em todos os produtos de um grupo de preço, com backup, conferência e só então
     ligar a CFG_REFCIS; poder desfazer.
  3. **Consultar** (CFG_REFCIS = 'S'): ver no cadastro o que a conversão mudou em cada produto.

---

## 2. Parte 1 — preparação com desconto PIS/COFINS e REFPRE (REFTRI-01)

### 2.1 O que foi feito
- `TFormacaoCusto` ganhou `DescontoPisCofins` e `PrecoCompraComDesconto`. O desconto entra **antes** da chamada ao host:
  o preço enviado como preço de compra é o líquido (`PRECOM × (1 − DPISCO/100)`, arredondado a `DECUNI`). Assim
  nenhuma fórmula de custo dos 5 hosts mudou.
- Gatilho `grPrecoLiquido`: o preço de compra digitado na aba 3 é o líquido; o PRECOM é refeito de trás para frente e o
  líquido digitado é preservado (sem isso o arredondamento devolvia outro valor).
- Tabela nova `REFPRE` (empresa + item, `ITE_DPISCO`, `ITE_DESOPE` e margem/preço/comissão das tabelas 1 a 7), gravada
  por upsert (`ogSubstituir` → `INSERT ... ON DUPLICATE KEY UPDATE`) dentro da transação do cadastro, com LOGREP.
- O código do item passou a ser enviado pelo host na gravação (contrato 5), porque na inclusão ele só existe ao gravar.
- Só os campos que a REFPRE guarda são digitáveis nas abas 2 e 3; o resto segue o produto (aba 1 → Novo → aba 3). Em
  2026-10-06 o **Preço de Venda com Impostos** passou a ser digitável também (vira preço de venda e margem pela conta da
  calculadora, `grPrecoCliente`; o caminho já existia, faltava liberar no `TSimulacaoReforma.CampoEditavel`).
- Contrato 6: a estrutura do banco passou a ser criada e ajustada na subida do autcom (`Reforma.Repositorio.Estrutura`,
  fonte única do DDL), e a linha da REFPRE passou a acompanhar a replicação de preço do cadastro (grupo de preço,
  empresas do preço da matriz, responsável pelo fornecedor).

### 2.2 Decisões
- Com `CFG_REFCIS = 'S'` nada da Parte 1 vale; a simulação passou a viver só em memória (antes gravava na ITEREF, que
  passou a ser do Convert).
- REFPRE sem FK para ITEGER; `ITE_CODITE VARCHAR(7)` mantido por decisão do usuário.
- Carga em duas etapas (`grInicial` + `grCargaParametros`): desconto, despesa e comissão antes do recálculo inicial;
  preço e margem gravados repostos depois.

---

## 3. Parte 2 — Convert "Ativar Preços Reforma Tributária" (REFTRI-02)

### 3.1 Arquitetura escolhida
- **A DLL decide o quê; o host decide como.** A DLL escolhe os itens, o preço de compra novo, a despesa, zera os
  federais, define o alvo (preço ou margem) por tabela, faz lotes, backup, conferência e ativação. O host calcula pelo
  motor nativo (150.x: `TPrecoProduto` em memória; 72/74.111: rotina que reproduz o `untCadProdutos` da versão) e grava
  pelas regras da família. Motivo: regras de custo e preço diferem muito entre as versões e não podiam ser duplicadas na
  DLL; e a regra de preço do negócio muda com frequência, então ficou isolada em `Reforma.Convert.Regra`.
- O Convert recebe o próprio host (`IReformaConvertHost`) no export e nunca usa o estado do cadastro (`GHost`,
  `GSimulacao`). Como a DLL pode estar carregada pelo cadastro e pelo menu ao mesmo tempo, o menu exige o cadastro
  fechado.
- **Fases:** 0 (abreviações), P (preparação: tudo calculado em memória e gravado na ITEREF/ITEREO sem tocar no produto),
  A (aplicação por lote), C (conferência e ativação). Retomada pela `REFCON.CON_FASE`; trava entre estações por
  `GET_LOCK`.

### 3.2 Regra de preço — evolução
1. 2026-10-03 (PEND-01): preço e margem viriam da REFPRE; sem REFPRE, do ITEGER.
2. 2026-10-05 (redefinida pelo usuário): "Recalcular Margem" = preço atual do ITEGER levado ao preço sem CBS/IBS/IS
   (`PREVEn / (1 + (1 − ICMSAI/100) × (CBS+IBS+IS)/100)`, conta de `TCalculadoraPrecoCliente.fAtualizaPrecoVenda`);
   "Recalcular Preço de Venda" = margem do ITEGER mantida (primeira versão mantinha o preço, corrigida no mesmo dia).
   Preço/margem da REFPRE deixaram de entrar; comissão e despesa da REFPRE ficaram.
3. 2026-10-06: o usuário pediu que a aba 4 usasse a margem da aba 3. Como isso contrariava a decisão do dia 5, foi
   perguntado; a resposta definiu: no "Recalcular Preço de Venda" a margem vem da REFPRE quando houver, senão do ITEGER;
   no "Recalcular Margem" continua o preço do ITEGER. Aplicado no Convert (`MargemRefpre` em `TItemOrigemConversao`) e na
   aba 4 (`TSimulacaoReforma.MargemNaRefpre`: a margem da aba 3 vale quando a linha da REFPRE tem a tabela ou há
   alteração pendente, porque a REFPRE grava as 7 tabelas de uma vez).

### 3.3 Grupos de preço (contrato 10)
- O cliente tem várias matrizes no mesmo servidor. O grid passou a ser por grupo de preço (como o monitoramento de
  empresas que usam o preço da matriz), com checkbox, detalhe e bloqueios com motivo. Para cada grupo de outra empresa o
  host troca a empresa logada sem senha (`TrocarEmpresa`, mesmo caminho da rotina automática do autcom, sem `fLogoff`) e
  volta à original no fim.
- `CADEMP.EMP_REFCON` foi criado porque a `CFGSIS` não replica e o `CADEMP` sim: nas lojas, a sanitização na subida do
  autcom liga a CFG_REFCIS das empresas com `EMP_REFCON = 'S'`.

### 3.4 Desempenho — gravação sem cascata de triggers
- Problema medido no 150.100: a Fase A levava 334 s, dos quais 291 s eram cascata de triggers. Com
  `@_PREPRO_ATUALIZA_ITEGER = 'SIM'`, cada linha da PREPRO (7 por item e empresa) regravava o ITEGER e lia 4
  configurações da CFGSIS.
- Solução: um comando por lote com `SET @_PREPRO_ATUALIZA_ITEGER = 'NAO'` (nenhum trigger de cópia age), `UPDATE PREPRO
  JOIN ITEREF` com o `PRO_CUSTAR` (TARE) calculado no próprio comando pela mesma função e configurações do trigger,
  `UPDATE ITEGER JOIN ITEREF JOIN CADITE` uma vez por item e empresa, e a variável de volta a NULL. O histórico PROALT
  continua saindo pelo trigger, que não depende da variável. No 72/74.111 o mesmo raciocínio com o trigger ITEGER→PREPRO.
- Lote: era 1.000 itens (tela congelava ~2 minutos por lote), foi a 10 e depois a 100. A ITEREF é gravada em INSERTs de
  250 linhas, com a ITEREO do mesmo bloco na mesma transação (nunca fica ITEREF sem backup).
- Pendência: medir o lote de 100 no 150.100 e a gravação sem cascata nas bases do 72/74.111.

### 3.5 Reverter (contrato 11)
- A `ITEREO` volta ao produto pela mesma gravação da Fase A (`fGravarLote` com origem ITEREO), lote a lote, com
  histórico próprio ("REFORMA TRIBUTARIA - REVERSAO"). Itens alterados depois da conversão: o operador decide.
- Primeira versão marcava as linhas com `'R'` e deixava a REFCON em fase `'R'`, que era o sinal para a loja desligar a
  CFG_REFCIS. O usuário pediu para **apagar** ITEREO, ITEREF, REFDIV e REFCON da chave; com a REFCON apagada o sinal
  sumiria. Solução: o sinal passou para `CADEMP.EMP_REFCON = 'R'` (replica), e a sanitização da loja desliga a
  CFG_REFCIS quando vê `'R'`. Empresa convertida antes do campo existir (`'N'`) não é afetada.
- A `ABFRTE` não volta no Reverter (decisão do usuário): ela não tem empresa e vale para todos os grupos.

### 3.6 Outras regras pedidas durante a implementação
- **Filtro de itens do operador 998** para validar com poucos itens; gravado em `REFCON.CON_FILITE` para a retomada.
- **Aba 4 "Cálculo Convert"** (998, antes da conversão): mostra o que o Convert gravaria para o item, pelo mesmo
  cálculo do host (`IReformaCalculoConvert.CalcularItemBase`).
- **Menu** só para o 998 ou a partir de 26/12/2026 (primeiro "depois de 26/12", corrigido pelo usuário para "a partir
  de"). A regra fica na DLL (`TConvertServico.Liberado`); o exe passa operador e data (contrato 12), para mudar a data
  trocando só a DLL.
- **ABFRTE**: antes do cálculo, `RTE_CBSALQ` e `RTE_IBSUFA` de todas as abreviações recebem CBS e IBS da IMPTRI
  (decisões do usuário: só esses dois campos, no início, sem volta no Reverter).
- **Mensagens curtas**: a caixa de mensagem corta texto longo; a mensagem final virou "Conversão concluída." e listas
  vão para a tela de log do host (`MostrarLista`).

---

## 4. Parte 3 — consulta da conversão (REFTRI-03)

- Com `CFG_REFCIS = 'S'` a DLL diz que a aba 3 não aparece (`fReformaAbaVisivel`, contrato 8) e a aba 2 entra em modo
  conversão: "Antes da Conversão" (ITEREO) × "Após Conversão" (ITEREF), tudo somente leitura.
- A linha lida é a da **última conversão aplicada** (ITEREF com `REF_APLICADO = 'S'` e maior `REF_ID`), com a ITEREO
  da mesma chave — decisão do usuário depois que a chave da ITEREO/ITEREF passou a incluir `REF_CHAVE` (uma loja pode
  estar em mais de uma conversão).
- Calculados refeitos: Antes pelo cálculo do host com a ITEREO no lugar do produto; Após por `grCarga`. Foi conferido
  (código e teste local) que `grCarga` não reescreve custo, preço, margem nem comissão gravados, então o "plano B" não
  foi preciso.
- Leitura sob demanda (só ao entrar na aba 2 e com o item mudado) e falha silenciosa (grupos em branco).
- Atalhos Ctrl+n e Ctrl+PgUp/PgDn passaram a pular abas ocultas (também usados depois pela aba 4).

---

## 5. Problemas encontrados e como foram resolvidos

| Problema | Situação | Solução |
|---|---|---|
| "fCriarAba4: Control '' has no parent window" ao abrir o cadastro | O painel da aba 4 criava os `TRadioGroup` antes de ter janela pai; o rádio cria os botões na hora | O construtor `TpnlCalculoConvert.Criar` recebe o pai e define `Parent` antes de criar os rádios |
| Falha do plugin deixava o 150.x com o cabeçalho "1 - Formação de Custo Atual" | `pReformaMontarAbas` só escondia as abas 2 a 4 | Na falha de montagem, o `pgcPrecos` some e o frame de preços volta ao lugar de antes, como sem o plugin (72/74.111 já faziam) |
| Foco do grid do Convert não ia para a empresa logada | `ActiveControl` do DFM não vale numa tela modal da DLL | `DoShow` posta uma mensagem e o foco é dado depois de a tela aparecer, na linha do grupo da logada |
| Menu do Convert apareceria para todos com a regra no exe | Regra de negócio presa ao exe | Regra na DLL com operador e data passados pelo exe (contrato 12) |
| Literais no SQL de gravação e no filtro do 998 (auditoria) | Concatenação; o filtro aceitava texto digitado (`QuotedStr` não escapa barra invertida no MySQL) | Tudo por parâmetro; nomes distintos por comando (`CHAVE_P`/`CHAVE_G`) num mesmo texto. Confirmado que a LOGREP aceita parâmetros: o gancho do UniDAC (`ParseSQLCitel`, `untModuloReplicacao`) substitui os valores antes de gravar |
| Objetos criados em sequência antes do `try` (auditoria) | Se o 2º `Create` falhasse, o 1º vazava | Só o primeiro antes do `try`; os demais dentro, `finally` libera (Free de nil é seguro) |
| DLL do 150.100 com 15 MB em vez de 11 MB | A IDE acrescentou `cxDataControllerConditionalFormattingRulesManagerDialog` no `uses` da tela do Convert | Unit removida; atenção a cada edição pela IDE |
| Ruído de DFM da IDE (`ActivePage`, `Explicit*`, espaço em `Caption`) | Diff com centenas de linhas sem mudança real | Descartado antes do commit |

---

## 6. Abordagens descartadas

- **Regra de preço com preço e margem da REFPRE** (2026-10-03): trocada pelo usuário em 2026-10-05; só a margem voltou,
  e só no rádio Recalcular Preço de Venda (2026-10-06).
- **Grid de todas as empresas da logada** (primeira tela): trocado pelo grid por grupo de preço.
- **Lote de 1.000 e depois de 10**: 1.000 congelava a tela; 10 gerava comandos demais; ficou 100.
- **Gravação pelos triggers da PREPRO**: correta mas lenta (291 s de 334 s); substituída pela gravação sem cascata.
- **Valores como literais com `ParamCheck := False`** na gravação de lote (o motivo era a hora com ':' no texto e evitar
  parâmetro repetido): trocado por parâmetros com nomes distintos depois da auditoria.
- **REFCON 'R' como sinal de reversão**: inviável quando o usuário pediu para apagar a REFCON; trocado por
  `EMP_REFCON = 'R'`.
- **Menu decidido no exe**: trocado pela regra na DLL.
- **Exceção para as variáveis de unit do `Reforma.Plugin`**: avaliado agrupar num objeto global, mas seria só mudar o
  nome; a DLL exporta funções soltas, sem objeto do host, e o estado das abas tem de ficar na unit.

---

## 7. Decisões de escopo

- Fora: trava de variação de preço da efetivação (`CFG_PCPRVE`); prefixo "GRUPO DE PREÇOS - " na PROALT; alíquota por
  NCM; validar `OPE_EMPLOG` nas empresas dos grupos; reler a CFG_REFCIS durante a sessão (as estações saem e entram);
  na consulta, tabelas 2 a 7, Margem Ideal e linhas de conversões anteriores.
- Fica de propósito: tabelas inativas seguem o rádio (não a `CFG_VENMAR`); PROALT só da logada; ativação tudo ou nada;
  grupo de preços com o valor do último item processado (maior código), como o cadastro.
- `pAjustarFundoTema` (`untPrecoProdutoFrame`, `untTabelasDoItemGrid`) é do RF11 (skin) da etapa REFTRI, não destas;
  vai no commit com justificativa ou separado.

---

## 8. Achados colaterais não corrigidos

- `pAtualizaIteGer(True)` do 74.111 com parâmetros fora do SQL (`TCIFCU..FATREG`).
- Vazamentos de `TfrmMonitoramentoEmpresasPrecoMatriz`/`TMonitoramentoEmpresasPrecoMatriz` e o `Column10GetDataText`
  daquela tela.
- `PrecosDaMatriz := False` fixo no adapter do 150.x.
- Concatenação de lista de empresas exigida pela rotina nativa `fSQLRecalculaItensResponsavelFornecedor` (códigos do
  CADEMP, sem entrada do usuário).

---

## 9. Situação e pendências (2026-10-07)

- Código pronto nas 5 versões; DLL compila nas 5 e as cópias do plugin estão idênticas.
- Os exes não compilam pela linha de comando (faltam os pacotes .bpl/.dcp); o usuário compila no IDE. Nada do
  contrato 12 foi testado no autcom ainda.
- Pendências: compilar os 5 exes; rodar o `Roteiro_Teste_466712.txt`; levar o DUnit do cálculo para a suíte do projeto;
  medir desempenho; aprovação e DelphAI; commit do plugin junto com os 5 hosts (`Req. 466712`), sem `opcoes.ini`,
  `rev.inc`, `*.dproj.local`, a linha `Debugger_HostApplication` do `libReformaPrecos.dproj`, `review.diff` e `.delphAI`.

---

## 10. Lições de ferramenta e processo

- Fontes Delphi são cp1252 com EOL próprio: nunca editar com ferramenta que grava UTF-8; usar edição byte-safe com
  âncora única e conferir a contagem de caracteres não-ASCII. Arquivo `.pas` novo: cp1252 com CRLF.
- Scripts de edição que aplicam várias trocas não são idempotentes: se uma âncora falha no meio, as anteriores já foram
  gravadas. Ensaiar antes contando as âncoras sem gravar e conferir o resultado depois de cada execução.
- A IDE acrescenta units e reescreve DFMs sozinha; conferir o `svn diff` antes de commitar.
- A DLL não pode ser copiada com o autcom aberto (arquivo em uso).
- O plugin é um external comum às 5 versões: diretivas de depuração (ex.: `REFTRI_CONVERT_TEMPO`) ligadas numa cópia
  vão para todas no commit.
- Escrita direta no banco e `svn revert` são bloqueados pelo modo automático; o usuário executa.
