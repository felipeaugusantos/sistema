# Análise — Req. 465598 — Performance do SELECT de movimentos sem lote com SPCDEN e validação de triggers

## 1. Contexto de negócio

No **Cadastro de Lote** (`untCadLote.pas`, `TCadLot.pSetaMovDet`), ao cadastrar um lote o sistema lista os movimentos do item que
ainda não têm lote (`IFNULL(DET_NUMLOT, "") = ""`) em `MOVDET` e `NOTDET`, posteriores à data de balanço. Para cada movimento,
a coluna calculada `ENDERE` indica se o documento gerou **endereçamento** (existe `EXTGOR` + `FATDOR` com o item e
`FGO_DOCEND` preenchido). Essa consulta é montada por `TCadLot.fSQLMovimentos(strTabela)`, com a função local `fRetSQLDocEnd`
fornecendo o vínculo entre o movimento e o documento de endereçamento.

A configuração **`CFG_SPCDEN`** ("Utilizar campos próprios para vincular os Pedidos de Reserva de Endereçamento com os Documentos
de que gerou endereçamento?") muda esse vínculo:

| `CFG_SPCDEN` | Vínculo movimento → `EXTGOR` |
|---|---|
| `N` | `FGO_DOCEND = CONCAT(número, espécie, série(3), empresa, fornecedor/cliente, "F" ou "C")` (índice `IDX_EXTGOR_16`) |
| `S` | 6 colunas próprias: `FGO_DCENUM`, `FGO_DCEESP`, `FGO_DCESER`, `FGO_DCEEMP`, `FGO_DCEFOR`, `FGO_DCETFC` (índice `IDX_EXTGOR_70`) |

As colunas `FGO_DCE*` são preenchidas por **triggers** da `EXTGOR` junto com `FGO_DOCEND`: `BI_EXTGOR_DOCEND` (INSERT) e
`BU_EXTGOR_DOCEND` (UPDATE). Documentos anteriores às triggers precisam de um UPDATE para alimentar esses campos.

## 2. Problema e causa raiz

**Lentidão com `SPCDEN = 'S'`** (empresa 004, item 37596, base AUTCOM): o `EXISTS` de `ENDERE` usava `SELECT STRAIGHT_JOIN 1`, que
força a ordem `EXTGOR → FATDOR`. O MySQL 5.7 não usava o `IDX_EXTGOR_70` e fazia `type=ALL` (~1,75 milhão de linhas) **a cada linha**
de MOVDET/NOTDET: ~5,6–5,9 s.

Causa de o índice ser ignorado (EXPLAIN, `SHOW INDEX`, contagem, tudo somente leitura):
- `IDX_EXTGOR_70` tem cardinalidade 1 em todas as colunas;
- só 22 de 1.781.519 linhas da `EXTGOR` têm `FGO_DCENUM` preenchido (NULL é o estado normal da tabela);
- sem informação de que o índice é esparso, o otimizador estima ~1,75 milhão de linhas e prefere varredura.

**Ausência de proteção ao ativar a configuração:** nada impedia ligar `CFG_SPCDEN` sem as triggers. Nesse caso as colunas `FGO_DCE*`
nunca são preenchidas e `ENDERE` retornaria sempre `'N'`. Na própria AUTCOM consultada não havia trigger em `EXTGOR` apesar de
`CFG_SPCDEN = 'S'` nas empresas 001 e 004.

## 3. Medições (AUTCOM, empresa 004, item 37596, `:DTABAL` 2026-09-23, 1 execução cada)

| Variante | Tempo |
|---|---|
| Original (`STRAIGHT_JOIN`, sem `IS NOT NULL`) | ~5.600–5.900 ms |
| Sem `STRAIGHT_JOIN` | ~323 ms |
| Com `AND FGO_DCENUM IS NOT NULL` (mantendo `STRAIGHT_JOIN`) | ~416 ms |
| `SPCDEN = 'N'`, com ou sem `STRAIGHT_JOIN` | ~300 ms (sem diferença relevante) |

## 4. Solução aplicada

1. **`untCadLote.pas` / `fRetSQLDocEnd`** (ramo `SPCDEN`): incluído `AND FGO_DCENUM IS NOT NULL` antes de
   `FGO_DCENUM = <tabela>.DET_NUMDOC`. O predicado é logicamente redundante com a igualdade (que já descarta NULL); serve só para
   sinalizar ao otimizador que o índice é seletivo.
2. **`untCadLote.pas` / `fSQLMovimentos`**: o `EXISTS` passa a ser `SELECT 1` quando `fCfgSis('SPCDEN', varBoolean)` é verdadeiro, e
   continua `SELECT STRAIGHT_JOIN 1` quando desligada. O INNER JOIN devolve as mesmas linhas em qualquer ordem; liberar a ordem permite
   iniciar pela `FATDOR` (índice por item) e entrar na `EXTGOR` pela chave primária. Com `SPCDEN = 'N'` o plano já era bom
   (`IDX_EXTGOR_16`), por isso o `STRAIGHT_JOIN` foi mantido ali para não alterar o comportamento desse ramo.
3. **`untCfgSistemaValidar.pas`**: nova `TValidarConfiguracoes.fValidaSPCDEN`, modelada em `fValidaDASWEB`, com `fTriggerExiste`
   duplicada como função local (consulta `INFORMATION_SCHEMA.TRIGGERS` por `TRIGGER_SCHEMA = DATABASE()`, `TRIGGER_NAME` e
   `EVENT_OBJECT_TABLE`, via `ParamByName`, `try/except` com `pMensagensErro`). Se `CFG_SPCDEN = 'S'` e faltar `BI_EXTGOR_DOCEND` ou
   `BU_EXTGOR_DOCEND` em `EXTGOR`, exibe `ATENÇÃO!` orientando contato com a Citel e retorna `False`, bloqueando o salvamento.
   Chamada na cadeia logo após `fValidaDASWEB`. Com `'N'` (ou configuração inexistente) retorna `True` sem consultar o banco.
4. **`untCfgSistema.pas`**: nova `TfrmCfgSistema.pAdicionarHintCFG_SPCDEN` (modelo `pAdicionarHintCFG_LIBEQP`/`LIBAJU`), com painel de
   informação em vermelho (altura 80, 4 linhas) informando a dependência das triggers, os campos `FGO_DCE*` e a necessidade do UPDATE
   dos documentos existentes. Declarada na classe e chamada após `pAdicionarHintCFG_LIBAJU`.

## 5. Abordagens consideradas e descartadas

- **Remover `STRAIGHT_JOIN` também com `SPCDEN = 'N'`:** descartado por escopo; o plano já é equivalente (~309 ms contra ~298 ms) e
  o ramo não apresentava problema.
- **Só `IS NOT NULL` mantendo `STRAIGHT_JOIN`:** melhora (~416 ms) mas ainda depende da ordem forçada; a remoção do `STRAIGHT_JOIN`
  com `SPCDEN` ligada foi mantida por dar o melhor tempo e um plano mais robusto.
- **`ANALYZE TABLE`/novo índice:** fora de escopo (nenhuma escrita/DDL no banco).
- **Extrair `fTriggerExiste` para compartilhar com `fValidaDASWEB`:** descartado por escopo; a função foi duplicada como local para
  não tocar em `fValidaDASWEB`. Pode ser extraída depois.

## 6. Validação

Base de teste `2_30_74_COM` (somente leitura):
- Triggers `BI_EXTGOR_DOCEND` e `BU_EXTGOR_DOCEND` existem em `EXTGOR` (confirma nomes e tabela).
- Resultado (linhas e `ENDERE`) **idêntico** entre original e novo em MOVDET, nos dois ramos, em empresas 123, 003, 013, 501 e 008 (itens
  com `ENDERE = 'S'`: 17, 6, 6 e 3 linhas). NOTDET retornou 0 linhas em todos os itens testados, portanto sem evidência real ali.
- EXPLAIN do SELECT novo com `SPCDEN` ligada: `FATDOR` (`IDX_FATDOR_36`) → `EXTGOR` por `eq_ref` na PK; sem varredura da `EXTGOR`.
- Base pequena (72 mil linhas em `EXTGOR`): não reproduz o ganho; o tempo de referência continua sendo o da AUTCOM (seção 3).

Validação funcional pelo usuário (tela de configurações): hint exibido completo; `S` sem triggers bloqueia; `S` com só uma trigger
bloqueia; `S` com as duas passa; `N` passa.

## 7. Propagação

Aplicado em 74.150.45 (origem), 74.150, 74.150.100 e 74.111 (a cópia 72 não possui `SPCDEN`).
- 74.150 e 74.150.100: as mesmas quatro alterações.
- 74.111: o SELECT de `fSQLMovimentos` usa subquery escalar com `LIMIT 1` (sem `EXISTS`/`STRAIGHT_JOIN`); recebeu só o `IS NOT NULL`
  (plano idêntico na base de teste, resultado igual, tempo menor). `untCfgSistema.pas` dessa cópia é UTF-8 com BOM (as demais, latin-1),
  e não tem `pAdicionarHintCFG_LIBEQP` (usado `LIBAJU` como modelo).

## 8. Achados colaterais e riscos

- Bases com `CFG_SPCDEN = 'S'` sem as triggers (caso da AUTCOM consultada, empresas 001 e 004) passam a ter o salvamento das
  configurações **bloqueado**, como já ocorre com `CFG_DASWEB`. Confirmar com a Citel/DBA a existência das triggers em produção antes
  de liberar a versão.
- Os 4 nomes de campos do hint (`FGO_DCE*`) foram derivados das 6 colunas do ramo `SPCDEN` e confirmados pelo solicitante.
- Medição de tempo em item com muitos movimentos sem lote não foi feita (base de teste pequena).
- `fSQLPedidos` e demais consultas da unit não foram alteradas.
- O UPDATE que alimenta `FGO_DCE*` nos documentos existentes não faz parte desta entrega (o hint apenas avisa).

## 9. Lições de ferramenta/processo

- `untCfgSistema.pas` da 74.150.45 contém o byte `0x81`, inválido em cp1252 do Python; ler/gravar com `latin-1` preserva os bytes.
- `untCadLote.pas` das cópias 74.150 e 74.150.100 já possuem 3 LF soltos de origem; não foram alterados.
- Antes de editar, conferir o encoding por arquivo: a 74.111 mistura latin-1 e UTF-8 com BOM entre units.
- Edição sempre via Python, nunca com a ferramenta `Edit`.
