# Análise de Requisito — Req. 463062

**Título:** Baixa de pedido de compra não grava documento fiscal em PCMDET quando a entrada passa pela efetivação do movimento fiscal em duas etapas
**Solicitante:** Diego Guimarães (Compras) — cliente G&B
**Ticket Zendesk:** https://citelsoftware.zendesk.com/agent/tickets/1677430
**Data da análise/implementação:** 2026-09-23

## 1. Contexto de negócio

A rotina de **Entrada de Mercadorias** (`WG > ENTRADA DE MERCADORIAS`) permite, dependendo da configuração
`fConferenciaDepoisDaEntrada` (unit `untFuncoesGenerica.pas`/`untFuncoesSimples.pas`), efetivar o movimento
fiscal em duas etapas: a entrada é lançada primeiro e a baixa dos pedidos de compra vinculados só ocorre depois,
num momento de conferência separado. Esse fluxo é usado por clientes que conferem fisicamente a mercadoria antes
de confirmar a baixa definitiva do pedido no sistema.

Quando o pedido de compra é baixado, o sistema grava em `PCMDET` (detalhe do pedido) o documento fiscal
responsável pela baixa — número (`PCD_DOCEMI`), série (`PCD_SEREMI`) e espécie (`PCD_ESPEMI`) — para que
relatórios de compras consigam mostrar qual nota fiscal baixou cada pedido. O cliente reportou que essa
informação estava sistematicamente vazia quando o pedido era baixado pelo caminho de efetivação do movimento fiscal em duas etapas.

## 2. Problema e causa raiz

### 2.1 Sintoma relatado

O pedido de compra `019000010338` foi baixado pela entrada da NF `000000027257`, mas `PCMDET.PCD_DOCEMI`
(e, por confusão do relato do cliente, também `PCD_DOCORI`) ficaram vazios. O relatório de compras do cliente,
que usa esse campo para exibir a nota fiscal de baixa, deixou de mostrar a informação.

### 2.2 Mecanismo em uso e causa raiz

A cadeia de chamadas relevante é:

```
TEfetivaMovimentoFiscal.pEfetiva            (untEfetivaMovimentoFiscal.pas)
  → [If fConferenciaDepoisDaEntrada Then]
    → fBaixaPedidosAtendidosDepoisDaEntrada (untPcmGer.pas)
      → fBaixaPedidos (versão curta)        (untPcmGer.pas)
        → fBaixaPedidosEmbalagem            (untPcmGer.pas)
          → fBaixaPcmDet                    ← UPDATE em PCMDET que grava PCD_DOCEMI/SEREMI/ESPEMI
          → fBaixaPcmGer
```

`fBaixaPedidosAtendidosDepoisDaEntrada` monta, internamente, uma query (`qryEntMer`, função aninhada
`pCriaEntmer`) que faz `INNER JOIN` de `MOVDET` com `MOVTRI` filtrando por `MOVDET.DET_SEQGER = strAutoincMovDet`
(o parâmetro recebido é o `AUTOINCREM` de `MOVGER`, guardado em `MOVDET.DET_SEQGER` como FK). Essa query traz,
entre outros campos, `DET_NUMDOC`, `DET_CODEMP`, `DET_CODFOR`, `DET_ESPDOC` e `DET_SERIE_` — exatamente os dados
fiscais necessários para a baixa. A função também calcula `strAutEle` (função aninhada
`fCarregaAutoIncremNotaFiscal`), consultando `GERELE` com os mesmos campos, para obter o `AUTOINCREM` da nota
eletrônica vinculada.

Apesar de ter todos esses dados disponíveis, a função, ao baixar o pedido, chamava a versão **curta** de
`fBaixaPedidos`:

```pascal
function fBaixaPedidos(oleItensPedidos : oleVariant; cdsPedidos : TUniClientDataSet;
                       blnEntradaDeMercadorias : Boolean = True):Boolean;
  Var
    strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie, strAutEle : String;
    objEmbala: TEntEmbalagens;
Begin
  objEmbala := Nil;
  Result := fBaixaPedidosEmbalagem(oleItensPedidos, cdsPedidos, strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie, strAutEle,
                                   objEmbala, blnEntradaDeMercadorias);
End;
```

Essas seis variáveis locais (`strNumDoc`, `strEspDoc`, `strCodEmp`, `strCodFor`, `strSerie`, `strAutEle`) nunca
são atribuídas — chegam como string vazia (valor padrão do Object Pascal para `String`) em
`fBaixaPedidosEmbalagem`, que as repassa para `fBaixaPcmDet`. O `UPDATE` de `fBaixaPcmDet` usa uma proteção
contra sobrescrita:

