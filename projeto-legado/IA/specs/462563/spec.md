# Especificação — Req. 462563

**Título:** Chave duplicada na tabela LOGCPR ao salvar Cadastro/Catálogo de Produtos
**Objetivo:** Eliminar a causa raiz estrutural que permite ao mecanismo de log de alteração de campos (`LOGCPR`) gerar um `AUTOINCREM` já existente na tabela, causando `#23000 Duplicate entry ... for key 'PRIMARY'` ao salvar produtos.
**Zona:** Legado
**Data:** 18/09/2026

## 1. Contexto / problema atual

Ao salvar um produto (Cadastro de Produtos ou Consulta/Alteração de Catálogos, que reutiliza a mesma rotina de gravação do Cadastro de Produtos), o sistema grava um registro em `LOGCPR` para cada campo alterado. O `AUTOINCREM` (chave primária de `LOGCPR`) é gerado por `TLogAltCadIte` (`untLogAltCadIte.pas`), que:

1. Reserva um bloco de sequenciais chamando `fRetAutoIncrem('LOGCPR', VS_strCodEmp, intIntervalo)`, com `intIntervalo = Fields.Count - 1`.
2. Consome os números do bloco localmente, um por campo alterado, via `pIncrementaAutoIncrem` — sem nova consulta ao banco a cada consumo.

Foram identificadas em campo (cliente FAZO FERRAMENTAS LTDA, loja 001) ocorrências repetidas do erro `Chave Duplicada na Tabela: LOGCPR`, registradas em `LOGERR` ao longo do dia 17/09/2026, com o padrão relatado pelo usuário: a primeira gravação passa sem erro, a segunda retorna duplicidade e a operação não é concluída.

Consulta ao banco do cliente (18/09/2026) confirmou:
- `PROINC.PRO_AUTINC` para `LOGCPR` = `8726159`
- `MAX(AUTOINCREM)` já gravado em `LOGCPR` (empresa 001) = `8726159` — **idêntico ao contador**, ou seja, o próximo número gerado colide de imediato com o último já existente.
- `PROCOD.PRO_AUTINC` para `LOGCPR` = `NULL` (campo não é o usado pelo gerador real — a tela "Próximos Códigos", que edita `PROCOD`, não tem efeito sobre o contador real em `PROINC`).

Análise de código revelou uma **falha estrutural independente do estado atual do banco**, presente em `untLogAltCadIte.pas`:

- Em `pGravaLogAlteracao` (linha 88), o bloco reservado tem `Fields.Count - 1` números, mas o laço de geração de log (linha 92: `For intContador := 0 To qryCadIte.Fields.Count - 1`) pode, no pior caso (todos os campos alterados), gerar até `Fields.Count` linhas de log — **um número a mais do que o reservado**. O último registro consumido nesse cenário coincide com o primeiro número que a próxima chamada a `fRetAutoIncrem('LOGCPR', ...)` vai devolver, gerando colisão determinística, sem depender de erro externo ou de ajuste manual do contador.
- Em `pGravaLogAlteracaoEcommerce` (linha 204), o mesmo déficit de reserva (`Fields.Count - 1`) existe, agravado por uma chamada **duplicada** a `pIncrementaAutoIncrem` (linhas 269 e 273 — antes e depois do `Post`), que consome 2 números do bloco por campo alterado em vez de 1, ampliando ainda mais o déficit.

O ajuste manual do contador `PROINC.PRO_AUTINC`, realizado pelo suporte a cada incidente (fora do escopo deste requisito — ver seção 7), reposiciona o contador dentro da faixa já ocupada em `LOGCPR`, o que faz a falha estrutural se manifestar imediatamente.

## 2. Módulos e entidades envolvidos

- Módulo: cadastros (Cadastro de Produtos / Consulta de Preços — Consulta/Alteração de Catálogos)
- Unit: `padra_atualizado/fontes/cadastros/untLogAltCadIte.pas`
- Tabelas: `LOGCPR` (chave primária `AUTOINCREM`), `PROINC` (contador de controle, chave `PRO_NOMARQ`)

## 3. Requisitos funcionais

