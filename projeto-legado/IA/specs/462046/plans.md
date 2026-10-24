# Plano de Execução — Req. 462046

**Referência:** specs.md
**Zona:** Legado (`padra_atualizado/fontes/faturamento/`)

## 1. Abordagem técnica

Correção pontual e cirúrgica, sem refatoração da rotina. `fReceberModalidadeInterna` é um método de ~1.000 linhas de `TfrmFatConfOrcamentos` (form VCL herdado de `TfrmPai`); a regra da Zona Legado é não refatorar proativamente.

A alteração troca a origem do valor gravado em `cdsModalidades.VALOR`: em vez de reler `edtValor.Value` da tela, usa `fltValDig` — o valor capturado no início da rotina e efetivamente enviado ao pinpad. A troca é condicionada a uma guarda de três termos para não afetar nenhum outro caminho de recebimento.

```pascal
If (VS_blnTefCitel) And (Assigned(objTefCitel)) And (Assigned(RetornoTEFCitel)) Then
  FieldByName('VALOR').AsFloat := fltValDig
Else
  FieldByName('VALOR').AsFloat := edtValor.Value;
```

### Justificativa de cada termo da guarda

| Termo | Papel |
|-------|-------|
| `VS_blnTefCitel` | Restringe ao TEF Citel. Equivale a `CFG_TEFCIT` em (`'S'` CliSiTef, `'T'` NCR/Scope), conforme `untFuncoesSimples.pas:9770`. |
| `Assigned(objTefCitel)` | Garante que a lib do TEF Citel está instanciada (`untTefCitelUtil.pas:163`). |
| `Assigned(RetornoTEFCitel)` | Garante que **esta** modalidade passou pelo pinpad. Sem ele a guarda valeria para toda a estação e quebraria a modalidade 013, que ajusta `edtValor.Value` na linha 4188 depois da captura de `fltValDig`. É interface local, inicializada como `nil`, atribuída apenas no ramo do TEF Citel (linhas 3663/3665). |

### Matriz de caminhos

| Cenário | `RetornoTEFCitel` | Valor gravado |
|---------|-------------------|---------------|
| Cartão TEF Citel aprovado | atribuído | `fltValDig` |
| Cartão POS / QUEST / GrynCash | `nil` | `edtValor.Value` |
| Dinheiro, cheque, cheque-pré, PIX | `nil` | `edtValor.Value` |
| Utilização de Créditos (013) | `nil` | `edtValor.Value` |
| TEF cancelado pelo operador | `nil` | não chega ao `Append` (`blnConfirma = False`) |

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untFatConfOrcamentos.pas` | `padra_atualizado/fontes/faturamento/` | alterar (linhas 4204-4219) |

Nenhum outro arquivo é tocado: sem mudança em `uses`, `.dfm`, `.dpr`, `.dproj` ou schema de banco.

## 3. Sequência de implementação

1. **[Concluído]** Substituir a atribuição direta de `VALOR` pela guarda condicional em `untFatConfOrcamentos.pas`, com bloco de comentário identificando o requisito.
2. **[Concluído]** Confirmar que `untTefCitelUtil` já consta no `uses` (linha 19) e que `objTefCitel` já é usado na unit (linhas 15716/15735) — nenhuma dependência nova.
3. **[Concluído]** Verificar encoding Windows-1252 + CRLF preservado após a edição.
4. **[Pendente]** Compilar `padra_atualizado/autcom.groupproj` no Delphi Seattle.
5. **[Pendente]** Executar os cenários de validação da seção 5.
6. **[Pendente]** `/review` → gate DelphAI → commit.

## 4. Conformidade com padrões do projeto

- **Zona Legado:** mantido o estilo da rotina; Hungarian style preservado (`fltValDig`, `edtValor`, `VS_blnTefCitel`); nenhuma refatoração introduzida.
- **Componentes:** nenhum componente novo. Não há `TButton`, `TBitBtn`, `TDBGrid`, `TClientDataSet`, `TDataSetProvider`, `dxSkin*` nem `frxSmartMemo` envolvidos.
- **Chamadas:** nenhuma chamada bloqueada introduzida — sem `Now`/`NOW()`, `StrToFloat`/`StrToFloatDef`, `.SetFocus` direto, `Application.CreateForm`, `ActiveControl :=` ou SQL concatenado. A alteração não executa SQL.
- **SQL:** nenhum. Sem `FOREIGN_KEY_CHECKS`.
- **`.dfm`:** não alterado — sem `FillType = ftBrush` nem `Outline =`.
- **Encoding:** Windows-1252 + CRLF, garantido pelo hook `.claude/hooks/delphi-encoding.ps1` e verificado com `iconv -f CP1252`.

## 5. Estratégia de testes

**Não há suite automatizada aplicável.** `padra_atualizado/TestesUnitarios/AutcomTestes.dpr` cobre `Faturamento/{Impostos, Margem, Model, Precos, Outros}` — classes de regra, não formulários VCL. A lógica alterada está dentro de um método de instância de `TfrmFatConfOrcamentos`, que exigiria extração para uma função testável; isso foi definido como fora de escopo.

Validação inteiramente **manual**, em homologação com pinpad (ambiente Scope já existente).

### Cenário principal — reprodução do defeito

1. Pedido com total 476,62, condição 010 (crédito 5x).
2. Modalidade CARTÃO, digitar 476,62, Enter.
3. Passar o cartão e concluir o TEF normalmente.
4. No instante em que o pinpad exibir `AUTORIZADO`, digitar `3` no campo Valor.
5. **Esperado:** grade grava 476,62; `Valor Digitado` fecha com o total; `[F10]` libera sem segunda passada.
6. **Antes da correção:** grade gravava 3,00 e o sistema disparava segunda cobrança de 473,62.

### Cenários de regressão

| Caso | Esperado |
|------|----------|
| Utilização de Créditos (013) | grava o valor dos créditos utilizados |
| Dinheiro (001) | grava o valor digitado |
| Cartão POS | grava o valor digitado |
| TEF cancelado no pinpad | nenhuma linha gravada |
| Cartão TEF Citel sem interferência na tela | grava o valor digitado (igual a `fltValDig`) |

## 6. Riscos e mitigação

| Risco | Mitigação |
|-------|-----------|
| Guarda ampla demais quebraria a modalidade 013 | Terceiro termo `Assigned(RetornoTEFCitel)` isola a modalidade que passou pelo pinpad |
| Ausência de regressão automatizada | Checklist manual explícito na seção 5 e nos critérios de aceitação do specs.md |
| Causa estrutural mantida (janela de reentrada no form) | Registrada em specs.md seção 7 item 1; outros campos da tela seguem alteráveis durante o retorno do TEF |
| TEF antigo (`VS_objTef`) e POS não corrigidos | Decisão explícita de escopo; specs.md seção 7 item 4 |
| Correção não compilada até o momento | Passo 4 da sequência é bloqueante antes de qualquer commit |
