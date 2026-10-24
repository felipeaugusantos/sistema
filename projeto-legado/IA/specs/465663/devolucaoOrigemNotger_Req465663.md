# Req. 465663 — Entrada de devolução com documento de origem em NOTGER (documento de confirmação)

**Data:** 2026-09-29
**Zona:** Legado (`padra_atualizado/fontes/movimentacaoitens/`)
**Cópias alteradas:** 379.48.2.30.74.150.45 (base, testada), 379.48.2.30.74.150.100, 379.48.2.30.74.150 e
74.Fechadas\74.150.45.Fechadas\379.48.2.30.74.150.45.67
**Artefatos de levantamento:** `spec.md`, `plan.md`, `tasks.md` (mesma pasta)

## 1. Contexto de negócio

Na entrada de mercadorias por transferência (`TfrmRecTransfEstoque`, `untRecTransfEstoque.pas`), quando o movimento
recebido é uma devolução (`TIPSEN = 'DEVOLU'`), o sistema precisa saber:

- se a nota realmente é uma devolução válida (`FblnDevolu`);
- qual foi a nota de venda original (`GER_SAIDA_`, guardada em `FstrAutIncVenda`), além de empresa, documento e espécie
  do documento devolvido (`FstrEmpresaDevolucao`, `FstrDocumentoDevolucao`, `FstrEspecieDevolucao`);
- quando a venda original foi para **cliente consumidor**, quais são os dados desse consumidor
  (nome, endereço, CEP, cidade, UF, telefone, CGC/CPF, IE), para que a nota de entrada da devolução os reproduza.

Essa descoberta é feita por `TRecTransfEstoqueDevolucao.fExecutar` (`untRecTransfEstoqueDevolucao.pas`), chamada em
`pPreparaFlagsDevolucao` (e, na cópia .67, dentro de `fGeraEntrada`). O mesmo objeto é usado por
`untEfetivaMovimentoFiscal.pas` (`fEntradaDevolucao`), que não precisou de alteração.

**Documento de confirmação:** existem vendas cuja origem não é a MOVGER, e sim a NOTGER (documento de confirmação).
Quando o cliente devolve uma mercadoria dessas vendas, o documento devolvido (`MOVDET.DET_DOCDEV/DET_ESPDEV/DET_EMPDEV`)
aponta para um registro da NOTGER.

## 2. Problema e causa raiz

1. `fExecutar` só consultava a MOVGER (`NFEENT` e `NFESAI` eram MOVGER). Para devolução de documento de confirmação a
   consulta voltava vazia: `FDevolucao` ficava `False`, `FAutIncVenda`/`FEmpDev`/`FDocDev`/`FEspDev` ficavam vazios e a
   nota de entrada não era reconhecida como devolução.
2. `fCarregaClienteConsumidor(AAutInc)` buscava sempre na MOVGER. `AUTOINCREM` da NOTGER e da MOVGER são sequências
   distintas e o **mesmo valor pode existir nas duas tabelas, para documentos diferentes**. Mesmo com a nota de venda
   encontrada na NOTGER, o consumidor seria lido do documento errado da MOVGER, sem qualquer erro.

## 3. Evidência (banco AUTCOM, apenas leitura, 2026-09-29)

Documento usado: `MOVDET.DET_NUMDOC = '000000004374'`, `DET_DTADOC = '2026-01-16'`, `DET_SEQGER = 00100000001324782100`,
CFOP 5411, origem NF 000000377763.

| Consulta | Resultado |
|---|---|
| Ramo atual (MOVGER) | vazio |
| Ramo novo (NOTGER) | `GER_SAIDA_ = 00100000000005845001`, NF 000000377763, espécie NF |
| `AUTOINCREM 00100000000005845001` na MOVGER | outro documento: NF 000000004848, espécie FF, cliente "DR AUTO CENTER PECAS PARA VEICULOS EIREL" |
| `AUTOINCREM 00100000000005845001` na NOTGER | o documento correto: NF 000000377763, cliente "SGS COMERCIO DE PECAS LTDA" |

- As 11 colunas de consumidor lidas por `fCarregaClienteConsumidor` (`GER_NOMCON`, `GER_ENDCON`, `GER_BAICON`,
  `GER_CEPCON`, `GER_CIDCON`, `GER_ESTCON`, `GER_TELCON`, `GER_CGCCON`, `GER_CGCCPF`, `GER_IESCON`, `GER_R_GCON`)
  existem na NOTGER (confirmado no banco).
- O SELECT novo foi validado com `NOTGER` em `NFEENT` e `NFESAI`, `MOVGER` em `NFEDEV`, `GROUP BY NFEDEV.AUTOINCREM,
  NFESAI.AUTOINCREM`. A lista de CFOP usada na validação foi a do exemplo; em produção vale o parâmetro `:CFOP`
  (`VS_strClaDev + VS_strClaDVC`).
