# Análise de Requisito — Req. 462563

**Título:** Chave duplicada na tabela LOGCPR ao salvar Cadastro de Produtos / Consulta-Alteração de Catálogos
**Solicitante:** Roberto — FAZO FERRAMENTAS LTDA, Loja 001
**Data da análise/implementação:** 2026-09-18

## 1. Contexto de negócio

Sempre que um produto é gravado no **Cadastro de Produtos** (ou na tela **Consulta de Preços > Consulta/
Alteração de Catálogos**, que internamente reabre o próprio Cadastro de Produtos com a flag `blnCatalogo`),
o sistema registra, para cada campo alterado, uma linha de auditoria na tabela `LOGCPR` (Log de Campos —
quem alterou, quando, valor anterior e valor novo). Esse registro é feito pela classe `TLogAltCadIte`
(unit `padra_atualizado/fontes/cadastros/untLogAltCadIte.pas`), chamada a partir de
`TfrmCadProdutos.fGravaItem` (`untCadProdutos.pas`).

A chave primária de `LOGCPR` (`AUTOINCREM`) não é um autoincremento nativo do MySQL — é gerada pela
aplicação através da função `fRetAutoIncrem` (`padra_atualizado/fontes/genericos/untFuncoesSimples.pas`),
que mantém um contador de controle na tabela `PROINC` (uma linha por nome de tabela, campo `PRO_AUTINC`).
Para evitar uma ida ao banco a cada linha de log, `TLogAltCadIte` reserva de uma só vez um **bloco** de
sequenciais (pedindo um intervalo maior que 1) e depois consome os números desse bloco localmente, em
memória, sem nova consulta ao banco a cada consumo.

## 2. Problema e causa raiz

### 2.1 Sintoma relatado

Ao salvar produtos na tela de Consulta/Alteração de Catálogos, o sistema passou a apresentar o erro:

```
Chave Duplicada na Tabela: LOGCPR - Mensagem de Erro: #23000Duplicate entry '00100000008718737001' for key 'PRIMARY'.
```

Segundo o relato do usuário (vinculado ao Req. 462188, de suporte): toda vez que o time de suporte ajustava
manualmente o contador de sequencial da `LOGCPR`, a primeira gravação passava sem erro, mas a segunda já
retornava duplicidade, e a operação não era concluída — padrão que se repetiu diversas vezes ao longo do
dia 17/09/2026 (10+ ocorrências registradas em `LOGERR`, com valores de `AUTOINCREM` decrescentes a cada
nova tentativa de ajuste: `8725567`, `8724975`, `8724383`, `8723488`...).

### 2.2 Causa raiz — duas causas independentes, uma operacional e uma estrutural

**Causa operacional (estado do banco do cliente FAZO):** consulta somente-leitura ao banco de produção do
cliente (18/09/2026) confirmou que o contador `PROINC.PRO_AUTINC` para `LOGCPR` estava **exatamente igual**
ao maior `AUTOINCREM` já gravado na tabela (`8726159` = `8726159`), em vez de estar acima dele. Isso
significa que a próxima geração de sequencial colidia de imediato com o último registro já existente. A
tabela `PROCOD` (editada pela tela "Cadastro/Manutenção de Próximos Códigos") tinha `PRO_AUTINC = NULL`
para `LOGCPR` — ou seja, essa tela não tem nenhum efeito sobre o contador real usado pelo gerador
(`PROINC`), o que é a explicação mais provável de por que os ajustes manuais do suporte não resolviam o
problema de forma definitiva.

**Causa estrutural (código, independente do estado do banco):** análise da unit `untLogAltCadIte.pas`
revelou que a reserva de bloco de sequenciais era insuficiente para o pior caso de consumo:

- Em `pGravaLogAlteracao`, o bloco reservado tinha `Fields.Count - 1` números, mas o laço que gera as
  linhas de log podia, no pior caso (todos os campos elegíveis alterados na mesma gravação), consumir até
  `Fields.Count` números — um a mais do que o reservado. O último número consumido nesse cenário coincide
  com o primeiro número que a próxima reserva de bloco (seja a chamada seguinte na mesma gravação, seja
  qualquer gravação futura, de qualquer usuário) vai devolver, causando colisão determinística — sem
  depender de nenhum erro externo nem do ajuste manual do contador.
- Em três das cinco cópias analisadas (ver seção 5), havia ainda uma duplicidade de incremento local do
  sequencial: a rotina que consome o bloco reservado avançava o contador em memória **duas vezes** por
  linha de log gravada, em vez de uma. Isso significa que cada linha efetivamente gravada em `LOGCPR`
  "queimava" dois números do bloco reservado, mas usava só um deles — reduzindo pela metade, no limite, a
  capacidade real do bloco reservado de cobrir o consumo esperado, e agravando ainda mais o déficit.

Também foi analisado o mecanismo de bloqueio do contador (`SELECT ... FOR UPDATE` em conexão própria,
com `COMMIT` imediato, isolado da transação principal da gravação) para descartar condição de corrida entre
usuários simultâneos — não foi encontrada evidência de disputa entre sessões diferentes; o problema é
inteiramente explicado pelas duas causas acima.

## 3. Investigação realizada

1. Localização da tela de Consulta/Alteração de Catálogos (`untConsultaFatCatalogo.pas`) e confirmação de
   que ela reutiliza `TfrmCadProdutos.fGravaItem` (`untCadProdutos.pas`) para a gravação efetiva.
2. Mapeamento de todas as referências a `LOGCPR` no código-fonte, identificando `TLogAltCadIte`
   (`untLogAltCadIte.pas`) como o gerador do sequencial e `fRetAutoIncrem`/`fRetAutoIncremInterno`
   (`untFuncoesSimples.pas`) como a função genérica de reserva de bloco.
3. Decomposição da chave `AUTOINCREM` via a função `fFormataAutInc`, confirmando que o valor
   `00100000008718737001` corresponde a `strProEmp(3) + sequencial(14) + strCodEmp(3)`.
4. Consulta somente-leitura ao banco de produção do cliente FAZO (host `FAZO-001-INDAIATUBA.DDNS.NET`, via
   script Python/pymysql do projeto), comparando `PROINC.PRO_AUTINC` com `MAX(AUTOINCREM)` real de `LOGCPR`
   e consultando `LOGERR` para confirmar o padrão recorrente de duplicidade ao longo do dia 17/09/2026.
