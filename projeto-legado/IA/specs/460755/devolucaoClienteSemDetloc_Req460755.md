# Análise de Requisito — Req. 460755

**Título:** Entrada de devolução de cliente acusava "todos os itens já devolvidos" para NF anterior à
configuração de localização física por lote
**Solicitante:** Marissa Garajau (Intercores) — ticket Zendesk 1658968
**Data da análise/implementação:** 2026-09-10

## 1. Contexto de negócio

A rotina **[ WG ] ENTRADA DE MERCADORIAS**, no fluxo de devolução de cliente, abre a tela de seleção de
itens a devolver (`TfrmEntSelItensDevolucao`, `untEntSelItensDevolucao.pas`) a partir do número da nota
fiscal de venda original digitada pelo operador (`untEntDigPedido.pas`). Essa tela consulta `MOVDET`
(detalhe da venda original) e calcula, por item, a quantidade ainda disponível para devolução, descontando
o que já foi devolvido anteriormente (rastreado por `MOVDET.DET_DOCDEV`/`DET_ESPDEV`/`DET_EMPDEV`).

Quando a empresa está configurada para controlar múltiplas localizações físicas por lote (config de sistema
`UM1LFL`, mais a manutenção de lote `MANEND` ligada), a consulta passa a considerar também a tabela
`DETLOC` — que vincula cada linha de `MOVDET` à localização física em que o produto foi fisicamente
guardado, permitindo tratar separadamente lotes/localizações diferentes do mesmo item dentro do mesmo
documento.

## 2. Problema e causa raiz

O cliente tentou dar entrada na devolução da NF 000000207774 (empresa 001) e o sistema retornou a
mensagem **"Todos os itens deste documento já foram devolvidos"**, mesmo não havendo nenhuma devolução
anterior vinculada a essa nota — confirmado por consulta direta ao banco (`MOVDET` filtrado por
`DET_DOCDEV`/`DET_ESPDEV`/`DET_EMPDEV`/`DET_CODCLI` da nota, sem nenhum resultado).

A causa raiz está em como a consulta de seleção de itens (`fGetSQLJoins`, dentro de
`TfrmEntSelItensDevolucao`) vinculava `MOVDET` a `DETLOC`: o vínculo era feito por um `INNER JOIN`. Isso
significa que, sempre que a empresa está com o controle de localização por lote ativo, **todo item da
lista de devolução precisava ter um registro correspondente em `DETLOC`** — caso contrário, o item era
completamente excluído do resultado da consulta, e não apenas tratado como "sem localização".

A NF 000000207774 foi lançada **antes** da empresa adotar o controle de localização física por lote — logo,
nenhum dos seus itens tem registro em `DETLOC`. Com o `INNER JOIN`, a consulta de seleção retornava zero
linhas para o documento inteiro, e a tela interpretava "nenhum item disponível" como "tudo já foi
devolvido" — uma mensagem tecnicamente correta para a situação em que a consulta *de fato* não teria mais
itens, mas enganosa neste caso, em que a real causa era a ausência de dado histórico, não a devolução já
ter ocorrido.

## 3. Investigação realizada

1. Localizado o ponto exato da mensagem: `untEntDigPedido.pas`, na chamada a
   `frmEntSelItensDevolucao.blnTemItensDisponiveis` logo após `pCarregaCDSItens`.
2. Lida por completo a rotina de montagem da consulta de seleção (`fGetSQL`/`fGetSQLJoins`/`fGetSQLCampos`,
   `untEntSelItensDevolucao.pas`) e identificado que o `JOIN` com `DETLOC` é condicionado à mesma
   configuração (`UM1LFL` + `MANEND`) que determina se cada coluna da consulta (quantidade, lote, valores
   fiscais) deve ser recalculada proporcionalmente à localização física.
3. Confirmado, consultando diretamente o banco do cliente Intercores (leitura, sem alterar dados): a
   configuração `UM1LFL` está ativa para a empresa 001 (`CFGSIS.SIS_VALCFG = 'S'`), assim como `MANEND`.
4. Confirmado, para os 9 itens (`AUTOINCREM`) da NF 000000207774, que **nenhum tem registro em `DETLOC`**
   (`SELECT COUNT(*) FROM DETLOC WHERE DTL_INCDET IN (...)` retornou 0).
5. Confirmado, por informação direta do usuário, que a nota é anterior à adoção da configuração pela
   empresa — explicando por que nunca houve gravação de `DETLOC` para esses itens.
