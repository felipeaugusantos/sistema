# Especificação — Req. 462046

**Título:** Gravar na grade de modalidades o valor efetivamente autorizado no TEF Citel
**Objetivo:** Impedir que a linha de modalidade cartão registre valor diferente do que foi enviado e autorizado no pinpad, evitando cobrança duplicada ao cliente e bloqueio do fechamento.
**Zona:** Legado
**Data:** 15/09/2026

## 1. Contexto / problema atual

No fechamento pelo F11 (`TfrmFatConfOrcamentos`), a rotina `fReceberModalidadeInterna` captura o valor digitado em `edtValor` uma vez, no início:

```pascal
3518:  fltValDig := edtValor.Value;
```

`fltValDig` é o valor enviado ao pinpad (`fChamaTelaDeOperacoes` → `frmTefCitelOperacoes.fltValor`) e o valor repassado a `fDigCartao`, que alimenta `arrCartoes[].fltValDig`.

Ao gravar a linha na grade, porém, o código **relê o controle da tela** em vez de usar o valor capturado:

```pascal
4204:  FieldByName('VALOR').AsFloat := edtValor.Value;
```

Entre os dois pontos ocorre todo o round-trip do TEF. Nesse intervalo o formulário é reabilitado e trazido para frente, ainda dentro do modal `TfrmGravando` que executa o recebimento:

```pascal
3706:  If Not fEhRecebimentoFormasPagtoNegociadas Then
3707:  Begin
3708:    Self.Enabled := True;
3709:    SetForegroundWindow(Handle);
3710:  End;
```

Com TEF Citel, `fExibirTelaParaInformarDadosDoCartao` retorna `False` (os campos do cartão vêm preenchidos pelo retorno), então `frmRcxDigCartoes` não é exibido e **nenhum modal fica na frente** até o `Append`. Qualquer alteração no campo Valor nessa janela é gravada na grade como se fosse o valor pago.

### Ocorrência registrada

Pedido 42369, empresa 001, estação TSPlus04, operador `jouglard_01_102`, 14/09/2026:

| Doc TEF | Hora | Valor TEF | NSU | Autorização | Status |
|---------|------|-----------|-----|-------------|--------|
| 0000000575 | 14:29:13 | 476,62 | 00000506593568 | 084916 | CANCELADA PDV |
| 0000000579 | 14:29:52 | 473,62 | 00000339347760 | 094338 | CANCELADA PDV |

O log do Scope confirma que a primeira transação foi **aprovada e retornou íntegra** ao PDV (`AUTORIZADO Controle 09402502019`, valor `47662`) — não houve erro de comunicação nem timeout. Mesmo assim a grade recebeu 3,00.

Estado resultante:

| Registro | Cartão 1 | Cartão 2 | Soma |
|----------|----------|----------|------|
| `cdsModalidades.VALOR` (grade) | 3,00 | 473,62 | 476,62 — tela "fecha" |
| `arrCartoes[].fltValDig` (TEF) | 476,62 | 473,62 | 950,24 — bloqueia o fechamento |

Como a grade fechava com o total do pedido, o sistema repôs `edtValor` com o restante de 473,62 e disparou a segunda cobrança. O cliente foi debitado em 950,24 até o estorno das duas transações.

Reproduzido em homologação com pinpad, digitando no campo Valor no instante em que o pinpad exibe `AUTORIZADO`.

## 2. Módulos e entidades envolvidos

- **Módulo:** faturamento
- **Unit alterada:** `padra_atualizado/fontes/faturamento/untFatConfOrcamentos.pas`
- **Units consultadas (sem alteração):**
  - `padra_atualizado/fontes/tef/TefCitel/untTefCitelUtil.pas` — `objTefCitel: ITefCitel`
  - `padra_atualizado/fontes/libTefCitel/untInterfaceTefCitel.pas` — `OPCAO_CLISITEF = 'S'`, `OPCAO_NCR = 'T'`
  - `padra_atualizado/fontes/genericos/untFuncoesSimples.pas` — `VS_blnTefCitel`
  - `padra_atualizado/fontes/resumodecaixa/untRcxDigCartoesController.pas` — origem de `arrCartoes[].fltValDig`
- **Tabelas (somente leitura, sem alteração de schema):**
  - `TEFTRA` — PK `AUTOINCREM`; usada como evidência da transação
  - `CFGSIS` — PK `SIS_CODEMP` + `SIS_CODCFG`; leitura de `CFG_TEFCIT`
- **Dataset em memória:** `cdsModalidades` (`TUniClientDataSet`, índice `IDX` = `ORDEM;ECF_CODMOD`)

## 3. Requisitos funcionais

- **RF01** — Quando a modalidade cartão passar pelo TEF Citel e a transação retornar aprovada, o campo `VALOR` da linha em `cdsModalidades` deve receber `fltValDig` (valor enviado/autorizado no pinpad).
- **RF02** — Em todos os demais caminhos, `VALOR` continua recebendo `edtValor.Value`, sem alteração de comportamento.
- **RF03** — `arrCartoes[].fltValDig` não é alterado por este requisito; ele já registra o valor correto.
- **RF04** — Com TEF Citel desativado (`CFG_TEFCIT` diferente de `'S'` e `'T'`) o comportamento permanece exatamente o atual.

## 4. Regras de negócio