```sql
UPDATE PCMDET
   SET PCD_BAIXAD = :BAIXAD,
       PCD_DOCEMI = IF(IFNULL(PCD_DOCEMI,"") = "", :NUMDOC, PCD_DOCEMI),
       PCD_SEREMI = IF(IFNULL(PCD_SEREMI,"") = "", :SEREMI, PCD_SEREMI),
       PCD_ESPEMI = IF(IFNULL(PCD_ESPEMI,"") = "", :ESPDOC, PCD_ESPEMI)
 WHERE ...
```

— ou seja, só grava o campo se ele ainda estiver vazio, para não sobrescrever um valor já preenchido por outro
fluxo. Essa proteção é correta em si, mas como os parâmetros chegam vazios e o campo já estava vazio, o
resultado é que ele **permanece vazio indefinidamente**, mesmo com o dado correto disponível poucas linhas
acima, em `qryEntMer`.

### 2.3 Validação (consulta somente-leitura em produção, credenciais fornecidas pelo usuário na conversa)

Consultas de simulação fornecidas no chamado, executadas via `pymysql` com acesso somente leitura
(schema `AUTCOM`, base indicada pelo usuário — `10.0.1.155:12006`):

```sql
SELECT PCD_DOCORI, PCD_DOCEMI, PCD_SEREMI, PCD_ESPEMI, PCD_BAIXAD, PCD_NUMPED, PCD_CODEMP, PCD_CODITE
  FROM PCMDET WHERE PCD_NUMPED = '019000010338';
```

Resultado: 20 linhas, todas com `PCD_BAIXAD = 1` e `PCD_DOCEMI`/`PCD_SEREMI`/`PCD_ESPEMI` vazios (`PCD_DOCORI`
é `NULL`, campo de semântica diferente — ver seção 6).

```sql
SELECT AUTOINCREM, DET_PEDCOM, DET_SEQGER, DET_NUMDOC, DET_CODEMP, DET_CODFOR, DET_ESPDOC, DET_SERIE_
  FROM MOVDET WHERE DET_PEDCOM = '019000010338' AND DET_CODITE = '38425';
```

Resultado: `DET_NUMDOC='000000027257'`, `DET_CODEMP='019'`, `DET_CODFOR='60000053'`, `DET_ESPDOC='NF'`,
`DET_SERIE_='1'`, `DET_SEQGER='00100000001432152019'` — todos corretos e completos.

```sql
SELECT AUTOINCREM, GER_NUMDOC, GER_ESPDOC, GER_SERIE_, GER_CODFOR, GER_CODEMP
  FROM MOVGER WHERE AUTOINCREM = '00100000001432152019';
```

Resultado: valores idênticos aos de `MOVDET` acima — confirma que a origem (`MOVGER`) e a cópia denormalizada
em `MOVDET` estão consistentes; não há dado ausente na origem.

```sql
SELECT AUTOINCREM, GER_DOCENT, GER_EMPENT, GER_CODFOR, GER_ESPENT
  FROM GERELE WHERE GER_DOCENT = '000000027257' AND GER_EMPENT = '019'
    AND GER_CODFOR = '60000053' AND GER_ESPENT = 'NF';
```

Resultado: `AUTOINCREM='00100000000125611019'` — idêntico ao `PEL_SEQELE` citado no ticket, confirmando que
`strAutEle` seria corretamente resolvido como não vazio.

**Prova definitiva** — log de auditoria (`LOGREP_ARQUIV_20260912`, 2026-09-11 14:50:02), UPDATE real gravado
contra `PCMDET` para este pedido:

```sql
UPDATE PCMDET SET PCD_BAIXAD = 1,
  PCD_DOCEMI = IF(IFNULL(PCD_DOCEMI,"") = "", '', PCD_DOCEMI),
  PCD_SEREMI = IF(IFNULL(PCD_SEREMI,"") = "", '', PCD_SEREMI),
  PCD_ESPEMI = IF(IFNULL(PCD_ESPEMI,"") = "", '', PCD_ESPEMI)
WHERE PCD_NUMCTN = 0 AND PCD_NUMPED = '019000010338' AND PCD_ESPDOC = "PD"
  AND PCD_CODEMP = '001' AND PCD_QTDBAI >= PCD_QTDITE
```

