# Análise Técnica — Req. 462266

## 1. Contexto de negócio

O cliente COMAX Atacado (LJ001) importa, do sistema ERP anterior, notas de entrada de mercadoria cujo único propósito é
viabilizar a emissão de uma devolução — não representam uma entrada de estoque real. Esse tipo de documento é
identificado pela finalidade XML "Entrada Mercadorias sistema anterior p/ emissão de devolução"
(`GERELE.GER_TIPXML = 4`, enum `tpeFinalidadeXML.xmlEntradaMercadoriasSistemaAnteriorDevolucao`, declarado em
`untTypesSistema.pas`).

Esse tratamento já existe na tela de Entrada de Mercadorias (`TfrmEntMercadorias`, unit
`padra_atualizado/fontes/movimentacaoitens/untEntMercadorias.pas`): a função `fVerificaDataBalanco` (linha ~10590) sai
imediatamente (`Exit`) quando `recNotEle.finalidadeXML = xmlEntradaMercadoriasSistemaAnteriorDevolucao`, sem aplicar a
validação de data de venda x data de balanço, justamente porque esse tipo de documento não gera movimentação real e
não deve ser comparado contra o saldo/balanço do item.

## 2. Problema identificado

A tela de Cancelamento de Documentos (`TfrmCancelamentoDocumentos`, unit `untCancelamentoDocumentos.pas`) possui uma
validação equivalente — `fVerificaSalBal` — que impede o cancelamento de um documento quando algum item tem
`MOVDET.DET_DTAENT` anterior à data de balanço do item (`fRetDataSalBal`). Diferente da tela de Entrada de
Mercadorias, essa função não tinha nenhuma exceção para documentos de finalidade "sistema anterior p/ devolução",
porque ela é chamada a partir da tela de cancelamento apenas com `strEspSel`, `strNumDoc` e `strCodCli` — sem acesso
direto ao registro `recNotEle` que carrega a finalidade XML.

Isso fez com que o cancelamento da NF de entrada nº 883370 (COMAX, LJ001), um documento desse tipo, fosse bloqueado
pela mensagem "Cancelamento não permitido pois documento possui itens em que a data de venda é menor que o balanço!",
mesmo sendo um documento sem movimentação real de estoque.

O cancelamento dessa NF era necessário porque o cadastro do produto (aba "Embalagens") estava com a quantidade de
embalagem incorreta no momento da importação, o que gerou precificação incorreta na devolução — a correção definitiva
exige reimportar o documento, e para isso o documento incorreto precisa primeiro ser cancelado. A causa raiz dessa
precificação incorreta (o cadastro da embalagem) não faz parte desta correção.

## 3. Alteração realizada

Na função `fVerificaSalBal`, quando o documento em cancelamento é uma Nota de Entrada (`strEspSel = 'NE'`), o sistema
passou a consultar a tabela `GERELE` (tabela de controle de documentos eletrônicos de entrada) para obter o
`GER_TIPXML` do documento antes de aplicar a validação de data de balanço. Quando `GER_TIPXML` corresponde à
finalidade "Entrada Mercadorias sistema anterior p/ emissão de devolução" (valor 4), a validação de balanço é
ignorada e o cancelamento é liberado normalmente — replicando, no cancelamento, a mesma exceção que já existe na
Entrada de Mercadorias.

Para qualquer outra situação — outra finalidade XML no mesmo documento `NE`, ausência de registro em `GERELE`, ou
qualquer outra espécie de documento (`OF`, `NF`, `TE`, etc.) — o comportamento de validação permanece exatamente como
era antes desta alteração.

## 4. Novo funcionamento

Ao tentar cancelar uma Nota de Entrada originada de importação do sistema anterior para emissão de devolução, o
usuário não recebe mais o bloqueio por data de balanço, podendo concluir o cancelamento e reimportar o documento com
os dados corrigidos. Para as demais Notas de Entrada — aquelas que representam movimentação real de estoque — a
trava de segurança contra cancelamento de itens já vendidos após o balanço continua funcionando sem alteração.

## 5. Impacto funcional

O ajuste resolve o bloqueio relatado pelo cliente COMAX sem afetar a regra de negócio original: a validação de data
de balanço continua protegendo o estoque real contra inconsistências de cancelamento tardio; apenas os documentos que
comprovadamente não representam movimentação real (finalidade 4) passam a ser tratados como já são na Entrada de
Mercadorias.

## 6. Replicação para outras cópias de trabalho

A mesma correção foi replicada em duas outras cópias de trabalho onde a validação reside em unit diferente:

| Cópia | Unit | Função |
|-------|------|--------|
| `379.48.2.30.74.150` | `untCancelaDocumentosValidacoes.pas` | `fVerificaSalBal(const strEspSel, strNumDoc, strCodCli, strEspecieCancelamento: String; var strMessage: String): Boolean` |
| `379.48.2.30.74.150.100` | `untCancelaDocumentosValidacoes.pas` | `fVerificaSalBal(const strEspSel, strNumDoc, strCodCli, strEspecieCancelamento: String; var strMessage: String): Boolean` |

Nessas duas cópias, a unit `untCancelaDocumentosValidacoes.pas` não possuía `untTypesSistema` no `uses` — unit que
declara o enum `tpeFinalidadeXML` e a constante `xmlEntradaMercadoriasSistemaAnteriorDevolucao`. Foi adicionada ao
`uses` da unit nas duas cópias para viabilizar a mesma checagem.

Diferença de adaptação em relação à unit principal (`untCancelamentoDocumentos.pas`): nessas cópias a função já
recebe a espécie de cancelamento resolvida via parâmetro `strEspecieCancelamento`, então o join com `GERELE` usa esse
parâmetro diretamente em vez de chamar `fRetornaEspecieCancelamento(strEspSel)` (função que não existe nessa unit).