- **RN01 — Condição de aplicação.** O valor autorizado só é usado quando as três condições forem verdadeiras:
  - `VS_blnTefCitel` — derivado de `MatchStr(fCfgSis('TEFCIT'), [OPCAO_CLISITEF, OPCAO_NCR])`, ou seja `'S'` (CliSiTef) ou `'T'` (NCR/Scope);
  - `Assigned(objTefCitel)` — a lib do TEF Citel está instanciada;
  - `Assigned(RetornoTEFCitel)` — **esta** modalidade passou pelo pinpad e voltou com retorno.

- **RN02 — Origem única do valor.** `fltValDig` tem atribuição única no escopo de `fReceberModalidadeInterna` (linha 3518) e chega intacto ao `Append`. É o mesmo valor entregue a `fChamaTelaDeOperacoes` e a `fDigCartao`.

- **RN03 — Modalidade 013 (Utilização de Créditos).** Não pode usar `fltValDig`. A linha 4188 ajusta `edtValor.Value := fltCredUtilizados` **depois** da captura de `fltValDig`, portanto o valor correto para 013 é o da tela. O termo `Assigned(RetornoTEFCitel)` garante esse isolamento, já que a variável é interface local (inicializada como `nil`) atribuída apenas dentro do ramo do TEF Citel.

- **RN04 — Troco.** As subtrações de troco-crédito nas linhas seguintes (`optTroco`, `optTrocoPre`, `optTrocoCar`, `optTrocoDin`) permanecem inalteradas. Na empresa 001 estão inertes (`CFG_TROCAR = N`, `CFG_UTTROC = N`).

- **RN05 — TEF cancelado.** Se o operador cancelar no pinpad, `RetornoTEFCitel` fica `nil`, `blnConfirma` vira `False` e o fluxo não chega ao `Append`. Nenhuma linha é gravada.

- **RN06 — POS, QUEST e GrynCash.** Não passam pelo ramo do TEF Citel; seguem pelo `Else` com `edtValor.Value`.

## 5. Requisitos técnicos / não-funcionais

- Zona Legado: manter Hungarian style e o estilo do código existente; não refatorar a rotina.
- Encoding do fonte: Windows-1252 (latin1) + CRLF — preservado pelo hook `.claude/hooks/delphi-encoding.ps1`.
- Sem alteração na cláusula `uses` (`untTefCitelUtil` já consta na linha 19), sem alteração em `.dfm` e sem alteração em `.dpr`/`.dproj`.
- Sem nova transação, auditoria ou permissão.
- **Impacto financeiro:** o `VALOR` da modalidade alimenta `fatVenda.fltValCar`, a geração de duplicatas e o resumo de caixa. Valor divergente gera diferença de caixa e cobrança indevida ao cliente.
- Sem impacto fiscal direto (não altera base de cálculo nem documento fiscal).

## 6. Critérios de aceitação

Validação **manual** — ver seção 7 quanto à ausência de suite automatizada.

- [ ] `autcom.groupproj` compila sem erros no Delphi Seattle
- [ ] Cenário reproduzido: pedido de 476,62 em crédito parcelado, alterar o campo Valor durante o retorno do TEF → a grade grava **476,62**
- [ ] `Valor Digitado` fecha com o total do pedido e o `[F10] Confirma` libera, sem segunda passada de cartão
- [ ] Modalidade 013 (Utilização de Créditos) continua gravando o valor dos créditos utilizados
- [ ] Modalidade 001 (Dinheiro) continua gravando o valor digitado
- [ ] Cartão POS continua gravando o valor digitado
- [ ] TEF cancelado no pinpad não grava linha na grade
- [ ] Nenhum padrão bloqueado pelo pre-commit introduzido

## 7. Fora de escopo

Itens identificados na investigação e **não tratados** neste requisito, por decisão do solicitante:

1. **Janela de reentrada no formulário.** `Self.Enabled := True; SetForegroundWindow(Handle)` nas linhas 3706-3710 reabilita `frmFatConfOrcamentos` enquanto o modal `TfrmGravando` ainda está aberto, quebrando o isolamento modal. É a causa estrutural que permite a alteração de qualquer campo da tela durante o retorno do TEF.
2. **Trava de consistência.** Não haverá validação `edtValor.Value <> fltValDig` com estorno automático da transação no momento do `Append`.
3. **`pZeraOpcaoTrocoCheque` ausente no início de `fReceberModalidadeInterna`.** `optTrocoCar` / `fltValorTrocoCar` são campos do form zerados apenas no init, na exclusão de modalidade e na limpeza de tela. Com `CFG_TROCAR = S` em outra empresa, um troco residual seria reaplicado ao cartão seguinte (linha 4213). Bug latente, não manifesto na empresa 001.
4. **TEF antigo (`VS_objTef`) e cartão POS.** Percorrem o mesmo trecho defeituoso e permanecem usando `edtValor.Value`, por decisão de manter a correção restrita ao TEF Citel.
5. **Cobertura automatizada.** Não será criado teste unitário nem extraída função testável.

## 8. Dependências e riscos

- **Dependência:** compilação no Delphi Seattle; validação exige pinpad em ambiente de homologação com Scope.
- **Risco — guarda ampla demais.** `VS_blnTefCitel` sozinho é verdadeiro para toda a estação e quebraria a modalidade 013. *Mitigado* por `Assigned(RetornoTEFCitel)`.
- **Risco — ausência de regressão automatizada.** Depende de execução disciplinada dos cenários da seção 6. *Mitigado* por critérios de aceitação explícitos e verificáveis.
- **Risco residual — causa estrutural mantida.** Outros campos da tela (cliente, condição, transportadora) continuam alteráveis durante o retorno do TEF. Ver item 1 da seção 7.
