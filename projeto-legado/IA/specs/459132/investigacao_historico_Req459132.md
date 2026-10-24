# Investigação Req. 459132 — Histórico passo a passo

> Documento de trabalho, construído incrementalmente durante a investigação guiada pelo usuário.
> Não deve ser confundido com `conhecimentoUnitsInvestigadas_Req459132.md` /
> `validacaoDivergenciaEnderecamento_Req459132.md` (conclusões já fechadas anteriormente) —
> este arquivo documenta o raciocínio e as evidências coletadas nesta nova rodada de investigação,
> partindo do zero, sem reaproveitar as conclusões anteriores.

## Passo 1 — `frmEntConferPreNota`: liberar sem conferir nenhum item

### Cenário reproduzido pelo usuário

- Tela: `TfrmEntConferPreNota` (unit `untEntConferPreNota.pas`, lógica em `untEntConfPreNotaFuncoes.pas`, classe `TConferePreNota`).
- Ação: iniciar a conferência do documento, **não conferir nenhum item**, e liberar por trava/senha (fluxo de inconsistência).
- Exemplo de dado real usado na investigação:
  - `GERELE.AUTOINCREM = '00100000000004333001'` (NF 000000009881, série 6, fornecedor 00000847, empresa 001)
  - `GER_IDEDIG = '001425'`
  - Transação de liberação: `LOGREP.LOG_IDTRAN = '102053757554019971'`, `LOG_CODOPE = '997'`, em `2026-09-03 10:36:05` a `10:36:11`

### Sequência observada em `LOGREP` (transação `...9971`, 10:36)

1. `DELETE FROM DIGCON WHERE DIC_IDEDIG = '001425' AND DIC_CODEMP = '001'`
2. `INSERT INTO LIBENT (...)` — grava o motivo de liberação, com o texto padrão `"<item> - <descrição>Qtd. Pedido: N Qtd. Conferida: 0"` para cada item — **confirma que nenhum item foi conferido**.
3. `UPDATE GERELE SET GER_IDEDIG=..., GER_DTACON=..., GER_HORCON=..., GER_OPECON='997', GER_SEMCON='S', GER_ENDDEV=0 WHERE AUTOINCREM='00100000000004333001'`
4. 7x `INSERT INTO DIGCON (AUTOINCREM, DIC_CODEMP, DIC_SEQGER='', DIC_CODITE, DIC_QTDITE, DIC_IDEDIG='001425', DIC_SEQDOR='', DIC_MOVDET, DIC_QTDTOT, DIC_SEMCON='N', DIC_QTDDEV=0, DIC_CODCON='')` — **uma linha por item do documento**, com `DIC_QTDITE = DIC_QTDTOT` = quantidade total do item (ex.: 100, 60, 150, 150, 150, 217, 75) — ou seja, a quantidade **cheia do pedido**, mesmo sem conferência real.
5. 7x `UPDATE ITEGER SET ITE_REPAUD = 'S' WHERE ITE_CODITE = ...` — marca os itens para reprocessamento de saldo.

### Rastreamento no código-fonte

Função raiz: `TConferePreNota.fGravaConferencia` (`untEntConfPreNotaFuncoes.pas:1970`).

Fluxo relevante quando não há conferência de nenhum item:

```
blnTeveConferencia := fTeveConferencia(cdsConsulta);          // False (nenhum item conferido)

If (Not blnTeveConferencia) And (fCfgSis('UDEVME', varBoolean)) then
begin
   intOpcao := fMensagem('', 'Não houve conferência, deseja mandar os itens para?',
                          ['Endereçar', 'Devolver'], 1);
   objDistribuicaoConferencia.LiberadoEnderecamentoSemConferencia := intOpcao = 1;
End;
```

**Achado 1 — a pergunta "Endereçar/Devolver" só aparece se `fCfgSis('UDEVME') = 'S'`.**
Na base investigada (`TU_SMF`), **não existe registro em `CFGSIS` para a chave `UDEVME`** (`SELECT * FROM CFGSIS WHERE SIS_CODCFG='UDEVME'` → 0 linhas), portanto `fCfgSis('UDEVME', varBoolean)` resolve para `False`. **A pergunta nunca é exibida** e `objDistribuicaoConferencia.LiberadoEnderecamentoSemConferencia` **nunca é setada** — permanece no valor padrão do construtor (`False`, `untTDistribuicaoConferencia.pas:266`).

Em seguida (`fGravaConferencia`, mais adiante), a `UPDATE GERELE` grava `GER_SEMCON = IIf(blnTeveConferencia, 'N', 'S')` → **`'S'` corretamente**, refletindo no cabeçalho que o documento foi liberado sem conferência.

O detalhe (`DIGCON`) é gerado por `TConferePreNota.pFinalizaConferencia` → `TDistribuicaoConferencia.fFinalizaConferencia` (`untTDistribuicaoConferencia.pas:460`):

```pascal
function TDistribuicaoConferencia.fFinalizaConferencia: Boolean;
begin
  Result := True;
  If (Not TemConferencia) and LiberadoEnderecamentoSemConferencia then
    Result := fFinalizaConferenciaSemContagem;      // NÃO executa (LiberadoEnderecamentoSemConferencia=False)

  Result := Result and fAjusteDigConParaGravacao;    // sempre executa
  result := result and fMarcaParaReprocessamentoSaldo;
end;
```

Como `LiberadoEnderecamentoSemConferencia = False`, `fFinalizaConferenciaSemContagem` **não roda** — mas isso não impede a quantidade cheia de ser gravada, porque `fAjusteDigConParaGravacao` (`:363`) tem sua **própria** lógica de "completar o que não foi conferido", incondicional ao motivo/flag:

```pascal
function TDistribuicaoConferencia.fAjusteDigConParaGravacao: Boolean;
begin
  for LItem in FItensReserva do
  begin
    ...
    If Not FUDEVME then                                              // FUDEVME = (fCfgSis('UDEVME')='S') = False aqui
      ConferirItem(LItem.CodItem, LItem.QuantidadeTotal - LItem.QuantidadeConferida);
                                                                       // → QuantidadeConferida vira QuantidadeTotal (100%)
  End;
  pAjustaDigConFinal();
  ...
end;

procedure TDistribuicaoConferencia.pAjustaDigConFinal;
begin
  for LItem in FItensReserva do
  begin
    If (LItem.SeqDigCon = '') and EfetivacaoMovimentoFiscal then
      GravaDigCon(LItem, LItem.QuantidadeConferida)
    else If LItem.SeqDigCon = '' Then
      GravaDigCon(LItem, IIf(LiberadoEnderecamentoSemConferencia or (Not FUDEVME), LItem.FQuantidadeTotal, 0))
                                                    // Not FUDEVME=True → grava QuantidadeTotal cheia mesmo assim
    Else
      AtualizaDigCon(LItem, IIf(FUDEVME, 0, LItem.QuantidadeConferida - LItem.QuantidadeLiberadaEnderecamento));
  end;
End;
```

