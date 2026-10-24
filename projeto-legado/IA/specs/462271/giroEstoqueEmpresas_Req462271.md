# Análise Técnica — Req. 462271

## 1. Contexto de negócio

O formulário "Estoque das Empresas" (acessado a partir de `[ JZ ] CONSULTAS DE PRODUTO`) exibe, para um item
selecionado, o saldo e os principais indicadores de estoque em cada empresa/filial cadastrada. Entre esses
indicadores estão três colunas de **giro de vendas**: "Giro 3 meses", "Giro 6 meses" e "Giro 12 meses", que somam
as saídas (vendas) do item nos últimos 3, 6 e 12 meses corridos, por empresa. Esse indicador ajuda o usuário
(setor de suprimentos/compras) a avaliar a velocidade de venda de um item por loja, apoiando decisões de compra e
redistribuição de estoque.

Essa funcionalidade foi implementada originalmente na cópia SVN `379.48.2.30.72`, sob o **Req. 363961**, em duas
revisões:

- **Revisão 408064** (10/02/2025, marcio.azzarini) — introduziu a função `fGetSqlGiro` em `untCadProdutos.pas`
  (tela de Cadastro de Produtos) e, na sequência, criou uma versão genérica dessa mesma lógica —
  `fGetSqlGiroProdutoPeriodo` — em `untFuncoes.pas`, reutilizada em `untFatMostraEstoqueEmp.pas` (novo
  `procedure pCalculaGiroMeses` e 3 novas colunas de grid).
- **Revisão 408973** (17/02/2025, marcio.azzarini) — moveu `fGetSqlGiroProdutoPeriodo` de `untFuncoes.pas` para
  `untFuncoesSimples.pas` (local definitivo da função), sem alterar seu comportamento.

## 2. Problema identificado (Req. 462271)

O ticket relatou que, no ambiente de homologação, as colunas de Giro 3/6/12 meses "aparecem, mas ficam vazias",
enquanto em produção exibem dados normalmente (evidenciado nas imagens anexadas ao ticket, comparando a mesma
tela nos dois ambientes, logado com o operador 265).

**Causa raiz:** a cópia de trabalho de homologação usada nesta análise (`379.48.2.30.74.150.45`) nunca recebeu a
implementação do Req. 363961. Ou seja, não se tratava de um problema de dados (tabela `GIRITE` vazia) nem de
configuração de ambiente — a própria funcionalidade (colunas de grid, campos no dataset e lógica de cálculo)
simplesmente não existia no código-fonte desta cópia. Ela existia apenas na cópia de origem `379.48.2.30.72` (de
onde, presumivelmente, o ambiente de produção é compilado) e não havia sido replicada/mesclada para as demais
cópias de manutenção.

## 3. Investigação realizada

1. Localizadas as revisões SVN de origem do Req. 363961 na cópia `379.48.2.30.72` via
   `svn diff -c 408064` e `svn diff -c 408973`.
2. Consolidado o efeito líquido das duas revisões (a segunda revisão desfez parte da primeira, movendo a função
   `fGetSqlGiroProdutoPeriodo` de unit): resultado final é a função residindo em `untFuncoesSimples.pas`, com
   `untFuncoes.pas` sem alteração líquida.
3. Comparado o estado de `untCadProdutos.pas` (tela de Cadastro de Produtos) na cópia de destino
   (`379.48.2.30.74.150.45`) contra a origem: identificado que a função `fGetSqlGiro` desta cópia **já diverge
   significativamente** da versão de origem — possui colunas adicionais (`EMP_CODEMP`, `ITE_SALDIS` via
   `fSQLSaldoDisponivel`, `GIR_QORC`) e integração com o módulo de Pasta de Compras
   (`blnUtilizaPastaCompras`/`PRE_GIRO_PASTA_COMPRA`) que não existem na cópia de origem. Essas diferenças são
   evolução própria desta cópia, não relacionada ao Req. 363961/462271.