5. Leitura completa de `pGravaLogAlteracao` e `pGravaLogAlteracaoEcommerce` (`untLogAltCadIte.pas`),
   identificando o déficit de reserva (`Fields.Count - 1` vs. consumo máximo de `Fields.Count`).
6. Leitura completa de `fRetAutoIncremInterno` (`untFuncoesSimples.pas`) para descartar condição de corrida
   entre usuários simultâneos (mecanismo `FOR UPDATE` + commit imediato em conexão dedicada).
7. Ao replicar a correção nas cópias de trabalho irmãs, identificado que cada cópia estava em um estado
   ligeiramente diferente (ver seção 5) — exigiu inspeção individual de cada `untLogAltCadIte.pas` antes de
   aplicar qualquer alteração, em vez de replicar cegamente o mesmo diff.

## 4. Abordagens consideradas e descartadas

- **Alterar a função genérica `fRetAutoIncrem`/`fRetAutoIncremInterno`** — descartada por decisão explícita
  do usuário: essa função é usada por diversas outras tabelas do sistema além de `LOGCPR`, e uma mudança ali
  teria alcance muito mais amplo do que o necessário para este requisito.
- **Reservar exatamente `Fields.Count` (sem margem extra)** — avaliada inicialmente como abordagem
  recomendada (cobre exatamente o pior caso teórico de consumo). Substituída por decisão explícita do
  usuário, durante a implementação, por `Fields.Count + 1` (uma unidade de folga adicional além do pior
  caso), como margem extra de segurança.
- **Corrigir agora o valor de `PROINC.PRO_AUTINC` no banco do cliente FAZO** — avaliada e descartada por
  decisão do usuário; tratada como fora de escopo deste requisito (ver seção 6), a ser feita separadamente.

## 5. Solução aplicada

A correção foi aplicada em `padra_atualizado/fontes/cadastros/untLogAltCadIte.pas`, em duas frentes:

1. Aumentar o tamanho do bloco de sequenciais reservado via `fRetAutoIncrem('LOGCPR', ..., intIntervalo)`,
   de `Fields.Count - 1` para `Fields.Count + 1`, em `pGravaLogAlteracao` e, onde existir,
   `pGravaLogAlteracaoEcommerce`.
2. Remover a duplicidade de incremento local do sequencial, mantendo apenas uma chamada de avanço do
   contador em memória por linha de log gravada (após o `Post` do registro).
3. **Achado de revisão, adicionado ao escopo por pedido explícito do usuário:** o objeto `qryLogCpr`
   (`TUniQuery`, criado via `fCriaQuery`) era liberado por um `FreeAndNil(qryLogCpr)` solto no final do
   procedimento, sem `Try/Finally`. Qualquer exceção lançada entre a criação do objeto e esse ponto — e o
   próprio cenário deste requisito, erro de chave duplicada no `Post`, é exatamente um desses caminhos —
   fazia o `FreeAndNil` nunca ser executado, vazando o `TUniQuery` a cada falha de gravação. Corrigido
   envolvendo o corpo de `pGravaLogAlteracao` e `pGravaLogAlteracaoEcommerce` (a partir da atribuição de
   `qryLogCpr.SQL.Text`) em `Try/Finally`, com `FreeAndNil(qryLogCpr)` movido para o `Finally`, reindentando
   o corpo por 2 espaços conforme o padrão de `Try/Finally` já usado em outras rotinas da base (ex.:
   `fRetAutoIncremInterno`, `untFuncoesSimples.pas`).

Cada cópia de trabalho estava em um estado diferente e recebeu exatamente a correção que seu código
realmente precisava:

| Cópia | `pGravaLogAlteracao` | `pGravaLogAlteracaoEcommerce` |
|---|---|---|
| `379.48.2.30.72` | Reserva ajustada para `Fields.Count + 1`. Já tinha incremento único (sem duplicidade). | Existe. Reserva ajustada para `Fields.Count + 1`. Incremento duplicado (estava aqui) removido. |
| `379.48.2.30.74.111` | Reserva ajustada para `Fields.Count + 1`. Já tinha incremento único. | Método não existe nesta cópia. |
| `379.48.2.30.74.150` | Reserva ajustada para `Fields.Count + 1`. Incremento duplicado (estava aqui, não no Ecommerce) removido. | Existe. Reserva ajustada para `Fields.Count + 1`. Já tinha incremento único. |
| `379.48.2.30.74.150.45` | Idêntico a `379.48.2.30.74.150`. | Idêntico a `379.48.2.30.74.150`. |
| `379.48.2.30.74.150.100` | Idêntico a `379.48.2.30.74.150`. | Idêntico a `379.48.2.30.74.150`. |
| `72.Fechadas\379.48.2.30.72.453` | Estado inicial idêntico byte a byte ao estado original de `379.48.2.30.72` (mesmo tamanho de arquivo, mesmo conteúdo) — recebeu exatamente a mesma correção: reserva `Fields.Count + 1`, incremento duplicado (estava no Ecommerce) removido. | Existe. Idêntico a `379.48.2.30.72`. |

Nas três cópias `74.150`/`74.150.45`/`74.150.100`, o incremento duplicado estava localizado em
`pGravaLogAlteracao` (não em `pGravaLogAlteracaoEcommerce`, como na `379.48.2.30.72` e na
`72.Fechadas\379.48.2.30.72.453`) — mesmo defeito conceitual, em local diferente por divergência histórica
entre as cópias. A correção foi aplicada onde o defeito realmente existia em cada uma, confirmado por
decisão explícita do usuário antes da implementação.

O ajuste de vazamento de `TUniQuery` (item 3 acima) foi replicado de forma idêntica nas seis cópias: em
todas, o padrão pré-existente era o mesmo (`qryLogCpr := fCriaQuery;` seguido do corpo do procedimento e de
um `FreeAndNil(qryLogCpr);` solto no final, sem `Try/Finally`) — não havia divergência entre cópias neste
ponto específico.

### Validação pós-implementação

Cada arquivo `.pas` foi editado via Python, lendo e gravando com encoding `cp1252` explícito (nunca com a
ferramenta de edição de texto genérica), e validado após a gravação: decodificação sem erro no encoding
declarado e ausência da sequência de bytes `\xef\xbf\xbd` (indicador de corrupção UTF-8 dentro de um
arquivo que deveria ser cp1252/Latin-1).

## 6. Decisões de escopo