Os parâmetros `:NUMDOC`/`:SEREMI`/`:ESPDOC` foram substituídos por **string vazia literal (`''`)** no SQL
efetivamente executado — prova de que os valores se perderam em trânsito entre `fBaixaPedidosAtendidosDepoisDaEntrada`
e o `UPDATE`, não que estavam ausentes na origem.

## 3. Investigação realizada

1. Recebida consolidação técnica prévia (documento colado pelo usuário no início da sessão) já apontando a
   causa raiz na versão curta de `fBaixaPedidos`. Cada afirmação do documento foi lida e verificada
   individualmente contra o código-fonte atual antes de ser aceita como válida (ver seção 4 para as
   imprecisões encontradas e corrigidas).
2. Localizadas as duas chamadas de `TEfetivaMovimentoFiscal.pEfetiva` relacionadas a entrada de mercadorias
   (`untEntMercadoriasEfetivaMovFiscal.pas:535` e `untPlanoDeRecebimento.pas:5628`) e confirmado que ambas já
   passam `strNumDoc`/`strEspDoc`/`strSerie`/`strCliFor`/`strCodEmp` corretos para `pEfetiva` — descartando a
   hipótese de que o problema estivesse nesses pontos de entrada.
3. Localizado que `pEfetiva`, apesar de receber esses parâmetros, não os repassa para
   `fBaixaPedidosAtendidosDepoisDaEntrada` (que recebe apenas `strAutoincMovDet`) — levantada a hipótese
   alternativa de que a correção deveria propagar os parâmetros de `pEfetiva`, em vez de usar os campos já
   lidos em `qryEntMer`.
4. Validada essa hipótese alternativa contra dados reais de produção (seção 2.3): `MOVDET`, `MOVGER` e `GERELE`
   têm todos os dados corretos e consistentes entre si — descartando a necessidade de tocar em `pEfetiva`; a
   correção mais simples e correta é usar os campos que `qryEntMer` já carrega.
5. Levantados, por busca textual, todos os call sites da versão curta de `fBaixaPedidos` no projeto:
   `untPcmGer.pas:15064` (o caso deste requisito) e `untTGarantiaRetornoFornecedor.pas:459`
   (`TRetornoFornecedor.pBaixarPedidos`).
6. Investigado o segundo caller: confirmado, por busca textual exaustiva na unit, que os campos `FNumDoc` e
   `FEspDoc` daquela classe nunca são atribuídos fora de `pInicializar` (fixos em `EmptyStr`/`'GR'`) — ou seja,
   são vazios por desenho nesse fluxo de retorno/garantia ao fornecedor, não pelo mesmo defeito de propagação.
   Descartado do escopo.
7. Confirmado, por grep, que as três working copies adicionais solicitadas pelo usuário
   (`379.48.2.30.74.150.45`, `379.48.2.30.74.150.100`,
   `74.Fechadas/74.150.Fechadas/379.48.2.30.74.150.36`) têm exatamente o mesmo trecho de código defeituoso em
   `untPcmGer.pas`, apenas em linhas diferentes.
8. Confirmado, por grep, que `TEntEmbalagens` e `fBaixaPedidosEmbalagem` já são usados na mesma unit em todas
   as quatro working copies, dispensando qualquer alteração de `uses`.
9. Confirmado, por leitura de bytes, que `untPcmGer.pas` é UTF-8 com BOM nas quatro working copies (não
   cp1252/Latin-1) — a edição via ferramenta de texto padrão é segura para este arquivo específico.

## 4. Abordagens consideradas e descartadas

- **Propagar os parâmetros que `pEfetiva` já recebe (`strNumDoc`/`strEspDoc`/`strSerie`/`strCliFor`/`strCodEmp`)
  através de `fBaixaPedidosAtendidosDepoisDaEntrada`** — considerada como hipótese alternativa após o usuário
  observar que `pEfetiva` já tem esses dados em escopo. Descartada após validação em produção mostrar que os
  campos denormalizados em `MOVDET` (fonte usada por `qryEntMer`) são idênticos aos de `MOVGER`/`pEfetiva` neste
  caso real — ou seja, ambas as fontes são igualmente confiáveis, e usar `qryEntMer` (já disponível na função)
  é mais simples do que alterar a assinatura de `fBaixaPedidosAtendidosDepoisDaEntrada` e potencialmente
  impactar os três chamadores de `pEfetiva`.
