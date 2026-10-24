# Especificação — Req. 465598

**Título:** SPCDEN — performance do SELECT de movimentos sem lote (fSQLMovimentos) e validação de triggers ao ativar a configuração
**Objetivo:** (1) Eliminar a varredura completa da EXTGOR no SELECT de `fSQLMovimentos` (cadastro de lote) quando a configuração `CFG_SPCDEN` está ligada, sem alterar o resultado da consulta. (2) Impedir a ativação de `CFG_SPCDEN` quando as triggers `BI_EXTGOR_DOCEND` e `BU_EXTGOR_DOCEND` não existirem no banco. (3) Exibir, na tela de configurações, um hint em `CFG_SPCDEN` informando as dependências (triggers e UPDATE dos documentos existentes).
**Zona:** Legado
**Data:** 2026-10-02

## 1. Contexto / problema atual

Ao cadastrar um lote na `untCadLote` (`TCadLot.pSetaMovDet`), a rotina `fSQLMovimentos(strTabela)` monta o SELECT que busca, em `MOVDET` e `NOTDET`, os movimentos do item sem lote (`IFNULL(DET_NUMLOT, "") = ""`) posteriores à data de balanço. Para cada linha, um `EXISTS` correlacionado verifica se o documento gerou endereçamento (coluna `ENDERE`), consultando `EXTGOR` + `FATDOR`.

Com `CFG_SPCDEN = 'S'` (caso da empresa 004), `fRetSQLDocEnd` vincula o documento por 6 colunas próprias (`FGO_DCENUM`, `FGO_DCEESP`, `FGO_DCESER`, `FGO_DCEEMP`, `FGO_DCEFOR`, `FGO_DCETFC`). O `SELECT STRAIGHT_JOIN 1` do `EXISTS` força a ordem EXTGOR → FATDOR e o MySQL 5.7 não usa o índice `IDX_EXTGOR_70` sobre essas colunas: faz `type=ALL` (~1,75 milhão de linhas) a cada linha de MOVDET/NOTDET.

Causa do índice ser ignorado (levantada por EXPLAIN, `SHOW INDEX` e contagem, somente leitura, base AUTCOM):
- `IDX_EXTGOR_70` tem cardinalidade 1 em todas as colunas.
- Apenas 22 de 1.781.519 linhas de EXTGOR têm `FGO_DCENUM` preenchido (nenhuma vazia). A coluna é preenchida por trigger junto com `FGO_DOCEND`; o NULL é o estado normal da tabela.
- Sem informar que o índice é esparso, o otimizador estima ~1,75 milhão de linhas e prefere varredura.

Medição (empresa 004, item 37596, `:DTABAL` = 2026-09-23, 1 execução cada):

| Variante | Tempo |
|---|---|
| Original (STRAIGHT_JOIN, sem IS NOT NULL) | ~5.600–5.900 ms |
| Sem STRAIGHT_JOIN | ~323 ms |
| Com `AND FGO_DCENUM IS NOT NULL` (mantendo STRAIGHT_JOIN) | ~416 ms |

Com `CFG_SPCDEN = 'N'` não há diferença relevante (~300 ms nas duas formas, índice `IDX_EXTGOR_16` por `FGO_DOCEND`).

### 1.1 Validação da configuração SPCDEN

A `CFG_SPCDEN` só funciona se as triggers que preenchem as colunas `FGO_DCE*` da `EXTGOR` junto com `FGO_DOCEND` existirem (`BI_EXTGOR_DOCEND` no INSERT e `BU_EXTGOR_DOCEND` no UPDATE). Hoje nada impede ligar a configuração sem elas: o ramo `SPCDEN` de `fRetSQLDocEnd` passaria a comparar colunas que nunca são preenchidas e `ENDERE` retornaria sempre `'N'`.