**Incluído:** ajuste do tamanho do bloco de reserva de sequenciais, remoção do incremento duplicado, e
correção do vazamento de `TUniQuery` em `pGravaLogAlteracao`/`pGravaLogAlteracaoEcommerce` (adicionada ao
escopo por achado de revisão, apontado explicitamente pelo usuário após a implementação inicial), em
`untLogAltCadIte.pas`, replicados nas seis cópias de trabalho listadas na seção 5 (a sexta,
`72.Fechadas\379.48.2.30.72.453`, adicionada ao escopo por pedido explícito do usuário após a
implementação inicial).

**Excluído deliberadamente:**

- Ajuste do valor atual de `PROINC.PRO_AUTINC` no banco de produção do cliente FAZO FERRAMENTAS LTDA —
  decisão explícita do usuário de tratar isso separadamente, fora deste requisito. O contador permanece,
  até uma ação futura, alinhado exatamente com o maior `AUTOINCREM` já gravado em `LOGCPR`.
- Qualquer alteração na função genérica `fRetAutoIncrem`/`fRetAutoIncremInterno`
  (`untFuncoesSimples.pas`) — usada por outras tabelas além de `LOGCPR`.
- Revisão da tela "Próximos Códigos" (`untCadProxCodigos.pas`) e do fato de ela não ter efeito sobre o
  contador real usado por `LOGCPR` — achado colateral, não tratado neste requisito (ver seção 7).

## 7. Achados colaterais (fora de escopo, registrados para não serem esquecidos)

1. **Tela "Próximos Códigos" sem efeito sobre o contador real de `LOGCPR`:** a tela
   `untCadProxCodigos.pas` (Cadastro/Manutenção de Próximos Códigos) edita `PROCOD.PRO_CODSEQ`, mas o
   gerador real usado por `LOGCPR` lê e grava em `PROINC.PRO_AUTINC` — uma tabela e campo completamente
   diferentes. Não foi encontrada nenhuma rotina que sincronize `PROCOD.PRO_CODSEQ` com
   `PROINC.PRO_AUTINC` para `LOGCPR`. É plausível que o suporte venha usando essa tela para tentar corrigir
   o sequencial de `LOGCPR` a cada incidente, sem efeito real algum sobre o problema — hipótese consistente
   com o padrão observado (ajuste seguido de nova ocorrência do erro, repetidas vezes).
2. **Estado do contador no cliente FAZO não corrigido:** `PROINC.PRO_AUTINC` continua, após esta
   implementação, com o mesmo valor problemático identificado na investigação (igual ao maior `AUTOINCREM`
   já gravado). A correção de código evita que o déficit estrutural gere duplicidade adicional a partir de
   agora, mas o incidente já em curso naquele cliente específico só será resolvido com um ajuste direto do
   contador no banco (fora de escopo, ver seção 6).
3. **Reserva com margem de segurança (`+ 1`) é maior que o estritamente necessário:** o pior caso teórico
   de consumo é `Fields.Count` (um log por campo). A reserva de `Fields.Count + 1` cobre esse pior caso com
   uma unidade de folga adicional, por decisão explícita do usuário — não há, até onde investigado, nenhum
   cenário que exija reservar mais que `Fields.Count`, mas a folga extra foi mantida por preferência
   deliberada, sem custo funcional relevante (apenas um número a mais reservado do contador por gravação).