4. **Decisão de escopo:** por essa divergência, a parte da alteração de origem que reescrevia
   `untCadProdutos.pas` (substituir `fGetSqlGiro` por `fGetSqlGiroProdutoPeriodo`) **não foi portada** — fazê-lo
   apagaria colunas e integrações já existentes nesta cópia, sem relação com o formulário afetado por este
   requisito (Estoque das Empresas usa uma consulta própria, independente de `untCadProdutos.pas`).
5. Confirmado que `untFatMostraEstoqueEmp.pas`/`.dfm` e `untFuncoesSimples.pas` desta cópia **não tinham**
   nenhum resquício da funcionalidade de giro (nem colunas, nem função, nem `procedure pCalculaGiroMeses`),
   confirmando que era uma portação limpa, sem conflito de merge.
6. Redimensionamento cosmético do `.dfm` feito na cópia de origem (aumento de `Width`/`Height` do formulário e
   dos painéis internos) **não foi replicado** — esta cópia do `.dfm` já não possui os atributos `Explicit*`
   presentes na origem (formato levemente diferente), e o redimensionamento não tem relação funcional com a
   exibição dos dados de giro.

## 4. Alteração implementada

### 4.1. `untFuncoesSimples.pas` (nova função utilitária)

Adicionada a função `fGetSqlGiroProdutoPeriodo(stlCamGir, stlCamNom, intQYear, blnCodEmp)`, que monta
dinamicamente um SQL de agregação sobre a tabela `GIRITE` (giro de itens por empresa/ano), somando as colunas de
saída (`GIR_QSAIxx`) e entrada (`GIR_QENTxx`) mês a mês, para tantos anos (`intQYear`) quanto necessário para
cobrir os 12 meses anteriores ao mês corrente — já que um período de 12 meses corridos pode abranger a virada de
ano (ex.: de out/2025 a set/2026 abrange os anos 2025 e 2026). O parâmetro `blnCodEmp` controla se o filtro por
empresa (`GIR_CODEMP = :CODEMP`) é aplicado — usado pelo formulário de Estoque das Empresas, que consulta uma
empresa por vez; sem esse filtro, seria usado por telas que consultam todas as empresas de uma vez (não é o caso
aqui).

### 4.2. `untFatMostraEstoqueEmp.pas` (formulário "Estoque das Empresas")

- Adicionada a unit `DateUtils` ao `uses` da interface, necessária para as funções `MonthOf`/`YearOf`.
- Declarados os 3 novos campos de grid: `gdITE_GIRO03`, `gdITE_GIRO06`, `gdITE_GIRO12` (`TcxGridDBColumn`).
- Declarada e implementada a `procedure pCalculaGiroMeses`, chamada ao final do evento `FormShow` (após a carga
  normal do grid de saldos por empresa). Essa procedure:
  1. Monta a lista dos últimos 13 meses (mês atual + 12 anteriores), identificando quantos anos-calendário
     distintos (`intQtdAno`) esse intervalo cobre.
  2. Para cada empresa carregada em `cdsSalEmp` (dataset do grid), executa uma consulta via
     `fGetSqlGiroProdutoPeriodo` (com `blnCodEmp = True`, filtrando pela empresa da linha) e soma as saídas dos
     últimos 3, 6 e 12 meses.
  3. Grava os totais nos campos `ITE_GIRO03`, `ITE_GIRO06` e `ITE_GIRO12` de cada linha do `cdsSalEmp`.
  4. Erros durante o cálculo são reportados via `pMensagensErro`, sem interromper a exibição do restante do
     formulário (que já foi carregado antes desta etapa).
- Adicionadas as colunas `(0.000) ITE_GIRO03`, `(0.000) ITE_GIRO06`, `(0.000) ITE_GIRO12` (placeholders zerados)
  nos dois blocos `SELECT` de `fGetSql` — a função que monta a consulta-base do grid — para que esses campos já
  existam no dataset antes de `pCalculaGiroMeses` os popular via `cdsSalEmp.Edit`/`Post`.

### 4.3. `untFatMostraEstoqueEmp.dfm` (layout do formulário)