- Toda a consulta foi somente leitura, sem teste de carga. A senha informada no chat não foi gravada em arquivo.

## 4. Solução aplicada

### 4.1 `untRecTransfEstoqueDevolucao.pas` (`TRecTransfEstoqueDevolucao`)

- Campo privado `FOrigemDoc: String` e método público fluent `fOrigemDocumento(out ATabelaOrigemDocDev: String)`,
  no mesmo padrão de `fAutoincrementoVenda`.
- `fExecutar`: os dois SELECTs existentes ganharam, como **última coluna**, `'MOVGER' ORIGEM_DOC`. Foi incluído um
  terceiro SELECT ligado por `UNION ALL`, cópia lógica do primeiro, com `NFEENT` e `NFESAI` em `NOTGER`, `NFEDEV`
  continuando em `MOVGER`, e `'NOTGER' ORIGEM_DOC` como última coluna.
- O terceiro SELECT reutiliza os parâmetros `:CFOP` e `:AUTOINCREM` (agora 3 ocorrências de cada; `ParamByName`
  atende todas).
- O `ORDER BY GER_SAIDA_ IS NULL, GER_SAIDA_ DESC` e o `LIMIT 1` externos permanecem.
- Após o `Open`: `FOrigemDoc := FqryDataSet.FieldByName('ORIGEM_DOC').AsString;`.

### 4.2 `untRecTransfEstoque.pas` (`TfrmRecTransfEstoque`)

- Campo `FstrOrigemDoc: String` ao lado de `FstrAutIncVenda`.
- `pPreparaFlagsDevolucao`: `FstrOrigemDoc := ''` junto dos demais resets e `.fOrigemDocumento(FstrOrigemDoc)` no fim da
  cadeia fluent. Na cópia .67 (que não tem `pPreparaFlagsDevolucao`) o reset e a cadeia ficam em `fGeraEntrada`.
- `fCarregaClienteConsumidor(AAutInc, ATabelaOrigemDocDev: String)`: o `FROM` passa a ser `NOTGER` quando
  `SameText(ATabelaOrigemDocDev, 'NOTGER')`, senão `MOVGER`. O valor recebido não é concatenado no SQL.
- Chamada em `fGravaMovGer` (bloco `With cdsConsulta, recTotais`): `fCarregaClienteConsumidor(FstrAutIncVenda,
  FstrOrigemDoc)`.

## 5. Investigação, decisões e abordagens descartadas

| Decisão | Escolha | Motivo |
|---|---|---|
| `UNION` x `UNION ALL` | `UNION ALL` nos três ramos | Pedido do usuário: mesmo conector em todos. O `UNION` que existia entre os ramos 1 e 2 foi trocado por `UNION ALL`; o resultado não muda por causa do `ORDER BY ... LIMIT 1` externo, e se evita o dedupe. |
| Prioridade entre MOVGER e NOTGER | Manter `ORDER BY GER_SAIDA_ IS NULL, GER_SAIDA_ DESC` | Decisão do usuário: não alterar a ordenação. |
| SQL fixo x parametrizado | Parametrizar `:CFOP` e `:AUTOINCREM` | Decisão do usuário; a lista do exemplo era literal e não deve ir para produção. |
| Como guiar a tabela do consumidor | Coluna `ORIGEM_DOC` constante nos 3 SELECTs, guardada em campo | Solicitado pelo usuário. Buscar nas duas tabelas e escolher não resolve a colisão de `AUTOINCREM`. |
| Escolha da tabela no `FROM` | Whitelist com `SameText` | Evita concatenar valor recebido no SQL (regra de SQL injection do projeto). Valor vazio/desconhecido cai em MOVGER (comportamento anterior). |
| Nome do parâmetro | `ATabelaOrigemDocDev` | Ajuste pedido pelo usuário (antes `AOrigemDoc`). |
| Nome de identificadores | Sem número de requisito | Regra global do usuário; padrão da unit (`F`, `A`, prefixo de tipo). |

Pontos que podem parecer riscos e foram checados:

- `ORIGEM_DOC` tem de ser a **última coluna** nos três SELECTs porque a união é posicional (nomes vêm do primeiro SELECT).
  Os ramos 1 e 3 têm a ordem `AUT_DEVOLU, GER_SAIDA_, DET_EMPDEV, DET_DOCDEV, DET_ESPDEV, ORIGEM_DOC`; o ramo 2
  já usava posições equivalentes (`NFEENT.AUTOINCREM`, `NFEDEV.AUTOINCREM`, `NULL` x3).
