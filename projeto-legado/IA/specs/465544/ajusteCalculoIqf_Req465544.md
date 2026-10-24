# Req. 465544 — Cálculo do IQF sem configuração em CADIQF e ajuste da tela de configuração

**Data:** 2026-10-09
**Zona:** Legado (`padra_atualizado/fontes/`)
**Working copies alteradas:** `379.48.2.30.74.150.100` e `379.48.2.30.74.150`
**Artefatos de levantamento:** `spec.md`, `plan.md`, `tasks.md` (mesma pasta)

## 1. Contexto de negócio

O IQF (Índice de Qualidade do Fornecedor) é calculado na confirmação da entrada de mercadorias
(`fConfirmaEntradaMercadorias`, `untPcmGer`) quando a configuração `IQFATI` está ligada
(`fCfgSis('IQFATI', varBoolean)`). O cálculo está em `TIndiceQualidadeFornecedor`
(`untIndiceQualidadeFornecedor.pas`) e usa três indicadores por fornecedor, extraídos de pedidos e notas:

| Indicador | Função | Significado |
|---|---|---|
| TMPENT | `fSQLTMPENT` | % de itens entregues no prazo (pedido x nota, `PCMDET` / `MOVDET`) |
| DISEST | `fSQLDISEST` | % de itens entregues em quantidade >= pedida (`DETPON`) |
| PRECOS | `fSQLPRECOS` | % de itens sem variação de preço acima da tolerância (`DETPON`) |

Os parâmetros ficam por empresa em `CADIQF` (chave `IQF_CODEMP`): pesos (`IQF_QUAPRO`, `IQF_TMPENT`,
`IQF_DISEST`, `IQF_PRECOS`), janela do filtro (`IQF_QTDMES` meses ou `IQF_QTDCMP` últimas compras),
tolerância de preço (`IQF_TOLPRE`), limite de score (`IQF_LIMVAL`) e tipo de filtro (`IQF_TIPFLT`:
`M` = últimos meses, `C` = últimas compras). Todas as colunas numéricas são `int` (`IQF_TOLPRE` é
`decimal(13,2)`), `IQF_TIPFLT` é `char(1)`.

A tela `TfrmCfgIndDesempenhoForn` (`untCfgIndDesempenhoForn.pas`) grava `IQFATI` em `CFGSIS`
(`fAtuCfgSis`) e o registro da empresa em `CADIQF`.

## 2. Problema e causa raiz

Empresa 001 (SAMEACH) com `IQFATI` = `S` e **sem registro em `CADIQF`** (confirmado no banco:
`SELECT COUNT(*) FROM CADIQF` = 0). Ao confirmar a entrada de mercadorias o cálculo do IQF falhava.
A investigação mostrou uma cadeia de erros, cada um escondendo o seguinte:

1. `EVariantTypeCastError` (OleStr -> Double) em `fSQLCalculaQualidadeFornecedor`:
   `fGetCfgIQF` devolvia o inteiro `0` quando `CADIQF` vinha vazia, e o código comparava esse Variant
   numérico com `'M'` (`fGetCfgIQF('IQF_TIPFLT') = 'M'`).
2. `EVariantTypeCastError` (UnicodeString -> Double) em `fSQLTMPENT` (`VarAdd`): a concatenação
   `'LIMIT ' + fGetCfgIQF('IQF_QTDCMP')` soma string com Variant numérico (o Delphi tenta converter a
   string para `Double`). O mesmo padrão existe em `fSQLDISEST` e `fSQLPRECOS`. Como as colunas de
   `CADIQF` são `int`, o problema também ocorreria com a configuração preenchida no filtro por
   últimas compras (`IQF_TIPFLT` diferente de `M`).
3. A exceção não chegava ao `Except` de `fConfirmaEntradaMercadorias`: o cálculo roda dentro de
   `TfrmGravando.fExecuta` -> `ShowModal` -> `FormActivate`. A exceção do `FormActivate` (disparado por
   mensagem do Windows via `SendMessage`) é consumida por `TWinControl.MainWndProc`, que chama
   `Application.HandleException`; nunca volta ao `ShowModal`. `fExecuta` só devolve
   `Result := blnConfirma` (`False`) e `pCalculaQualidadeFornecedorLocal` ignorava o retorno.
4. `EUniError #42000 This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery'`:
   o filtro por últimas compras usa `DET_SEQPED IN (SELECT ... ORDER BY ... LIMIT n)`. O servidor
   não aceita `LIMIT` direto em subquery de `IN`.
