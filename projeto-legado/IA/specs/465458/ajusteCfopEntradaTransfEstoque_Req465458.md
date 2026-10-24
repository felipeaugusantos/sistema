# Análise — Req. 465458 — CFOP de entrada inválido na entrada de transferência de estoque

## 1. Contexto de negócio
Na entrada de transferência de estoque (`untRecTransfEstoque.pas`, `TfrmRecTransfEstoque`), o CFOP de entrada de cada item é
derivado do CFOP com que a nota foi emitida pela empresa de origem. Quando a entrada é uma devolução (`FblnDevolu = True`), a
contraparte é tratada como cliente (`strCliFil`, tipo 'C') e não como fornecedor.

A conversão é feita por `fTrocaClaFis`, que delega a `pDeterminaClafis` (`untFuncoesGenerica.pas`). Se o resultado tiver menos
de 4 caracteres, a entrada é abortada e o log registra: "Foi encontrado uma falha ao definir o CFOP da Entrada. Favor, verificar
no cadastro da empresa de origem ... as classificações de entrada definidas na Aba 2 - Configuração de Transf. de Estoque".

## 2. Problema e causa raiz
Caso reportado: Documento 000000102401-NF-003-1, Fornecedor 00067813, empresa de origem 003 - ABRAFER COMERCIAL LTDA, documento
emitido com CFOP 5209, `FblnDevolu = True`.

Dois pontos contribuíam para o CFOP inválido:

1. `pDeterminaClafis`, ramo `blnForFil = True`: após a troca via arrays de exceção (`arrClaSai`/`arrClaEnt`), o código sempre
   fazia `'1' + RightStr(strClaFis, 3)` (ou `'2' + ...`). Com `strClaFis` vazio (por exemplo, exceção mapeada para vazio), o
   resultado era `'1'` ou `'2'` (1 caractere). Como o resultado não ficava vazio, o fallback de `fTrocaClaFis` também não atuava,
   e a validação `Length < 4` abortava a entrada.
2. `fTrocaClaFis`, fallback de devolução (`FblnDevolu` e `Result` vazio): só era acionado com `Result` vazio (um `Result` de 1
   caractere não o acionava) e só mapeava 5401, 5405, 6401 e 6405. O CFOP 5209
   (e 6209) ficava sem correspondência de entrada.

Observação: a causa exata do valor vazio no caso 5209 depende do cadastro da empresa 003 e não foi reproduzida em banco nesta
sessão; a correção cobre o comportamento de forma genérica.

## 3. Solução aplicada
| Unit | Rotina | Alteração |
|------|--------|-----------|
| `padra_atualizado/fontes/genericos/untFuncoesGenerica.pas` | `pDeterminaClafis` (ramo `blnForFil`) | Prefixo '1'/'2' só é aplicado se `strClaFis` não for vazio e tiver exatamente 4 caracteres. Caso contrário, mantém o valor e deixa o fluxo/fallback seguir. |
| `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas` | `TfrmRecTransfEstoque.fTrocaClaFis` | Fallback passou a ser acionado também quando `Length(Result) < 4`. `Case AnsiIndexStr` do fallback passou a incluir '5209' → '1209' e '6209' → '2209', além de 5401→1410, 5405→1411, 6401→2410, 6405→2411. |

Código resultante em `pDeterminaClafis`:

```pascal
{So monta o CFOP de entrada se strClaFis tiver 4 posicoes. Req. 465458}
If (Not fEmptyStr(strClaFis)) And (Length(strClaFis) = 4) Then
Begin
  If (strEstFor = strEmpEst) Or blnPresencial Then
    strClaFis := '1' + RightStr(strClaFis, 3)
  Else
    strClaFis := '2' + RightStr(strClaFis, 3);
End;
```

Código resultante em `fTrocaClaFis`:

```pascal
if FblnDevolu and (fEmptyStr(Result) or (Length(Result) < 4)) then
begin
  Case AnsiIndexStr(strClaFis, ['5401', '5405', '6401', '6405', '5209', '6209']) Of
    0 : Result := '1410';
    1 : Result := '1411';
    2 : Result := '2410';
    3 : Result := '2411';
    4 : Result := '1209';
    5 : Result := '2209';
  End;
end;
```

## 4. Decisões de escopo
- Guard aplicado somente no ramo `blnForFil = True` (decisão do usuário). O trecho `IIF(strEstFor = fCadEmp('ESTADO'), '1', '2')
  + RightStr(...)` da rotina (bloco `Not blnDevolu`, ~linha 13116) não foi alterado.
- O pedido original citava os CFOPs 5902/6902, informados por engano; foram corrigidos para os CFOPs corretos 5209 (→ 1209) e 6209 (→ 2209). Os CFOPs 5902/6902 não foram incluídos.
- Replicado nas working copies `379.48.2.30.74.150` e `379.48.2.30.74.150.100` (além da `74.150.45`).
- O comentário curto no fonte de `fTrocaClaFis` foi removido a pedido do usuário; o comentário de `pDeterminaClafis` permanece.
- Condição do fallback: usado `Length(Result) < 4` (e não `Length(strClaFis)`), pois `strClaFis` é o CFOP de saída de entrada e o
  valor inválido é o `Result` vindo de `pDeterminaClafis`.
- Alinhamento (indentação) da chamada `pDeterminaClafis(Result, ...)`, do `If Result = '' Then` e do `End;` do `Case` ajustado na
  `74.150.45` (pelo usuário) e replicado nas outras duas cópias; `fTrocaClaFis` ficou idêntica nas três.
- Nenhum comentário do fonte exigiu "Nota N": as explicações são curtas e autoexplicativas.

## 5. Ressalvas
- `pDeterminaClafis` é genérica (usada em outras telas). O guard só muda o caso em que `strClaFis` é vazio ou com tamanho diferente
  de 4, que antes já gerava CFOP inválido no ramo `blnForFil`.
- Se o `Result` voltar com menos de 4 caracteres e o CFOP de saída não estiver na lista do `Case`, o `Result` continua inválido e a
  validação `Length < 4` ainda aborta a entrada.
- O diff SVN inclui também linhas só de alinhamento (chamada `pDeterminaClafis`, `If Result = '' Then`, `End;` do `Case`).
- Não foi executada compilação nem teste em ambiente Delphi; a validação funcional (CFOP 5209, 6209 e regressão dos CFOPs
  anteriores) está pendente na Fase 3 do `tasks.md`.

## 5.1 Alteração pré-existente fora do escopo (log de falhas do gravamento do movimento)
Na `74.150.45`, `untRecTransfEstoque.pas` (ramo de gravação do movimento, ~linhas 2225-2250), havia alteração local pré-existente,
sem relação com o CFOP, incluída junto com este requisito por decisão do usuário. A `74.150` já continha a mesma alteração
(feita pelo usuário) e ela foi replicada na `74.150.100`, nos mesmos três blocos.

- Três blocos de falha passaram a chamar `TGeraLogAutEnt.RegistraLog` sempre (antes só com `blnAutEnt`) e, na entrada manual
  (`Not blnAutEnt`), chamam `TGeraLogAutEnt.Finaliza` em seguida. Condições afetadas:
  - `blnMarNeg And (Not blnGerarLotePrecos) And (Not fGravaMovDet(True))`
  - `(fltOscMed > 0) And blnAtuMed And (Not fGravaMovDet(False, True))`
  - `fGeraAgendamento And (not fValidaTransportadoraAgendamento)`
- No terceiro bloco, o `fMensagem` que avisava sobre a transportadora ("CFG_TRASUG" sem transportadora válida) foi removido. A
  mensagem passou a ser registrada no log.