- Mistura de tabelas na ordenação: `GER_SAIDA_ DESC` compara AUTOINCREMs de tabelas diferentes; a prioridade entre ramos
  é apenas a ordem numérica. Mantido por decisão; só é relevante se um mesmo documento aparecer nos dois ramos.
- Retorno de `fCarregaClienteConsumidor` (`Result := Not IsEmpty`) continua ignorado pelo chamador, como antes.

## 6. Notas referenciadas no código-fonte

### Nota 1

**Onde:** `untRecTransfEstoqueDevolucao.pas`, `TRecTransfEstoqueDevolucao.fExecutar` (comentário antes do
`UNION ALL` do terceiro SELECT) e `untRecTransfEstoque.pas`, `TfrmRecTransfEstoque.fCarregaClienteConsumidor`
(comentário antes da escolha do `FROM`).

**Explicação:** documentos de confirmação têm origem na NOTGER, não na MOVGER. Sem o terceiro SELECT, `fExecutar`
não enxergava a venda original e a nota de entrada deixava de ser tratada como devolução. Encontrada a venda na NOTGER,
o `AUTOINCREM` dela (`GER_SAIDA_`) não identifica sozinho o documento: NOTGER e MOVGER têm sequências independentes e o
mesmo valor pode existir nas duas tabelas para documentos distintos (exemplo real: `00100000000005845001` é a NF
000000377763 de "SGS COMERCIO DE PECAS LTDA" na NOTGER e a NF 000000004848 de "DR AUTO CENTER PECAS PARA VEICULOS EIREL"
na MOVGER). Por isso cada SELECT devolve `ORIGEM_DOC` fixo, o valor é guardado em `FOrigemDoc`/`FstrOrigemDoc` e
`fCarregaClienteConsumidor` lê o consumidor da tabela indicada. Remover a coluna, o campo ou o parâmetro faz o consumidor
voltar a ser lido sempre da MOVGER, o que grava o cliente errado sem gerar erro. O `FROM` é escolhido por comparação com
valores fixos, e não por concatenação, de propósito.

## 7. Escopo

- **Incluído:** os dois fontes acima, em quatro cópias (Fase 4 do `tasks.md`).
- **Sem alteração:** `untEfetivaMovimentoFiscal.pas` (usa `fEntradaDevolucao`; só se beneficia do reconhecimento correto).
  `untEntMercadorias.pas` tem um `fCarregaClienteConsumidor` sem parâmetro que não tem relação com este ajuste.
- **Fora de escopo:** cópia 74.111 e demais não listadas; guard clause para `FstrAutIncVenda` vazia; renomear
  `fAutoIncremeto`; tratar o retorno de `fCarregaClienteConsumidor`; alterar a prioridade entre tabelas.

## 8. Achados colaterais (não corrigidos)

- `fCarregaClienteConsumidor` é chamada mesmo com `FstrAutIncVenda` vazia (devolução sem venda encontrada): a query
  retorna vazio e o array `FarrClienteConsumidor` é zerado; comportamento anterior, não alterado.
- `fAutoIncremeto` (nome no singular incompleto) segue como estava.
- O `untRecTransfEstoque.pas` já tinha 8 finais de linha LF puros misturados a CRLF antes desta alteração; foram
  preservados (não normalizar, para não poluir o diff).

## 9. Ressalvas e lições de processo

- Fontes `.pas` são cp1252/CRLF: edição feita somente por Python (`encoding='cp1252'`, `newline=''`); nunca a ferramenta
  Edit. Validado: decodificam em cp1252 e não contêm `\xef\xbf\xbd`.
- Erro corrigido durante a implementação: nos `SQL.Add` de `ORIGEM_DOC` as aspas de `'MOVGER'`/`'NOTGER'` foram geradas
  sem duplicar (`'  ,'MOVGER' ORIGEM_DOC'`), o que não compilaria; corrigido para `'  ,''MOVGER'' ORIGEM_DOC'` nas
  quatro cópias. Ao revisar, conferir que existem 2 ocorrências de `''MOVGER''` e 1 de `''NOTGER''` em
  `untRecTransfEstoqueDevolucao.pas`.
- A cópia .67 tem `untRecTransfEstoque.pas` mais antigo (sem `pPreparaFlagsDevolucao`); a cadeia fluent fica em
  `fGeraEntrada`, com indentação de 10 espaços. As demais cópias seguem a estrutura da 74.150.45.

## 10. Situação dos testes

- Devolução com origem em NOTGER e cliente consumidor (74.150.45): validado pelo usuário, entrada feita corretamente.
- Regressão com origem em MOVGER, devolução sem nota de venda encontrada e demais validações nas outras cópias serão
  feitas pela rotina de testes do requisito.