4. ~~`pGravaLogAlteracaoIndividual` tem o mesmo padrão de vazamento de `TUniQuery`, mas não foi
   corrigido`~~ — **reaberto e corrigido na seção 8.6**, depois que a correção da seção 8.4 tornou esse
   método efetivamente alcançável (chamado a cada `OnBeforePost` de produto quando `ITE_IMPLIS` muda,
   em `379.48.2.30.72`/`72.453`/`CONFE`), expondo o vazamento pré-existente a um cenário de uso real.

## 8. Segundo sintoma e causa raiz — `LOG_CODITE` gravado em branco em Inclusão

### 8.1 Sintoma relatado

Em nova ocorrência, ainda na tela **Consulta de Preços > Consulta/Alteração de Catálogos**: usuário
selecionou, no grid, um item do fornecedor `90490400` sem código de produto atribuído, pressionou
`[F6] Ativar/Inativar`, em seguida `Incluir`, preencheu os campos obrigatórios e salvou. A gravação
não apresentou erro de chave duplicada em `LOGCPR`, mas a maior parte das linhas de log geradas para
essa inclusão saiu com o campo `LOG_CODITE` **vazio** — só as últimas linhas (geradas depois que o
código do item passou a existir) saíram com o código correto (`06788`).

### 8.2 Investigação

Consulta somente-leitura ao banco do cliente confirmou o padrão exato: das 192 linhas gravadas em
`LOGCPR` para essa inclusão (`LOG_CODOPE = '904'`, mesma data/hora), as 184 primeiras (campos
GRUPO, EMPRESA, DESCRIÇÃO, UNIDADE, MARCA etc.) saíram com `LOG_CODITE` vazio; só a partir da linha
cujo `LOG_NOMCAM = 'CÓDIGO DO ITEM'` em diante (incluindo linhas de campos de E-commerce, geradas por
`pGravaLogAlteracaoEcommerce`) é que `LOG_CODITE` veio preenchido.

Leitura de `untLogAltCadIte.pas:111` (`pGravaLogAlteracao`) mostrou que `LOG_CODITE` é atribuído, a
cada linha de log, lendo o valor **corrente** de `qryCadIte.FieldByName('ITE_CODITE').AsString` —
não um valor fixado uma vez no início do procedimento. Leitura de `untCadProdutos.pas`
(`TfrmCadProdutos.fGravaItem`) mostrou que `TLogAltCadIte.pGravaLogAlteracao(qryTabela)` é chamado
**antes** de `inherited pGravaRegistro`. E é dentro de `pGravaRegistro`
(`padra_atualizado/fontes/genericos/untPaiCad.pas:246`, rotina genérica usada por dezenas de telas de
cadastro) que o código do item é gerado e atribuído ao dataset, para registros em Inclusão
(`qryTabela.FieldByName(strNomeCampo).AsString := fProximoCodigo;`). Ou seja: no momento em que
`pGravaLogAlteracao` percorre os campos e grava cada linha, `ITE_CODITE` ainda está vazio no
`qryTabela` — só passa a existir depois, quando `pGravaRegistro` roda. Daí toda inclusão nova gerar
seu lote inteiro de log com `LOG_CODITE` em branco (as linhas de E-commerce, geradas em outro ponto
do fluxo, depois do código já existir, saem corretas).

A chamada não pode simplesmente ser movida para depois de `inherited pGravaRegistro`: `pGravaLogAlteracao`
decide o que logar comparando `Fields[].Value` com `Fields[].OldValue`, e esse `OldValue` só é
significativo enquanto o dataset está em `dsInsert`/`dsEdit`, antes do `Post` — mover a chamada para
depois do `Post` (dentro de `pGravaRegistro`) quebraria a comparação e pararia de gerar log algum.

**Cobertura nas 6 cópias de trabalho:** inspecionado o mesmo ponto em todas. O bug existe apenas em
`379.48.2.30.72` e `72.Fechadas\379.48.2.30.72.453`, onde `fGravaItem` chama
`pGravaLogAlteracao(qryTabela)` incondicionalmente (Inclusão e Alteração), antes de
`inherited pGravaRegistro`. Nas outras 4 cópias (`379.48.2.30.74.111`, `379.48.2.30.74.150`,
`379.48.2.30.74.150.45`, `379.48.2.30.74.150.100`) essa chamada já foi reestruturada para dentro do
evento `qryTabelaOnBeforePost`, com uma guarda logo na primeira linha do evento
(`If (State <> dsEdit) Or (blnInserindo) Then Exit;`) que faz o log de `qryTabela` só rodar em
Alteração de registro já existente — nunca em Inclusão. Nessas 4 cópias o cenário do bug
simplesmente não ocorre, porque não há log de campos em Inclusão.

### 8.3 Abordagens consideradas e descartadas

- **Backfill via `UPDATE`** (gerar o log como hoje e, depois que o código existir, atualizar
  `LOG_CODITE` das linhas recém-inseridas por intervalo de `AUTOINCREM`) — avaliada e proposta
  inicialmente; envolveria alterar a assinatura de `pGravaLogAlteracao` (parâmetros `out` com o
  intervalo de `AUTOINCREM` usado) e adicionar uma nova rotina de atualização, além de um novo ponto
  de chamada em `untCadProdutos.pas`. Descartada por decisão explícita do usuário em favor de alinhar
  `30.72`/`72.453` à arquitetura já usada nas outras 4 cópias.
- **Gerar o código do item antes da chamada de log** (antecipando a atribuição que hoje acontece
  dentro de `pGravaRegistro`) — descartada: `pGravaRegistro` sempre gera um código novo quando
  `qryTabela.State = dsInsert`, independentemente de o campo já ter valor; antecipar a geração
  faria o código antecipado ser descartado e um segundo, diferente, ser realmente usado — queimando
  um número de sequencial por gravação, mesma classe de defeito já corrigida na seção 5 (déficit de
  reserva/consumo de sequencial).

### 8.4 Solução aplicada

Alinhar `379.48.2.30.72` e `72.Fechadas\379.48.2.30.72.453` à arquitetura já usada nas outras 4
cópias, em `padra_atualizado/fontes/cadastros/untCadProdutos.pas`:

1. Em `fGravaItem`, o bloco que chamava `TLogAltCadIte.pGravaLogAlteracao(qryTabela)` e
   `TLogAltCadIte.pGravaLogAlteracao(qryIteGer, ...)` antes de `inherited pGravaRegistro` foi
   inicialmente comentado (mesma convenção usada nas outras 4 cópias) e depois removido por
   completo (ver seção 8.8) — achado de revisão: mantê-lo comentado criaria um segundo ponto
   "aparente" de manutenção de LOGCPR na unit.
2. Em `qryTabelaOnBeforePost`, acrescentadas as variáveis locais `strNomeCampo`, `strValorAtual`,
   `strValorAntigo` e, após o bloco já existente de `TAltDes.pSalvaLog`, inserido o mesmo bloco já
   presente nas outras 4 cópias: chamada a `pGravaLogAlteracao(qryTabela)`, log individual do campo
   "Imprime Lista" via `pGravaLogAlteracaoIndividual`, e chamada a
   `pGravaLogAlteracao(qryIteGer, ...)` para abreviações fiscais. Como o evento inteiro sai
   (`Exit`) quando `blnInserindo = True`, esse bloco nunca executa em Inclusão — eliminando o
   cenário de `LOG_CODITE` em branco sem tocar em `untPaiCad.pas` (rotina genérica compartilhada por
   outras telas de cadastro).

**Efeito colateral esperado, não uma regressão:** itens incluídos por essas duas cópias deixam de
gerar qualquer linha em `LOGCPR` para a inclusão em si — mesmo comportamento já em vigor nas outras 4
cópias. Alterações em itens já existentes continuam gerando log normalmente, com `LOG_CODITE`
preenchido (o dataset já tem o código real desde o início, nesse caso).

### Validação pós-implementação

Mesmo processo das correções anteriores: edição via Python com `encoding='cp1252'` explícito,
validação de decodificação limpa e ausência de `\xef\xbf\xbd`, e `svn diff` conferido via
`corrigeUnitFlipCRLF-LF` em ambas as cópias — só as mudanças pretendidas, sem ruído de EOL/encoding.

### 8.5 Achado de revisão — comparação Null-unsafe em `ITE_IMPLIS` (bloco da seção 8.4)

Revisão do próprio bloco adicionado em `qryTabelaOnBeforePost` (seção 8.4) apontou dois problemas de
manuseio de `Variant`/`Null`, ambos em `untCadProdutos.pas`:

```pascal
If qryIteGer.FieldByName('ITE_IMPLIS').Value <> qryIteGer.FieldByName('ITE_IMPLIS').OldValue Then
Begin
  strNomeCampo := 'Imprime Lista';
  strValorAntigo := String(qryIteGer.FieldByName('ITE_IMPLIS').OldValue);
  strValorAtual := String(qryIteGer.FieldByName('ITE_IMPLIS').Value);
  ...
```

1. **Comparação `Value <> OldValue` sem proteção contra `Null`:** se um lado for `Null` e o outro
   `'S'`/`'N'`, o operador `<>` pode lançar `EVariantTypeCastError` (a depender de
   `NullStrictConvert`) dentro do `BeforePost` — fora do único `Try/Except` do método (que só cobre
   o bloco de `TAltDes.pSalvaLog`, linhas ~8811-8823) — abortando a gravação inteira do produto. Se
   ambos os lados forem `Null`, o resultado da comparação também é `Null` (avaliado como `False`),
   podendo mascarar uma alteração real `Null → valor`.
2. **Cast direto `String(...)` de variante potencialmente `Null`:** mesmo risco de
   `EVariantTypeCastError` ao formatar `strValorAntigo`/`strValorAtual` se `ITE_IMPLIS` estiver
   `Null` (cenário plausível em produto legado/migrado).

**Correção:** substituídos os acessos diretos por `VarToStr`, que trata `Null` como string vazia sem
lançar exceção:

```pascal
If VarToStr(qryIteGer.FieldByName('ITE_IMPLIS').Value) <>
   VarToStr(qryIteGer.FieldByName('ITE_IMPLIS').OldValue) Then