Adicionados os 3 objetos `TcxGridDBColumn` (`gdITE_GIRO03`, `gdITE_GIRO06`, `gdITE_GIRO12`) ao grid principal
(`cxGridDados`), com as legendas "Giro 3 meses", "Giro 6 meses" e "Giro 12 meses", inseridos logo após a coluna
`gdITE_SDPDBF` e antes de `cxGridNivel`.

## 5. Novo funcionamento

Ao abrir o formulário "Estoque das Empresas" para um item, além dos indicadores já existentes (saldo reservado,
disponível, pedidos em aberto etc.), o usuário passa a visualizar, por empresa, o total de unidades vendidas do
item nos últimos 3, 6 e 12 meses. Itens sem vendas no período correspondente exibem `0` na coluna (não ficam em
branco/nulo). O comportamento é equivalente ao já existente em produção e na cópia de origem `379.48.2.30.72`.

## 6. Impacto funcional

- **Usuário/processo afetado:** equipe de suprimentos/compras que utiliza a tela de Cadastro de Produtos →
  Consulta de Estoque das Empresas para decisões de reposição.
- **Nenhuma outra funcionalidade do formulário foi alterada** — saldos, preços, filtros de multiloja e demais
  colunas permanecem com o comportamento anterior.
- **Sem impacto em `untCadProdutos.pas`** — a `fGetSqlGiro` dessa tela permanece como estava nesta cópia,
  incluindo suas colunas/integrações próprias (Pasta de Compras, `ITE_SALDIS`, `GIR_QORC`).
- Validado manualmente pelo usuário nesta sessão, confirmando que os valores de giro passaram a ser exibidos
  corretamente.
- A mesma portação foi posteriormente replicada, de forma idêntica, nas cópias `379.48.2.30.74.150` e
  `379.48.2.30.74.150.100` (mesmos três arquivos, mesma decisão de não tocar em `untCadProdutos.pas`).

## 7. Revisão de código pós-implementação

Após a implementação inicial, uma revisão de código apontou dois problemas em `pCalculaGiroMeses`
(`untFatMostraEstoqueEmp.pas`) e uma sugestão de otimização, avaliados e tratados como segue — aplicados nas
três cópias (`74.150.45`, `74.150`, `74.150.100`):

### 7.1. Vazamento de memória — CORRIGIDO

`stlCamGir`, `stlCamNom` (dois `TStringList`) e `qryGirIte` (um `TUniQuery` criado via `fCriaQuery()` com
`AOwner = Nil`, portanto sem dono que o libere automaticamente) eram criados no início da procedure e nunca
liberados — nem no caminho de sucesso, nem no caminho de exceção (o bloco `Except` apenas chamava
`pMensagensErro` e retornava). Cada abertura do formulário "Estoque das Empresas" vazava os três objetos.

**Correção:** os três objetos passaram a ser criados antes de um `Try...Finally` que envolve todo o restante do
corpo da procedure (incluindo o `Try...Except` de tratamento de erro já existente), com o `Finally` chamando
`FreeAndNil(qryGirIte)`, `FreeAndNil(stlCamNom)` e `FreeAndNil(stlCamGir)` — garantindo a liberação em qualquer
caminho de saída da procedure, inclusive quando o `Except` interno captura um erro.

### 7.2. `EnableControls` no `Finally` sem `DisableControls` garantido antes — CORRIGIDO (defensivo)

O par `DisableControls`/`EnableControls` estava organizado como: `DisableControls` era a **primeira instrução
dentro do bloco `Try`** cujo `Finally` chama `EnableControls`. Na prática, isso já garantia o pareamento correto
(se o `Try` foi alcançado, `DisableControls` já rodou antes de qualquer coisa que pudesse falhar dentro dele) —
não havia um caminho real de `EnableControls` disparar sem o `DisableControls` correspondente ter sido
executado. Ainda assim, essa organização é frágil/não é o padrão canônico Delphi (`Disable` fora do `Try`,
pareado com o `Try...Finally` que se inicia logo em seguida), o que dificulta revisões futuras. Corrigido movendo
`cdsSalEmp.DisableControls` para imediatamente antes do `Try...Finally` interno, deixando o pareamento explícito.

