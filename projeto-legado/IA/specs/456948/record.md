# Req. 456948 — Registro de Análise

## 1. Contexto de negócio

A tela **Útil > Operações Referentes a Produtos > Balanço de Estoque por Ajuste > Gravação da
Contagem** grava a contagem física de itens, ajusta o saldo de estoque para bater com o
contado, gera documentos fiscais de ajuste (`AJ`) e um log de auditoria da contagem
(`CONDET`). O processo é usado por operação, roda em janela de manutenção, e leva a
integridade do estoque diretamente — qualquer imprecisão aqui reflete em saldo de venda.

A rotina está em produção há anos, escrita para processar poucas centenas de itens. O uso
cresceu para ~2.000 itens por rodada (~14.000 linhas de lote), e a gravação passou a levar
~20 minutos, mantendo transação aberta o tempo todo — o faturamento fica bloqueado atrás
dela. Um incidente de monitor de lock registrou 96.570 linhas travadas em `ITEGER` numa
única rodada.

## 2. Diagnóstico

A análise anterior (handoff) media custo por "comando enviado pela aplicação" e concluía que
o problema era round-trip de rede. Medição desta análise, usando o general log do MySQL (que
registra também o corpo dos triggers), mostrou que essa métrica escondia o termo dominante:

| Termo de custo | % do total | Natureza |
|---|---|---|
| Linhas de `ITEGER` tocadas × ~6 statements de trigger cada | 49% | por linha física alterada |
| `INSERT INTO LOGREP` (réplica, 1 por `ExecSQL`) | 12,5% | por ida ao banco |
| `SELECT` de metadado/lookup repetidos por linha | 13% | por leitura |
| Trabalho de negócio propriamente dito | 25,5% | irredutível |

O trigger `BEFORE UPDATE` de `ITEGER` dispara ~6-7 sub-consultas a cada linha alterada. Um
`UPDATE` que a aplicação enxerga como 1 comando pode custar ~90.000 statements no servidor
quando atinge 14.000 linhas — um fator de ~7 que a métrica antiga não capturava.

Rastreando a origem dos toques excedentes em `ITEGER`/`CADLOT`, apareceram cinco rotinas que
gravam estado de nível de **item** (ou **documento**) mas executam uma vez por **linha de
divergência** (item × lote × localização): `pZeraItem`, `fZeraContagemLote`,
`fAtualizaEstoqueCadIte`, `fMarcaAjuIteger`/`fAjusteQtdIteger` e o equivalente em `CADLOT`.
Uma delas, `fMarcaAjuCadLot`, não tinha filtro por item — a cada documento ela varria **todos**
os lotes ainda em contagem da empresa, um trabalho quadrático no número de documentos e a
causa raiz do incidente de lock.

Esse mesmo trabalho quadrático, além de lento, produzia dado errado: em 42 de 280 lotes e
12 de 40 itens testados, o valor de ajuste gravado (`LOT_QTDAJU`/`ITE_QTDAJU`) não
correspondia ao movimento real, porque a marcação de um documento anterior sobrevivia sobre
o lote antes de ele ser efetivamente processado.

Durante a análise foi encontrado ainda um defeito de atomicidade: se a atualização de estoque
de um documento falhasse no meio da rotina, a exceção era engolida silenciosamente e a
rotina seguia para o próximo documento consumindo a contagem sem mover o estoque. Se o
último documento desse certo, a rotina commitava mesmo assim, deixando para trás documentos
fiscais gerados sem o saldo correspondente. Isso foi reproduzido no banco com evidência real
(documentos 3921/3922, saldo do lote intocado, contagem já zerada).

Por fim, uma rodada de medição de volume (2.100 linhas) mostrou que, mesmo depois de reduzir
70% dos comandos de gravação do documento de ajuste, o tempo de parede continuou em ~24
minutos — praticamente a queixa original. O gargalo real estava em outro lugar: a gravação
do log de auditoria da contagem (`CONDET`), linha a linha, cada `INSERT` abrindo conexão e
transação próprias para reservar autoincremento — 22 statements de servidor para cada 2
inserções úteis.

## 3. O que foi alterado

### 3.1 Redução de trabalho repetido em `ITEGER`/`CADLOT` (M2, M3)

As rotinas que zeravam contagem e recalculavam o ajuste do item passaram a rodar **uma vez
por item por rodada**, em vez de uma vez por linha de divergência (item × lote). O cálculo
do ajuste (`ITE_QTDAJU`/`ITE_SEQAJU` em `ITEGER`, `LOT_QTDAJU`/`LOT_SEQAJU` em `CADLOT`)
passou a ser derivado diretamente do movimento gravado (`MOVDET`) numa única consulta
agregada ao final do processamento de todos os documentos da rodada, em vez de ser
recalculado — e sobrescrito — a cada documento.