- **Criar overload de `fBaixaPedidos` recebendo os campos fiscais** (proposta original da consolidação técnica
  recebida no início da sessão) — descartada em favor de chamar `fBaixaPedidosEmbalagem` diretamente, opção
  mais direta que evita adicionar mais uma sobrecarga a uma função que já tem duas versões (curta e via
  `fBaixaPedidosEmbalagem`), sem nenhuma perda de funcionalidade.
- **Corrigir `TRetornoFornecedor.pBaixarPedidos`** (segundo caller da versão curta) — descartada nesta sessão
  após investigação mostrar que os dados fonte daquela classe são vazios por desenho, não pelo mesmo defeito;
  corrigi-la não mudaria o comportamento observável e sairia do escopo do problema relatado.
- **Corrigir `PCD_DOCORI` também** — descartada porque esse campo tem semântica diferente (documento de origem
  do pedido, gravado uma única vez na criação do pedido) e não está relacionado ao defeito de baixa relatado;
  o ticket confundiu os dois campos.

## 5. Solução aplicada

Em `fBaixaPedidosAtendidosDepoisDaEntrada`, a chamada à versão curta de `fBaixaPedidos` foi substituída por uma
chamada direta a `fBaixaPedidosEmbalagem`, informando os campos já lidos em `qryEntMer` e a variável local
`strAutEle`:

```pascal
If blnBaiPed Then
Begin
  objEmbala := Nil;
  Result := fBaixaPedidosEmbalagem(oleItensPedidos, cdsPedidos,
                                   qryEntMer.FieldByName('DET_NUMDOC').AsString,
                                   qryEntMer.FieldByName('DET_ESPDOC').AsString,
                                   qryEntMer.FieldByName('DET_CODEMP').AsString,
                                   qryEntMer.FieldByName('DET_CODFOR').AsString,
                                   qryEntMer.FieldByName('DET_SERIE_').AsString,
                                   strAutEle,
                                   objEmbala,
                                   True);
End;
```

Foi adicionada a variável local `objEmbala: TEntEmbalagens` (inicializada como `Nil`, mesmo padrão já usado
pela própria versão curta de `fBaixaPedidos`), já que `fBaixaPedidosEmbalagem` recebe esse parâmetro por
referência (`Var`). Nenhuma outra assinatura foi alterada — `fBaixaPedidos`, `pEfetiva` e os demais chamadores
permanecem exatamente como estavam.

### Arquivos alterados (mesmo diff aplicado em todas as cópias)

| Working copy | Arquivo | Linha da chamada (antes da edição) | Status |
|---|---|---|---|
| `379.48.2.30.74.150` | `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas` | ~15064 | Alterado |
| `379.48.2.30.74.150.45` | `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas` | ~14429 | Alterado |
| `379.48.2.30.74.150.100` | `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas` | ~15008 | Alterado |
| `74.Fechadas/74.150.Fechadas/379.48.2.30.74.150.36` | `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas` | ~14435 | Alterado |

Em todas: mesmos dois pontos — (1) adição de `objEmbala: TEntEmbalagens` na declaração de variáveis locais de
`fBaixaPedidosAtendidosDepoisDaEntrada`; (2) troca da chamada de baixa, dentro do bloco `If blnBaiPed Then`,
para a forma acima, com o comentário curto de referência à Nota 1 (ver seção 9).

A localização em cada arquivo foi feita por conteúdo textual exato (`Result := fBaixaPedidos(oleItensPedidos, cdsPedidos);`),
não por número de linha fixo, já que as quatro cópias têm o mesmo trecho deslocado em linhas diferentes.

### Validação pós-implementação

Validação por revisão de lógica e confirmação de tipos/escopo (sem compilação nesta sessão, por não haver
acesso a IDE Delphi/compilador no ambiente de execução):

- Confirmado, por grep em cada uma das quatro working copies, que `TEntEmbalagens` já é usado na mesma unit
  (em `fBaixaPedidosEmbalagem` e em outras funções), portanto o tipo já está no escopo sem necessidade de novo
  `uses`.
- Confirmado, por leitura, que a assinatura de `fBaixaPedidosEmbalagem` é idêntica nas quatro cópias
  (`oleItensPedidos, cdsPedidos, strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie, strAutEle, Var objEmbala,
  blnEntradaDeMercadorias = True, ...`), então a chamada nova é válida em todas.
- Confirmado que `qryEntMer` não é navegada (nenhum `.Next`/`.First`) entre o `Open` (em `pCriaEntmer`) e o novo
  ponto de leitura — permanece no primeiro registro aberto, cujos campos fiscais são os mesmos para todos os
  itens do mesmo documento (agrupados por `DET_SEQGER`), então ler do primeiro registro é equivalente a ler de
  qualquer outro.