- Remoção do `fMensagem` é intencional (confirmado pelo usuário): o `Finaliza` exibe o log ao usuário, e só deixa de exibir quando a
  configuração de gravação de log está ativa. Essa configuração só é ativada quando é necessário gravar o log, e a análise técnica
  consulta o log nesse caso.
- Texto das mensagens de log mudou de "falhou nessa condição" para "falha nessa condição" (e "falha na condição" no terceiro).

## 5.2 Alteração pré-existente fora do escopo (Raise do cálculo de PIS/COFINS na entrada simplificada)
`TCalculoPisCofins.fCalculoPisCofins` (`untCalculoPisCofins.pas`) gera `Raise Exception` ("Abreviação de PIS/COFINS não configurada...")
quando `blnGerarException` é True ou `fInTransaction()` é True. Em `untRecTransfEstoque.pas` as duas chamadas (`fGravaNotDetEsp` e
`fGravaMovDet`) setam `blnGerarException := True` e rodam dentro de transação, então o Raise sempre ocorria e interrompia a entrada.

- Primeira tentativa (descartada): envolver as chamadas em `Try/Except` no `untRecTransfEstoque.pas`. O usuário apontou que o Raise é
  gerado dentro de `untCalculoPisCofins`, então o tratamento precisa estar nela; revertida.
- Solução: `TCalculoPisCofins` ganhou o campo público `prcRegistraErro` (tipo `TProcErroCalculo`, `Reference To Procedure(strMsg: String)`).
  Nos quatro pontos de erro de abreviação de PIS/COFINS (saída e entrada), se `prcRegistraErro` estiver atribuído, a mensagem é
  enviada a ele (sem Raise e sem pop-up) e a função sai com `Result.blnResult := False`; caso contrário, o comportamento anterior é mantido
  (Raise se `blnGerarException` ou `fInTransaction()`, senão mensagem). Por isso as demais telas não mudam.
- Em `untRecTransfEstoque.pas` (`fGravaNotDetEsp` e `fGravaMovDet`), antes da chamada, `tmp.prcRegistraErro` recebe um método anônimo que
  chama `TGeraLogAutEnt.RegistraLog`. O fluxo existente (`Result := CalcResult.blnResult; If Not Result Then Break;`) interrompe o
  loop, o chamador faz `fRollBack` e, quando `Not blnAutEnt`, `TGeraLogAutEnt.Finaliza` exibe a mensagem ao final.
- `untCalculoPisCofins.pas` é compilada também para Linux, por isso usa callback em vez de referenciar `TGeraLogAutEnt` diretamente.
- Aplicada nas 3 cópias (74.150.45, 74.150, 74.150.100).

## 5.3 Alteração pré-existente fora do escopo (devolução com CFOP fora de CFG_CLADEV/CFG_CLADVC)
Na lista da entrada simplificada (`untEntradaSimplificada.pas`), um documento recebe `TIPSEN = 'DEVOLU'` se algum item tiver `DET_DOCDEV`
preenchido OU `DET_CLAFIS` dentro de `CFG_CLADEV`+`CFG_CLADVC`. Já `TRecTransfEstoqueDevolucao.fExecutar` (que define `FblnDevolu`) exige
`MOVDET.DET_CLAFIS` dentro de `VS_strClaDev + VS_strClaDVC`. Se o CFOP do documento (ex.: 5209) não estiver nessas configurações,
`FblnDevolu` fica False, a entrada segue como transferência normal e só falha adiante com "Registro do Livro Fiscal não encontrado para
o documento ...", sem indicar o motivo. `FblnDevolu` só é conhecido depois do SELECT do `fExecutar`, por isso a detecção usa `TIPSEN`.