### 7.3. Chamada de `pCalculaGiroMeses` quando `blnEstrutura = True` — AVALIADO, NÃO ALTERADO (falso alarme)

Foi sugerido restringir a chamada de `pCalculaGiroMeses` (feita incondicionalmente ao final do `FormShow`) com
`If Not blnEstrutura Then`, sob a premissa de que, no fluxo `blnEstrutura = True`, a tela passaria a usar
`cdsIteEst`/`cxGridEstrutura` em vez do grid principal (`cdsSalEmp`/`cxGridDados`, onde ficam as colunas de
giro), tornando o cálculo supérfluo nesse caso.

**Verificação:** no `.dfm`, `cxGridEstrutura` (grid de itens de estrutura, ligado a `cdsIteEst`) tem
`Align = alBottom` e só é exibido quando `blnEstrutura = True` (`cxGridEstrutura.Visible := blnEstrutura` no
`FormShow`) — mas isso é **aditivo**, não substitutivo: `dbeEstoqueMM`/`cxGridDados` (grid principal, ligado a
`cdsSalEmp`, onde estão `gdITE_GIRO03/06/12`) tem `Align = alClient` e sua visibilidade **nunca** é alterada em
código — permanece sempre visível, com ou sem `blnEstrutura`. Quando `blnEstrutura = True`, o formulário mostra
os dois grids simultaneamente (divididos por `Splitter1`): o grid de estrutura embaixo, e o grid principal
(com as colunas de giro) preenchendo o restante — ele nunca é ocultado nem substituído.

**Conclusão:** a premissa do achado não se confirma — o grid que exibe as colunas de giro está sempre visível,
portanto o cálculo continua sendo necessário também quando `blnEstrutura = True`. Aplicar a restrição sugerida
deixaria as colunas de Giro em branco nesse fluxo, uma regressão. **Decisão do usuário: não aplicar**, apenas
documentar o achado e a verificação que o descarta, para que uma revisão futura não repita a mesma pergunta.

### 7.4. Quebra de compilação em `74.150` e `74.150.100` (unit não compilava) — CORRIGIDO (crítico)

Um script de portação (Python, edição em nível de bytes) usado para inserir `pCalculaGiroMeses` nas cópias
`379.48.2.30.74.150` e `379.48.2.30.74.150.100` continha um bug: o texto de substituição não preservava o
trecho final de `fValidaCampos` (`If Not Result Then pSetFocus(Sender); end;`) antes de inserir a nova
procedure — ele **apagava** esse trecho e emendava `pCalculaGiroMeses` diretamente no lugar. O resultado, nas
duas cópias:

- `pCalculaGiroMeses` ficava declarada **dentro do corpo de `fValidaCampos`** (entre suas últimas instruções e
  o `end;` que deveria fechá-la) — Delphi não aceita declarar uma rotina qualificada com `ClassName.MethodName`
  dentro de um bloco `begin..end`.
- O `end;` que sobrava fechava `pCalculaGiroMeses` em vez de `fValidaCampos`, deixando `fValidaCampos` sem
  fechamento.
- A instrução `If Not Result Then pSetFocus(Sender);` (que devolve o foco ao campo inválido quando a validação
  falha) desaparecia — mesmo corrigindo a estrutura, faltaria essa linha.

O resultado é que **as units `untFatMostraEstoqueEmp.pas` de `74.150` e `74.150.100` não compilavam** desde a
portação inicial desta sessão — só não foi percebido antes porque a verificação de diff/encoding aplicada
checa ruído de linha/encoding, não sintaxe Object Pascal, e a cópia `74.150.45` (a primeira a ser portada, com
um script anterior e correto) não tinha o problema, mascarando o defeito do script reaproveitado para as
outras duas.