6. Avaliada uma correção adicional em `TfrmEntMercadorias.pAdicionaItem` (resolução da localização física
   da nova linha de entrada, `untEntMercadorias.pas`), inicialmente incluída no escopo e depois **revertida**
   — ver seção 4.
7. Investigado, à parte (pesquisa complementar, sem gerar alteração de código), como uma entrada normal de
   mercadoria com a mesma configuração ativa trata um lote ainda não definido: confirmado que o sistema não
   grava `DETLOC` nesse momento — apenas atualiza o saldo agregado por localização e gera um pedido de
   reserva de estoque para o endereçamento físico posterior. Esse conhecimento foi registrado à parte (ver
   seção 7) por ser relevante para quem mantiver esta área do sistema no futuro, não só para este requisito.

## 4. Abordagens consideradas e descartadas

- **Ajustar também `TfrmEntMercadorias.pAdicionaItem`** para resolver a localização física da nova entrada
  com um valor alternativo quando a localização por lote não estiver cadastrada — **incluída inicialmente
  no escopo, depois descartada**. Verificado que o caso real (NF 000000207774) não passa nunca por esse
  trecho: como a nota não tem lote gravado na venda original, a rotina de entrada já usa a localização
  padrão do cadastro do item por um caminho totalmente diferente, que nunca dependeu de `DETLOC`. Manter a
  alteração ali seria adicionar um comportamento sem uso real e sem garantia de estar correto para outras
  situações (a tabela de referência alternativa cogitada pertence a um esquema de localização diferente do
  usado quando o controle por lote está ativo). Revertida integralmente, código restaurado ao original.
- **Popular retroativamente `DETLOC`/localização física para documentos antigos** — descartado; foge do
  escopo de uma correção pontual e exigiria reprocessamento de dados histórico, sem necessidade funcional
  imediata.

## 5. Solução aplicada

Na consulta de seleção de itens (`fGetSQLJoins`/`fGetSQLCampos`, `untEntSelItensDevolucao.pas`), o vínculo
com a localização física do lote deixou de ser obrigatório: passou de um vínculo que **exige** o dado de
localização para um vínculo que **aproveita** o dado quando ele existe e, quando não existe, usa a
quantidade, o lote e os valores fiscais do documento de venda original — exatamente como já acontece para
uma empresa que não usa controle de localização física por lote.

Com isso, um item sem esse dado histórico volta a aparecer na lista de devolução, com os valores corretos
do documento original, sem alterar em nada o comportamento de itens que já têm a localização física
registrada.

### Arquivos alterados (mesmo diff aplicado em todas as cópias)

| Working copy | Status |
|---|---|
| `379.48.2.30.74.150` (origem da correção) | Alterado |
| `379.48.2.30.74.150.45` | Alterado (patch aplicado) |
| `379.48.2.30.74.150.100` | Alterado (patch aplicado) |
| `74.Fechadas\74.150.45.Fechadas\379.48.2.30.74.150.45.4` | Alterado (patch aplicado) |

Em todas: `padra_atualizado/fontes/movimentacaoitens/untEntSelItensDevolucao.pas`, funções
`fGetSQLJoins` e `fGetSQLCampos`. O mesmo diff (`svn diff`) foi conferido idêntico em todas as cópias
(código-base idêntico nesse trecho em todas elas), e o encoding cp1252/CRLF de cada arquivo foi validado
após a gravação (decodifica sem erro, sem marcador de corrupção UTF-8/`\xef\xbf\xbd`).

`untEntMercadorias.pas` foi alterado e depois **revertido** ao original nas mesmas 4 working copies — sem
diff pendente hoje (ver seção 4).

### Validação pós-implementação

Consulta direta ao banco do Intercores (leitura) confirmou os dados reais que motivaram e validaram a
correção: os 8 itens da NF 000000207774 têm `DET_TIP_FC='C'`, `DET_PROEMB='N'`, `DET_DOCDEV=NULL` (nenhuma
devolução registrada) e `DET_NUMLOT=NULL`; e nenhum dos 9 `AUTOINCREM` correspondentes tem registro em
`DETLOC`. Teste funcional da tela de seleção/entrada de devolução com essa nota específica fica pendente de
validação manual pelo usuário (fase de testes do `tasks.md`).

## 6. Decisões de escopo

**Incluído:** troca do vínculo obrigatório por vínculo opcional na consulta de seleção de itens para
devolução, aplicado nas 4 working copies acima.

**Excluído deliberadamente:**