E dentro de `GravaDigCon` (`:990`):

```pascal
FQryInsertDigCon.ParamByName('DIC_SEMCON').AsString := IIf(LiberadoEnderecamentoSemConferencia, 'S', 'N');
```

**Achado 2 (o núcleo do problema deste passo) — inconsistência `GER_SEMCON` x `DIC_SEMCON`.**
`DIC_SEMCON` é gravado como `'N'` (como se o item **tivesse sido efetivamente conferido**) porque depende exclusivamente de `LiberadoEnderecamentoSemConferencia`, que ficou `False` (achado 1) — **mesmo que a quantidade gravada em `DIC_QTDITE` seja a quantidade cheia do pedido, sem nenhuma conferência real**, e mesmo que o cabeçalho (`GERELE.GER_SEMCON`) esteja corretamente marcado `'S'`.

Confirmado no banco: `GERELE.GER_SEMCON = 'S'` × todas as 7 linhas de `DIGCON` para `DIC_IDEDIG='001425'` com `DIC_SEMCON='N'`.

**Resumindo o passo 1:** ao liberar a pré-nota sem conferir nenhum item, com `UDEVME` desabilitado (comum/padrão nesta base), o sistema:
- corretamente marca o cabeçalho (`GERELE.GER_SEMCON='S'`);
- mas grava o detalhe (`DIGCON`) com a quantidade **cheia** do pedido e `DIC_SEMCON='N'` — **como se fosse uma conferência real completa**, sem qualquer sinalização no detalhe de que não houve conferência.

Isso por si só já é suspeito como origem de divergência de endereçamento (o endereçamento provavelmente confia em `DIGCON`/`DIC_QTDITE`+`DIC_SEMCON` para saber "quanto e o que pode ser endereçado", e não em `GERELE.GER_SEMCON`).

---

## Passo 2 — Duplicação da quantidade em `DIGCON` (achado durante a validação do exemplo)

Ao conferir o estado atual do `DIGCON` gerado para `DIC_IDEDIG='001425'` (`SELECT * FROM DIGCON WHERE DIC_IDEDIG='001425'`), a quantidade **não bate** com a gravada no passo 1 — está **exatamente em dobro**:

| Item | `DIC_QTDTOT` (pedido) | `DIC_QTDITE` gravado no INSERT (10:36:10) | `DIC_QTDITE` atual no banco |
|---|---|---|---|
| 08520 | 100 | 100 | **200** |
| 08519 | 60  | 60  | **120** |
| 08016 | 150 | 150 | **300** |
| 08014 | 150 | 150 | **300** |
| 07890 | 150 | 150 | **300** |
| 07888 | 217 | 217 | **434** |
| 08521 | 75  | 75  | **150** |

### Segunda transação encontrada em `LOGREP`

`LOG_IDTRAN = '102053757554019979'`, mesmo `LOG_CODOPE='997'`, **10:39:46 a 10:39:58** (≈4 min depois da primeira). Contém:
- `UPDATE MOVGER SET GER_DTAENT=..., GER_HORENT=...` (efetivação de entrada)
- `UPDATE CADFIS SET FIS_DTAENT=...`
- 2x `UPDATE CADPAG SET CTP_DTACAD=..., CTP_COMPET=...` (geração/baixa de contas a pagar)
- `UPDATE ITEGER` (custo/saldo)
- 7x `UPDATE DIGCON SET DIC_QTDITE = IFNULL(DIC_QTDITE,0) + <qtd_total>, DIC_QTDTOT=<qtd_total>, DIC_QTDDEV=0, DIC_SEQGER=..., DIC_SEQDOR=... WHERE DIC_IDEDIG='001425' AND DIC_MOVDET=<seq>` — **update aditivo**, soma a quantidade cheia de novo em cima do que já existia.

Essa transação é da **efetivação do movimento fiscal** — unit `untEfetivaMovimentoFiscal.pas` (classe `TEfetivaMovimentoFiscal`), **não** é um segundo clique do usuário na tela de pré-nota. É a etapa seguinte do pipeline de entrada de mercadorias, disparada automaticamente após a liberação (mesmo `LOG_CODOPE='997'`, consistente com processo interno/automático).

### Código responsável (`untEfetivaMovimentoFiscal.pas:1108-1124`)

```pascal
If Assigned(ANotaEletInfConf) then
  If blnSucesso then
  Begin
    If (fCfgSis('UDEVME', VarBoolean)) or
       (TEnderecamentoConferenciaParcial.ConferenciaSemDigConCorretaPorDigEle(ANotaEletInfConf.FDigEle)) then
    Begin
      If ANotaEletInfConf.FDtaCon > 0 then
      begin
        lDistribuicaoConferencia := TDistribuicaoConferenciaFactory.CriarPorIDeDig(ANotaEletInfConf.FDigEle);
        try
          lDistribuicaoConferencia.EfetivacaoMovimentoFiscal := True;
          lDistribuicaoConferencia.fFinalizaConferencia;      // <-- roda a MESMA lógica do passo 1, em um objeto NOVO
        finally
          FreeAndNil(lDistribuicaoConferencia);
        End;
      End;
    End;
  End;
```

Como `UDEVME='N'`, a entrada neste bloco só ocorre porque `TEnderecamentoConferenciaParcial.ConferenciaSemDigConCorretaPorDigEle(...)` retornou `True` — ou seja, **o próprio sistema detectou que o `DIGCON` gravado no passo 1 está "incorreto"** (provavelmente por causa do `DIC_SEMCON='N'` indevido do achado 2) e tenta corrigir, rodando de novo `fFinalizaConferencia` — mas o resultado é pior: duplica a quantidade.

### Causa-raiz da duplicação: chave de reconciliação instável (`DIC_SEQDOR`)

`TDistribuicaoConferenciaFactory.CriarPorIDeDig` (`untTDistribuicaoConferencia.pas:1364`) recarrega os itens do zero a partir de `GERELE`/`DETELE`/`MOVTRI`/`MOVDET`/`EXTDOR`/`FATDOR`/`FATGOR` (`CarregarDadosPorIDeDig`, `:1255`), e tenta restaurar `QuantidadeLiberadaEnderecamento` (o que já foi gravado antes em `DIGCON`) via `CarregarDadosDigCon` → `AdicionarConferenciaAnterior`:

