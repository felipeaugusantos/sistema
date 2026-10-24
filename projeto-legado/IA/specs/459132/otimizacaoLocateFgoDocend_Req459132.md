# Otimização — `FGO_DOCEND`: LOCATE → igualdade direta em `pValQtdEnderecada` (Req. 459132)

**Escopo:** pontual e independente das demais investigações do Req. 459132 (duplicação em
`DIGCON.DIC_QTDITE`, Hipótese #1 `FDO_QTDBAI` já descartada/revertida — ver
`conhecimentoUnitsInvestigadas_Req459132.md`). Aqui o tema é só a forma como `pValQtdEnderecada`
localiza o pedido de reserva vinculado ao documento de origem, via `FGO_DOCEND`.

**Zona:** Legado (`padra_atualizado/fontes/movimentacaoitens/`).

**Data:** 2026-09-03.

---

## 1. Contexto — como `FGO_DOCEND` é montado

Cadeia: `untPcmGer.fGerarPedidosReservaEstoque` → cria `objEnderecamento: TEnderecamentoProduto`,
seta `objEnderecamento.endDocumento` (record `TEndDocumento`: `strNumDoc/strEspDoc/strSerie_/strCodEmp/
strCliFor/strTip_FC`) → chama `objEnderecamento.fGerarPedidoParaReservarEstoque`.

Dentro dela, a procedure aninhada `fMarcaDocumentoEnderecamento`
([untEnderecamentoProduto.pas:1434-1449](../../../padra_atualizado/fontes/movimentacaoitens/untEnderecamentoProduto.pas))
grava o campo:

```pascal
function fMarcaDocumentoEnderecamento: Boolean;
var lAlias: String;
begin
  If blnResEstPenLotpre then
    lAlias := QuotedStr('PE' + strDocumento)
  Else If blnLibercaoAmazenamento then
    lAlias := 'NULL'
  Else
    lAlias := QuotedStr(strDocumento);
  Result := fExecutaSQL(' UPDATE EXTGOR SET FGO_DOCEND = ' + lAlias +
                        ' WHERE FGO_SEQFGO = ' + QuotedStr(FSeqFgo));
end;
```

Chamada em `fGerarPedidoParaReservarEstoque` (linha 1742): `Result := Result And fMarcaDocumentoEnderecamento;`.

`strDocumento` é a property `strDocumento` (getter `fGetStrEnderecamento`,
[untEnderecamentoProduto.pas:2720-2730](../../../padra_atualizado/fontes/movimentacaoitens/untEnderecamentoProduto.pas)):

```pascal
function TEnderecamentoProduto.fGetStrEnderecamento: String;
begin
  Result := '';
  Result := Result + fPadL(FDocume.strNumDoc , fTamNumDoc);
  Result := Result + fPadR(FDocume.strEspDoc , 02);
  Result := Result + fPadR(FDocume.strSerie_ , 03);
  Result := Result + fPadR(FDocume.strCodEmp , 03);
  Result := Result + fPadR(FDocume.strCliFor , 08);
  Result := Result + fPadR(FDocume.strTip_FC , 01);
end;
```

Ou seja, `FGO_DOCEND` (caso normal) é uma string de largura fixa — concatenação posicional de
`NumDoc(fTamNumDoc, pad à esquerda) + EspDoc(2) + Serie_(3) + CodEmp(3) + CliFor(8) + Tip_FC(1)`.
`fTamNumDoc` não é uma constante literal — é `RetornarTamanhoDoCampoNumeroDoDocumentoFat(...)`
(`untFuncoesSimples.pas:62916`), dependente de configuração/conexão (usualmente 12).

Essa decomposição bate com os `SUBSTRING(FGO_DOCEND, N, M)` já usados em várias queries do sistema
(posições 1-12/13-2/15-3/18-3/21-8/29-1 — assumindo `fTamNumDoc=12`), inclusive dentro da própria
`pValQtdEnderecada` (2ª query, ver seção 3).

**Casos especiais (fora do formato "normal"):**
- `blnResEstPenLotpre = True` → `FGO_DOCEND = 'PE' + strDocumento` (prefixo de 2 chars, desloca todas as
  posições subsequentes).
- `blnLibercaoAmazenamento = True` → `FGO_DOCEND = NULL`.

