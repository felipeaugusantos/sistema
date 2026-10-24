# Análise — Req. 469019 — Chave duplicada na FORGEF na transferência de código de fornecedor

## 1. Contexto de negócio

A rotina "Transferência de código de fornecedor" (`TfrmTransfCodFornecedor`, unit `untTransfCodFornecedor.pas`, DLL
`libTransfCodigo.dll`) move todo o histórico de um fornecedor (origem) para outro (destino). Para isso, percorre as tabelas
filhas de `CADFOR` e executa, em cada uma, `UPDATE <tabela> SET <campo> = <destino> WHERE <campo> = <origem>`, também na
versão `DEL_<tabela>` quando existe. Tudo ocorre dentro de uma transação (`fStartTransaction` / `fRollBack`).

Cenário reportado: transferir o fornecedor **00005920 (XYZ COM DE PROD AUTOMOTIVOS)** para **00005989 (GWT GLOBAL IMPORTACAO
EXPORT. LTDA)**. A operação abortava com `EUniError #23000 Duplicate entry '00005989-00001' for key 'FORGEF.PRIMARY'`
(mensagem exibida ao usuário como "Chave Duplicada na Tabela: FORGEF"), no `ExecSQL` de `fAtualizaCodFornecedor`.

## 2. Causa raiz

- `FORGEF` (grupos do fornecedor) tem PK `(FGE_CODFOR, FGE_CODGEF)`, FK para `CADFOR` e para `GRECFR`, sem triggers.
- Os dois fornecedores já tinham o grupo `00001`: `('00005920','00001')` e `('00005989','00001')`.
- O UPDATE de troca de código tentava gerar uma segunda linha `('00005989','00001')` e violava a PK.
- Existe uma limpeza genérica de duplicados antes dos UPDATEs: `TIntegridadeTransferenciaCodigo.pAjustaRegistrosDuplicados`
  (`untTIntegridadeTransferenciaCodigo.pas`), alimentada pelas linhas de `TCOARR` com `TCA_DELDUP = 1`. A `FORGEF` está
  marcada (`TCA_ARQUIV='CADFOR'`, `TCA_ARQREL='FORGEF'`, `TCA_CAMREL='FGE_CODFOR'`, `TCA_DELDUP=1`).
- Porém essa classe monta a comparação apenas a partir de **chaves únicas diferentes de PRIMARY**
  (`SHOW INDEX ... WHERE Non_unique = 0 AND Key_name <> 'PRIMARY'`). A `FORGEF` só possui a PK, então nenhuma coluna é
  montada e nada é apagado.
- A mesma classe envolve o procedimento em `Except` vazio, intencional e comentado no fonte, o que esconde a falha.
- Em toda a base, apenas duas linhas de `TCOARR` têm `TCA_DELDUP = 1`: `FORGEF` (PK composta contendo o campo do
  fornecedor, quebra) e `EMPPRA` (PK `AUTOINCREM` + única `IDX_EMPPRA_02`, funciona).

## 3. Jornada de investigação

1. Leitura do fonte: `btnConfirmaDadosClick` → `fTransfereCodFornecedor` → `fAtualizaCodFornecedor` (stack do madExcept).
2. Consulta somente leitura ao banco (pymysql): estrutura da `FORGEF`, dados dos dois fornecedores, linhas de `TCOARR`.
3. Leitura de `TIntegridadeTransferenciaCodigo` e identificação do filtro `Key_name <> 'PRIMARY'` como lacuna.
4. Levantamento das tabelas com `TCA_DELDUP = 1` e das suas chaves, para medir o impacto de uma correção na classe genérica.
5. Verificação de triggers em `FORGEF` (nenhum) e de linhas em `DEL_FORGEF` para os dois fornecedores (nenhuma).

## 4. Abordagens avaliadas e descartadas

| Abordagem | Motivo do descarte |
|-----------|--------------------|
| Incluir a PRIMARY em `TIntegridadeTransferenciaCodigo.pAjustaRegistrosDuplicados` | Decisão do usuário de **não alterar** a classe, compartilhada pelas transferências de produto, cidade, conta, departamento, portador e vendedor |
| Tratar a duplicidade capturando o erro e repetindo | Esconde o problema e deixa a transação em estado incerto |

## 5. Solução aplicada

Criada em `TfrmTransfCodFornecedor` a procedure `pApagaForGefDuplicado(strForOri, strForDes: String)`, no molde de
`TfrmTransfCodProduto.pApagaPreIteDuplicado`, porém com `ParamByName()` (sem concatenar valores no SQL):

```sql
DELETE FROM FORGEF
 WHERE FGE_CODFOR = :FORORI
   AND FGE_CODGEF IN (SELECT FGE_CODGEF FROM (
        SELECT FGE_CODGEF FROM FORGEF WHERE FGE_CODFOR = :FORDES) AS TAB)
```

- O subselect aninhado (derived table) evita o erro 1093 do MySQL ("can't specify target table for update in FROM clause").
- Chamada em `fTransfereCodFornecedor`, logo após o bloco `TIntegridadeTransferenciaCodigo` e antes do
  `DELETE FROM FORNEO` e do laço de UPDATEs, dentro da transação: falha posterior desfaz o DELETE pelo `fRollBack` existente.
- Regra: em duplicidade prevalece o registro do destino; o da origem é descartado. Grupos que só existem na origem seguem
  para o UPDATE normal e migram para o destino.
- Query criada com `fCriaQuery(Self)` e liberada em `Try/Finally`.

Alterações idênticas nas working copies `379.48.2.30.74.150.100`, `379.48.2.30.74.150` e `379.48.2.30.74.150.45`, somente em
`padra_atualizado/fontes/util/untTransfCodFornecedor.pas` (declaração em `private`, implementação antes de
`pValidaCodCtaOriDes`, chamada em `fTransfereCodFornecedor`).

Verificação feita no banco (leitura): o `SELECT` equivalente ao novo `DELETE` para 00005920 → 00005989 retorna exatamente
`('00005920','00001')`.

## 6. Decisões de escopo

- Não alterar `untTIntegridadeTransferenciaCodigo.pas` nem o cadastro do `TCOARR`.
- Tratar somente a `FORGEF`, única tabela filha de `CADFOR` que falha com esse cenário.
- Portar para as working copies `74.150` e `74.150.45` (a `74.150` tem a unit idêntica à `.100`; a `.45` difere em 12 bytes,
  porém com as mesmas linhas de referência).

## 7. Achados colaterais não corrigidos

- `DEL_FORGEF` (histórico de exclusões) tem a mesma PK `(FGE_CODFOR, FGE_CODGEF)`. O UPDATE com prefixo `DEL_` em
  `fAtualizaCodFornecedor` pode colidir se existirem registros históricos dos dois fornecedores com o mesmo grupo. Nesta base
  não há linhas para 00005920 nem 00005989.
- A lacuna da PRIMARY em `TIntegridadeTransferenciaCodigo` continua existindo; hoje só a `FORGEF` é afetada, mas outras bases
  de cliente podem ter mais linhas com `TCA_DELDUP = 1`.

## 8. Ressalvas de ferramenta/processo

- O `pymysql` está instalado no site de usuário do Python 3.14; rodar com `python -I` oculta o módulo.
- Os fontes Delphi são cp1252 com CRLF; a edição foi feita por Python com encoding explícito, nunca com a ferramenta Edit.

## 9. Notas referenciadas no código-fonte

Não há. O comentário inserido no fonte é curto e autoexplicativo (descreve o que a procedure faz e por quê); não foi
necessária referência "Verificar Nota N".