```pascal
procedure TDistribuicaoConferencia.AdicionarConferenciaAnterior(const ACodItem,
  ASeqFatDor: string; AQuantidade: Double; ADigCon: string);
begin
  for LItem in FItensReserva do
    if (LItem.CodItem = ACodItem) and (LItem.SeqFatDor = ASeqFatDor) Then   // <-- casamento por CodItem + SeqFatDor
      LItem.QuantidadeLiberadaEnderecamento := AQuantidade;
end;
```

**O problema:** no passo 1 (primeiro `INSERT INTO DIGCON`), `DIC_SEQDOR` foi gravado como **string vazia `''`** (ver o `INSERT` original: `DIC_SEQDOR = ''`), porque, no momento da liberação da pré-nota, o `FATDOR` daquele item **ainda não existia** (é gerado depois, em outra etapa do pipeline). No passo 2, quando `CarregarDadosPorIDeDig` reconstrói os itens, o `FATDOR` **já existe** — então `LItem.SeqFatDor` vem populado (ex.: `'00100000001398002001'`), **diferente** do `ASeqFatDor=''` lido de volta do `DIGCON` já gravado.

Resultado: o `if (...) and (LItem.SeqFatDor = ASeqFatDor)` **nunca casa**, `QuantidadeLiberadaEnderecamento` fica em `0` (nunca é restaurada), mesmo a linha já existindo em `DIGCON` com 100% da quantidade gravada.

Daí em diante, dentro do mesmo `fFinalizaConferencia` do passo 2:
1. `fAjusteDigConParaGravacao` → `Not FUDEVME` (True) → `ConferirItem(item, QuantidadeTotal - 0)` → `QuantidadeConferida := QuantidadeTotal` (100% de novo, "do zero").
2. `LItem.SeqDigCon` é preenchido via `fGetIncDigCon` (esse sim encontra a linha existente, pois busca por `DIC_MOVDET` + `DIC_IDEDIG`, chave estável) → `pAjustaDigConFinal` cai no `Else` → `AtualizaDigCon(LItem, QuantidadeConferida - QuantidadeLiberadaEnderecamento)` = `AtualizaDigCon(LItem, QuantidadeTotal - 0)` = quantidade **cheia de novo**.
3. `AtualizaDigCon` executa `UPDATE DIGCON SET DIC_QTDITE = IFNULL(DIC_QTDITE,0) + :DIC_QTDITE ...` — **soma** (em vez de substituir) → quantidade final = 2x a quantidade do pedido.

Isso bate exatamente com os números observados (217→434, 100→200, etc.) e com o `UPDATE` real capturado em `LOGREP`.

### Cadeia de causa consolidada (passos 1+2)

1. `UDEVME` desabilitado nesta base → pergunta "Endereçar/Devolver" nunca aparece → `LiberadoEnderecamentoSemConferencia` nunca é setada como `True` no fluxo normal.
2. Mesmo assim, `fAjusteDigConParaGravacao` **sempre** completa a quantidade não conferida para 100% quando `FUDEVME=False`, independente de ter havido conferência real — e grava em `DIGCON` com `DIC_SEMCON='N'` (parece conferência real).
3. Como a chave usada para "lembrar quanto já foi liberado" (`SeqFatDor`) **não é a mesma** no momento da liberação (`''`) e no momento da efetivação fiscal (`FATDOR` real), a segunda passada não reconhece a primeira, repete a lógica do zero e a `UPDATE ... DIC_QTDITE = DIC_QTDITE + :qtd` (aditiva, sem idempotência) **duplica** a quantidade em `DIGCON`.

Isso é praticamente certo que seja (ou seja uma das causas de) a divergência de endereçamento do requisito: o endereçamento passa a enxergar o dobro da quantidade realmente recebida/pedida para aquele documento, sem qualquer conferência física real por trás.

---

## Arquivos/units envolvidos até aqui

| Unit | Papel neste fluxo |
|---|---|
| `padra_atualizado/fontes/movimentacaoitens/untEntConferPreNota.pas` | Form da tela de conferência de pré-nota (`TfrmEntConferPreNota`) |
| `padra_atualizado/fontes/movimentacaoitens/untEntConfPreNotaFuncoes.pas` | Lógica de negócio da conferência (`TConferePreNota.fGravaConferencia`, `.pFinalizaConferencia`, `.fLiberarEnderecamentoParcial`) |
| `padra_atualizado/fontes/genericos/untTDistribuicaoConferencia.pas` | Classe central `TDistribuicaoConferencia` — monta/grava `DIGCON`/`DIGELE`, contém `fFinalizaConferencia`, `fFinalizaConferenciaSemContagem`, `fAjusteDigConParaGravacao`, `pAjustaDigConFinal`, `GravaDigCon`, `AtualizaDigCon`, `CarregarDadosPorIDeDig`, `AdicionarConferenciaAnterior` — **onde estão os dois achados centrais** |
| `padra_atualizado/fontes/movimentacaoitens/untEfetivaMovimentoFiscal.pas` | `TEfetivaMovimentoFiscal` — efetivação fiscal/estoque da entrada; dispara a segunda passada por `TDistribuicaoConferenciaFactory.CriarPorIDeDig(...).fFinalizaConferencia` que duplica a quantidade |
| `padra_atualizado/fontes/cadastros/untTEnderecamentoConferenciaParcial.pas` | `ConferenciaSemDigConCorretaPorDigEle` — detecta que o `DIGCON` gravado no passo 1 está "incorreto" e decide reprocessar (gatilho da duplicação) |
| `padra_atualizado/fontes/movimentacaoitens/untEntEnderecamentoProduto.pas` | Tela de endereçamento — outro consumidor de `TDistribuicaoConferencia`/`DIGCON` (ainda não aprofundado nesta rodada) |

## Tabelas envolvidas

- `GERELE` — cabeçalho da nota/entrada (`GER_SEMCON`, `GER_ENDDEV`, `GER_IDEDIG`, `GER_DTACON`)
- `DIGCON` — detalhe da digitação de conferência por item (`DIC_QTDITE`, `DIC_QTDTOT`, `DIC_SEMCON`, `DIC_SEQDOR`, `DIC_MOVDET`)
- `DIGELE` — digitação eletrônica agregada
- `LIBENT` — motivo/registro de liberação por trava
- `ITEGER` — saldo/custo por item (`ITE_REPAUD`)
- `LOGREP` — log de auditoria de todos os comandos SQL (usado nesta investigação para reconstruir a timeline)

## Passo 3 — Conexão confirmada com o Req. 459132 já documentado (spec.md/plan.md/tasks.md)