## 2. Estado anterior: por que `LOCATE` era usado

Em `TTransferenciaArmazens.pValQtdEnderecada`
([untTransferenciaArmazens.pas:2281](../../../padra_atualizado/fontes/movimentacaoitens/untTransferenciaArmazens.pas)),
a 1ª query (`qryPedidoEnderecamento`, existence check de pedido de reserva vinculado ao documento de
origem, antes desta mudança):

```pascal
qryPedidoEnderecamento.SQL.Add(' SELECT DEL_FATGOR.AUTOINCREM ');
qryPedidoEnderecamento.SQL.Add('   FROM DEL_FATGOR ');
qryPedidoEnderecamento.SQL.Add('   JOIN DEL_EXTGOR ON DEL_FATGOR.AUTOINCREM = DEL_EXTGOR.FGO_SEQFGO ');
qryPedidoEnderecamento.SQL.Add('  WHERE FGO_DOCEND IS NOT NULL ');
qryPedidoEnderecamento.SQL.Add('    AND FGO_DTAENT >= :DTAENT ');
qryPedidoEnderecamento.SQL.Add('    AND LOCATE(:DOCUME, FGO_DOCEND) ');
qryPedidoEnderecamento.ParamByName('DTAENT').AsDateTime := IncMonth(VS_Date, -12);
qryPedidoEnderecamento.ParamByName('DOCUME').AsString := endDocumento.strNumdoc + endDocumento.strEspdoc + endDocumento.strSerie_;
```

`:DOCUME` continha só 3 dos 6 campos (`NumDoc+EspDoc+Serie_`, sem padding de largura fixa) e era
localizado **como substring, em qualquer posição** de `FGO_DOCEND` via `LOCATE`. Isso tinha o efeito
colateral de tolerar o prefixo `'PE'` (o texto buscado continuava aparecendo dentro de
`'PE'+strDocumento`, só que deslocado 2 posições) — mas ao custo de uma comparação não-sargable
(função sobre a coluna, sem uso de índice) e de uma correspondência mais fraca (substring, não o
documento completo).

**Já existia, na 2ª query da mesma validação** (linhas ~2362-2393, comparação item a item de
`QTDAENDERECAR`), filtro por posições fixas e completas — `SUBSTRING(FGO_DOCEND,1,12)=:DOCEND`,
`(...,13,2)=:ESPEND`, `(...,15,3)=:SEREND`, `(...,18,3)=:EMPEND`, `(...,21,8)=:FOREND`,
`(...,29,1)=:TIPEND` — já assumindo o formato "normal" sem o prefixo `'PE'`. Ou seja, a 2ª query **já
não cobria** o caso `'PE'` antes desta mudança.

## 3. Mudança aplicada

Arquivo: `padra_atualizado/fontes/movimentacaoitens/untTransferenciaArmazens.pas`,
`TTransferenciaArmazens.fGeraTransferencia` → `pValQtdEnderecada`.

1. Adicionada variável local `strDocEnd: String`.
2. Antes da 1ª query, montada a string no mesmo formato de `fGetStrEnderecamento`:

```pascal
strDocEnd := fPadL(endDocumento.strNumdoc, fTamNumDoc) +
             fPadR(endDocumento.strEspdoc, 02) +
             fPadR(endDocumento.strSerie_, 03) +
             fPadR(endDocumento.strCodemp, 03) +
             fPadR(endDocumento.strCliFor, 08) +
             fPadR(endDocumento.strTip_FC, 01);
```

3. A 1ª query passou a comparar por igualdade direta:

```pascal
qryPedidoEnderecamento.SQL.Add(' SELECT DEL_FATGOR.AUTOINCREM ');
qryPedidoEnderecamento.SQL.Add('   FROM DEL_FATGOR ');
qryPedidoEnderecamento.SQL.Add('   JOIN DEL_EXTGOR ON DEL_FATGOR.AUTOINCREM = DEL_EXTGOR.FGO_SEQFGO ');
qryPedidoEnderecamento.SQL.Add('  WHERE FGO_DOCEND = :DOCFUL ');
qryPedidoEnderecamento.SQL.Add('    AND FGO_DTAENT >= :DTAENT ');
qryPedidoEnderecamento.ParamByName('DTAENT').AsDateTime := IncMonth(VS_Date, -12);
qryPedidoEnderecamento.ParamByName('DOCFUL').AsString := strDocEnd;
```