**Correção:** reconstruído, nas duas cópias, o trecho `  If Not Result Then\r\n    pSetFocus(Sender);\r\nend;`
imediatamente antes da declaração de `pCalculaGiroMeses`, restaurando o fechamento de `fValidaCampos` e o
comportamento de foco em campo inválido. Conteúdo final de `pCalculaGiroMeses` comparado byte a byte com a
cópia `74.150.45` (que nunca teve o problema) para garantir equivalência exata.

### 7.5. Campos `ITE_GIRO0x` de `cdsSalEmp` possivelmente `ReadOnly` — CORRIGIDO (defensivo)

As três colunas nascem no SQL como literal constante (`(0.000) ITE_GIRO03` etc.). O ajuste `ReadOnly := False`
já existente no código só era aplicado aos campos de `qrySalEmp` (a `TUniQuery` de origem), não aos de
`cdsSalEmp` (o `TUniClientDataSet` alimentado pelo provider) — que é o dataset efetivamente editado em
`pCalculaGiroMeses` via `cdsSalEmp.Edit`/`FieldByName(...).AsFloat :=`/`Post`. Caso o provider marque esses
campos como somente leitura por herança (comportamento que varia por versão/configuração de driver), a
atribuição lançaria `EDatabaseError`, capturado pelo `Except` e reproduzindo exatamente o sintoma original do
Req. 462271 (coluna aparece, mas fica vazia).

Na prática, o teste manual já realizado em `74.150.45` confirmou que a gravação funciona sem esse ajuste (mesma
engine UniDAC nas três cópias) — não há evidência de que o problema ocorra de fato. Ainda assim, por ser uma
trava defensiva de custo desprezível, foi aplicada nas três cópias por segurança.

**Correção:** adicionadas, logo após `cdsSalEmp.Open` no `FormShow` (antes de `pcdsSalEmp`):
```pascal
cdsSalEmp.FieldByName('ITE_GIRO03').ReadOnly := False;
cdsSalEmp.FieldByName('ITE_GIRO06').ReadOnly := False;
cdsSalEmp.FieldByName('ITE_GIRO12').ReadOnly := False;
```

### 7.6. `N+1` consultas em `pCalculaGiroMeses` — AVALIADO, NÃO ALTERADO (documentado como pendência)

`qryGirIte` é reaberta uma vez por linha de `cdsSalEmp` (uma por empresa do item), sempre com o mesmo
`CODITE` e a mesma janela de 12 meses, variando apenas `CODEMP`. Em itens presentes em muitas empresas, a
abertura do formulário faz uma ida-e-volta síncrona ao banco por empresa, travando a UI (`FormShow`)
proporcionalmente ao número de filiais do item — esse diagnóstico foi confirmado como correto.

**Alternativa sugerida:** rodar a agregação uma única vez sem filtro de empresa (`fGetSqlGiroProdutoPeriodo`
já aceita `blnCodEmp = False`) e casar os totais com `cdsSalEmp` em memória via `Locate`/dicionário por
`GIR_CODEMP`.

**Por que a correção sugerida, como descrita, não é diretamente implementável:** verificado em
`untFuncoesSimples.pas:96495` — a coluna `GIR_CODEMP` do resultado é **sempre**
`CONCAT(GIR_CODEMP, " - ", EMP_NOMEMP)` (código + nome concatenados), incondicionalmente, independente de
`blnCodEmp`; e a `SELECT`/`GROUP BY` externos (linhas 96542 e 96567) operam sobre esse mesmo alias já
concatenado. Um `Locate('GIR_CODEMP', cdsSalEmp.FieldByName('EMP_CODEMP').AsString, [])` direto contra
`"01 - Filial Centro"` **nunca casaria com `"01"`** — falharia silenciosamente (nenhuma exceção, apenas
nenhum match), deixando o giro de **todas** as filiais zerado de uma vez, reproduzindo o sintoma original do
Req. 462271 de forma mais ampla e mais difícil de perceber em teste manual do que o bug atual (que ao menos
falha visivelmente/lança exceção). Para funcionar, seria necessário parsear
`Copy(GIR_CODEMP, 1, Pos(' - ', GIR_CODEMP) - 1)` (frágil, quebra se algum nome de empresa contiver `" - "`)
ou, de forma mais robusta, alterar `fGetSqlGiroProdutoPeriodo` para expor também uma coluna com o código puro
sem `CONCAT` — o que amplia o escopo da mudança (a função compartilhada, não só o laço de
`pCalculaGiroMeses`).