A tela de validação de configurações (`untCfgSistemaValidar.pas`) já tem validação equivalente para a `CFG_DASWEB` — `TValidarConfiguracoes.fValidaDASWEB`: lê o valor em `cdsCfgSis` via `fFindCfg`, e, se for `'S'`, exige as tabelas e as triggers (função local `fTriggerExiste`, consulta em `INFORMATION_SCHEMA.TRIGGERS` com `TRIGGER_SCHEMA = DATABASE()`, `TRIGGER_NAME` e `EVENT_OBJECT_TABLE` por parâmetro). Se faltar algo, mostra `fMensagem('ATENÇÃO!', ...)` e retorna `False`, bloqueando o salvamento. Ela é chamada em cadeia (`If (Not fValidaDASWEB()) Then Exit;`).

Observação sobre a base AUTCOM consultada (somente leitura): a consulta em `INFORMATION_SCHEMA.TRIGGERS` não retornou nenhuma trigger na tabela `EXTGOR`, apesar de `CFG_SPCDEN = 'S'` nas empresas 001 e 004 e de 22 linhas com `FGO_DCENUM` preenchido. Os nomes `BI_EXTGOR_DOCEND` / `BU_EXTGOR_DOCEND` e a tabela `EXTGOR` não aparecem em nenhum fonte do projeto; a tabela alvo foi assumida a partir do nome.

### 1.2 Hint da configuração SPCDEN

A tela de configurações (`TfrmCfgSistema`, `untCfgSistema.pas`) mostra textos de ajuda por configuração no painel `pnlInfoCfgSis` / memo `mmoInfoCfgSis`, por procedures `pAdicionarHintCFG_<CFG>` (ex.: `pAdicionarHintCFG_LIBEQP`, linha ~10262): saem se `SIS_CODCFG` não for a configuração, limpam o memo, definem altura do painel, `Visible := True`, fonte vermelha (`clRed`, `Height := 16`) e adicionam as linhas. Todas são declaradas na classe (bloco ~422–436) e chamadas em sequência na rotina que as dispara (~9250–9279). Não existe hint para `CFG_SPCDEN`.

## 2. Módulos e entidades envolvidos

- Módulo: cadastros (cadastro de lote) e configurações (validação de configurações do sistema).
- Unit: `padra_atualizado\fontes\cadastros\untCadLote.pas` — `TCadLot.fSQLMovimentos` (e função local `fRetSQLDocEnd`).
- Unit: `padra_atualizado\fontes\configuracoes\untCfgSistemaValidar.pas` — nova `TValidarConfiguracoes.fValidaSPCDEN`, modelada em `fValidaDASWEB`.
- Unit: `padra_atualizado\fontes\configuracoes\untCfgSistema.pas` — novo `TfrmCfgSistema.pAdicionarHintCFG_SPCDEN`, modelado em `pAdicionarHintCFG_LIBEQP`.
- Triggers verificadas: `BI_EXTGOR_DOCEND` e `BU_EXTGOR_DOCEND` (tabela `EXTGOR`).
- Tabelas: `MOVDET`, `NOTDET`, `CADITE`, `AUXMOV`, `EXTGOR` (PK `FGO_SEQFGO`), `FATDOR` (`FDO_SEQGER`).
- Configuração: `CFGSIS` (`SIS_CODCFG = 'CFG_SPCDEN'`, por empresa).

## 3. Requisitos funcionais