- Confirmado, por grep, que não restou nenhuma chamada residual à versão curta dentro de
  `fBaixaPedidosAtendidosDepoisDaEntrada` em nenhuma das quatro cópias após a edição.
- Confirmado, por leitura de bytes antes da edição, que o arquivo é UTF-8 com BOM nas quatro cópias — a edição
  via ferramenta de texto padrão não introduz risco de corrupção de encoding.

## 6. Esclarecimento sobre `PCD_DOCORI`

O ticket menciona tanto `PCD_DOCORI` quanto `PCD_DOCEMI` como campos não gravados. Apenas `PCD_DOCEMI` (e os
irmãos `PCD_SEREMI`/`PCD_ESPEMI`) fazem parte deste defeito. `PCD_DOCORI` é gravado uma única vez, na criação
do pedido (`untPcmGer.pas`, função de inclusão do item do pedido, ~linha 1206), representando o **documento de
origem do pedido** (por exemplo, uma requisição que originou o pedido) — não o documento que o baixou. Ficar
`NULL` é o comportamento esperado quando o pedido não tem documento de origem, e não está relacionado à baixa
via entrada de mercadorias.

## 7. Decisões de escopo

**Incluído:** correção do ponto único identificado em `untPcmGer.pas`
(`fBaixaPedidosAtendidosDepoisDaEntrada`), aplicada nas quatro working copies solicitadas.

**Excluído deliberadamente:**

- **Reparo retroativo dos dados já gravados incorretamente** para o pedido `019000010338` — identificado e
  documentado (SQL exato em `IA/specs/463062/tasks.md`, Fase 4), mas **não executado nesta sessão**. Depende
  do protocolo de duas etapas (preview + aprovação explícita) da ferramenta de acesso ao banco em modo
  escrita, que não foi acionado até o momento deste registro.
- **Levantamento de outros pedidos históricos com o mesmo padrão** — não dimensionado; não se sabe quantos
  outros pedidos, além do citado no ticket, têm `PCD_BAIXAD=1` com os campos fiscais vazios.
- **Correção de `TRetornoFornecedor.pBaixarPedidos`** (segundo caller da versão curta de `fBaixaPedidos`) —
  investigado e descartado por não ser o mesmo defeito (ver seções 3 e 4).
- **Correção de `PCD_DOCORI`** — campo de semântica diferente, não relacionado a este defeito (ver seção 6).
- **Riscos adicionais identificados mas não corrigidos**: `try/except` externo silencioso em
  `fBaixaPedidosAtendidosDepoisDaEntrada` (engole qualquer exceção sem log, retornando apenas `Result := False`);
  `fCarregaAutoIncremNotaFiscal` sem `Result := ''` explícito no caminho de `Exit` quando `GERELE` não retorna
  registro (funciona hoje porque Delphi inicializa `String` como vazio, mas o contrato não é explícito);
  criação de `qryConsulta` antes do `try/finally` externo (frágil a mudanças futuras na função, embora não
  vaze objeto no fluxo atual).

## 8. Ressalvas e lições

- **Consolidação técnica prévia recebida no início da sessão estava correta na causa raiz, mas com duas
  imprecisões factuais**, ambas identificadas e corrigidas durante a investigação: (1) `fAtualizaDadosPcmDet` e
  `fBaixaPcmGer` não estão em `untPcmGer.pas` como o documento afirmava — vivem em
  `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untFuncoesPedidoSimples.pas`; (2) os números de
  linha citados no documento (`14348-14439`, chamada em `1079`) não batiam com o código atual (função em
  `14983-15074`, chamada em `1250`) — provavelmente por terem sido levantados sobre outra revisão/branch. Isso
  reforça a prática de **sempre verificar cada afirmação de um documento de análise recebido de terceiros
  contra o código-fonte atual**, mesmo quando a conclusão geral está correta.
- **Hipótese alternativa levantada pelo usuário (propagar parâmetros de `pEfetiva`) era tecnicamente válida e
  só foi descartada com evidência real de banco** — sem essa validação (seção 2.3), as duas abordagens
  pareceriam igualmente corretas em teoria; a checagem factual (comparar `MOVDET` com `MOVGER` no caso real do
  ticket) foi o que decidiu por usar `qryEntMer`, por ser a opção mais simples sem alterar a assinatura de
  `pEfetiva`/`fBaixaPedidosAtendidosDepoisDaEntrada`.