- RF01 — Ao gravar alterações de campos do Cadastro de Produtos (fluxo `pGravaLogAlteracao`), a quantidade de sequenciais reservada em `PROINC` deve ser suficiente para cobrir o pior caso de consumo (todos os campos elegíveis alterados), evitando reutilização de um `AUTOINCREM` que a próxima reserva de bloco também venha a devolver.
- RF02 — O mesmo comportamento (RF01) se aplica ao fluxo de log de campos de E-commerce (`pGravaLogAlteracaoEcommerce`).
- RF03 — O fluxo `pGravaLogAlteracaoEcommerce` deve consumir exatamente 1 número do bloco reservado por linha de log gravada (hoje consome 2, por chamada duplicada de incremento).

## 4. Regras de negócio

- RN01 — O tamanho do bloco reservado via `fRetAutoIncrem('LOGCPR', ..., intIntervalo)` deve ser `Fields.Count + 1` (não `Fields.Count - 1`), tanto em `pGravaLogAlteracao` quanto em `pGravaLogAlteracaoEcommerce` — a folga de +1 além do pior caso teórico (`Fields.Count`) foi decisão explícita do usuário durante a implementação, como margem de segurança adicional.
- RN02 — Em `pGravaLogAlteracaoEcommerce`, `pIncrementaAutoIncrem` deve ser chamado **uma única vez** por campo alterado (após o `Post`, mantendo consistência com `pGravaLogAlteracao`).
- RN03 — A função genérica `fRetAutoIncrem`/`fRetAutoIncremInterno` (`untFuncoesSimples.pas`) está fora de escopo e não deve ser alterada — é usada por outras tabelas além de `LOGCPR`.

## 5. Requisitos técnicos / não-funcionais

- Alteração restrita a `untLogAltCadIte.pas`, sem impacto em outras tabelas que usam `fRetAutoIncrem`.
- Sem impacto em transação/auditoria além do já existente (a reserva do contador continua em transação própria e commit imediato, comportamento inalterado por este requisito).

## 6. Critérios de aceitação

- [ ] Ao alterar o maior número possível de campos logáveis de um produto em uma única gravação (Cadastro de Produtos ou Consulta/Alteração de Catálogos) e salvar duas vezes seguidas, não deve ocorrer `#23000 Duplicate entry` em `LOGCPR` decorrente do déficit de reserva corrigido.
- [ ] `pGravaLogAlteracaoEcommerce` deixa de fazer incremento duplicado por campo alterado.
- [ ] Nenhuma outra tabela/rotina que usa `fRetAutoIncrem` é afetada pela mudança.

## 7. Fora de escopo

- Ajuste do valor atual de `PROINC.PRO_AUTINC` no banco do cliente FAZO FERRAMENTAS LTDA (contador hoje alinhado exatamente com o `MAX(AUTOINCREM)` de `LOGCPR`) — decisão do usuário de tratar separadamente, fora deste requisito.
- Qualquer alteração na função genérica `fRetAutoIncrem`/`fRetAutoIncremInterno`.
- Revisão da tela "Próximos Códigos" (`untCadProxCodigos.pas`) e sua falta de efeito sobre o contador real usado por `LOGCPR` (achado colateral da análise, não tratado neste requisito).

## 8. Dependências e riscos

- Sem dependência de outros módulos/serviços.
- Risco: como o incidente do cliente FAZO não é corrigido neste requisito, o erro de duplicidade pode continuar ocorrendo naquele ambiente específico até um ajuste de banco separado, mesmo após esta correção de código.
- Risco residual: não foi identificado nenhum outro chamador que dependa do tamanho exato do bloco reservado por estas duas rotinas.

## 9. Replicação em cópias irmãs

A mesma classe de defeito (déficit de reserva de sequencial + incremento local duplicado) foi verificada e corrigida também nas seguintes cópias de trabalho, cada uma com o código de `untLogAltCadIte.pas` em estado ligeiramente distinto:

| Cópia | `pGravaLogAlteracao` | `pGravaLogAlteracaoEcommerce` |
|---|---|---|
| `379.48.2.30.74.111` | reserva corrigida para `Fields.Count + 1`; já tinha incremento único (sem duplicidade) | método não existe nesta cópia |
| `379.48.2.30.74.150` | reserva corrigida para `Fields.Count + 1`; incremento duplicado (estava nesta rotina, não na Ecommerce) removido | reserva corrigida para `Fields.Count + 1`; já tinha incremento único |
| `379.48.2.30.74.150.45` | idêntico a 74.150 | idêntico a 74.150 |
| `379.48.2.30.74.150.100` | idêntico a 74.150 | idêntico a 74.150 |

