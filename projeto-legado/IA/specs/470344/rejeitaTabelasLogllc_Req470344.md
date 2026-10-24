# Análise — Req. 470344: Alteração de Número de Lote, erro `Unknown column 'LGL_CODEMP'` em `LOGLLC_ARQUIV`

**Solicitante:** Júlio (TI), cliente TOGO HOMECENTER — ticket Zendesk 1711996
**Menu:** Útil > Operações referentes a Produtos > Alteração de Número de Lote
**Mesmo problema do:** Req. 463357
**Origem da correção:** backport da r434316 (Req. 398922), da working copy 74.150.45
**Working copies com a alteração:** 74.111 e 74.111.191
**Data:** 16/10/2026

## 1. Contexto de negócio
A tela `TfrmAltNumLote` troca o número de um lote (item + lote atual → lote novo) em todas as tabelas do banco que possuem
campo de lote. Ela não tem lista fixa de tabelas: descobre dinamicamente, no banco, toda tabela que possua um campo cujo nome
termine em `NUMLOT` (`pRetornaTables` lista as tabelas e `pRetornaFields` filtra pelo campo). Para cada uma, `fGravaAltNumLote`
monta um `UPDATE` com filtro por empresa, item e lote atual.

Exceções à regra geral ficam cadastradas na tabela `CONFIG_ALTNUMLOT`, para tratar tabelas que fogem do padrão sem recompilar:

| Coluna | Efeito |
|--------|--------|
| `TABELA_REGRA` | Nome (ou máscara, no caso de `REJEITA_TABELA`) da tabela a que a regra se aplica |
| `IGNORA_TABELA = 1` | Tabela é descartada em `pRetornaFields` (comparação por nome exato, via `Locate`) |
| `SEM_CADEMP = 1` | Tabela não tem `xxxxCODEMP`; usa o `AJUSTE_SQL` (join) para filtrar por empresa |
| `SEM_CODITE = 1` | Tabela não tem `xxxxCODITE`; usa o `AJUSTE_SQL` (join) para filtrar por item |
| `AJUSTE_SQL` | Trecho de join usado nas exceções acima |
| `REJEITA_TABELA = 1` | Tabela (aceita máscara com `*` e `?`) nem entra na lista de tabelas, em `pRetornaTables` |

## 2. Problema e causa raiz
Ao confirmar a alteração (empresa 003, item 11546, lote `LC-11546` → `LC-11546+`), o sistema exibia
`LOGLLC_ARQUIV #42S22Unknown column 'LGL_CODEMP' in 'where clause'`, a transação sofria rollback e nada era alterado.

`LOGLLC_ARQUIV` (e demais `LOGLLC_*`, tabelas de log) possui o campo `LGL_NUMLOT`, então é incluída na lista. Como não está
em nenhuma exceção, `fGravaAltNumLote` monta o `UPDATE` com `AND LGL_CODEMP = :CODEMP`, campo que a tabela não tem.
Tabelas de log não fazem parte da movimentação de lote e não devem ser alteradas.

## 3. Investigação
- Leitura de `fGravaAltNumLote`: o filtro `<ABREV>CODEMP` é montado para qualquer tabela fora das exceções
  (`blnSemCodEmp = False`), o que explica o erro de coluna inexistente.
- A unit já usava `CONFIG_ALTNUMLOT` com `IGNORA_TABELA`, `SEM_CADEMP` e `SEM_CODITE`. Nenhuma delas resolve o caso de forma
  prática: `IGNORA_TABELA` exige nome exato (uma linha por tabela `LOGLLC_*`), e `SEM_CADEMP` exigiria `AJUSTE_SQL`.
- A r434316 (Req. 398922), já feita na 74.150.45, trata exatamente esse cenário com a coluna `REJEITA_TABELA` e máscara.
- Busca no projeto: não há script de criação da coluna `REJEITA_TABELA`; o solicitante informou que **não precisa de script**.
- A configuração do cliente é uma linha de dado em `CONFIG_ALTNUMLOT`, fornecida pelo solicitante (seção 5).

## 4. Solução aplicada
Arquivo: `padra_atualizado/fontes/util/operacoesrefitens/untAltNumLote.pas`

1. `uses` da **implementação** (junto de `StrUtils`): adicionado `System.Masks` (para `MatchesMask`). O `uses` da interface não foi alterado,
   pois a unit só é usada em `pRetornaTables`.