Begin
  strNomeCampo := 'Imprime Lista';
  strValorAntigo := VarToStr(qryIteGer.FieldByName('ITE_IMPLIS').OldValue);
  strValorAtual  := VarToStr(qryIteGer.FieldByName('ITE_IMPLIS').Value);
  ...
```

Aplicado nas 3 cópias que receberam o bloco na correção da seção 8: `379.48.2.30.72`,
`72.Fechadas\379.48.2.30.72.453` e `379.48.2.30.72.CONFE`. Validado via `corrigeUnitFlipCRLF-LF` nas
3 — `svn diff` sem ruído de EOL/encoding, só as mudanças pretendidas.

### 8.6 Achado de revisão — vazamento de `TUniQuery` em `pGravaLogAlteracaoIndividual`, reaberto

Revisão do mesmo commit apontou que `pGravaLogAlteracaoIndividual` (`untLogAltCadIte.pas`) tem o
mesmo padrão de vazamento de `TUniQuery` já corrigido na seção 5 para `pGravaLogAlteracao` e
`pGravaLogAlteracaoEcommerce` — `qryLogCpr := fCriaQuery;` seguido de um corpo que pode lançar
exceção (`Insert`, `FieldByName`, `Post`, `fRetAutoIncrem`) e só então `qryLogCpr.Post;` no fim do
procedimento, sem `Try/Finally`. Na seção 6 este achado tinha ficado deliberadamente fora de escopo,
por não ter sido citado pelo usuário junto com os outros dois métodos.

**Por que reabrir agora:** a correção da seção 8.4 passou a chamar
`TLogAltCadIte.pGravaLogAlteracaoIndividual(...)` a cada `OnBeforePost` de produto em que
`ITE_IMPLIS` muda, em `379.48.2.30.72`, `72.Fechadas\379.48.2.30.72.453` e `379.48.2.30.72.CONFE` —
um consumidor real e recorrente que antes não existia nessas três cópias. Em cliente com muitas
alterações de catálogo, isso acumularia `TUniQuery` órfãos e cursores do UniDAC ao longo de toda a
sessão. O vazamento já existia antes (e já era exercitado nas outras 4 cópias, que já chamavam esse
método por outro caminho), mas a ausência de um consumidor visível nessas três cópias mascarava o
problema.

**Correção:** mesmo padrão das seções 5/8.4 — corpo do procedimento (a partir de
`qryLogCpr.SQL.Text := ...`) envolvido em `Try/Finally`, com `FreeAndNil(qryLogCpr)` no `Finally`,
reindentado por 2 espaços. Aplicado nas **7 cópias de trabalho** (não só as 3 da seção 8.4): o método
já era chamado, com o mesmo padrão de vazamento pré-existente, também em `379.48.2.30.74.111`,
`379.48.2.30.74.150`, `379.48.2.30.74.150.45` e `379.48.2.30.74.150.100`, antes mesmo desta sessão.
Validado via `corrigeUnitFlipCRLF-LF` nas 7 — `svn diff` sem ruído de EOL/encoding, só as mudanças
pretendidas.

### 8.7 Achado de revisão — transação prematura em torno de `TAltDes.pSalvaLog`

Revisão do bloco de `qryTabelaOnBeforePost` apontou que o trecho pré-existente (já presente antes
desta sessão):

```pascal
Try
  fStartTransaction;
  TAltDes.pSalvaLog(FieldByName('ITE_CODITE').AsString, ...);
  fCommit;
Except
  fRollback;