**Ressalva adicional, a favor da otimização (não é motivo para não implementar, é algo a tratar quando for
implementada):** a consulta é `FROM GIRITE INNER JOIN CADEMP` — uma empresa sem nenhum registro em `GIRITE`
para aquele item em todo o período consultado (nunca vendido ali) não gera linha alguma no resultado, nem
zerada. Isso já é um risco **hoje**, no código atual: se `qryGirIte.Open` retornar 0 linhas para alguma
empresa do laço, `FieldByName(...).AsFloat` lança exceção, cai no `Except` externo e aborta o cálculo para
**todas** as demais empresas do `cdsSalEmp` (o `Except` está fora do `While`, então uma falha em uma empresa
derruba as demais). Uma versão com dicionário resolveria isso com naturalidade — bastaria tratar chave
ausente como `0`, sem propagar exceção — mas isso não é um argumento contra a mudança, é um cuidado a
incorporar nela.

**Decisão:** não implementado agora, para não somar uma refatoração de escopo maior (função compartilhada +
tratamento de chave ausente) em cima de uma rotina que acabou de sair de um bug crítico de compilação (ver
7.4) e ainda está em processo de validação manual. Registrado como melhoria de performance pendente para uma
sessão dedicada, com o cuidado acima já mapeado para quem for implementar.

### 7.7. `cdsSalEmp` podia ficar em modo `Edit` após exceção — CORRIGIDO (defensivo)

Se a atribuição `cdsSalEmp.FieldByName('ITE_GIRO0x').AsFloat := ...` (ou qualquer instrução entre `Edit` e
`Post`) lançasse uma exceção, o dataset permanecia em modo `dsEdit`. O bloco `Finally` mais interno (que chama
`cdsSalEmp.First`/`EnableControls`) **executa antes** do `Except` externo, como parte do desenrolamento da
pilha — ou seja, `cdsSalEmp.First` seria chamado com o dataset ainda em modo `Edit`, um cenário frágil (o
`First` pode disparar um post implícito, que pode falhar de novo, ou deixar o dataset em estado inconsistente
para operações seguintes no formulário, com erro "Dataset not in edit or insert mode").

**Correção:** adicionado, no início do `Finally` mais interno (antes de `cdsSalEmp.First`):
```pascal
If cdsSalEmp.State In [dsEdit, dsInsert] Then
  cdsSalEmp.Cancel;
```
Colocado no `Finally` (não no `Except`, como sugerido inicialmente) porque o `Finally` é executado primeiro,
durante o desenrolamento da exceção — um `Cancel` apenas no `Except` chegaria tarde demais, depois que o
`Finally` já teria tentado `cdsSalEmp.First` com o dataset ainda em edição.

### 7.8. Mês corrente (`MES0`) nunca somado no giro — AVALIADO, NÃO ALTERADO (comportamento herdado da origem)

`stlCamNom.Insert(0, 'MES0')` adiciona o mês corrente à lista de períodos consultados (a coluna `MES0_SAI`
existe no resultado de `fGetSqlGiroProdutoPeriodo`), mas o laço de leitura (`For intIndex := 12 DownTo 1`) só
acessa `stlCamNom[0..11]` — que, pela ordem de inserção (sempre no início da lista), correspondem a
`MES1..MES12` (os 12 meses **fechados** anteriores ao corrente). `stlCamNom[12]` (`MES0`, mês em andamento)
nunca é lido — o giro de 3/6/12 meses exclui o mês corrente (parcial) do cálculo.