2. `TfrmAltNumLote.pRetornaTables` reescrita:
   - `qryTables`, `qryConfig` e `lstRegras` iniciam em `nil` e são criadas dentro do `try`, de modo que o `finally` libere apenas o que
     chegou a ser criado (sem vazamento se a segunda criação falhar);
   - carrega, em uma única consulta, as regras de `CONFIG_ALTNUMLOT` com `REJEITA_TABELA = 1` (`TABELA_REGRA`) em uma `TStringList`;
   - percorre o resultado de `SHOW FULL TABLES WHERE Table_Type = "BASE TABLE"` e, para cada tabela, testa as regras com `MatchesMask`;
   - só inclui a tabela em `cdsTables` se nenhuma regra casar e se ela não for `TMP_*` nem `LOGDOR` (exclusões fixas anteriores, mantidas);
   - usa `DisableControls`/`EnableControls` em `cdsTables` e libera as queries e a lista em `finally`;
   - deixa de chamar `Application.ProcessMessages` dentro do laço.
3. `TfrmAltNumLote.pRetornaFields`: adicionado `qryFields := nil;` logo após o `begin`. Correção de risco pré-existente (apontada em
   revisão): sem a inicialização, se `fCriaQuery` lançasse exceção, o `FreeAndNil(qryFields)` do `finally` receberia ponteiro local com
   lixo e geraria Access Violation, escondendo o erro original. Não altera o comportamento no caminho normal.
4. Como `pRetornaFields` só percorre `cdsTables`, as tabelas rejeitadas nunca chegam a `cdsFields` e `fGravaAltNumLote` não monta `UPDATE` para elas.

Não alterados: `fGravaAltNumLote`, `fLocalteIgnoraTabela`, `fLocalteTabelaSemCodEmp`, `fLocalteTabelaSemCodIte`,
`libOpeRefProd.dpr`, `untOpeProd.pas`.

## 5. Configuração necessária no cliente (dado, não script de código)
```sql
INSERT INTO CONFIG_ALTNUMLOT (SEM_CADEMP, TABELA_REGRA, IGNORA_TABELA, AJUSTE_SQL, SEM_CODITE, REJEITA_TABELA)
VALUES ('0','LOGLLC_*','0',NULL,'0','1');
```
Com essa linha, todas as tabelas `LOGLLC_*` deixam de ser listadas. Sem ela o erro continua no ambiente do cliente.

## 6. Decisões de escopo e de encoding
- Foi trazida **somente** a mudança funcional da r434316. A revisão original também converteu `untAltNumLote.pas` de
  Windows-1252 para UTF-8 com BOM (13 hunks só de acentuação mais o BOM na linha 1). Essa conversão **não** foi trazida:
  o arquivo permanece em cp1252, CRLF, sem BOM, e foi editado por Python (nunca pela ferramenta `Edit`).
- O `uses` da interface da 74.111 é mais antigo que o da 74.150.45 (sem `cxProgressBar` nem `FilenameEditFocus`). Além disso, na
  r434316 `System.Masks` entrou no `uses` da interface; aqui foi colocado no `uses` da implementação (ajuste de revisão), pois só
  `pRetornaTables` o utiliza.
- Ajustes de revisão aplicados depois do backport: `qryFields := nil` em `pRetornaFields` e criação dos objetos de `pRetornaTables`
  dentro do `try` (seção 4). Nenhum deles altera o comportamento funcional.
- Nenhum script de banco foi criado (solicitação do analista).
- `.dpr`/`.dproj` não precisaram de alteração: a unit já pertence a `libOpeRefProd.dpr`.

## 7. Validação
- Teste manual do usuário com o cenário do requisito (empresa 003, item 11546, `LC-11546` → `LC-11546+`): **OK**, sem mensagem
  de erro. O resultado também indica que a coluna `REJEITA_TABELA` existe no banco em que o teste foi feito.
- Arquivo conferido: decodifica em cp1252, sem BOM e sem a sequência `EF BF BD`; `svn diff` na 74.111 mostra apenas as duas
  mudanças (`uses` e `pRetornaTables`).
- Na 74.111.191 o arquivo ficou byte a byte idêntico ao da 74.111.

## 8. Achados colaterais e ressalvas (não corrigidos)
- Se uma base não tiver a coluna `REJEITA_TABELA`, o `SELECT` de `pRetornaTables` falha e a tela quebra ao abrir. O código não
  tem proteção para isso.
- Máscara ampla demais (por exemplo `*`) rejeita todas as tabelas; a configuração é responsabilidade do cadastro.
- `MatchesMask` ignora diferença de maiúsculas/minúsculas.
- A mensagem de erro de `fLocalteTabelaSemCodIte` cita "campo empresa", mas se refere a item (texto copiado de
  `fLocalteTabelaSemCodEmp`); fora do escopo.
- Outras working copies (74.150, 74.150.100 etc.) não foram tratadas neste requisito.

## 9. Notas referenciadas no código-fonte
Nenhuma. Os comentários inseridos em `pRetornaTables` são curtos e autoexplicativos, sem referência a nota.