## 7. Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit e função:**
- `padra_atualizado/fontes/cancelamento/untCancelamentoDocumentos.pas`, função `TfrmCancelamentoDocumentos.fVerificaSalBal`
- `379.48.2.30.74.150/padra_atualizado/fontes/cancelamento/untCancelaDocumentosValidacoes.pas`, função `fVerificaSalBal`
- `379.48.2.30.74.150.100/padra_atualizado/fontes/cancelamento/untCancelaDocumentosValidacoes.pas`, função `fVerificaSalBal`

**Explicação completa:** o bloco de consulta a `GERELE` inserido logo após o filtro de espécies de documento (`Pos(strEspSel,
'NE_OF_...') <= 0 Then Exit`) parece, à primeira vista, uma validação redundante ou desnecessária para quem só olhar o
restante da função — que segue validando `MOVDET.DET_DTAENT` contra a data de balanço normalmente. O motivo de essa
consulta existir especificamente para `strEspSel = 'NE'`, e especificamente checando `GER_TIPXML = 4`, é que
documentos de Entrada de Mercadoria importados do sistema anterior apenas para viabilizar uma devolução (finalidade
XML "Entrada Mercadorias sistema anterior p/ emissão de devolução") não geram movimentação real de estoque — a mesma
premissa que já existe, para essa mesma finalidade, na tela de Entrada de Mercadorias
(`TfrmEntMercadorias.fVerificaDataBalanco`, `untEntMercadorias.pas:10590`, que dá `Exit` na mesma condição). Sem essa
exceção, o cancelamento desse tipo de documento é bloqueado indevidamente pela mensagem de data de balanço, mesmo
quando o documento não corresponde a uma venda/movimentação real que justificasse a trava. Se essa checagem for
removida em uma limpeza futura por parecer "código morto" ou redundante, o bug de bloqueio indevido no cancelamento
de documentos de devolução do sistema anterior será reintroduzido (foi exatamente o comportamento relatado pelo
cliente COMAX na NF 883370, que motivou a abertura deste requisito).

## 8. Achados colaterais não corrigidos nesta sessão

- A causa raiz da precificação incorreta na devolução (quantidade incorreta cadastrada na aba "Embalagens" do
  produto) não foi corrigida — está fora do escopo deste requisito, que trata apenas do bloqueio de cancelamento.
  Deve ser tratada separadamente pelo cliente/suporte, ajustando o cadastro do produto antes de reimportar o
  documento.

## 9. Decisões de escopo

- Não foi alterado o comportamento de `TfrmEntMercadorias.fVerificaDataBalanco` — essa função já trata corretamente o
  cenário e serviu apenas de referência de comportamento esperado.
- Não foi criada uma função utilitária compartilhada entre `untCancelamentoDocumentos.pas` e
  `untEntMercadorias.pas`/`untCancelaDocumentosValidacoes.pas` para essa checagem — cada unit manteve o padrão de
  consulta SQL embutida já usado localmente (`strSQL` + `TUniQuery`), consistente com o padrão de código legado do
  projeto (sem ORM, sem abstração adicional para uma checagem pontual).

## 10. Detalhamento técnico do mecanismo aplicado

- **Tabela consultada:** `GERELE` (registros de documentos eletrônicos de entrada).
- **Campos usados no `WHERE`:** `GER_ESPENT` (espécie do documento, resolvida via `fRetornaEspecieCancelamento` ou
  recebida por parâmetro conforme a unit), `GER_DOCENT` (número do documento), `GER_EMPENT` (código da empresa),
  `GER_CODFOR` (código do fornecedor — para `NE`, `strCodCli` já representa o fornecedor, conforme a função auxiliar
  `fRetSQLCodCli` já existente na mesma unit), e `B07_SERIE` (série do documento, com `IFNULL(B07_SERIE, '') = :SERIE`
  porque a coluna pode ser nula).
- **Padrão de join replicado:** o mesmo conjunto de colunas (`GER_ESPENT`/`GER_DOCENT`/`GER_EMPENT`/`GER_CODFOR`/
  `B07_SERIE`) já é usado para relacionar `GERELE` a `MOVDET`/documentos de entrada em outros pontos do projeto
  (`fRetAutoIncremGerEle`, na mesma unit — que também trata `B07_SERIE` com `IFNULL`; `untConsultas.pas:16148`;
  `TestShared.Functions.SQL.pas:107`) — não foi inventado um novo padrão de relacionamento, apenas reaproveitado o já
  validado no projeto. A inclusão da série evita casar o documento em cancelamento com um registro de `GERELE` de
  outra série que, por coincidência, tenha o mesmo número de documento.
- **Impacto de assinatura:** como `fVerificaSalBal` não recebia a série do documento, foi necessário acrescentar um
  novo parâmetro `strSerie` à função (nas três units alteradas) e propagá-lo a partir do único ponto de chamada de
  cada projeto (`strSerieSel` em `untCancelamentoDocumentos.pas`; `FInput.strSerie` em `untCancelaDocumentos.pas` nas
  duas réplicas).
- **Valor de negócio verificado:** `GER_TIPXML = 4` corresponde ao enum `tpeFinalidadeXML.xmlEntradaMercadoriasSistemaAnteriorDevolucao`
  (`untTypesSistema.pas`). Na comparação, foi usado `Ord(xmlEntradaMercadoriasSistemaAnteriorDevolucao)` em vez do
  literal `4`, para manter a leitura ligada ao enum nomeado.
- **Ausência de registro em `GERELE`:** se a consulta não retornar nenhuma linha (`IsEmpty = True`), o código não
  interrompe a função — segue para a validação de balanço normal (`MOVDET`/`fRetDataSalBal`), preservando o
  comportamento anterior nesse cenário.