Efeito colateral corrigido: como o cálculo agora deriva do movimento real de cada lote,
deixou de existir a situação em que o valor gravado como ajuste não correspondia ao que
efetivamente moveu. Nos testes de equivalência, essa correção alterou 42 de 280 lotes e
12 de 40 itens — todos passaram a bater com o movimento real.

### 3.2 Escrita em lote no documento de ajuste (M4, M1)

As gravações de itens do documento fiscal de ajuste (`MOVDET` e tabelas relacionadas de
tributo/auxiliar) e a atualização de saldo de estoque passaram a ser acumuladas e enviadas
ao banco em blocos de até 500 comandos, em vez de um comando por linha. O comportamento e o
resultado final são os mesmos; só a forma de envio ao banco muda. Fluxos que não passam por
essa acumulação (venda, devolução, compra, transferência) continuam exatamente como estavam.

### 3.3 Correção de atomicidade

A rotina de confirmação do ajuste (`fConfirmaAjuste`) passou a garantir que uma falha em
qualquer documento durante a atualização de estoque interrompe o processamento e desfaz
(`rollback`) tudo o que já havia sido feito na rodada, em vez de seguir adiante e permitir
que a gravação seja concluída com um documento incompleto.

### 3.4 Log de auditoria da contagem em lote (M8)

A gravação do log de contagem (`CONDET`) — usado para auditoria e relatório de linha a
linha por item e lote — passou de uma inserção por chamada para uma única operação em bloco
por rodada. Esse era o maior consumidor de tempo identificado na medição de volume, maior
até que a gravação do próprio documento fiscal.

### 3.5 Correção de leitura do log de contagem por lote

Quando a divergência era de um lote específico, o log de contagem estava lendo o saldo
anterior do **item inteiro** em vez do saldo do **lote**, gravando um valor incorreto no
histórico de auditoria. Passou a ler o saldo do lote correspondente.

### 3.6 Cache do peso específico de item a granel (tintométrico)

Para itens do segmento tintométrico (fórmulas configuradas por marca), o cálculo do peso
específico — usado no ajuste de estoque em medida líquida — era recalculado do banco a cada
linha. Passou a ser calculado uma vez por item e reaproveitado durante a gravação do
balanço. A lógica de cálculo em si não mudou.

## 4. Novo funcionamento

A gravação da contagem continua exigindo a mesma confirmação na tela e produzindo o mesmo
resultado — mesmo saldo final, mesmos documentos fiscais, mesma contagem zerada ao final.
O que muda é o volume de trabalho que o banco de dados executa para chegar lá: a quantidade
de vezes que cada linha de `ITEGER`/`CADLOT` é efetivamente alterada cai para o mínimo
necessário (uma vez por item, uma vez por lote), e as gravações do documento fiscal e do
log de contagem passam a ir ao banco em blocos, não uma a uma.

Como consequência do desenho de atomicidade, se a rotina falhar no meio de uma rodada, nada
fica gravado pela metade: ou o ajuste completo é efetivado, ou nada é.

## 5. Impacto funcional

Redução medida de 70% no número de comandos de gravação do documento de ajuste, e do que
restava, o log de contagem — identificado como o novo gargalo dominante — também passou a
ser gravado em bloco. O tempo de bloqueio do faturamento durante a gravação do balanço deve
cair proporcionalmente, sem alteração no resultado que o usuário vê na tela ou nos
relatórios de estoque e auditoria de contagem.

Dois defeitos pré-existentes de dados foram corrigidos como parte desta mesma frente: o
ajuste gravado por lote/item passa a refletir sempre o movimento real, e o log de auditoria
por lote passa a registrar o saldo do lote, não do item inteiro.