O usuário confirmou: esta duplicação em `DIGCON.DIC_QTDITE` é a **mesma causa** do Req. 459132
("Endereçamento de entrada gerando quantidade duplicada e saldo negativo no lote 'A DEFINIR'").
Lidos agora `spec.md`, `plan.md` e `tasks.md` dessa pasta (antes propositalmente não lidos, para não
enviesar a investigação partindo do zero — ver topo deste documento).

### O que o spec.md/plan.md/tasks.md já registravam

- **Sintoma:** NF `000000009771`, item `07888`, quantidade NF = 217 → TA `000000010981` gravada com
  **434** (2×) na saída (lote "A DEFINIR") e na entrada (lote "EXTERNO AMERICO"). Mesmo padrão nos
  7 itens do documento — **mesmo padrão exato** encontrado nesta investigação (documento diferente:
  NF `000000009881` / `GERELE.AUTOINCREM='00100000000004333001'`, item `07888`, 217→434 idêntico).
- **Achado 4 do spec.md:** já identificava que `DIGCON.DIC_QTDITE` chega duplicado (`434`) **antes**
  da geração da TA, e que isso só se propaga para o endereçamento porque `CFG_COFEND='S'` +
  `CFG_TIPPNT='D'` (fórmula `IFNULL(DIC_QTDITE,0) + IFNULL(DIC_QTDLDE,0) - @ITE_QTDEND_1` em
  `untEnderecamentoProduto.pas:2207`, em vez de `FDO_QTDITE - FDO_QTDBAI`).
- **Achado 5 do spec.md — origem da duplicação em `DIGCON` NÃO confirmada:** o spec registrava
  como "candidato mais provável" (não confirmado) uma condição de corrida entre **duas threads
  concorrentes sem sincronização** em `TEnderecamentoConferenciaParcial.Processa`
  (`untTEnderecamentoConferenciaParcial.pas:306`), e explicitamente descartava a hipótese de uma
  segunda chamada de gravação (`LOGREP` mostrava só 1 gravação de `MOVGER`/`MOVDET`, mas a
  investigação anterior não tinha rastreado o `LOGREP` do próprio `DIGCON` — o que fiz aqui).
- **Correção implementada (pendente, Fase 2 de tasks.md — checkbox ainda não marcado):** é
  **defensiva**, em `TTransferenciaArmazens.pValQtdEnderecada`
  (`untTransferenciaArmazens.pas`) — muda a validação para comparar contra a quantidade
  **pendente** do pedido (`FDO_QTDITE - FDO_QTDBAI`) em vez do total bruto, fazendo `fGeraTransferencia`
  abortar com exceção quando a quantidade a endereçar exceder a pendência real. **Não corrige a
  duplicação em si** — spec.md é explícito que a causa raiz em `DIGCON` fica "fora de escopo" dessa
  correção (seção 7), tratada como investigação futura.

### Diferença importante em relação a esta investigação

**Esta investigação (passos 1-2 acima) encontrou e confirmou, com evidência de `LOGREP` +
leitura de código, o mecanismo exato da duplicação em `DIGCON.DIC_QTDITE`** — não é a hipótese de
concorrência de threads do spec.md (achado 5), e sim:

> Reconciliação por `SeqFatDor` falhando entre a gravação original (`DIC_SEQDOR=''`, `FATDOR`
> ainda não existe) e o reprocessamento em `TEfetivaMovimentoFiscal`
> (`CriarPorIDeDig`→`CarregarDadosPorIDeDig`, `FATDOR` já existe) — combinada com o
> `UPDATE DIGCON SET DIC_QTDITE = DIC_QTDITE + :qtd` **aditivo** em `AtualizaDigCon`.

Isso é **determinístico** (não depende de timing/concorrência) — acontece toda vez que:
1. o documento é liberado sem conferência real de algum item (gerando `DIC_SEQDOR=''` no primeiro
   `GravaDigCon`), **e**
2. `TEnderecamentoConferenciaParcial.ConferenciaSemDigConCorretaPorDigEle` detecta a inconsistência
   do passo 1 (achado 1 acima: `DIC_SEMCON='N'` indevido) e aciona o reprocessamento em
   `untEfetivaMovimentoFiscal.pas:1116` durante a efetivação fiscal.

Isso também **derruba a suposição de "caso único"** registrada em spec.md, seção 8
("Escopo confirmado como único caso reportado até o momento") — o mesmo padrão foi reproduzido de
forma independente nesta investigação, em outro documento (NF `000000009881`), o que sugere que a
condição de disparo (liberar pré-nota sem conferir + `UDEVME` desabilitado) é **sistemática**, não
um evento raro de concorrência.

### Implicação para a correção