- RF01 — O SELECT de `fSQLMovimentos` deve retornar exatamente as mesmas linhas e valores (inclusive a coluna `ENDERE`) que a versão atual, para `MOVDET` e `NOTDET`, com `CFG_SPCDEN` ligada ou desligada.
- RF02 — Com `CFG_SPCDEN` ligada, o `EXISTS` de endereçamento deve usar o índice `IDX_EXTGOR_70` (ou plano equivalente sem varredura completa da EXTGOR).
- RF03 — A validação de configurações deve impedir salvar `CFG_SPCDEN = 'S'` quando a trigger `BI_EXTGOR_DOCEND` ou a `BU_EXTGOR_DOCEND` não existir na tabela `EXTGOR` do schema atual, exibindo mensagem de atenção que informe as triggers ausentes ou oriente a contatar a Citel (mesmo padrão da `CFG_DASWEB`).
- RF05 — Ao selecionar `CFG_SPCDEN` na tela de configurações, o painel de informação deve exibir (em vermelho, como os demais hints) que a configuração: (a) depende das triggers `BI_EXTGOR_DOCEND` e `BU_EXTGOR_DOCEND` na `EXTGOR`; (b) exige rodar um UPDATE para alimentar os campos `FGO_DCENUM`, `FGO_DCEESP`, `FGO_DCESER`, `FGO_DCEEMP`, `FGO_DCEFOR` e `FGO_DCETFC` dos documentos já existentes (linhas de `EXTGOR` com `FGO_DOCEND` preenchido).
- RF04 — A nova validação (`fValidaSPCDEN`) deve ser incluída na cadeia de validações de `untCfgSistemaValidar.pas`, logo após `fValidaDASWEB`, interrompendo o fluxo (`Exit`) quando retornar `False`.

## 4. Regras de negócio

- RN01 — `ENDERE = 'S'` quando existe `EXTGOR` + `FATDOR` com `FDO_CODITE` do item, `FGO_DOCEND` não vazio e documento correspondente ao movimento (ramo `SPCDEN`: 6 colunas `FGO_DCE*`; ramo sem `SPCDEN`: `FGO_DOCEND = CONCAT(...)`). Regra inalterada.
- RN02 — O predicado `FGO_DCENUM IS NOT NULL` é logicamente redundante com `FGO_DCENUM = DET_NUMDOC` (a igualdade já descarta NULL); serve apenas para orientar o otimizador. Não pode alterar o resultado.
- RN04 — `fValidaSPCDEN` lê o valor com `fFindCfg('CFG_SPCDEN')` (valor `'N'` quando a configuração não é encontrada). Se for `'N'`, retorna `True` sem consultar o banco. Se for `'S'`, exige as duas triggers; qualquer uma ausente → mensagem + `False`.
- RN05 — A existência da trigger é verificada em `INFORMATION_SCHEMA.TRIGGERS` com `TRIGGER_SCHEMA = DATABASE()`, `TRIGGER_NAME = :TRIGGER` e `EVENT_OBJECT_TABLE = :TABELA`, sempre por `ParamByName()`. Erro na consulta é tratado com `pMensagensErro` (como em `fValidaDASWEB`) e a trigger é considerada ausente.
- RN06 — O hint segue o padrão de `pAdicionarHintCFG_LIBEQP`: sai sem fazer nada se `SIS_CODCFG <> 'CFG_SPCDEN'`; caso contrário `mmoInfoCfgSis.Clear`, `pnlInfoCfgSis.Height` ajustada ao número de linhas, `Visible := True`, `Font.Color := clRed`, `Font.Height := 16` e uma `Lines.Add` por linha de texto. Sugestão de texto (a revisar): "Esta configuração depende das triggers BI_EXTGOR_DOCEND e BU_EXTGOR_DOCEND, que preenchem os campos FGO_DCENUM, FGO_DCEESP, FGO_DCESER, FGO_DCEEMP, FGO_DCEFOR e FGO_DCETFC da EXTGOR a partir do FGO_DOCEND." / "Antes de ativar, é preciso rodar um UPDATE para alimentar esses campos nos documentos já existentes." / "Entre em contato com a Citel para disponibilizar as triggers e o script de atualização."
- RN03 — Com `CFG_SPCDEN` ligada, a ordem de junção não pode ser forçada (`STRAIGHT_JOIN`): o INNER JOIN devolve as mesmas linhas em qualquer ordem e a dica produziu plano ruim. Com `CFG_SPCDEN` desligada o `STRAIGHT_JOIN` é mantido como está hoje (plano equivalente ao sem a dica nas medições, ~309 ms contra ~298 ms), para não alterar o comportamento desse ramo.

## 5. Requisitos técnicos / não-funcionais