5. `EUniError #42S22 Unknown column 'DET_SEQPED' in 'IN/ALL/ANY subquery'`: em `fSQLTMPENT` a consulta
   externa lê `PCMDET`, `PCMGER` e `MOVDET`; `DET_SEQPED` só existe em `DETPON` (que está dentro da
   subquery). Confirmado no banco: `DETPON.DET_SEQPED` tem FK `FK_DETPON_05` para `PCMDET.AUTOINCREM`
   (e `untPreNota.pas:5914` grava `DET_SEQPED` com o `AUTOINCREM` do item do pedido).
6. Com `CADIQF` vazia, `IQF_QTDCMP` = 0 resultaria em `LIMIT 0` (nenhuma linha, indicadores
   zerados/nulos). Decidido usar `1` como padrão para esse campo.

Na tela de configuração, mesmo com "Utiliza índice" = "Não" (`rdgUtiInd`), as validações dos demais
campos eram executadas e `pSalvaDados` tentava `INSERT` em `CADIQF` com campos vazios (e
`LTipoFiltro` sem valor).

## 3. Solução aplicada

### 3.1 `untIndiceQualidadeFornecedor.pas`

- `uses`: incluída a unit `Variants` (necessária para `VarToStr`).
- `fGetCfgIQF`: sem registro **ou** campo nulo, retorna string padrão: `'1'` para `IQF_QTDCMP`,
  `'0'` para os demais (`IfThen(ACampo = 'IQF_QTDCMP', '1', '0')`). Com valor, devolve o valor do campo; `IQF_QTDCMP` gravado como `0`
  ou negativo também devolve `'1'` (`LIMIT 0` zeraria o IQF e classificaria o fornecedor como `D`, podendo acionar a trava de liberação).
- `fSQLCalculaQualidadeFornecedor`: `VarToStr(fGetCfgIQF('IQF_TIPFLT')) = 'M'`. Sem configuração,
  `'0'` não é `'M'` e o filtro fica "por últimas compras".
- `fSQLTMPENT`, `fSQLDISEST`, `fSQLPRECOS`: concatenação do limite via
  `VarToStr(fGetCfgIQF('IQF_QTDCMP'))`, e o `LIMIT` encapsulado em tabela derivada:

```sql
AND <coluna> IN (
  SELECT DET_SEQPED FROM (
    SELECT DET_SEQPED FROM DETPON WHERE DET_CODFOR = :CODFOR
    ORDER BY DET_DTAENT DESC LIMIT n
  ) ITQF
)
```

  Em `fSQLTMPENT` o lado esquerdo do `IN` passou de `DET_SEQPED` para `PCMDET.AUTOINCREM`; em
  `fSQLDISEST`/`fSQLPRECOS` continua `DET_SEQPED` (a consulta externa já é `DETPON`).
- `TDadosIQF`: novo campo `strErro: String`.
- `fCalculaQualidadeFornecedorPrg`: corpo envolvido em `Try/Except`; a exceção é guardada em `recDadosIQF.strErro` e a função
  retorna `False`. Assim o `FormActivate` termina sem exceção e o form fecha normalmente (`WM_CLOSE`).
- `pCalculaQualidadeFornecedorLocal`: zera `strErro`, chama `TfrmGravando.fExecuta` e, se retornar `False`,
  `Raise Exception.Create('Nao foi possivel calcular o IQF do fornecedor ' + strCodFor + '. ' + recDadosIQF.strErro)`.
  A exceção sobe por `pCalculaQualidadeFornecedor` (que libera `objPreNota` em `Try/Finally`, para não vazar o objeto na falha) e `pUpdateQualidadeFornecedor` (rollback e relança com prefixo) até o
  `Except` de `fConfirmaEntradaMercadorias`, agora com a mensagem original.

### 3.2 `untGravando.pas`

Não alterada. Uma alteração anterior (`Self.Hide` no `Finally` do `FormActivate`) foi revertida por ser unit genérica,
usada em muitas rotinas, com efeito colateral difícil de mensurar.

### 3.3 `untCfgIndDesempenhoForn.pas`

- `btnConfirmaClick`: se `rdgUtiInd.ItemIndex <> 0` ("Não"), chama `pSalvaDados`, define
  `ModalResult := mrOK` e sai, sem as validações (filtro, tolerância, valor mínimo, soma dos pesos).
- `pSalvaDados`: `fAtuCfgSis('IQFATI', ...)` primeiro; `DELETE` e `INSERT` em `CADIQF` somente quando
  `strValCfg = 'S'` (blocos reindentados dentro do `If`). Com "Não" o registro existente em `CADIQF`
  é preservado.

### 3.4 `untCfgRepositorio.pas`

`pAdicionarConfiguracao('CFG_IQFATI', ...)`: valor padrão trocado do `SELECT ... CFG_PROCOT` para `'N'`.