**Por que não foi alterado:** essa é a lógica **exata**, portada byte a byte, da revisão de origem
(`379.48.2.30.72`, Req. 363961, revisão 408064) — não foi introduzida durante a portação desta sessão. Ou seja,
produção já roda hoje com esse comportamento (giro = 12 meses fechados, sem contar o mês em curso), o que é
consistente com uma leitura razoável de "giro dos últimos N meses" (evita misturar um mês parcial/em andamento
com meses fechados). Alterar esse cálculo somente nas cópias de homologação faria o resultado divergir do que
produção mostra hoje — o oposto do que o Req. 462271 pede (igualar homologação a produção). **Decisão do
usuário: não alterar.** Se a regra de negócio realmente deveria incluir o mês corrente, isso é uma mudança de
comportamento que precisa ser tratada também em produção (`379.48.2.30.72`), como um requisito à parte — não
como parte desta correção de portação.

## 8. Achados colaterais (não corrigidos nesta sessão)

- Foi identificado que `untCadProdutos.pas` (Cadastro de Produtos) possui sua própria `fGetSqlGiro`, com lógica
  de giro parecida, porém mais completa (saldo disponível, giro orçado, integração Pasta de Compras) e
  **duplicada** em relação a `fGetSqlGiroProdutoPeriodo`. Uma eventual unificação dessas duas funções
  (aproveitando os recursos extras de `fGetSqlGiro` dentro de `fGetSqlGiroProdutoPeriodo`) poderia reduzir
  duplicação de código, mas está fora do escopo deste requisito e não foi avaliada em profundidade.

  **Por que não foi simplesmente removida/unificada:** as duas funções não são intercambiáveis — cada uma tem
  recursos que a outra não tem:

  | Recurso | `fGetSqlGiro` (untCadProdutos) | `fGetSqlGiroProdutoPeriodo` (untFuncoesSimples) |
  |---|---|---|
  | Giro de saída/entrada por mês (`GIR_QSAIxx`/`GIR_QENTxx`) | sim | sim |
  | `EMP_CODEMP` na saída | sim | não |
  | Saldo disponível (`ITE_SALDIS`, via `fSQLSaldoDisponivel`) | sim | não |
  | Giro orçado (`GIR_QORC`) | sim | não |
  | `JOIN` com `ITEGER` (saldo do item) | sim | não |
  | Integração Pasta de Compras (`blnUtilizaPastaCompras`/`PRE_GIRO_PASTA_COMPRA`) | sim | não |
  | Filtro opcional por empresa (`blnCodEmp`) | não | sim |

  Remover `fGetSqlGiro` e substituir a chamada em `untCadProdutos.pas` por `fGetSqlGiroProdutoPeriodo` — como a
  revisão de origem (`379.48.2.30.72`, Req. 363961) fez naquela cópia — quebraria a tela de Cadastro de Produtos
  **nesta cópia**, que já evoluiu para depender de saldo disponível, giro orçado e integração com Pasta de
  Compras, recursos inexistentes na versão de origem. Unificar de fato exigiria estender
  `fGetSqlGiroProdutoPeriodo` com essas colunas/joins extras (via parâmetro opcional) e depois migrar e testar a
  tela de Cadastro de Produtos — um refactor com risco de regressão em uma tela sem nenhuma relação com o
  problema relatado no Req. 462271 (que era exclusivamente sobre o formulário Estoque das Empresas, o qual nunca
  usou `fGetSqlGiro`). Por isso a duplicação foi mantida e apenas registrada aqui como pendência, em vez de
  decidida unilateralmente durante a correção do bug.

## 9. Referências

- Requisito de origem da funcionalidade: **Req. 363961** (SVN `379.48.2.30.72`, revisões 408064 e 408973,
  autor marcio.azzarini).
- Requisito desta análise: **Req. 462271** — Zendesk
  [1671219](https://citelsoftware.zendesk.com/agent/tickets/1671219).
- Artefatos relacionados: `IA/specs/462271/spec.md`, `IA/specs/462271/plan.md`, `IA/specs/462271/tasks.md`.

## 10. Notas referenciadas no código-fonte

Não houve necessidade de comentário defensivo com referência cruzada ("Verificar Nota N") nesta alteração — o
código portado é direto (cálculo de giro por período) e não introduz comportamento não óbvio que exija esse tipo
de nota.