```text
CONTEXTO TÉCNICO (IA):
- REQUISITO: 456948. Fonte principal: padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas.
  Zona de código: Legado. Pasta de análise: IA/456948/ (specs.md, plans.md, tasks.md, ferramentas/, testes/, diffs/).
- ARQUIVOS ALTERADOS NESTA REQUISIÇÃO (ver tasks.md "Arquivos tocados" para o mapeamento completo tarefa-a-arquivo):
  - padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas — M2 (dedup pZeraItem, superado
    depois pela integração do trunk), M3 (fMarcaAju*/fAjusteQtd* fora do laço), M5 (pré-carga qryIteGer/custo),
    M4 (chamada com ABatch), M1→M1b (batch de saldos), Q8 (notificação de saldo mínimo adiada), M10 (chamada do
    cache de peso específico). Encoding latin-1 + CRLF — edição só via ferramenta byte-safe do projeto.
  - padra_atualizado/fontes/faturamento/untMovGer.pas — parâmetro ABatch: TBatchSQL = Nil acrescentado ao FIM
    da lista de parâmetros de fGravaMovDet (default Nil preserva todo o resto do ERP: venda, devolução, compra,
    transferência). Cinco Post convertidos para TBatchHelper.PostOuAcumula (MOVDET, MOVTRI, BRIDET, MOVAUX,
    MOVREF — todas filhas de MOVDET por FK). fGravaMovGer NÃO foi alterada (fica em Post imediato, é o pai).
  - padra_atualizado/fontes/genericos/BatchSQL/untTBatchSQL.Helper.pas — nova
    TBatchHelper.PostOuAcumula(ADataSet, AstrTabela, ABatch): com ABatch=Nil faz Post normal; com ABatch
    atribuído monta INSERT manualmente a partir dos campos do dataset e cancela o Post. Regra: campo NULL não
    entra na lista de colunas (deixa o MySQL aplicar o DEFAULT, como o Post do UniDAC faz); exceção: campo
    blob/memo nunca é omitido mesmo quando IsNull=True com string vazia (comportamento peculiar do Delphi).
  - padra_atualizado/fontes/genericos/BatchSQL/untTBatchSQL.pas — nova propriedade OwnsQuery: Boolean
    (default False); no Destroy, libera o Query interno só se OwnsQuery=True. Não altera chamadores existentes
    (untCadConcilBancNova.pas, untFuncAutban.pas), que continuam donos do próprio Query.
  - padra_atualizado/fontes/genericos/untFuncoesSimples.pas — cache do @VS_ID_TRANSACAO: globais
    VS_objConexaoIDTran (TUniConnection) e VS_intIDTransacaoCache (UInt64), Nil/0 por default. Guarda de três
    condições no topo de fGetIDTransacao (conexão bate, transação aberta, cache > 0). Armado só por
    pLigaCacheIDTransacao (chamada em fConfirmaAjuste após fStartTransaction) e desarmado em toda saída,
    inclusive Except. Diff puramente aditivo — corpo original de fGetIDTransacao intocado.
  - padra_atualizado/fontes/genericos/untTypesSistema.pas — campo ABatch em TMovDetParams (record de parâmetros
    de fGravaMovDet), e TMovDetParams.Init passou a inicializá-lo. ATENÇÃO: qualquer chamador que passe este
    record sem chamar Init primeiro herda defaults zerados (string vira '', Boolean vira False) em vez dos
    defaults posicionais da função — isso já causou um defeito real nesta mesma implementação (ver abaixo).
  - padra_atualizado/fontes/cadastros/untConDet.pas — M8 (fGravaConDetZeraContagemLote / fInserirRegistro /
    fSQLInsertItens convertidos de INSERT por chamada para INSERT...SELECT dirigido por tabela auxiliar BALZER,
    uma passada por rodada; blnUsaTemporaria removido, era um ramo que lia de tabela temporária sem ganho
    medido) e M9 (TConDet.pSetValoresAntigos: nova variável local blnTemLote := Not fEmptyStr(FNumLot); quando
    True, o SELECT de valores antigos passa a ler CADLOT.LOT_SALDOS/LOT_QTEF_A/LOT_QTEF_F/LOT_QTEF_P em vez de
    ITEGER.ITE_SALDOS/ITE_QTEF_*; mantém o ramo antigo — leitura de ITEGER — quando não há lote).
  - padra_atualizado/fontes/genericos/untFuncoesGenerica.pas — M10: pLigaCachePesoEspGranel /
    pDesligaCachePesoEspGranel e dicionário global VS_dicCachePesoEspGranel: TDictionary<String,
    TCachePesoEspGranel> (record com fltPeso e strFormula), chave = strCodIteGranel + '|' + strCodCor. Nil por
    default — fGetPesoEspecificoItemGranel só consulta o cache se o dicionário estiver Assigned; do contrário
    lê do banco como sempre. Cache armado só pela gravação do balanço (mesmo padrão do cache de ID de
    transação). fGetPesoEspecificoItemGranel continua em Delphi — não houve re-derivação para SQL.
  - padra_atualizado/fontes/cadastros/untCadIte.pas, untCadLote.pas, untICadLote.pas,
    genericos/untConstantes.pas — trazidos pela integração de 6 revisões do trunk 379.48.2.30.74.150 que o
    branch desta cópia não tinha (r463674, r463916, r478453, r478688, r484029, r484382); untBalancoEstoqueGravar.pas
    foi adotado por inteiro na versão do trunk nesse merge (9 conflitos não-triviais, decisão do Willian), o
    que superou os mecanismos M2/M2b (fZeraItens Fase 1 do trunk já faz o equivalente em blocos de 1.000) e M7
    (atomicidade — r463674 já subiu fStartTransaction para fGravar com Result propagado corretamente).
- DECISÕES DE ESCOPO REGISTRADAS EM specs.md:
  - D1: commit em mais de uma etapa é aceitável, mas não obrigatório — o desenho final manteve a transação do
    'AJ' única e atômica.
  - D4/D13: a lógica de fGravaMovGer/fGravaMovDet e de fGetPesoEspecificoItemGranel NÃO foi re-derivada para
    SQL; só a forma de envio ao banco (batch) e a repetição de leitura (cache) mudaram.
  - D7: adesão ao batch de MOVDET é por parâmetro ABatch: TBatchSQL = Nil (não Boolean) — decisão deliberada
    para que o chamador seja dono do ciclo de vida e do momento do flush.
  - D8: cache do ID de transação e cache do peso específico (M10) são armados pela própria rotina do balanço,
    não um mecanismo sempre ligado para o ERP inteiro — reduz o raio de risco a essa janela.
  - D12/D13 (2026-08-25): a correção de pSetValoresAntigos (M9) e a gravação de CONDET em lote (M8, mais o
    cache de peso específico M10 e TBatchSQL.OwnsQuery M11) foram absorvidas dentro do escopo deste requisito
    por decisão do Willian, em vez de virarem requisito próprio como planejado inicialmente — ver plans.md,
    seção "Pendente", itens 1 e 2 marcados como resolvidos.
  - Fora de escopo (specs.md §9, mantido): alterar o trigger pSetaVariaveisPreAlt ou o INSERT INTO LOGREP;
    re-derivar fGravaMovGer/fGravaMovDet para SQL; tabela de staging BALPLA; reduzir CFG_ITEDOC; fatiamento
    transacional/commit por documento (a transação do AJ segue atômica); fConfirmaAjuste('ML') e o caminho sem
    divergência, inalterados.
- DEFEITOS ENCONTRADOS E CORRIGIDOS DURANTE A VALIDAÇÃO (via diff coluna a coluna entre versão base e nova,
  massa de teste controlada — ver specs.md §7 e plans.md Tarefas 5 e 10):
  1. fMarcaAjuCadLot (código anterior) não filtrava por item — a cada documento varria todos os lotes ainda em
     contagem da empresa (WHERE só com LOT_CODEMP e LOT_DIGCON='S'), gerando trabalho quadrático (~n²/2) e,
     como pZeraItem ia liberando LOT_DIGCON conforme processava, causava LOT_QTDAJU=0 em lotes que
     efetivamente moveram (LEFT JOIN sem match cai no IFNULL(...,0)). Corrigido pelo M3 (agregação via MOVDET,
     sem depender de qual documento "carimbou" o lote).
  2. TBatchHelper.PostOuAcumula, primeira versão: campo NULL era emitido explicitamente como NULL no INSERT
     gerado, sobrescrevendo o DEFAULT da coluna que o Post do UniDAC preservaria (por só incluir campos
     modificados). Corrigido: campo NULL não entra na lista de colunas do INSERT, EXCETO campo blob/memo, que
     o Delphi mantém IsNull=True mesmo após receber string vazia — esse tipo nunca é omitido.
  3. TMovDetParams usado sem chamar Init antes de cada chamada dentro do laço de itens: por ser record de
     campo do form (reaproveitado entre itens), nasce zerado, perdendo os defaults posicionais originais da
     função (strGnrOri='P', strEntTri='N', strPegou_='N', blnFilFul=True) em 8 colunas de MOVTRI e 1 de
     MOVAUX. Não gerava erro de compilação nem de execução — só valor errado, silencioso. Corrigido chamando
     MovDetParams.Init dentro do laço, antes de cada uso. Registrado como risco geral: qualquer código do ERP
     que venha a migrar para TMovDetParams sem Init corre o mesmo risco.
  4. objBatchReprocessarSaldo (mecanismo pré-existente usado pela primeira versão do M1) NÃO agrupa comandos —
     TBatchReprocessarSaldo.Execute despacha um ExecSQL por comando internamente. Medido: zero economia. Por
     isso M1 foi redesenhado como M1b, usando TBatchSQL de fato. Achado que se estende além deste requisito:
     quem usa AUsarBatchSaldos hoje (ex. faturamento, untFuncFat.pas:10898) acreditando que agrupa não está
     ganhando nada — registrado como aviso, não corrigido aqui (fora do escopo).
- PONTOS DE ATENÇÃO CONFIRMADOS DURANTE A ANÁLISE (para não serem re-perguntados em revisão):
  - Risco aparente: adiar o UPDATE de saldo para lote (M1b) faria a auditoria de saldo
    (objAuditoriaSaldo.fValidouTodas, que chama a function de banco F_AUDITORIA_GRAVACAO_SALDO) ler o valor
    pré-ajuste e falhar. Descartado por desenho: fConfirmaAjuste descarrega o lote de saldos explicitamente
    ANTES de chamar a auditoria, ainda dentro da mesma transação — a auditoria enxerga o mesmo estado de
    sempre. Não foi possível testar esse caminho fim-a-fim nesta base porque CFG_UTAUFA='N' em todas as
    empresas e a function não existe no schema de teste — a proteção é por construção, não por teste.
  - Risco aparente: TBatchSQL concatenar até 500 comandos por ExecSQL mudaria a granularidade do LOGREP (réplica),
    de 1 linha = 1 comando para 1 linha = até 500. Confirmado com o Willian (D11) que o consumidor da réplica
    aceita comandos concatenados; reforçado pela evidência de que pInsertLoteLGCEST já faz exatamente isso em
    produção (500 INSERT por ExecSQL) sem incidente conhecido.
  - Índices de MOVTRI/MOVAUX no diff de equivalência: essas tabelas não têm DET_CODITE como chave — a primeira
    coluna é DET_SEQGER (aponta para MOVDET.AUTOINCREM, que muda a cada rodada). O comparador de diff precisou
    materializar colunas auxiliares K_CODITE/K_NUMLOT trazidas via join com MOVDET para ter uma chave estável;
    sem isso, as duas tabelas simplesmente não eram comparadas e dois dos defeitos acima passaram
    despercebidos nas primeiras rodadas de teste.
  - ITE_SEQAJU/LOT_SEQAJU saem da comparação de VALOR na prova de equivalência (apontam para AUTOINCREM de
    MOVGER, que muda toda rodada por natureza) — são conferidos estruturalmente (apontam para documento real
    da rodada), não por igualdade byte a byte contra a base.
  - Encoding: untBalancoEstoqueGravar.pas é latin-1 sem BOM (168 bytes acentuados); untFuncoesSimples.pas é
    UTF-8 com BOM (7.561 bytes acentuados). Toda edição nesta requisição passou por ferramenta Python
    byte-safe própria do requisito (IA/456948/ferramentas/edita_pas.py), que aborta a operação inteira
    (atomicamente) se qualquer trecho de âncora não bater exatamente uma vez, e confere contagem de bytes
    acentuados antes/depois.
- MEDIÇÃO FINAL (massa funcional controlada, 40 itens × 7 lotes = 280 linhas, 14 documentos, CFG_ITEDOC=20):
  comandos no LOGREP caíram de 2.064 (base mesclada com o trunk) para 614 (-70%) com M6+M3+M4+M5+Q8+M1b.
  Numa massa de volume (300 itens × 7 lotes = 2.100 linhas, CFG_ITEDOC=500), o tempo de parede continuou em
  ~24 minutos mesmo com a redução de 70% — foi essa medição que revelou CONDET (M8) como o novo termo
  dominante (4.485 INSERT INTO CONDET na rodada, 491 transações próprias de reserva de autoincremento, 22
  statements de servidor para 2 inserts úteis por transação). Prova de equivalência (diff coluna a coluna,
  massa funcional e de volume): 100% de conferência funcional; nenhuma divergência em MOVDET/MOVTRI/MOVAUX/
  LGCEST; as únicas divergências contra a base são ITE_QTDAJU/LOT_QTDAJU, que são a correção intencional do M3.
- PENDÊNCIAS REGISTRADAS EM plans.md, NÃO RESOLVIDAS NESTA SESSÃO:
  - TBatchReprocessarSaldo não agrupa comandos (achado 4 acima) — avisar quem cuida do faturamento; fora do
    escopo deste requisito.
  - Diff consolidado e mensagem de commit para o DelphAI ainda não gerados. padra_atualizado\opcoes.ini e
    padra_atualizado\rev.inc aparecem modificados em svn status e NÃO são deste requisito — devem ser
    excluídos do diff final antes do commit.
```