- Ajuste em `TfrmEntMercadorias.pAdicionaItem` (revertido — ver seção 4).
- Popular retroativamente dados históricos de localização física para documentos antigos.
- Qualquer rotina de relatório/espelho de devolução que eventualmente também dependa do mesmo vínculo com
  `DETLOC` — não identificada nesta análise; revisitar se surgir.

## 7. Achados colaterais (fora de escopo, registrados para não serem esquecidos)

1. **Uma entrada normal de mercadoria (não devolução), com o mesmo controle de localização por lote ativo
   e lote ainda não definido, também não tem localização física registrada no momento da entrada** — o
   sistema atualiza só o saldo agregado e gera um pedido de reserva de estoque, deixando o registro
   definitivo de localização para quando o produto for de fato endereçado fisicamente. Ou seja, a ausência
   desse dado não é exclusiva de documentos antigos: pode acontecer também com itens correntes ainda não
   endereçados. Documentado em `IA\know\detloc_geracao_localizacao_fisica_lote.md` para consulta futura da
   equipe, por não ser conhecimento específico deste requisito.
2. **Qualquer outra rotina que vincule de forma obrigatória um documento de entrada/venda ao seu registro
   de localização física corre o mesmo risco identificado aqui** — não foi feito um levantamento
   sistemático de todas essas rotinas; se surgir um sintoma parecido em outra tela, vale revisitar o mesmo
   padrão de correção.

## 8. Ressalvas e lições

- **Cuidado ao expandir escopo de uma correção sem verificar se o cenário realmente ocorre**: a alteração
  em `TfrmEntMercadorias.pAdicionaItem` parecia, à primeira vista, necessária para fechar o mesmo problema
  "de ponta a ponta", mas na prática nunca era exercitada pelo caso real — só foi percebido ao questionar a
  suposição e conferir, dado a dado, qual caminho o código realmente segue para este documento específico.
  A correção foi revertida assim que isso ficou claro.
- **Validação direta no banco (leitura) foi decisiva** em cada etapa: para confirmar a ausência de
  devolução anterior, para confirmar a configuração ativa da empresa, e para confirmar a ausência do dado
  de localização física nos itens da nota — a skill `citel-conectarBanco` (modo leitura) permitiu validar
  cada hipótese com uma consulta real, sem depender de reproduzir a tela na aplicação Delphi.
- **Correção replicada em 4 working copies**, com verificação de encoding cp1252 pós-gravação em cada uma
  — nenhuma reintroduziu corrupção de caracteres.

## 9. Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit:** `padra_atualizado/fontes/movimentacaoitens/untEntSelItensDevolucao.pas`
**Função:** `TfrmEntSelItensDevolucao.fGetSQLCampos`, função interna `fRetCampo`

**Explicação completa:** quando a empresa usa controle de localização física por lote, cada valor fiscal
do item (IPI, ICMS, PIS/COFINS, frete, desconto, FCP-ST etc.) precisa ser recalculado proporcionalmente à
fração da quantidade total que está naquela localização específica — porque um mesmo item do documento
original pode estar fisicamente dividido entre mais de uma localização, e cada linha resultante da consulta
representa só uma dessas frações. Antes deste ajuste, esse cálculo proporcional dependia sempre de existir
o vínculo com a localização física; sem esse vínculo, o resultado da conta vinha vazio, e o item
desaparecia da lista de devolução (o problema deste requisito).

O ajuste faz o cálculo proporcional cair no valor cheio do campo (sem proporção nenhuma) sempre que não
houver vínculo de localização física para aquele item — que é exatamente o comportamento correto: sem
divisão entre localizações, a quantidade inteira do item pertence a uma única "fração", que é o total.

**Por que isso não é óbvio e por que uma revisão futura não deve simplesmente remover o tratamento
alternativo (revertendo para o cálculo proporcional puro):** o vínculo com a localização física deixou de
ser obrigatório justamente para não excluir itens sem esse dado histórico (documentos anteriores à adoção
do controle de localização, ou itens correntes ainda não endereçados fisicamente — ver seção 7). Se o
cálculo proporcional voltar a ser aplicado sem esse tratamento alternativo, o valor fiscal de todo item sem
localização física registrada viria vazio novamente, e o sintoma original ("todos os itens já devolvidos")
reapareceria mesmo com o vínculo já sendo opcional — porque o item apareceria na consulta, mas com valores
fiscais ausentes, quebrando o cálculo da devolução de outra forma.