- Performance: consulta com `SPCDEN` ligada deve ficar na ordem de centenas de milissegundos (referência: ~0,3–0,4 s no item 37596, empresa 004).
- Encoding: a unit está em Windows-1252; edição somente via Python com encoding explícito, sem a ferramenta `Edit`.
- Sem alteração de assinatura de método, parâmetros (`:DTABAL`, `:CODEMP`, `:CODITE`), colunas retornadas ou comportamento de `pSetaMovDet`.
- Sem alteração de índices, estatísticas (`ANALYZE TABLE`) ou DDL no banco.
- Sem impacto fiscal/financeiro direto; o resultado da consulta é idêntico.

## 6. Critérios de aceitação

- [ ] `fRetSQLDocEnd` (ramo `SPCDEN`) inclui `AND FGO_DCENUM IS NOT NULL` antes de `FGO_DCENUM = <tabela>.DET_NUMDOC`.
- [ ] `fSQLMovimentos` usa `SELECT 1` (sem `STRAIGHT_JOIN`) no `EXISTS` apenas quando `fCfgSis('SPCDEN', varBoolean)` é verdadeiro; com `SPCDEN` desligada o texto continua `SELECT STRAIGHT_JOIN 1`.
- [ ] EXPLAIN do SELECT final (MOVDET) com `SPCDEN` ligada mostra `key=IDX_EXTGOR_70` ou plano que não varre EXTGOR inteira; com `SPCDEN` desligada o plano não piora.
- [ ] Tempo medido com `SPCDEN` ligada no item 37596 / empresa 004 na ordem de centenas de ms.
- [ ] Resultado (linhas e `ENDERE`) idêntico ao da versão original, comparado por SELECT em MOVDET e NOTDET, nos dois ramos de `SPCDEN`.
- [ ] Com `CFG_SPCDEN = 'S'` e uma das triggers (ou ambas) ausente, o salvamento das configurações é bloqueado com mensagem de atenção.
- [ ] Com `CFG_SPCDEN = 'S'` e as duas triggers presentes, a validação passa.
- [ ] Com `CFG_SPCDEN = 'N'` (ou configuração inexistente), a validação passa sem consultar triggers.
- [ ] `fValidaSPCDEN` é chamada na cadeia de validações, após `fValidaDASWEB`.
- [ ] Ao selecionar `CFG_SPCDEN` na tela de configurações, o painel mostra o hint com as triggers e o UPDATE; ao selecionar outra configuração, o hint de `SPCDEN` não aparece.
- [ ] `pAdicionarHintCFG_SPCDEN` está declarada na classe e chamada junto dos demais hints; o diff de `untCfgSistema.pas` contém só a declaração, a implementação e a chamada.
- [ ] Diff de `untCadLote.pas` contém somente as alterações de SQL da rotina; diff de `untCfgSistemaValidar.pas` contém só a declaração, a implementação de `fValidaSPCDEN` e a chamada na cadeia. Ambos decodificam em cp1252 sem `\xef\xbf\xbd`.

## 7. Fora de escopo

- Criar/alterar índices, rodar `ANALYZE TABLE` ou qualquer escrita/DDL no banco.
- Alterar `fSQLPedidos` ou outras consultas da unit.
- Escrever ou executar o UPDATE que alimenta os campos `FGO_DCE*` dos documentos existentes — o hint apenas informa que ele é necessário.
- Criar ou instalar as triggers `BI_EXTGOR_DOCEND` / `BU_EXTGOR_DOCEND` (script de banco) — a validação apenas verifica a existência.
- Refatorar `fValidaDASWEB` ou extrair/compartilhar `fTriggerExiste`: a função de verificação será duplicada como função local em `fValidaSPCDEN`, sem tocar em `fValidaDASWEB`.
- Verificar o conteúdo/corpo das triggers (só a existência por nome e tabela).
- Propagar a correção para as demais cópias do fonte (74.111, 74.150, 74.150.100 etc.) — passo à parte, via `citel-applyPatch`.

