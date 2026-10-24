# Análise Técnica — Req. 444393

## 1. Contexto de negócio

A rotina **Alteração de Número de Lote** (`TfrmAltNumLote`, unit `untAltNumLote.pas`, pasta
`padra_atualizado/fontes/util/operacoesrefitens/`) troca o número de um lote de um produto em todas as tabelas
do sistema que guardam esse número (campo terminado em `NUMLOT`). Para cada tabela encontrada, `fGravaAltNumLote`
monta um `UPDATE ... SET <abrev>NUMLOT = :LOTNOV WHERE <abrev>CODEMP = :CODEMP AND <abrev>CODITE = :CODITE
AND <abrev>NUMLOT = :LOTATU`, com tratamentos especiais por tabela (LOTDOR, LOCDOR, DORLOC, PREPTE, DEICOR,
DETPRO, ESPDET e suas versões `DEL_`).

A configuração **CFG_UM1LFL** ("Utilizar mais de uma localização física por lote?", grupo PRODUTOS, padrão `N`,
tabela `CFGSIS`, campos `SIS_CODCFG` / `SIS_CODEMP` / `SIS_VALCFG`) faz o mesmo lote poder estar em várias
localizações físicas. Nesse modo o número do lote também é gravado em `EQLLOC.LOC_NUMLOT`, tabela de localização
física por item de equalização/acelerador.

## 2. Problema

As tabelas de detalhe de equalização (`EQLDET`) e acelerador (`ACLDET`), e suas versões `DEL_`, ficam
vinculadas a `CONEQL` e a `CADEQL`/`CADACL`. Elas não têm `CODEMP`/`CODITE` próprios: esses campos estão em
`EQL_CODEMP`, `EQL_CODITE`, `ACL_CODITE`. O UPDATE genérico não monta essa junção corretamente. Com a configuração
CFG_UM1LFL ligada, o número do lote também precisava ser trocado em `EQLLOC.LOC_NUMLOT`, o que o UPDATE genérico
não faz. O resultado era lote trocado só em parte das tabelas.

## 3. Solução na revisão de origem (74.150, rev. 478075)

Revisão 478075 da working copy `379.48.2.30.74.150`, unit `untAltNumLote.pas`:

- Novas funções privadas `fMontaUpdEQLDET(AMultiLoc, AUsaDel)` e `fMontaUpdACLDET(AMultiLoc, AUsaDel)`, que
  montam o UPDATE com JOIN em `CONEQL`/`CADEQL`/`CADACL`. Com `AMultiLoc = True` acrescentam `LEFT JOIN EQLLOC`
  (`LOC_TIPEQL = 'E'` para equalização, `'A'` para acelerador) e atualizam também `LOC_NUMLOT`.
  `AUsaDel = True` prefixa as tabelas com `DEL_`.
- Em `fGravaAltNumLote`: quatro strings montadas no início (`EQLDET`, `DEL_EQLDET`, `ACLDET`, `DEL_ACLDET`), usando
  `fUsaMaisDeUmaLocalizacaoFisicaPorLote`, e quatro ramos novos no loop de tabelas.

## 4. Por que não deu para aplicar como patch na 30.72 / 30.72.457

O patch não aplicava por contexto, por dois motivos:

1. A função `fUsaMaisDeUmaLocalizacaoFisicaPorLote` **não existe** na 30.72 (na 74.150 está em
   `untFuncoesGenerica`/`untFuncoesSimples`).
2. O `fGravaAltNumLote` da 30.72 tem outra estrutura: `strUpdESPDET` e `strUpdDEL_ESPDET` são `Const`, não `var`,
   e o trecho não tem `blnMultiLoc`. Os hunks ancorados nesse bloco não encontravam contexto.

Também não foi encontrada nenhuma referência a `EQLLOC` em unit `.pas` da 30.72 (`grep` na pasta `fontes`).

## 5. Solução adaptada (30.72 e 30.72.457)

Alteração só em `untAltNumLote.pas`:

- **`fUsaMaisDeUmaLocalizacaoFisicaPorLote`** — método privado de `TfrmAltNumLote`. Consulta
  `SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = 'CFG_UM1LFL' AND SIS_CODEMP = :CODEMP LIMIT 1`, com
  `CODEMP = VS_strCodEmp`. Retorna `True` somente se existir registro e o valor, ignorando espaços e caixa, for
  `S`. Sem registro de configuração, ou em caso de exceção na consulta, retorna `False`. Foi escolhida consulta
  direta à `CFGSIS` (por pedido do solicitante) em vez de `fCfgSis`, que na 74.150 é o mecanismo usado.
- **`fMontaUpdEQLDET` / `fMontaUpdACLDET`** — copiadas da 74.150 sem alteração de lógica.
- **`fGravaAltNumLote`**:
  - novas variáveis `blnMultiLoc` e `strUpdEQLDET`, `strUpdACLDET`, `strUpdDEL_EQLDET`, `strUpdDEL_ACLDET`;
  - as quatro strings são montadas logo após `qryUpd := fCriaQuery(Self)`;
  - quatro ramos novos no loop, acrescentados depois do ramo `ESPDET`, escolhidos pelo nome da tabela
    (`EQLDET`, `DEL_EQLDET`, `ACLDET`, `DEL_ACLDET`);
  - comentário curto no fonte com a referência ao Req. 444393.
- O `IfThen` usado vem de `StrUtils`, que já constava no `uses` da unit.
- Encoding preservado em cp1252 e CRLF. Diff final: 118 linhas acrescentadas e 1 removida (`blnSemCodIte: Boolean;`
  virou `blnSemCodIte,`, para entrar na mesma declaração).

Working copies alteradas: `379.48.2.30.72` e `72.Fechadas/379.48.2.30.72.457`.

## 6. Decisões de escopo

- Não foi portada a função de configuração de `untFuncoesGenerica`/`untFuncoesSimples`: ela é local na unit, como
  pedido, para não espalhar a alteração por units genéricas.
- Não foi criada a tabela `EQLLOC` nem nenhum script de banco: a alteração só a utiliza quando CFG_UM1LFL = S.

## 7. Pontos de atenção

- **`EQLLOC` na base da 30.72:** a tabela precisa existir. Se a configuração estiver `S` e a tabela não existir, o
  UPDATE de `EQLDET`/`ACLDET` falha, e a troca de lote é desfeita pelo rollback do `fGravaAltNumLote`.
- **Colunas de `ACLDET`:** o UPDATE usa `EQD_SEQCON`, `EQD_SEQACL` e `EQD_NUMLOT` na tabela `ACLDET`, como na
  origem. Os nomes de coluna não foram conferidos contra o schema.
- Não houve compilação no Delphi nem teste em banco nesta sessão.
- `fUsaMaisDeUmaLocalizacaoFisicaPorLoteComTintaDeMaquinaESeparacaoSemWMS` (também na origem) não faz parte desta
  alteração.

## 8. Notas referenciadas no código-fonte

Nenhuma. O comentário no fonte é autoexplicativo e cita apenas o requisito.