- **Investigar segundo caller antes de assumir que a correção deveria ser replicada automaticamente**: a
  primeira leitura de `TRetornoFornecedor.pBaixarPedidos` sugeria o mesmo defeito (mesma chamada à versão
  curta), mas a leitura completa da classe (`FNumDoc`/`FEspDoc` nunca atribuídos fora de `pInicializar`)
  mostrou que os dados são vazios por desenho ali, não pelo mesmo bug de propagação — corrigir esse ponto não
  teria efeito prático e ampliaria o raio da mudança sem necessidade.
- **Encoding verificado antes de editar**: apesar da orientação geral do projeto de tratar arquivos `.pas` como
  cp1252/Latin-1 por padrão, a leitura de bytes de `untPcmGer.pas` nas quatro cópias confirmou BOM UTF-8 e
  decodificação válida como UTF-8 — a ferramenta de edição de texto padrão foi usada com segurança, sem risco
  de corrupção de acentuação.
- **Uso de credenciais de banco fornecidas ad-hoc pelo usuário na conversa**: a skill de acesso ao banco
  (`citel-conectarBanco`) prevê esse caminho explicitamente (conexão ad-hoc via flags, sem exigir
  `db-config.json`/variável de ambiente) quando o usuário informa host/porta/usuário/senha diretamente no chat
  — usado para validar a hipótese da causa raiz com dados reais de produção, em modo somente leitura.

## 9. Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit:** `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas` (mesma nota nas quatro working
copies: `379.48.2.30.74.150`, `379.48.2.30.74.150.45`, `379.48.2.30.74.150.100` e
`74.Fechadas/74.150.Fechadas/379.48.2.30.74.150.36`)
**Função:** `fBaixaPedidosAtendidosDepoisDaEntrada`

**Explicação completa:** a chamada original acionava a versão curta de `fBaixaPedidos`, que declara localmente
as variáveis `strNumDoc`, `strEspDoc`, `strCodEmp`, `strCodFor`, `strSerie` e `strAutEle` sem nunca inicializá-las,
repassando-as vazias para `fBaixaPedidosEmbalagem` e, na sequência, para o `UPDATE` de `PCMDET` que grava
`PCD_DOCEMI`/`PCD_SEREMI`/`PCD_ESPEMI`. Como esse `UPDATE` usa uma condição que só preenche o campo se ele ainda
estiver vazio (`IF(IFNULL(campo,"")="", :novo_valor, campo)` — proteção legítima contra sobrescrever um valor já
gravado por outro fluxo), o efeito prático era o campo permanecer vazio indefinidamente, mesmo com o dado
correto disponível poucas linhas acima, em `qryEntMer` (que já faz `INNER JOIN MOVDET`+`MOVTRI` e traz
`DET_NUMDOC`/`DET_CODEMP`/`DET_CODFOR`/`DET_ESPDOC`/`DET_SERIE_`).

Essa causa foi confirmada com dados reais de produção (Req. 463062, pedido `019000010338`, NF `000000027257`):
as tabelas `MOVDET`, `MOVGER` e `GERELE` tinham os dados fiscais corretos e consistentes entre si, e o log de
auditoria (`LOGREP_ARQUIV_20260912`) mostrou o `UPDATE` real executado contra `PCMDET` com os parâmetros de
número/série/espécie substituídos por string vazia literal — ou seja, o problema era exclusivamente a perda em
trânsito entre `fBaixaPedidosAtendidosDepoisDaEntrada` e a rotina de gravação, não ausência de dado na origem.

**Por que isso não é óbvio e por que uma revisão futura não deve reintroduzir a chamada à versão curta neste
ponto:** a versão curta de `fBaixaPedidos` existe como um wrapper de conveniência, válido em contextos onde os
dados fiscais realmente não estão disponíveis (por isso ela existe e é usada em outros pontos do sistema). O
que não é óbvio ao ler apenas essa chamada é que, especificamente dentro de
`fBaixaPedidosAtendidosDepoisDaEntrada`, os dados fiscais **já foram apurados** poucas linhas antes (`qryEntMer`
e `strAutEle`) e estavam sendo descartados sem necessidade. Reintroduzir a chamada à versão curta neste ponto —
por exemplo, numa tentativa de "simplificar" ou "padronizar" a chamada com outros pontos do arquivo — voltaria
a descartar esses dados já disponíveis, reintroduzindo exatamente o defeito relatado no Req. 463062 para todo
pedido baixado através do fluxo de efetivação do movimento fiscal em duas etapas.