- Solução: em `TfrmRecTransfEstoque.pAddListaQuery`, ao marcar o documento (`Not fInLista`), se `TIPSEN = 'DEVOLU'` e `Not FblnDevolu`,
  a função local `fCfopForaDaConfigDevolucao` lê os `DET_CLAFIS` do documento em `MOVDET` (`DET_SEQGER = AUTOINCREM`); se nenhum estiver
  em `VS_strClaDev + VS_strClaDVC`, informa o documento e os CFOPs ("... é uma devolução, mas o CFOP X não está cadastrado nas
  classificações de devolução (CFG_CLADEV/CFG_CLADVC)!") e sai sem marcar. Na entrada automática (`blnAutEnt`), a mensagem vai para o log.
- Ressalva: se `FblnDevolu` for False por outro motivo (CFOP configurado, mas documento de origem da devolução não localizado), a
  validação não age e o comportamento anterior é mantido.
- Aplicada nas 3 cópias (74.150.45, 74.150, 74.150.100).

## 5.4 Alteração pré-existente fora do escopo (TGeraLogAutEnt.Inicializa no início das rotinas e Finaliza nas saídas antecipadas)
Em `untRecTransfEstoque.pas`, o `TGeraLogAutEnt.Inicializa` (somente `Not blnAutEnt`) ficava no meio de `fGeraEntradaEspecial` e de
`fGeraEntrada`, depois de várias validações. Por isso os `RegistraLog` das falhas anteriores a ele (ex.: itens da seção 5.1) eram
descartados silenciosamente na entrada manual (`RegistraLog` é no-op quando o log não foi inicializado).

- O `Inicializa` foi movido para a primeira instrução das duas rotinas, mantendo a condição `Not blnAutEnt`. Na entrada automática
  (`blnAutEnt`) o `Inicializa`/`Finaliza` são feitos em `untPrincipal.pas` (~linhas 7178-7188), em volta de `pGeraEntradaTransfEstoque`.
- Com o log aberto desde o início, as saídas antecipadas da entrada manual passaram a chamar `TGeraLogAutEnt.Finaliza` (`Not blnAutEnt`),
  para não deixar `INICIO` sem `FIM` em `LOGAUTENT` nem o `qry` ativo no modo banco (`LAUTET <> 'N'`; no modo memória não havia efeito):
  - `fGeraEntradaEspecial`: documento já baixado (`fVerificaConfBaixada`) e falha em `fMontaDuplicatas`.
  - `fGeraEntrada`: pedido já baixado (`fVerificaTransfBaixada`), trava de data de meses anteriores (ramo manual),
    falha em `fMontaDuplicatas` e "já foi dada a entrada do documento".
- Na saída "já foi dada a entrada", o `RegistraLog` passou a ocorrer só com `blnAutEnt` (no manual chama `Finaliza`). Motivo: na entrada
  manual ele antes não registrava nada (log não inicializado); sem a condição, o `Finaliza` abriria o popup "Erros relatados" no modo memória.
- Tratadores `On E: ExceptionLotesADefinir` de `fGeraEntradaEspecial` e `fGeraEntrada`: passaram a chamar `Finaliza` (`Not blnAutEnt`) após o
  `pMensagemSonora`. Com o `Inicializa` no início, essa exceção (ex.: vinda de `fGravaMovDet`) acontece com o log aberto e deixaria o `qry`/`Conexao`
  alocados; no modo banco o `Inicializa` do documento seguinte sairia em `if Assigned(qry) then Exit` e os logs iriam para o registro do anterior.
- Caminho de sucesso (pré-existente: nunca chamava `Finaliza`): criado o método `TGeraLogAutEnt.Encerra` (`untTGeraLogAutEnt.pas`), que só limpa e
  encerra sem exibir nada. Modo banco: grava `FIM`, libera `qry` e `Conexao`. Modo memória: libera a lista e zera o modo (sem popup, igual ao
  comportamento anterior). Sem log aberto: não faz nada. Chamado em `fGeraEntradaEspecial` e `fGeraEntrada` (`Result And Not blnAutEnt`, antes de
  `pLimparArrDadLivFull`), cobrindo o sucesso e o sucesso com `blnTransacaoExterna`. Evita que, na seleção de vários documentos
  (`fGeraEntradaMercadorias`), o log inteiro caia no primeiro documento.
- Ressalva: em `fGeraEntradaEspecial`, com `blnTransacaoExterna = True` e falha, não há rollback nem `Finaliza` (ficam dentro de `If Not
  blnTransacaoExterna`), então o log segue aberto; pré-existente e não tratado.
- Aplicado nas 3 cópias (74.150.45, 74.150, 74.150.100). Testado manualmente pelo usuário, sem problemas.

## 6. Lições de ferramenta/processo
- Arquivos `.pas` em cp1252 + CRLF: edição feita via Python com `newline=''`, sem uso da ferramenta `Edit`. Verificado ausência de
  U+FFFD e diff limitado às linhas pretendidas.
- As três working copies diferiam sutilmente (indentação do `End;`); a aplicação foi precedida de contagem de ocorrências para
  garantir uma única correspondência por arquivo.

## 7. Notas Referenciadas no Código-Fonte

### Nota 1
Arquivo: `padra_atualizado/fontes/genericos/untCalculoPisCofins.pas` — tipo `TProcErroCalculo` e campo `prcRegistraErro` de `TCalculoPisCofins`.

`TCalculoPisCofins.fCalculoPisCofins` gerava `Raise Exception.Create(strMsgErro)` em 4 pontos (quando `blnGerarException Or fInTransaction()`).
Na entrada simplificada esse Raise abortava o processo sem registro no log (`TGeraLogAutEnt`), e o usuário só via a falha genérica adiante.
O Raise acontece dentro da própria unit, por isso um `Try/Except` nos pontos de chamada (`untRecTransfEstoque.pas`) não resolve (tentativa feita e
descartada). A solução é um callback: `prcRegistraErro` (`Reference To Procedure(strMsg: String)`), `nil` no `Create`. Nos 4 pontos, se
`Assigned(prcRegistraErro)` a mensagem é entregue ao callback e o Raise não é gerado; senão vale o comportamento anterior (Raise ou atribuição
de `strMsgErro`). Um callback, e não uma chamada direta a `TGeraLogAutEnt.RegistraLog`, porque `untCalculoPisCofins.pas` também é compilada
para Linux (serviços) e não pode depender de `untTGeraLogAutEnt` (VCL). Quem chama define o destino: `fGravaNotDetEsp` e `fGravaMovDet`
(`untRecTransfEstoque.pas`) atribuem um procedure anônimo que chama `TGeraLogAutEnt.RegistraLog`. Os demais chamadores não atribuem o callback
e mantêm o comportamento anterior. Não remover o campo nem os `If Assigned`, sob pena de voltar o Raise na entrada simplificada.

### Nota 2
Arquivo: `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas` — `fGravaNotDetEsp` e `fGravaMovDet`, atribuição de `prcRegistraErro`.

O callback só é atribuído `If Not fTranferenciaAutomaticaFulfillment`. Na transferência automática Fulfillment o erro de PIS/COFINS precisa continuar gerando `Raise`: os tratadores de exceção (`Raise Exception.Create(E.Message)` quando `fTranferenciaAutomaticaFulfillment`) propagam a falha ao chamador. Se o callback fosse atribuído, o erro seria consumido pelo log (`TGeraLogAutEnt.RegistraLog`), `fCalculoPisCofins` devolveria só `blnResult = False` e a mensagem se perderia, pois o Fulfillment não exibe o popup do log. Fora do Fulfillment o comportamento é o da Nota 1 (erro registrado no log). Não remover essa condição, sob pena de o Fulfillment perder a mensagem de erro.

### Nota 3
Arquivo: `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas` — `fGeraEntrada`, tratador `On E: Exception`, ramo `fTranferenciaAutomaticaFulfillment`.

Com o `TGeraLogAutEnt.Inicializa` movido para o início da rotina, todo caminho de exceção passa a ter o log aberto. O ramo Fulfillment fazia `Raise Exception.Create(E.Message)` antes do `Finaliza` do fim do tratador, então o `Raise` pulava a liberação: no modo banco (`LAUTET <> 'N'`) `qry`/`Conexao` ficavam alocados e o `Inicializa` do documento seguinte saía em `if Assigned(qry) then Exit`, jogando os logs no registro anterior; no modo memória a `FListaLog` ficava sem liberar. Corrigido chamando `TGeraLogAutEnt.Encerra` (se `Not blnAutEnt`) imediatamente antes do `Raise`. Usado `Encerra` e não `Finaliza` porque, no modo memória, o `Finaliza` abriria o popup "Erros relatados" em um fluxo automático cujo erro já é propagado ao chamador; o `Encerra` apenas libera (modo banco grava 'FIM'). `fGeraEntradaEspecial` não tem esse problema (não há `Raise` no seu tratador).

### Nota 4
Arquivo: `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas` — `fGeraEntradaEspecial` e `fGeraEntrada`, posição do `TGeraLogAutEnt.Inicializa`.

O `Inicializa` havia sido movido para a primeira instrução das rotinas, mas ainda antes de código fora do `Try` (`fVerificaConfBaixada` em `fGeraEntradaEspecial`; `pPreparaFlagsDevolucao` em `fGeraEntrada`). Uma exceção nesses trechos não passa pelos tratadores que chamam `Finaliza`/`Encerra`, deixando `qry`/`Conexao` abertos no modo banco (`LAUTET <> 'N'`): o `Inicializa` do documento seguinte saía em `if Assigned(qry) then Exit` e os logs iam para o `LOG_DOCORI` errado. Correção: o `Inicializa` passou a ser a primeira instrução dentro do `Try` das duas rotinas, de modo que toda exceção posterior cai nos tratadores. Esses trechos que ficaram antes do `Inicializa` não registram log, então nada se perde; por isso também foi removido o `Finaliza` do retorno antecipado de `fVerificaConfBaixada` (o log ainda não existe nesse ponto). Não voltar o `Inicializa` para antes do `Try`.

### Nota 5
Arquivo: `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas` — `fGeraEntradaEspecial`, fim do `Try`, após `fGravaFinanceiroEsp`.

O `rollback` e o `Finaliza` de falha ficavam dentro de `If Not blnTransacaoExterna`, e o `Encerra` só cobre `Result = True`. Com `blnTransacaoExterna = True` e `Result = False` nenhum dos dois era chamado: no modo banco (`LAUTET <> 'N'`) `qry`/`Conexao` ficavam abertos e o `Inicializa` do documento seguinte saía em `if Assigned(qry) then Exit`, enviando os logs ao `LOG_DOCORI` errado; no modo memória os erros acumulados não eram exibidos. Correção: `Else If (Not Result) And (Not blnAutEnt) Then TGeraLogAutEnt.Finaliza`, ligado ao `If Not blnTransacaoExterna`. Não há rollback nesse ramo porque a transação pertence ao chamador. Usado `Finaliza` (e não `Encerra`) por ser falha: no modo memória o usuário vê o log. Pode haver mensagem do chamador somando-se ao popup; não foi verificado quando `blnTransacaoExterna` é True.

## 8. Ajuste de revisão — liberação do TCalculoPisCofins
Em `fGravaNotDetEsp` e `fGravaMovDet` (`untRecTransfEstoque.pas`), `tmp := TCalculoPisCofins.Create` era liberado com `tmp.Destroy` fora de `Try/Finally` (pré-existente): qualquer exceção de `fCalculoPisCofins` (Raise com callback não atribuído, como no Fulfillment, ou exceção interna) vazava o objeto. O trecho entre o `Create` e o `Destroy` passou a ficar em `Try ... Finally FreeAndNil(tmp); End;`, sem alterar a lógica (o corpo apenas foi indentado, o que aumenta o diff). Aplicado nas 3 cópias.