(Parâmetro renomeado de `DOCUME` para `DOCFUL` para não ser confundido com o `:DOCEND` já usado, com
significado diferente — só `NUMDOC` — na 2ª query da mesma procedure.)

4. Comentário curto no fonte + `Verificar Nota 1 - Req. 459132`.

Edição feita via Python (`io.open(..., encoding='cp1252', newline='')`), nunca pela ferramenta de edição
de texto genérica — arquivo em encoding legado (cp1252/CRLF). Validado após a gravação: decodifica sem
erro em cp1252, sem marcador de corrupção (`\xef\xbf\xbd`), e `svn diff` mostra exatamente (e só) as
linhas pretendidas alteradas.

## 4. Por que a mudança é segura (equivalência de comportamento)

- `WHERE FGO_DOCEND IS NOT NULL` deixou de ser necessário explicitamente: `FGO_DOCEND = :DOCFUL` já
  exclui `NULL` (comparação com `NULL` nunca é verdadeira em SQL), preservando o mesmo efeito prático do
  filtro anterior — casos com `blnLibercaoAmazenamento` (`FGO_DOCEND = NULL`) continuam de fora.
- Caso normal (`FGO_DOCEND = strDocumento`): a nova igualdade encontra exatamente os mesmos registros que
  o `LOCATE` encontrava, porque `strDocEnd` (6 campos, largura fixa) é um prefixo mais completo e mais
  específico do que `:DOCUME` (3 campos, sem padding) — qualquer registro que baterial com o `LOCATE`
  antigo (substring de 3 campos em qualquer posição) também bate com a igualdade nova (quando não há
  prefixo `'PE'`), e a igualdade é mais estrita, então não introduz falsos positivos que o `LOCATE` já
  não pudesse produzir.
- Caso `'PE'+strDocumento`: **decisão explícita do usuário — fora de escopo desta troca.** Um pedido nesse
  estado deixa de casar na 1ª query (antes casava via `LOCATE`, tolerante ao deslocamento). Isso **não é
  uma regressão de comportamento final observável**: a 2ª query da mesma validação já usava
  `SUBSTRING` posicional sem tolerar `'PE'` antes desta mudança (seção 2) — então um pedido `'PE'`
  já não completava a validação (não entrava na comparação de `QTDAENDERECAR`) mesmo quando passava
  pela 1ª query via `LOCATE`. O resultado final da trava (quais itens efetivamente são comparados e
  podem disparar a exceção de inconsistência) é o mesmo antes e depois desta mudança.
- Ganho: comparação sargable (potencial uso de índice em `FGO_DOCEND`, sem função sobre a coluna) e
  código mais claro/específico (usa exatamente a mesma composição de campos gravada por
  `fMarcaDocumentoEnderecamento`, em vez de uma substring parcial "mágica").

## 5. Decisões de escopo

**Incluído:** troca do `LOCATE` pela igualdade direta em `FGO_DOCEND` na 1ª query de
`pValQtdEnderecada`, montando a string no mesmo formato de `fGetStrEnderecamento`.