## 8. Dependências e riscos

- Depende da trigger que preenche `FGO_DCENUM` junto com `FGO_DOCEND`. Se esse vínculo mudar, o resultado continua correto (a igualdade já exige valor), mas o ganho do `IS NOT NULL` cairia; a remoção do `STRAIGHT_JOIN` (apenas com `SPCDEN` ligada) mantém o plano seguro.
- Com `SPCDEN` desligada o `STRAIGHT_JOIN` permanece; o plano é bom hoje (índice `IDX_EXTGOR_16`), mas continua dependente de a ordem forçada ser favorável.
- Medições foram pontuais (uma execução, item com poucos movimentos); itens com muitos movimentos sem lote tendem a mostrar diferença maior.
- A mesma rotina existe em outras cópias do fonte, que continuam com o problema até propagação.
- Bases em que `CFG_SPCDEN = 'S'` mas as triggers não existem (caso da base AUTCOM consultada, empresas 001 e 004) passam a ter o salvamento de configurações bloqueado por esta validação, como já ocorre com `CFG_DASWEB`. Confirmar com a Citel/DBA que as triggers existem nas bases de produção antes de liberar a versão.
- Nomes das triggers e tabela (`EXTGOR`) não foram encontrados nos fontes; confirmar antes de implementar.
- A lista de campos do hint (`FGO_DCENUM`, `FGO_DCEESP`, `FGO_DCESER`, `FGO_DCEEMP`, `FGO_DCEFOR`, `FGO_DCETFC`) foi assumida a partir das 6 colunas do ramo `SPCDEN` de `fRetSQLDocEnd` e do índice `IDX_EXTGOR_70`; confirmar que são exatamente os campos preenchidos pelas triggers e pelo UPDATE.

## 9. Propagação para outras cópias (levantamento)

Verificação da presença da configuração `SPCDEN` (`CFG_SPCDEN` em `untCfgRepositorio.pas` e `fCfgSis('SPCDEN', ...)` em `untCadLote.pas`):

| Cópia | Tem SPCDEN | `if SPCDEN` na untCadLote | `STRAIGHT_JOIN` no EXISTS |
|-------|-----------|---------------------------|---------------------------|
| 379.48.2.30.72 | **Não** (nenhuma ocorrência nos fontes) | Não | Não (`fRetSQLDocEnd` existe, sem ramo SPCDEN) |
| 379.48.2.30.74.111 | Sim | Sim (linha ~4384) | Não — consulta diferente (subselect `FGO_DOCEND` com `LIMIT 1`, sem EXISTS) |
| 379.48.2.30.74.150 | Sim | Sim (linha ~5208) | Sim (linha ~5238) |
| 379.48.2.30.74.150.100 | Sim | Sim (linha ~5139) | Sim (linha ~5169) |

- RF06 — Nas cópias que têm `SPCDEN` (74.111, 74.150, 74.150.100), incluir a validação `fValidaSPCDEN` (RF04) e o hint `pAdicionarHintCFG_SPCDEN` (RF05), iguais aos da 74.150.45.
- RF07 — Na `untCadLote.pas`, deixar `fRetSQLDocEnd` e o `EXISTS` iguais à 74.150.45 (`AND FGO_DCENUM IS NOT NULL` + `STRAIGHT_JOIN` só com SPCDEN desligada) onde houver o mesmo trecho (74.150 e 74.150.100). Todas as cópias com SPCDEN já possuem o `if` da SPCDEN, então nenhum `if` novo é necessário.
- A 74.111 tem o ramo SPCDEN, mas o SQL é outro (sem EXISTS/STRAIGHT_JOIN): o `IS NOT NULL` é aplicável no ramo SPCDEN; o item do `STRAIGHT_JOIN` não se aplica. Medir/EXPLAIN antes de alterar.
- A 72 não tem a configuração: fica fora (validação e hint dependem de `CFG_SPCDEN`). Criar a configuração nela é outro escopo.