A correção já planejada em `pValQtdEnderecada` (Fase 2 de tasks.md) continua válida como **trava
defensiva** (RN01/RN02 do spec.md — nunca deixar a TA gravar além da quantidade pendente) e deve
ser mantida. Mas, com a causa raiz agora identificada e determinística (não mais "candidato não
confirmado"), faz sentido reabrir o escopo para incluir uma correção na **origem**
(`untTDistribuicaoConferencia.pas` / gatilho em `untEfetivaMovimentoFiscal.pas`), em vez de deixá-la
como "investigação futura" indefinida — a ser decidido com o usuário nos próximos passos.

---

## Passo 4 — Correção aplicada (causa raiz da duplicação em DIGCON)

Implementado em `padra_atualizado/fontes/genericos/untTDistribuicaoConferencia.pas` (via Python,
encoding cp1252/CRLF preservado, validado sem corrupção):

1. **`AdicionarConferenciaAnterior`** (interface `:127` + implementação `:669`): parâmetro/casamento
   trocado de `SeqFatDor` para `SeqMovDet`. `Nota 2 - Req. 459132`.
2. **`CarregarDadosDigCon`** (`:1045`): filtro trocado de `WHERE DIC_SEQGER IN (...)` para
   `WHERE DIC_IDEDIG = :IDEDIG AND DIC_CODEMP = :CODEMP`; passa `DIC_MOVDET` em vez de `DIC_SEQDOR`
   para a reconciliação. `Nota 2 - Req. 459132`.
3. **`AtualizaDigCon`/`FQryUpdateDigCon`** (`:310`): `DIC_QTDITE = LEAST(IFNULL(DIC_QTDITE,0) + :DIC_QTDITE, :DIC_QTDTOT)`
   — trava de segurança adicional (nunca deixa `DIC_QTDITE` ultrapassar `DIC_QTDTOT`).
   `Nota 3 - Req. 459132`.

**Pendente (fora desta rodada, já estava planejado em `tasks.md` Fase 2, ainda não aplicado no
fonte):** `Nota 1 - Req. 459132` — ajuste em `TTransferenciaArmazens.pValQtdEnderecada`
(`untTransferenciaArmazens.pas`), somar `- IFNULL(FDO_QTDBAI, 0)` ao `SUM(...)` de `QTDAENDERECAR`.
Continua válido como trava defensiva complementar na ponta da geração da TA.

*(Ainda não executados nesta rodada: `/citel-aprovaRequisito`, gate DelphAI, commit — ficam para
quando o usuário pedir.)*

---

## Passo 5 — Por que `pValQtdEnderecada` não acusou a divergência no caso real (NF 000000009771)

Reproduzindo manualmente as duas queries de `pValQtdEnderecada` (`untTransferenciaArmazens.pas:2281`)
contra os dados reais do caso do `spec.md` (NF `000000009771`, série 6, fornecedor `00000847`,
empresa 001):

- **1ª query** (`qryPedidoEnderecamento`, checagem de existência): `SELECT DEL_FATGOR.AUTOINCREM
  FROM DEL_FATGOR JOIN DEL_EXTGOR ... WHERE FGO_DOCEND IS NOT NULL AND FGO_DTAENT >= ... AND
  LOCATE(:DOCUME, FGO_DOCEND)` — **retorna vazia**. Confirmado direto no banco:
  `SELECT * FROM DEL_EXTGOR WHERE FGO_DOCEND LIKE '%000000009771%'` → **0 linhas**.
- Comparando com as demais NFs do mesmo fornecedor (`FGO_DOCEND LIKE '%00000847%'`), existe reserva
  em `DEL_EXTGOR` para praticamente toda NF anterior/posterior (`...9264, 9318, 9332, 9340, 9468,
  9554, 9734`, e a sequência retoma bem depois de 9771) — **a NF 9771 é a única sem nenhuma linha**,
  não é uma característica geral do fluxo/config.

**Efeito no código:** como a 1ª query vem vazia, o bloco `If Not (qryPedidoEnderecamento.IsEmpty)
Then` (`:2396`) nunca executa — a 2ª query (que de fato somaria `FDO_QTDITE` de `DEL_FATDOR`) nunca
roda, e a comparação da linha `:2404` nunca acontece. `fltQtdEnderada`/`fltQtdAEnderecar` permanecem
nos valores iniciais `0.0`/`0.0` (`:2432-2433`). A checagem final em `fGeraTransferencia`
(`:2538`, `RoundTo(fltQtdEnderada,-4) <> RoundTo(fltQtdAEnderecar,-4)`) avalia `0 <> 0` = **falso**
→ nenhuma exceção é levantada, mesmo a TA tendo sido gravada com o dobro da quantidade.

**Gap de design confirmado:** `pValQtdEnderecada` trata "não encontrei o pedido de reserva para
comparar" e "comparei e está tudo certo" da mesma forma — silêncio. Isso é uma falha de projeto da
própria trava (independente da causa raiz em `DIGCON` já corrigida nas Notas 2/3): sempre que
`DEL_FATGOR`/`DEL_EXTGOR` não existir por qualquer motivo, a validação passa despercebida em vez de
bloquear defensivamente.

**Por que a reserva sumiu especificamente nesta NF (hipótese, não fechada com 100% de certeza):**
liga com o achado do Passo 2 — `TEfetivaMovimentoFiscal` rodou duas vezes para este documento
(reprocessamento disparado por `ConferenciaSemDigConCorretaPorDigEle`). O mesmo bloco que dispara a
2ª passada (`untEfetivaMovimentoFiscal.pas:1063-1066`) chama `pDeletaPedidoReservaAntigo` (apaga a
reserva antiga) **antes** de `objEnderecamento.fGerarPedidoParaReservarEstoque` (recria). Se a
recriação não persistiu na 2ª passada (falha silenciosa, ou pulada por alguma guarda ainda não
mapeada — `blnTemItem`/`blnRecebimentoDeGarantiaDaFilial`/`blnNotaMae`), a reserva fica apagada e
nunca mais é recriada — exatamente o estado observado no banco. **Não foi confirmado com certeza
absoluta** (não foi lido `pDeletaPedidoReservaAntigo`/`fGerarPedidoParaReservarEstoque` em detalhe
ainda) — candidato a próximo passo de investigação, se necessário.

### Implicação para a correção

Duas frentes independentes, ambas necessárias:
1. **Já corrigida (Notas 2/3):** impedir a duplicação em `DIGCON.DIC_QTDITE` na origem — corrige a
   causa que faz o endereçamento calcular/gravar quantidade maior.
2. **Pendente:** tornar `pValQtdEnderecada` fail-safe — quando `DEL_FATGOR`/`DEL_EXTGOR` não for
   encontrado para o documento, a validação não deve simplesmente "passar" (0=0); deve, no mínimo,
   logar/alertar essa condição anômala, e idealmente ainda comparar `MOVDET`/TA contra alguma outra
   fonte confiável (ex.: `FATDOR.FDO_QTDITE`, a NF real, como o usuário sugeriu) em vez de depender
   exclusivamente de uma reserva que pode não existir.

---

## Perguntas em aberto para os próximos passos

1. O que exatamente a tela/rotina de **endereçamento** (`untEntEnderecamentoProduto.pas`) faz com `DIGCON` (`DIC_QTDITE`, `DIC_SEMCON`) — é ali que a divergência aparece visualmente para o usuário?
2. `DIC_SEQDOR=''` no primeiro `INSERT` é sempre assim quando não há conferência? Ou só neste tipo de operação (`TIPPNT='D'`, `LOGENT='S'`)? Vale checar se em fluxos com conferência real o `FATDOR` já existe no momento do primeiro `GravaDigCon`.
3. Confirmar se `ConferenciaSemDigConCorretaPorDigEle` é sempre acionada neste cenário (UDEVME desabilitado + liberação sem conferência), ou só às vezes — o que explicaria por que nem toda liberação sem conferência duplica.
4. O `GER_ENDDEV = '1'` (comparação de inteiro com string) em `CarregarDadosPorIDeDig:1281` parece uma condição que praticamente nunca é satisfeita (`GER_ENDDEV` é gravado como `0`/`1` inteiro; `intOpcao` só vira `1` se a pergunta Endereçar/Devolver aparecer) — vale confirmar se isso é um bug à parte (comparação errada) ou intencional.

---

## Passo 6 — `FGO_DOCEND`: como é montado e troca do `LOCATE` por igualdade direta em `pValQtdEnderecada`

> Sessão separada, tema pontual: não relacionado à causa raiz da duplicação em `DIGCON` (Passos 1-5) nem
> à Hipótese #1 (`FDO_QTDBAI`) já descartada/revertida em `conhecimentoUnitsInvestigadas_Req459132.md`.
> Foco: a **1ª query** de `pValQtdEnderecada` (existence check de pedido de reserva via `FGO_DOCEND`),
> independente de qual fórmula a 2ª query usa para `QTDAENDERECAR`.

### Como `FGO_DOCEND` é montado

Rastreado `untPcmGer.fGerarPedidosReservaEstoque` → `TEnderecamentoProduto.fGerarPedidoParaReservarEstoque`
→ procedure aninhada `fMarcaDocumentoEnderecamento` (`untEnderecamentoProduto.pas:1434-1449`, chamada na
linha 1742):

```pascal
UPDATE EXTGOR SET FGO_DOCEND = <lAlias> WHERE FGO_SEQFGO = :FSeqFgo
```

`lAlias` é:
- `QuotedStr('PE' + strDocumento)` se `blnResEstPenLotpre` (reserva de lote pré-venda) — desloca todas as
  posições em 2 caracteres;
- `NULL` se `blnLibercaoAmazenamento`;
- `QuotedStr(strDocumento)` no caso normal.

`strDocumento` é a property `strDocumento` (getter `fGetStrEnderecamento`, `untEnderecamentoProduto.pas:2720-2730`):

```pascal
Result := fPadL(FDocume.strNumDoc, fTamNumDoc)   // fTamNumDoc dinâmico (não é literal 12), via CFG/conexão
        + fPadR(FDocume.strEspDoc, 02)
        + fPadR(FDocume.strSerie_, 03)
        + fPadR(FDocume.strCodEmp, 03)
        + fPadR(FDocume.strCliFor, 08)
        + fPadR(FDocume.strTip_FC, 01);
```

Confirma a decodificação de 29 chars já documentada em
`conhecimentoUnitsInvestigadas_Req459132.md` (seção "Decodificação do formato FGO_DOCEND").

### Mudança aplicada em `pValQtdEnderecada`

`untTransferenciaArmazens.pas`, procedure aninhada `pValQtdEnderecada` (dentro de
`TTransferenciaArmazens.fGeraTransferencia`) — 1ª query (`qryPedidoEnderecamento`, existence check em
`DEL_FATGOR`/`DEL_EXTGOR`):

- **Antes:** `WHERE FGO_DOCEND IS NOT NULL AND FGO_DTAENT >= :DTAENT AND LOCATE(:DOCUME, FGO_DOCEND)`, com
  `:DOCUME = strNumdoc + strEspdoc + strSerie_` (função sobre coluna, não indexável).
- **Depois:** variável local `strDocEnd` montada com o mesmo formato de `fGetStrEnderecamento`
  (`fPadL(strNumdoc, fTamNumDoc) + fPadR(strEspdoc,2) + fPadR(strSerie_,3) + fPadR(strCodemp,3) +
  fPadR(strCliFor,8) + fPadR(strTip_FC,1)`), usada em `WHERE FGO_DOCEND = :DOCFUL` (igualdade exata).
- Comentário curto no fonte + `Verificar Nota 1 - Req. 459132` (nota registrada em
  `otimizacaoLocateFgoDocend_Req459132.md`).

**Decisão de escopo (explícita do usuário):** não tratar o caso `'PE'+strDocumento`
(`blnResEstPenLotpre`) nesta troca. Isso não é uma regressão nova: a **2ª query** da mesma validação
(`SUBSTRING(FGO_DOCEND,18,3)=:EMPEND` etc., linhas ~2379-2384) já assumia posições fixas sem esse
prefixo antes desta mudança — um pedido `'PE'`-prefixado que passasse pela 1ª query (via `LOCATE`, que
tolerava o deslocamento) já não seria capturado pela 2ª. O comportamento final da trava para esse cenário
não muda; só deixa de ser "quase coberto" na 1ª query.

Detalhes completos (por que é seguro, formato exato, código antes/depois) em
`otimizacaoLocateFgoDocend_Req459132.md`.

---

## Passo 7 — Fecha o Passo 5: por que `DEL_FATGOR`/`DEL_EXTGOR` vêm vazios em `blnCofEnd`

> Fecha, com certeza (não mais hipótese), a pergunta deixada em aberto no **Passo 5** ("Por que a
> reserva sumiu especificamente nesta NF") e na pergunta 1 de "Perguntas em aberto". A causa **não**
> é uma falha silenciosa em `pDeletaPedidoReservaAntigo`/`fGerarPedidoParaReservarEstoque` (como ali
> especulado) — é uma condição explícita no fluxo de salvamento do endereçamento que **nunca chega a
> arquivar/apagar** o pedido de reserva quando `CFG_COFEND='S'`.

### Achado

Em `TfrmEntEnderecamentoProduto` (`untEntEnderecamentoProduto.pas`), no fluxo de gravação
(`btnConfirmaClick`), o apagamento do pedido de reserva (`FATGOR`/`FATDOR`, que é o que
`fVerificaIntegridade` arquiva em `DEL_FATGOR`/`DEL_EXTGOR`/`DEL_FATDOR`/`DEL_EXTDOR` antes de
excluir) só roda quando `blnCofEnd` está **desligado**:

```pascal
// untEntEnderecamentoProduto.pas:2773-2774 — ANTES de gerar a TA
If (Not blnCofEnd) and (Not blnUDEVME) then
  blnSalvar := blnSalvar And objEnderecamento.fApagaPedidoReservaEstoque;

// untEntEnderecamentoProduto.pas:2794 — gera a TA (roda pValQtdEnderecada por dentro)
blnSalvar := blnSalvar And objEndArm.fGeraDocumentoTransfArmazens(strNumDoc, strEspDoc, strCodCli,
  objEnderecamento.endDocumento.strAutInc, objEnderecamento.endDocumento, objEnderecamento);
```

Nesta base, `blnCofEnd := (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D')`
(`:557`) resolve para `True` (`CFG_COFEND='S'`, `CFG_TIPPNT='D'`, confirmado em `CFGSIS`). Logo a
condição `(Not blnCofEnd) and (Not blnUDEVME)` é `False`, e **`fApagaPedidoReservaEstoque` nunca
executa** antes da geração da TA — o pedido de reserva (`FATGOR`/`FATDOR`) permanece **vivo**, nunca
é arquivado em `DEL_FATGOR`/`DEL_EXTGOR`/`DEL_FATDOR`/`DEL_EXTDOR`.

Só que `pValQtdEnderecada` (`untTransferenciaArmazens.pas:2350-2398`), a trava defensiva que deveria
comparar a quantidade endereçada contra a pendência do pedido, **só sabe ler o pedido a partir das
tabelas de arquivo**:

```pascal
qryPedidoEnderecamento.SQL.Add(' FROM DEL_EXTGOR ');
qryPedidoEnderecamento.SQL.Add(' INNER JOIN DEL_FATDOR ');
qryPedidoEnderecamento.SQL.Add('  ON DEL_EXTGOR.FGO_SEQFGO = DEL_FATDOR.FDO_SEQGER ');
...
qryPedidoEnderecamento.SQL.Add(' WHERE DEL_EXTGOR.FGO_SEQFGO IN (' + strDocEndIn + ') ');
```

Como o pedido nunca foi arquivado, a query de existência (1ª query) vem vazia, o bloco que soma
`FDO_QTDITE`/compara `QTDAENDERECAR` nunca roda (mesmo mecanismo de "silêncio" já descrito no Passo
5), e a trava não acusa nada — **não porque a reserva "sumiu" por alguma falha pontual**, e sim
porque, com `CFG_COFEND='S'`, ela **nunca é movida para o arquivo em primeiro lugar** neste ponto do
fluxo.

### Diferença em relação à hipótese do Passo 5

O Passo 5 especulava uma falha silenciosa específica de uma NF (`pDeletaPedidoReservaAntigo` +
recriação falhando). O achado deste passo é **estrutural e determinístico**: em **qualquer**
ambiente com `CFG_COFEND='S'` (como este), `fApagaPedidoReservaEstoque` é pulado por design nesse
ponto do fluxo — a trava fica estruturalmente inerte para 100% dos endereçamentos com COFEND ativo,
não só para casos isolados de falha de recriação.

### Implicação para a correção

A trava planejada (Fase 2 de `tasks.md`, subtrair `FDO_QTDBAI` no `SUM`) **não teria efeito algum**
neste ambiente: a query de existência nunca encontra `DEL_FATGOR`/`DEL_EXTGOR`, então a query que
computaria `QTDAENDERECAR` com a fórmula corrigida nunca chega a rodar. Fazer `pValQtdEnderecada`
funcionar de verdade em ambientes `CFG_COFEND='S'` exige uma de duas frentes (a decidir com o
usuário):
1. Buscar o pedido de reserva pendente também nas tabelas **vivas** (`FATGOR`/`EXTGOR`/`FATDOR`),
   não só nas arquivadas (`DEL_*`) — cobrindo o caso em que o pedido ainda não foi apagado.
2. Ou mover/duplicar o apagamento (`fApagaPedidoReservaEstoque`) para antes da geração da TA também
   quando `blnCofEnd` está ativo — mas isso exige entender por que a condição atual exclui esse
   caso deliberadamente (pode haver um motivo de negócio ainda não mapeado para não apagar a reserva
   já nesse ponto quando `CFG_COFEND='S'`).

---

## Passo 8 — Correção aplicada (Nota 4): `pValQtdEnderecada` também busca o pedido vivo

Implementado em `padra_atualizado/fontes/movimentacaoitens/untTransferenciaArmazens.pas`
(procedure aninhada `pValQtdEnderecada`, dentro de `TTransferenciaArmazens.fGeraTransferencia`),
via Python (encoding cp1252/CRLF preservado, validado sem corrupção: sem `\xef\xbf\xbd`, decodifica
limpo, CRLF 2823/LF solto 0).

### O que mudou

1. **Resolução local de `blnCofEndLocal`/`blnUDEVMELocal`** no início de `pValQtdEnderecada` — a
   classe `TTransferenciaArmazens` não carregava esses flags, então foram calculados com a mesma
   fórmula de `TfrmEntEnderecamentoProduto` (`untEntEnderecamentoProduto.pas:557-558`):
   ```pascal
   blnCofEndLocal := (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D');
   blnUDEVMELocal := fCfgSis('UDEVME', varBoolean);
   ```
2. **1ª query (existência do pedido de reserva)** — removido `AND FGO_DTAENT >= :DTAENT` (filtro de
   janela de 12 meses que não tinha relação com o problema) e adicionado `UNION ALL` contra as
   tabelas **vivas** (`FATGOR`/`EXTGOR`), condicionado a `blnCofEndLocal or blnUDEVMELocal`:
   ```pascal
   qryPedidoEnderecamento.SQL.Add(' SELECT DEL_FATGOR.AUTOINCREM ');
   qryPedidoEnderecamento.SQL.Add('   FROM DEL_FATGOR ');
   qryPedidoEnderecamento.SQL.Add('   JOIN DEL_EXTGOR ON DEL_FATGOR.AUTOINCREM = DEL_EXTGOR.FGO_SEQFGO ');
   qryPedidoEnderecamento.SQL.Add('  WHERE FGO_DOCEND = :DOCFUL ');
   If blnCofEndLocal or blnUDEVMELocal Then
   Begin
     qryPedidoEnderecamento.SQL.Add(' UNION ALL ');
     qryPedidoEnderecamento.SQL.Add(' SELECT FATGOR.AUTOINCREM ');
     qryPedidoEnderecamento.SQL.Add('   FROM FATGOR ');
     qryPedidoEnderecamento.SQL.Add('   JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
     qryPedidoEnderecamento.SQL.Add('  WHERE FGO_DOCEND = :DOCFUL ');
   End;
   ```
3. **2ª query (soma `FDO_QTDITE`)** — mesmo padrão de `UNION ALL` contra `EXTGOR`/`FATDOR`/`EXTDOR`
   vivos (senão os `AUTOINCREM` de `FATGOR` vivo trazidos pela 1ª query não bateriam em nenhum
   `JOIN`, já que essa parte só enxergava `DEL_EXTGOR`/`DEL_FATDOR`/`DEL_EXTDOR`).
4. **Limpeza (pedida pelo usuário durante a implementação):** removidas as 6 linhas
   `SUBSTRING(FGO_DOCEND, N, M) = :XXXX` (e os `ParamByName('DOCEND'..'TIPEND')` correspondentes,
   que ficaram sem uso) da 2ª query, nos dois ramos (`DEL_*` e o novo vivo) — redundantes, já que
   `FGO_SEQFGO IN (strDocEndIn)` sozinho já restringe às linhas cujo `FGO_DOCEND` já bateu
   exatamente com `:DOCFUL` na 1ª query.
5. **`SUM(...) AS QTDAENDERECAR` condicional (pedido pelo usuário, ajuste seguinte na mesma
   correção):** em ambientes `CFG_COFEND`/`CFG_UDEVME`, comparar contra a quantidade **pendente**
   do pedido (`FDO_QTDITE - FDO_QTDBAI`), não contra o total bruto — senão a trava nunca acusaria
   endereçamento parcial já baixado. Aplicado nos dois ramos:
   - **Ramo `DEL_*`** (sempre montado, precisa escolher a fórmula em runtime):
     ```pascal
     If blnCofEndLocal or blnUDEVMELocal Then
       qryPedidoEnderecamento.SQL.Add('  SUM(IFNULL(FDO_QTDITE, 0)- IFNULL(FDO_QTDBAI, 0)) AS QTDAENDERECAR, ')
     Else
       qryPedidoEnderecamento.SQL.Add('  SUM(IFNULL(FDO_QTDITE, 0)) AS QTDAENDERECAR, ');
     ```
   - **Ramo vivo** (`EXTGOR`/`FATDOR`, já dentro do `If blnCofEndLocal or blnUDEVMELocal`): usa a
     fórmula pendente direto, sem `If` redundante (a condição já está garantida ali).

   Isso retoma, com o `If` condicionado ao ambiente, a correção que já estava planejada na Fase 2
   de `tasks.md` (subtrair `FDO_QTDBAI`) — mas que, isolada, não teria efeito neste ambiente porque
   a query nunca encontrava dado nenhum (ver Passo 7). Com os Passos 7+8 combinados, a trava agora
   encontra o pedido (vivo ou arquivado) **e** compara contra a quantidade pendente correta.
6. **Bug apontado pelo usuário durante a implementação — soma perdida quando os dois ramos
   retornam linha para o mesmo item:** cada ramo (`DEL_*` e vivo) faz seu próprio
   `GROUP BY FDO_CODITE`; se um pedido estiver **parcialmente** arquivado (alguns itens já em
   `DEL_*`, outros ainda vivos), o `UNION ALL` gera **2 linhas** para o mesmo `CODITEPEDIDO`. O
   consumo (`qryPedidoEnderecamento.Locate('CODITEPEDIDO', ...)`) só acha a **primeira** — a
   `QTDAENDERECAR` da outra parte seria perdida, subestimando a quantidade pendente e podendo
   deixar a trava passar mesmo com divergência real.

   **Correção:** envolvida a query inteira numa camada externa que soma de novo por
   `CODITEPEDIDO`, mesmo padrão já usado por `qryQtdEnderecada` (linhas anteriores da mesma
   procedure, `SELECT TAB.DET_CODITE, SUM(TAB.QTDITE) ... FROM (...) AS TAB GROUP BY TAB.DET_CODITE`):
   ```pascal
   qryPedidoEnderecamento.SQL.Add(' SELECT TAB.CODITEPEDIDO, SUM(TAB.QTDAENDERECAR) AS QTDAENDERECAR ');
   qryPedidoEnderecamento.SQL.Add(' FROM ( ');
     <SELECT DEL_EXTGOR/DEL_FATDOR/DEL_EXTDOR ... GROUP BY FDO_CODITE>
     UNION ALL   -- so quando blnCofEndLocal or blnUDEVMELocal
     <SELECT EXTGOR/FATDOR/EXTDOR (vivas) ... GROUP BY FDO_CODITE>
   qryPedidoEnderecamento.SQL.Add(' ) AS TAB ');
   qryPedidoEnderecamento.SQL.Add(' GROUP BY TAB.CODITEPEDIDO ');
   ```
   De quebra, removidas as colunas `SUBSTRING(FGO_DOCEND,...) AS NUMDOC/ESPDOC/SERDOC/EMPDOC/
   FORDOC/TIPDOC` das duas SELECTs internas — confirmado via grep (`qryPedidoEnderecamento.
   FieldByName`) que nunca são lidas pelo código (só `CODITEPEDIDO` e `QTDAENDERECAR`); mantê-las
   exigiria agregá-las também no `SELECT` externo sem necessidade real.

7. **`blnSalvar` incluído no `If` que grava `FATEND`/quantidade parcial (pedido pelo usuário, achado
   durante a validação com caso real):** em `TfrmEntEnderecamentoProduto.btnConfirmaClick`
   (`untEntEnderecamentoProduto.pas:2855`), o bloco que chama `fGravarFatEnd`/
   `fGravarQuantidadeParcialEnderecamento` rodava **incondicionalmente** quando `blnCofEnd or
   blnUDEVME`, mesmo que um passo anterior do salvamento (agora, com a Nota 4, `pValQtdEnderecada`)
   já tivesse marcado `blnSalvar := False` por ter encontrado divergência. Corrigido para:
   ```pascal
   If blnSalvar And (blnCofEnd or blnUDEVME) Then
   Begin
     objEnderecamento.pSetIdEnd;
     objEnderecamento
       .fConsulta(cdsConsulta)
       .fGravarFatEnd
       .fGravarQuantidadeParcialEnderecamento;
   End;
   ```
   Sem isso, mesmo com a trava (Nota 4) acusando a divergência e abortando a TA, este bloco ainda
   gravaria `FATEND`/quantidade parcial com o valor duplicado antes do `fRollBack` — a trava impedia
   a TA, mas não impedia por si só esse outro efeito colateral da mesma tentativa de gravação.

Comentário curto no fonte + `Verificar Nota 4 - Req. 459132` nos pontos alterados.

### Validação com caso real (usuário, tela `frmEntEnderecamentoProduto`)

Reproduzido o cenário real do requisito (NF `000000009771`, série 6, fornecedor `00000847`, item
`07888`) na tela de Endereçamento do Produto, com o item mostrando saldo duplicado (`Quant.=434,00`
na grid, quando o pedido real é `217`). Ao confirmar (`F10`), a trava disparou:

```
Erro: Houve inconsistência na gravação da TA. Entre em contato com a Citel.
Quantidade Registros Saída    = 1804
Quantidade Registros Entrada  = 1804
Quantidade Registros Endereçados: = 434,0000
Quantidade Registros A Endereçar: = 217,0000
Código Item: = 07888
```

Ou seja: `pValQtdEnderecada` agora **encontra** o pedido de reserva (via `UNION ALL` contra as
tabelas vivas, Nota 4) e **acusa corretamente** a divergência (434 endereçado × 217 pendente real,
exatamente o padrão histórico do requisito) — a TA deixou de ser gravada com a quantidade
duplicada, bloqueando a inconsistência em vez de deixá-la passar silenciosamente. **Validação
end-to-end da Nota 4 concluída com sucesso.**

### Por que fecha o Passo 7

Com `CFG_COFEND='S'` nesta base, `blnCofEndLocal=True` — a partir de agora, mesmo quando
`fApagaPedidoReservaEstoque` não arquiva o pedido em `DEL_FATGOR`/`DEL_EXTGOR`/`DEL_FATDOR`/
`DEL_EXTDOR` antes da geração da TA, `pValQtdEnderecada` passa a encontrá-lo direto em
`FATGOR`/`EXTGOR`/`FATDOR`/`EXTDOR` (tabelas vivas) via o `UNION ALL`, e a comparação
`QTDAENDERECAR` × `QTDITE` volta a rodar de fato, em vez de ficar silenciosamente inerte.

*(Continuação: aguardando próximo passo do usuário.)*