**Excluído deliberadamente** (decisão explícita do usuário — "e pValQtdEnderecada não me interessa o
'PE'"):
- Cobrir o caso `'PE'+strDocumento` (`blnResEstPenLotpre`) na 1ª query (ex.: `FGO_DOCEND IN (:DOCFUL,
  CONCAT('PE', :DOCFUL))`). Não implementado.
- Qualquer alteração na 2ª query da mesma procedure (já posicional/estrita, ver seção 2) ou em qualquer
  outra parte de `pValQtdEnderecada`/`fGeraTransferencia`.
- Qualquer correção relacionada à Hipótese #1 (`FDO_QTDBAI`) ou à causa raiz da duplicação em `DIGCON` —
  temas de outra frente de investigação, hoje sem alteração de código aplicada nesta working copy (ver
  `conhecimentoUnitsInvestigadas_Req459132.md`).

## 6. Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit:** `padra_atualizado/fontes/movimentacaoitens/untTransferenciaArmazens.pas`
**Função:** `TTransferenciaArmazens.fGeraTransferencia`, procedure aninhada `pValQtdEnderecada`.

**Explicação completa:** a 1ª query desta validação (existence check de pedido de reserva de estoque
vinculado ao documento de origem, via `DEL_FATGOR`/`DEL_EXTGOR.FGO_DOCEND`) usava `LOCATE(:DOCUME,
FGO_DOCEND)`, com `:DOCUME` = apenas `NumDoc+EspDoc+Serie_` (3 dos 6 campos que compõem `FGO_DOCEND`,
sem padding de largura fixa), localizado como substring em qualquer posição da coluna. Isso foi trocado
por uma igualdade direta (`FGO_DOCEND = :DOCFUL`), montando `:DOCFUL` com a mesma fórmula posicional de
largura fixa usada por `TEnderecamentoProduto.fGetStrEnderecamento`
(`fPadL(NumDoc,fTamNumDoc)+fPadR(EspDoc,2)+fPadR(Serie_,3)+fPadR(CodEmp,3)+fPadR(CliFor,8)+fPadR(Tip_FC,1)`)
— o mesmo formato gravado por `TEnderecamentoProduto.fMarcaDocumentoEnderecamento` quando marca o
documento de origem no pedido de reserva.

**Por que isso não é óbvio e por que uma revisão futura não deve reverter para `LOCATE` nem assumir que a
igualdade cobre 100% dos casos sem entender o contexto:** `FGO_DOCEND` pode conter um formato diferente
do "normal" — quando `TEnderecamentoProduto.blnResEstPenLotpre` está ativo (reserva de lote pré-venda),
`FGO_DOCEND` é gravado como `'PE'+strDocumento` (2 caracteres extras no início, deslocando todas as
posições subsequentes). A igualdade direta implementada aqui **não casa** com esse formato prefixado —
decisão explícita do usuário, por dois motivos: (1) o caso `'PE'` não é de interesse para esta correção;
(2) a **2ª query** desta mesma procedure (comparação item a item de `QTDAENDERECAR`, logo abaixo) já
usava posições fixas (`SUBSTRING(FGO_DOCEND,18,3)=:EMPEND` etc.) sem tolerar esse prefixo **antes** desta
mudança — ou seja, um pedido `'PE'`-prefixado já não completava a validação mesmo quando a 1ª query o
encontrava via `LOCATE`. Portanto, a troca para igualdade não introduz uma regressão nova: o
comportamento final observável da trava (quais itens efetivamente entram na comparação de quantidade)
é o mesmo antes e depois. Se no futuro for necessário que `pValQtdEnderecada` também valide pedidos com
reserva de lote pré-venda (`'PE'`), será preciso tratar esse prefixo explicitamente nas duas queries (não
só reverter esta para `LOCATE`) — ver detalhes completos em
`IA/specs/459132/otimizacaoLocateFgoDocend_Req459132.md`.

## 7. Referências cruzadas

- `correcaoDuplicacaoDigconEnderecamento_Req459132.md` — Notas 2, 3 e 4 (mesmo requisito),
  continuando a numeração a partir da Nota 1 deste arquivo: causa raiz da duplicação em
  `DIGCON.DIC_QTDITE` e correção completa de `pValQtdEnderecada` (a mesma procedure desta Nota 1),
  incluindo a subtração de `FDO_QTDBAI` e o `UNION ALL` contra tabelas vivas quando `CFG_COFEND`/
  `CFG_UDEVME` ativos.
- `investigacao_historico_Req459132.md` (Passo 6) — registro cronológico desta sessão dentro do
  histórico de investigação do requisito.
- `conhecimentoUnitsInvestigadas_Req459132.md` — decodificação original do formato `FGO_DOCEND` (seção
  "Decodificação do formato FGO_DOCEND") e estado real do código (Hipótese #1/`FDO_QTDBAI` descartada e
  revertida — **não confundir** com a mudança documentada aqui, que é independente e está aplicada).
- `spec.md`/`plan.md`/`tasks.md`/`validacaoDivergenciaEnderecamento_Req459132.md` — documentação da
  frente de investigação anterior (Hipótese #1), hoje desatualizada quanto à causa raiz conforme o
  próprio `conhecimentoUnitsInvestigadas_Req459132.md` registra; não tratam desta mudança.