End;
```

fazia `fCommit` de uma transação — mas `fGravaItem` já havia aberto sua própria transação externa
(`fStartTransaction`, antes de `inherited pGravaRegistro`) que ainda está em andamento nesse ponto do
fluxo (`qryTabelaOnBeforePost` roda durante o `Post` de `qryTabela`, dentro dessa mesma transação).
Esse `fCommit` fechava a transação externa antes da hora. Antes da correção da seção 8.4, isso não
tinha consequência visível: nada crítico rodava depois, na mesma transação. A partir da seção 8.4, o
bloco de log (`pGravaLogAlteracao`/`pGravaLogAlteracaoIndividual`) passou a rodar logo em seguida,
dentro do que deveria continuar sendo a mesma transação — o `fCommit` prematuro passou a fechá-la
antes que esse código crítico rodasse, tornando um problema pré-existente (mas inofensivo) em uma
causa direta de perda de transação.

**Correção:** removido o `Try/fStartTransaction/fCommit/Except/fRollback` ao redor de
`TAltDes.pSalvaLog`, deixando a chamada direta dentro do `If` — igual ao padrão já usado em
`379.48.2.30.74.150` (que nunca teve essa transação própria nesse ponto). Aplicado nas 3 cópias que
receberam o bloco de log na seção 8.4: `379.48.2.30.72`, `72.Fechadas\379.48.2.30.72.453` e
`379.48.2.30.72.CONFE`. Validado via `corrigeUnitFlipCRLF-LF` nas 3 — `svn diff` sem ruído de
EOL/encoding, só as mudanças pretendidas.

**Ressalva de escopo (pendência registrada, não uma correção adicional):** avaliação posterior desta
mudança concluiu que ela é **tecnicamente inócua** — o `fStartTransaction` removido estava aninhado
sobre a transação já aberta em `fGravaItem`/`pGravaRegistro` (`untPaiCad.pas:239-240`: o UniDAC não
abre uma segunda transação real ali, e o `fRollBack` do `Except` antigo cancelaria a transação
inteira de qualquer forma, não só o trecho de `TAltDes.pSalvaLog`). Ou seja, a remoção não corrige um
bug novo introduzido por esta sessão — apenas elimina uma redundância que já era inofensiva. Ainda
assim, essa mudança está **fora do escopo declarado do Req. 462563** (que trata da duplicidade de
`AUTOINCREM` em `LOGCPR` e, na segunda causa raiz, do `LOG_CODITE` em branco) — foi aplicada por ter
sido apontada como achado de revisão sobre o próprio bloco novo desta sessão (seção 8.4), não porque
o requisito original a exigisse. Registrada aqui para transparência de escopo.

### 8.8 Achado de revisão — remoção do código morto comentado em `fGravaItem`

A correção da seção 8.4 tinha comentado (não removido) o bloco antigo de chamadas a
`pGravaLogAlteracao` em `fGravaItem`, seguindo a mesma convenção já usada nas outras 4 cópias
(74.111/74.150/74.150.45/74.150.100), que já tinham esse bloco comentado antes desta sessão.

Revisão apontou o risco de manter código comentado permanentemente nessas três cópias: cria um
segundo ponto "aparente" de manutenção de LOGCPR na unit — qualquer manutenção futura precisaria
conferir os dois locais (`fGravaItem` e `qryTabelaOnBeforePost`) para entender onde o log realmente
é gerado. Pior, se alguém reativasse o bloco comentado por engano (ex.: durante um merge ou uma
limpeza de código mal avaliada), o log voltaria a ser gerado em duas trilhas — a antiga em
`fGravaItem` e a nova em `qryTabelaOnBeforePost` — reproduzindo exatamente o tipo de duplicidade de
`LOGCPR` que este requisito existe para corrigir.

**Correção:** removidas (não apenas comentadas) as linhas do bloco antigo em `fGravaItem`, nas 3
cópias que passaram pela correção da seção 8.4: `379.48.2.30.72`, `72.Fechadas\379.48.2.30.72.453` e
`379.48.2.30.72.CONFE`. `fGravaItem` passa a ir direto de `fStartTransaction;` para
`inherited pGravaRegistro;`, sem nenhum vestígio do bloco antigo. As outras 4 cópias, que já tinham
esse bloco comentado antes desta sessão (estado pré-existente, fora do diff deste requisito), não
foram tocadas. Validado via `corrigeUnitFlipCRLF-LF` nas 3 — `svn diff` sem ruído de EOL/encoding, só
as mudanças pretendidas.

### 8.9 Achados de revisão — inicialização morta e leitura de chave via UI em `qryTabelaOnBeforePost`

Dois achados de revisão sobre o mesmo bloco novo da seção 8.4/8.5:

1. **Inicialização morta:** `strNomeCampo`, `strValorAtual` e `strValorAntigo` eram inicializadas com
   `''` logo no início do procedimento, mas as três são reatribuídas incondicionalmente (dentro do
   único `If` que as usa) antes de qualquer leitura — a inicialização nunca é observada, é código morto.
2. **Leitura de chave via componente de UI:** a chamada a `TLogAltCadIte.pGravaLogAlteracaoIndividual`
   passava `dbeCodIte.text` (valor lido do `TDBEdit` na tela) em vez de
   `FieldByName('ITE_CODITE').AsString` (valor do próprio dataset que está sendo postado, dentro do seu
   próprio `OnBeforePost`). Se o componente de tela estivesse dessincronizado do field — por exemplo,
   uma edição no `DBEdit` ainda não commitada para o dataset no instante do Post — o log gravaria a
   linha com o código de item errado.

**Correção:** removidas as três linhas de inicialização com `''` (a declaração das variáveis em `Var`
foi mantida, só a inicialização morta foi removida); `dbeCodIte.text` trocado por
`FieldByName('ITE_CODITE').AsString` na chamada a `pGravaLogAlteracaoIndividual`. Aplicado nas mesmas 3
cópias: `379.48.2.30.72`, `72.Fechadas\379.48.2.30.72.453` e `379.48.2.30.72.CONFE`. Validado via
`corrigeUnitFlipCRLF-LF` nas 3 — `svn diff` sem ruído de EOL/encoding, só as mudanças pretendidas.

### 8.10 Achado de revisão — `Sender.Visible` em `fValidaCampos` (fora do escopo do Req. 462563)

Durante a revisão do diff completo de `untCadProdutos.pas` em `379.48.2.30.72`, foi identificada uma
mudança em `fValidaCampos` (linha ~7952) não relacionada às seções 8.1–8.9: o guard
`If Sender.Enabled Then` (para a validação Sim/Não de `dbeComLub`, `dbeIncPis`, `dbeImpLis`,
`dbeAtiCom`, `dbeApeRet`, `dbeApeEnt`) passou a `If Sender.Enabled And Sender.Visible Then`.

Essa mudança **não foi feita como parte da investigação/correção do Req. 462563** — é um ajuste do
próprio usuário (Danilo Stefaneli), aplicado diretamente na working copy `379.48.2.30.72`, para tratar
a validação de campos que não estão visíveis na tela: sem o `And Sender.Visible`, um campo desses,
mesmo oculto (portanto não editável pelo usuário na tela atual), podia travar a gravação por falhar a
validação Sim/Não, sem que o usuário tivesse como corrigi-lo (o campo não está acessível para edição).

Confirmado que essa mudança existe **apenas** em `379.48.2.30.72` — ausente em
`72.Fechadas\379.48.2.30.72.453` e em `379.48.2.30.72.CONFE`. Fica registrada aqui, junto das demais
alterações de `untCadProdutos.pas` nesta working copy, por transparência de escopo — não é replicada
para as demais cópias por não fazer parte da correção do Req. 462563 nem ter sido solicitada para elas.

## 9. Mapeamento do diff × Mudanças (rastreabilidade)

Tabela de correspondência entre cada hunk do `svn diff` de `untCadProdutos.pas`/`untLogAltCadIte.pas`
e a Mudança documentada que o originou, para permitir reversão pontual de uma mudança específica sem
afetar as demais.

| Arquivo | Hunk (função/método) | Mudança | Seção | Cópias |
|---|---|---|---|---|
| `untLogAltCadIte.pas` | `pGravaLogAlteracao` / `pGravaLogAlteracaoEcommerce` — reserva `Fields.Count + 1` | Mudança 1 | 5 | 7 cópias |
| `untLogAltCadIte.pas` | `pGravaLogAlteracao` / `pGravaLogAlteracaoEcommerce` — remoção do `pIncrementaAutoIncrem` duplicado | Mudança 2 | 5 | 7 cópias |
| `untLogAltCadIte.pas` | `pGravaLogAlteracao` / `pGravaLogAlteracaoEcommerce` — `Try/Finally` + `FreeAndNil` | Mudança 3 | 7 | 7 cópias |
| `untCadProdutos.pas` | `fGravaItem` — remoção das chamadas a `pGravaLogAlteracao(qryTabela)` / `pGravaLogAlteracao(qryIteGer, ...)` | Mudança 4 | 8.4 | 72 / 72.453 / CONFE |
| `untCadProdutos.pas` | `qryTabelaOnBeforePost` — novo bloco `If fCfgSis('LOGCPR', ...)` com `pGravaLogAlteracao(qryTabela)` e `pGravaLogAlteracao(qryIteGer, ...)` | Mudança 4 | 8.4 | 72 / 72.453 / CONFE |
| `untCadProdutos.pas` | `qryTabelaOnBeforePost` — `VarToStr(...)` nas comparações/leituras de `ITE_IMPLIS` | Mudança 5 | 8.5 | 72 / 72.453 / CONFE |
| `untLogAltCadIte.pas` | `pGravaLogAlteracaoIndividual` — `Try/Finally` + `FreeAndNil` | Mudança 6 | 8.6 | 7 cópias |
| `untCadProdutos.pas` | `qryTabelaOnBeforePost` — remoção do `Try/fStartTransaction/fCommit/Except/fRollback` em torno de `TAltDes.pSalvaLog` | Mudança 7 (fora do escopo declarado, ver ressalva na seção 8.7) | 8.7 | 72 / 72.453 / CONFE |
| `untCadProdutos.pas` | `fGravaItem` — remoção física do bloco comentado (em vez de manter comentado) | Mudança 8 | 8.8 | 72 / 72.453 / CONFE |
| `untCadProdutos.pas` | `qryTabelaOnBeforePost` — remoção da inicialização morta `strNomeCampo/strValorAtual/strValorAntigo := ''` | Mudança 9 | 8.9 | 72 / 72.453 / CONFE |
| `untCadProdutos.pas` | `qryTabelaOnBeforePost` — `dbeCodIte.text` → `FieldByName('ITE_CODITE').AsString` em `pGravaLogAlteracaoIndividual` | Mudança 10 | 8.9 | 72 / 72.453 / CONFE |
| `untCadProdutos.pas` | `fValidaCampos` — `If Sender.Enabled Then` → `If Sender.Enabled And Sender.Visible Then` | Mudança 11 (fora do escopo do Req. 462563 — ajuste próprio do usuário) | 8.10 | **apenas 72** |

## 10. Ressalvas e lições

- **Working copies irmãs podem divergir significativamente entre si, mesmo em uma mesma unit pequena e
  aparentemente estável** — antes de replicar um diff "às cegas" em cópias irmãs, é necessário inspecionar
  cada uma individualmente. Neste caso, três das quatro cópias irmãs tinham o incremento duplicado em um
  método diferente do da cópia de origem da correção (`379.48.2.30.74.111` não tinha o duplicado; três
  cópias tinham em `pGravaLogAlteracao`; a cópia de origem tinha em `pGravaLogAlteracaoEcommerce`).
- **Arquivos `.pas` em encoding legado (cp1252/Latin-1)** — todas as edições desta correção foram feitas
  via Python, lendo e gravando com `encoding='cp1252'` explícito, nunca com a ferramenta de edição de texto
  genérica, para evitar corrupção silenciosa de caracteres acentuados em qualquer outra parte do arquivo.
- **Mecanismo de reserva de sequencial da aplicação (`fRetAutoIncrem`) não é um autoincremento nativo do
  banco** — reserva blocos inteiros de uma vez, validando unicidade apenas do primeiro número do bloco
  contra a tabela real; os demais números do bloco são consumidos localmente, sem nova validação. Qualquer
  rotina que use esse mecanismo com `intIntervalo > 1` deve garantir que o tamanho do bloco reservado
  cubra, com folga, o consumo máximo real, sob pena de reproduzir a mesma classe de bug corrigida aqui.

## Contexto Técnico (IA)

- Arquivo/unit: `padra_atualizado/fontes/cadastros/untLogAltCadIte.pas`, classe `TLogAltCadIte`.
- Funções alteradas: `pGravaLogAlteracao` (todas as 6 cópias) e `pGravaLogAlteracaoEcommerce` (existe
  em `379.48.2.30.72`, `72.Fechadas\379.48.2.30.72.453`, `379.48.2.30.74.150`,
  `379.48.2.30.74.150.45` e `379.48.2.30.74.150.100`; não existe em `379.48.2.30.74.111`).
- Tabela `LOGCPR`: log de alteração de campo a campo do Cadastro de Produtos. Chave primária
  `AUTOINCREM`, gerada pela aplicação (não é autoincremento nativo do MySQL).
- Tabela `PROINC`, campo `PRO_AUTINC`: contador de controle do sequencial, uma linha por
  `PRO_NOMARQ` (`'LOGCPR'` neste caso). Lido/gravado por `fRetAutoIncrem`/`fRetAutoIncremInterno`
  (`untFuncoesSimples.pas`) — função genérica usada por outras tabelas além de `LOGCPR`, não alterada
  nesta correção (decisão explícita do usuário).
- Mecanismo: `fRetAutoIncrem` reserva um bloco de N sequenciais de uma vez (`SELECT ... FOR UPDATE`
  em conexão própria + `UPDATE PRO_AUTINC += N` + `COMMIT` imediato, isolado da transação principal
  da gravação), validando unicidade contra a tabela real só para o primeiro número do bloco. Os
  demais números do bloco são consumidos localmente em memória, via `pIncrementaAutoIncrem`, sem
  nova consulta ao banco.
- Mudança 1 (déficit de reserva): terceiro parâmetro (`intIntervalo`) de
  `fRetAutoIncrem('LOGCPR', VS_strCodEmp, intIntervalo)` alterado de `Fields.Count - 1` para
  `Fields.Count + 1`, em `pGravaLogAlteracao` (`qryCadIte.Fields.Count`) e
  `pGravaLogAlteracaoEcommerce` (`qryInfos.Fields.Count`), onde existir. `Fields.Count` é a
  quantidade de campos da query de origem (`qryCadIte`/`qryInfos`); o laço de geração de log pode
  gerar até `Fields.Count` linhas (um `Insert` em `LOGCPR` por campo alterado), então
  `Fields.Count - 1` era insuficiente por definição no pior caso; `Fields.Count + 1` cobre o pior
  caso com uma unidade de folga extra, por decisão explícita do usuário (a alternativa avaliada e
  descartada foi reservar exatamente `Fields.Count`, sem folga).
- Mudança 2 (incremento duplicado): em `379.48.2.30.72` e `72.Fechadas\379.48.2.30.72.453`,
  `pGravaLogAlteracaoEcommerce` chamava `pIncrementaAutoIncrem(strAutIncBkp)` duas vezes por campo
  alterado (uma antes do `Post`, uma depois); removida a chamada anterior ao `Post`, mantida só a
  posterior. Em `379.48.2.30.74.150`, `379.48.2.30.74.150.45` e `379.48.2.30.74.150.100`, o mesmo
  duplicado existia, mas em `pGravaLogAlteracao` (não em `pGravaLogAlteracaoEcommerce`); mesma
  correção aplicada, no método correto de cada cópia. `379.48.2.30.74.111` não tinha esse duplicado
  em nenhum dos dois métodos (só tem `pGravaLogAlteracao`).
- Mudança 3 (vazamento de `TUniQuery`, achado de revisão): `qryLogCpr` (criado via `fCriaQuery`) era
  liberado por um `FreeAndNil(qryLogCpr)` solto no final do procedimento, sem `Try/Finally` —
  qualquer exceção entre a criação e esse ponto (incluindo o próprio erro de chave duplicada deste
  requisito) deixava o objeto sem ser liberado. Corrigido envolvendo o corpo de `pGravaLogAlteracao`
  e `pGravaLogAlteracaoEcommerce` (a partir de `qryLogCpr.SQL.Text := ...`) em `Try/Finally`, com
  `FreeAndNil(qryLogCpr)` no `Finally`, nas 6 cópias. `pGravaLogAlteracaoIndividual` tem o mesmo
  padrão mas não foi citado pelo usuário — ficou fora de escopo.
- Mudança 4 (`LOG_CODITE` em branco em Inclusão, segunda causa raiz — `379.48.2.30.72`,
  `72.Fechadas\379.48.2.30.72.453` e `379.48.2.30.72.CONFE`): `TLogAltCadIte.pGravaLogAlteracao(qryTabela)`
  era chamado em `untCadProdutos.pas` (`TfrmCadProdutos.fGravaItem`) antes de
  `inherited pGravaRegistro` (`untPaiCad.pas:246`), ponto onde o código do item é gerado e atribuído
  ao dataset em Inclusão. Como `LOG_CODITE` é lido de `qryCadIte.FieldByName('ITE_CODITE').AsString`
  no momento de cada linha de log (`untLogAltCadIte.pas:111`), toda inclusão nova gravava seu lote
  inteiro de log com `LOG_CODITE` vazio. Corrigido alinhando essas três cópias à arquitetura já usada
  nas outras 4 (`379.48.2.30.74.111`, `379.48.2.30.74.150`, `379.48.2.30.74.150.45`,
  `379.48.2.30.74.150.100`): chamada comentada em `fGravaItem`, mesmo bloco de log movido para
  dentro de `qryTabelaOnBeforePost`, que já tem `If (State <> dsEdit) Or (blnInserindo) Then Exit;`
  — o log de `qryTabela` passa a rodar só em Alteração, nunca em Inclusão, eliminando o cenário sem
  tocar em `untPaiCad.pas` (rotina genérica usada por outras telas de cadastro). Efeito colateral
  esperado (não regressão): itens incluídos por essas três cópias deixam de gerar qualquer linha em
  `LOGCPR` para a inclusão em si — mesmo comportamento já em vigor nas outras 4 cópias.
- Segundo sintoma investigado (que levou à Mudança 4): tela Consulta/Alteração de Catálogos, item sem
  código de produto ativado via `[F6] Ativar/Inativar`, incluído e salvo — `LOGCPR` gravou sem erro de
  duplicidade, mas com `LOG_CODITE` vazio na maior parte das linhas (192 linhas geradas, 184 com
  `LOG_CODITE` vazio), confirmado por consulta read-only ao banco do cliente (fornecedor `90490400`,
  `LOG_CODOPE = '904'`).
- Descartado (confirmado, não é o problema): condição de corrida entre usuários simultâneos na
  reserva do bloco — `fRetAutoIncremInterno` usa `SELECT ... FOR UPDATE` em conexão MySQL dedicada
  (`TCriarConexao.Create`), com `COMMIT` imediato; o lock InnoDB é aplicado pelo servidor
  independentemente da camada de aplicação, serializando corretamente chamadas concorrentes de
  sessões diferentes.
- Causa operacional (não corrigida nesta sessão, fora de escopo): no banco de produção do cliente
  FAZO FERRAMENTAS LTDA (host `FAZO-001-INDAIATUBA.DDNS.NET`, schema `AUTCOM`), consulta
  somente-leitura em 18/09/2026 confirmou `PROINC.PRO_AUTINC = 8726159` para `PRO_NOMARQ = 'LOGCPR'`,
  idêntico ao `MAX(AUTOINCREM)` real já gravado em `LOGCPR` para a empresa 001 (também `8726159`) —
  ou seja, o contador estava posicionado exatamente sobre a faixa já ocupada, fazendo qualquer nova
  geração colidir de imediato. `PROCOD.PRO_AUTINC` para `'LOGCPR'` = `NULL`, confirmando que a tela
  "Próximos Códigos" (`untCadProxCodigos.pas`, edita `PROCOD.PRO_CODSEQ`) não tem efeito sobre o
  contador real (`PROINC.PRO_AUTINC`) — achado colateral, não corrigido nesta sessão.
- Validação de encoding: todas as edições em `.pas` foram feitas via Python com `encoding='cp1252'`
  explícito (nunca com ferramenta de edição de texto genérica), e cada arquivo foi validado após a
  gravação (decodifica sem erro, sem a sequência de bytes `EF BF BD` / U+FFFD).
- Validação de ruído de diff: skill `corrigeUnitFlipCRLF-LF` executada (bulk e single-file, dry-run)
  em todas as working copies após cada rodada de implementação; os arquivos voltaram "clean" em
  todas — nenhuma linha classificada como ruído de EOL ou de encoding, todas as diferenças contra a
  revisão BASE do SVN correspondem exatamente às mudanças pretendidas.
- Achado colateral não relacionado a este requisito, sinalizado mas não investigado: em
  `379.48.2.30.74.111`, o script apontou "possible mojibake" em duas linhas de
  `padra_atualizado/fontes/fiscal/libFiscalCat42.dproj.local` — arquivo e alteração pré-existentes
  na working copy, sem relação com o Req. 462563; não investigado nem tocado nesta sessão.