## 4. Jornada de investigação e decisões

- Causa do erro 1 e 2 identificada lendo `fGetCfgIQF` (retornava `0` inteiro quando `IsEmpty`).
- Inicialmente concluí que as colunas de `CADIQF` eram texto (a tela grava com `AsString`); o
  `SHOW CREATE TABLE CADIQF` mostrou `int`. Por isso o `Result := '0'` sozinho não bastava e as três
  concatenações de `LIMIT` passaram a usar `VarToStr`.
- `Result := 0` -> `'0'` -> `IfThen(ACampo = 'IQF_QTDCMP', '1', '0')`: o `LIMIT 0` foi apontado pelo
  analista como incorreto; padrão `1` considera a última compra.
- Erro 3: avaliadas três opções. (1) Checar só o retorno de `fExecuta`: a mensagem original continuava sendo
  exibida pelo `Application.HandleException`, e o form de aguarde ficava visível sob o erro. (2) `Self.Hide` no
  `Finally` do `FormActivate` / guardar a exceção em `TfrmGravando` (`AcquireExceptionObject`) e relançá-la em
  `fExecuta`: **descartadas** por alterarem `untGravando.pas`, unit genérica usada em muitas rotinas (efeito
  colateral difícil de mensurar); o `Self.Hide` chegou a ser aplicado e foi revertido (`svn revert`).
  (3) **Adotada:** capturar a exceção dentro de `fCalculaQualidadeFornecedorPrg` (`recDadosIQF.strErro`) e relançá-la
  em `pCalculaQualidadeFornecedorLocal` depois de o form fechar normalmente.
- Erro 5 inicialmente sem acesso ao banco (variáveis `MYSQL_PRG_USER`/`MYSQL_PRG_PASS` vazias no
  processo); a correção partiu do código (`untPreNota.pas`) e depois foi confirmada no banco em modo
  somente leitura (`SHOW CREATE TABLE DETPON`, `SHOW CREATE TABLE CADIQF` e uma consulta leve validando
  o padrão `IN (SELECT ... FROM (... LIMIT) ITQF)` com `PCMDET.AUTOINCREM`).
- `CFG_IPISOU` (Req. diferente): chegou a ser alterada por engano (configuração errada informada) e foi
  revertida ao original; confirmado por `svn diff` (somente `CFG_IQFATI` alterada em
  `untCfgRepositorio.pas`).
- Aplicação em `74.150`: `svn patch` a partir do `svn diff` da `.100` (offset 5 / fuzz 1 só no hunk de
  `untCfgRepositorio.pas`), depois as correções seguintes foram aplicadas por Python em ambas.
- Edição de arquivos cp1252 sempre por Python (leitura/gravação com `encoding='cp1252', newline=''`),
  nunca pela ferramenta `Edit`; validado decodificação cp1252 e ausência de U+FFFD. Cuidado com EOL
  misto em `untIndiceQualidadeFornecedor.pas` (preservado).

## 5. Comportamento após a alteração

- Empresa sem `CADIQF` e com `IQFATI` = `S`: o cálculo roda sem exceção de conversão e sem erro de SQL.
  Com `IQF_QTDCMP` ausente usa a última compra; sem pesos/tolerância configurados o resultado reflete
  valores padrão, não a configuração da empresa (o cadastro em `CADIQF` continua necessário para um
  IQF fiel).
- Falha no cálculo: o form de aguarde fecha normalmente, e o `Except` de
  `fConfirmaEntradaMercadorias` recebe a exceção genérica (`Result := False`, `pMensagensErro`).
- Tela de configuração com "Não": grava `IQFATI` = `N` sem validar; com "Sim": comportamento anterior.
- Nova instalação: `CFG_IQFATI` com padrão `N`.

## 6. Achados colaterais não corrigidos

- Exceções do `FormActivate` fora da rotina do IQF seguem o caminho padrão de `TfrmGravando` (consumidas por
  `Application.HandleException`); não foram tratadas por estarem fora do escopo.
- `IQF_QTDMES` ausente: `DATE_SUB(CURDATE(), INTERVAL (SELECT IQF_QTDMES ...) MONTH)` resulta `NULL` e
  o filtro por meses não retorna linhas (só ocorre com `IQF_TIPFLT` = `M`, que exige registro em
  `CADIQF`).
- A senha de acesso ao banco foi colada no chat durante a sessão; recomendável trocá-la.

## 7. Pendências de validação

Compilar e testar no Autcom (Fase 4 do `tasks.md`): entrada de mercadorias com `CADIQF` vazio, filtro por
últimas compras, falha forçada no cálculo, tela de configuração com "Sim"/"Não", repetição na `74.150`.