Nessas três últimas cópias, o incremento duplicado estava em `pGravaLogAlteracao` (não em `pGravaLogAlteracaoEcommerce`, como na 30.72) — mesmo defeito conceitual, localizado de forma diferente por divergência histórica entre as cópias. Correção replicada no mesmo espírito da RN02, no método onde o duplicado realmente ocorria em cada cópia.

## 10. Segunda causa raiz — `LOG_CODITE` gravado em branco em Inclusão (30.72 / 72.453)

Novo sintoma relatado (Consulta de Preços > Consulta/Alteração de Catálogos): ao selecionar um item sem código de produto, ativar via `[F6] Ativar/Inativar`, incluir e salvar, a gravação em `LOGCPR` não apresenta erro de chave duplicada, mas a maior parte das linhas geradas grava com `LOG_CODITE` vazio — só as últimas linhas (geradas depois que o código do item já existe) saem com o código correto.

**Causa raiz:** em `untCadProdutos.pas` (`fGravaItem`), a chamada `TLogAltCadIte.pGravaLogAlteracao(qryTabela)` acontecia **antes** de `inherited pGravaRegistro`. É dentro de `pGravaRegistro` (`untPaiCad.pas`, genérica) que o código do item é gerado e atribuído ao dataset (`qryTabela.FieldByName(strNomeCampo).AsString := fProximoCodigo;`), para registros em Inclusão. Como `pGravaLogAlteracao` lê `qryCadIte.FieldByName('ITE_CODITE').AsString` no momento de cada linha de log (`untLogAltCadIte.pas:111`), e essa chamada roda antes do código existir no dataset, toda inclusão nova gerava seu lote inteiro de log com `LOG_CODITE` em branco.

Essa falha existia nas cópias `379.48.2.30.72`, `72.Fechadas\379.48.2.30.72.453` e `379.48.2.30.72.CONFE`, que chamam `pGravaLogAlteracao(qryTabela)` incondicionalmente em `fGravaItem` (Inclusão e Alteração). Nas demais cópias irmãs (`379.48.2.30.74.111`, `379.48.2.30.74.150`, `379.48.2.30.74.150.45`, `379.48.2.30.74.150.100`) essa chamada já foi reestruturada para dentro do evento `qryTabelaOnBeforePost`, condicionada a `If (State <> dsEdit) Or (blnInserindo) Then Exit;` — ou seja, o log de `qryTabela` só roda em Alteração de registro já existente, nunca em Inclusão, então o cenário do bug nunca ocorre nelas.

**Decisão:** alinhar `30.72` e `72.453` à arquitetura já usada nas outras 4 cópias, em vez de introduzir um mecanismo novo (ex.: backfill via `UPDATE`) só nessas duas.

- RF04 — Em Inclusão de item (`blnInserindo = True`), a rotina `pGravaLogAlteracao(qryTabela)` não deve ser chamada — mesma regra já aplicada nas demais cópias.
- RF05 — Em Alteração de item existente, `pGravaLogAlteracao(qryTabela)` deve ser chamada a partir do evento `qryTabelaOnBeforePost`, junto com o log individual de "Imprime Lista" (`pGravaLogAlteracaoIndividual`) e o log de abreviações fiscais (`pGravaLogAlteracao(qryIteGer, ...)`), replicando exatamente a estrutura já usada em `74.150`/`74.111`/`74.150.45`/`74.150.100`.
- RN04 — A chamada original em `fGravaItem` (antes de `inherited pGravaRegistro`) é comentada, não removida, seguindo a mesma convenção já usada nas outras cópias para preservar o histórico do código.

### Critérios de aceitação (adicional)

- [ ] Ao incluir um item novo (via Cadastro de Produtos ou Consulta/Alteração de Catálogos) alterando vários campos numa mesma gravação, nenhuma linha de `LOGCPR` é gerada para essa inclusão (mesmo comportamento das demais cópias).
- [ ] Ao alterar um item já existente, `LOGCPR` continua sendo gravado normalmente, com `LOG_CODITE` preenchido em todas as linhas.

### Fora de escopo (adicional)

- Qualquer alteração em `untPaiCad.pas`/`pGravaRegistro` (função genérica usada por outras telas de cadastro).
- Estender o log de Inclusão a essas duas cópias com o código já preenchido (ex.: via backfill) — decisão do usuário foi igualar ao comportamento das demais cópias (sem log de Inclusão), não inventar um terceiro comportamento.
