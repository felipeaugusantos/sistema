# Req. 458948 — Plano de implementação

> Contrato e critérios de aceitação em `spec.md`. Este documento é o roteiro técnico;
> o checklist de execução é o `tasks.md`.

**Objetivo:** cadastrar percentual de juros por faixa de valor, devolver a tabela de parcelamento
já calculada no endpoint de faixa, e permitir que a baixa de duplicatas receba e grave o juros
escolhido.

**Arquitetura:** três frentes independentes até a compilação. A Frente A (banco + cadastro) é VCL
legado. As Frentes B (simulação) e C (baixa) são serviço Linux, cada uma no par
`Financeiro.Services.<Recurso>` + `types/`. Nenhuma unit nova, nenhuma tabela nova.

**Stack:** Delphi Seattle, UniDAC, DMVCFramework, MySQL. Desktop compilado por
`autcom.groupproj`; serviço por `Services.groupproj` (PAServer/Linux).

## Restrições globais

Valem para toda tarefa deste plano, sem exceção:

- **Não há TDD neste projeto.** Nem na zona legado (sem infraestrutura), nem na moderna (o caso de
  teste é escrito por analista). Nenhuma tarefa abaixo pede "escrever o teste antes".
- **Travas do pre-commit SVN.** Proibidos e já relevantes aqui: `StrToFloat(` / `StrToFloatDef(`
  (usar `fStrToFloat` / `fStrToFloatDef`), `.SetFocus` direto (usar `pSetFocus`), `Now`/`NOW()`
  (usar `fNow()`), `TBitBtn`/`TButton` (usar `TBitBtnLocked`).
- **Zona legado** (`fontes/`): Hungarian obrigatório, prefixo `F` em campo privado, `p`/`f` em
  métodos. Não refatorar o que está ao redor.
- **Zona moderna** (`Services/`): dot-notation, sem Hungarian, Controller → Service → Repository.
- **Encoding:** fontes Delphi em CP1252 com CRLF. **O hook `.claude/hooks/delphi-encoding.ps1` está
  configurado mas NÃO é executado** — verificado em 28/08/2026 com um `.pas` de teste de 7 linhas:
  o Edit gravou UTF-8 e destruiu os dois acentos, sem o hook barrar. Para quem edita por IA: antes
  de tocar num `.pas`, contar os bytes `>= 0x80`; havendo algum, editar **somente** por PowerShell
  ou Python lendo e gravando em CP1252, nunca pelas ferramentas de edição. Conferir depois que
  `EF BF BD` é zero e que a contagem de bytes altos bate com a de antes. Isso já custou quatro
  arquivos corrompidos neste projeto.
- **Commit SVN:** primeira linha `Req. 458948`, token do DelphAI obrigatório na mensagem.

## Mapa de arquivos

| Arquivo | Responsabilidade | Frente |
|---------|------------------|--------|
| `IA/specs/458948/alterar_tabela_fxcasa.sql` | DDL da coluna nova | A |
| `fontes/cadastros/untCadFaixaParcelamentoCartao.pas` | validação e formatação do campo | A |
| `fontes/cadastros/untCadFaixaParcelamentoCartao.dfm` | label + edit do percentual | A |
| `fontes/genericos/untConsultas.pas` | coluna na grade de pesquisa da faixa | A |
| `Core/financeiro/services/types/Financeiro.Services.ParcelamentoCartao.Types.pas` | DTO da opção + campos no result | B |
| `Core/financeiro/services/Financeiro.Services.ParcelamentoCartao.pas` | leitura da faixa e montagem da tabela | B |
| `Financeiro.Services.API/.../api.controller.parcelamentocartao.pas` | documentação Swagger | B |
| `Core/financeiro/services/types/Financeiro.Services.Cobranca.Baixa.Types.pas` | `jurosParcelamento` no item de cartão | C |
| `Core/financeiro/services/Financeiro.Services.Cobranca.Baixa.pas` | fechamento, rateio e gravação | C |
| `Financeiro.Services.API/Scripts/testes/008_INFRA_FAIXA_JUROS.sql` | massa de teste | D |
| `.../Target/Linux/Test_Cases/Cartao/LimiteParcelasTest.inc` | casos REST — **analista** | D |
| `.../Target/Linux/Test_Cases/Cobranca/BaixaTest.inc` | casos REST — **analista** | D |

---

# Frente A — Banco e cadastro

## Tarefa 1: Coluna `FAI_PERJUR`

**Arquivo:** criar `IA/specs/458948/alterar_tabela_fxcasa.sql`

```sql
-- ============================================================================
-- Req. 458948 - percentual de juros de parcelamento por faixa de valor
-- ============================================================================
-- A FXCASA nasceu no Req. 454627 com escopo GLOBAL (sem FAI_CODEMP). O
-- percentual acompanha esse escopo: vale para todas as empresas da instancia.
--
-- Nulo por padrao de proposito. As faixas ja cadastradas continuam validas sem
-- intervencao, e o endpoint devolve juros zero ate alguem preencher (spec R5).
-- ============================================================================

ALTER TABLE FXCASA
  ADD COLUMN FAI_PERJUR DECIMAL(5,2) DEFAULT NULL AFTER FAI_QTDPAR;

-- Conferencia
SHOW COLUMNS FROM FXCASA LIKE 'FAI_PERJUR';
```

**Passos:**

- [ ] Criar o arquivo com o conteúdo acima
- [ ] Executar na base de desenvolvimento e conferir o `SHOW COLUMNS`
- [ ] Conferir que as faixas existentes continuam legíveis: `SELECT * FROM FXCASA`

## Tarefa 2: Campo no cadastro

**Arquivos:**
- Modificar: `fontes/cadastros/untCadFaixaParcelamentoCartao.dfm`
- Modificar: `fontes/cadastros/untCadFaixaParcelamentoCartao.pas`

O form tem hoje 3 campos numa linha só, ocupando até `Left = 446` numa largura de 534. Um quarto
campo na mesma linha exigiria alargar o form e remanejar `pnlBotoes`, `FlwBotoes` e `btnSair`. **Usar
uma segunda linha** — mexe só em alturas.

- [ ] **Passo 1: `.dfm` — abrir espaço**

Alterar as alturas, nesta ordem:

```
TfrmCadFaixaParcelamentoCartao.Height   128 -> 156
pnlDados.Height                          58 ->  86
pnlBotoes.Top                            58 ->  86
pnlStatus.Top                            83 -> 111
```

- [ ] **Passo 2: `.dfm` — label e edit novos**

Dentro de `pnlDados`, depois de `edtQtdPar`:

```
    object lblPerJur: TLabel
      Left = 6
      Top = 52
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = '% Juros a.m.:'
    end
    object edtPerJur: TDBEditFocus
      Tag = 99
      Left = 73
      Top = 46
      Width = 83
      Height = 22
      DataField = 'FAI_PERJUR'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
```

- [ ] **Passo 3: `.pas` — declarar os componentes**

Na declaração da classe, junto dos outros:

```pascal
    lblPerJur: TLabel;
    edtPerJur: TDBEditFocus;
```

- [ ] **Passo 4: `.pas` — formatação**

Em `pFormatarCamposFaixas`, junto dos existentes:

```pascal
  qryFaixas.FieldByName('FAI_PERJUR').DisplayLabel := '% Juros a.m.';

  TFloatField(qryFaixas.FieldByName('FAI_PERJUR')).DisplayFormat := '#,##0.00';
```

- [ ] **Passo 5: `.pas` — incluir na gravação**

Em `pInicializaIndices`, acrescentar **antes** de `AUTOINCREM`:

```pascal
  stlCampos.Add('FAI_PERJUR');
```

`stlCamInd` e `stlDesInd` não mudam — o percentual não é campo de índice de busca.

- [ ] **Passo 6: `.pas` — validação**

Em `fValidaCampos`, novo ramo depois do de `edtQtdPar`:

```pascal
  Else If (Sender = edtPerJur) Then
  Begin
    If (Not fEmptyStr(edtPerJur.Text)) And
       (fStrToFloat(edtPerJur.Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe um percentual de juros maior ou igual a zero!', ['&Ok']);
      Result := False;
    End;
  End;
```

Campo **não** obrigatório: vazio é válido e significa sem juros (spec R5). Por isso o teste de
`fEmptyStr` guarda o de valor, ao contrário dos outros campos.

- [ ] **Passo 7: `.pas` — incluir na validação de gravação**

Em `fValidaFaixaCompleta`, ao final:

```pascal
  If Result Then
    Result := fValidaCampos(edtPerJur);
```

- [ ] **Passo 8: grade de pesquisa**

Em `fontes/genericos/untConsultas.pas`, em `fPesqFaixasParcelamentoCartaoAppSales`
(a partir da linha 50708), acrescentar a coluna no SQL e nos dois arrays:

```pascal
    strSQL := strSQL + '  FAI_QTDPAR, ';
    strSQL := strSQL + '  FAI_PERJUR  ';
```

```pascal
    If fConsultaConfig([strSQL],
                 ['AUTOINCREM', 'Valor inicial', 'Valor final', 'Qtd. parcelas', '% Juros a.m.'],
                 ['FAI_VALINI', 'FAI_VALFIN', 'FAI_QTDPAR', 'FAI_PERJUR'],
```

- [ ] **Passo 9: compilar e validar à mão**

Compilar `autcom.groupproj`. Roteiro de validação em `tasks.md`, seção Frente A.

- [ ] **Passo 10: commit** — `Req. 458948` + token DelphAI

---

# Frente B — Simulação no endpoint de faixa

## Tarefa 3: DTOs

**Arquivo:** modificar `Core/financeiro/services/types/Financeiro.Services.ParcelamentoCartao.Types.pas`

- [ ] **Passo 1: uses e constante**

Acrescentar `System.Generics.Collections` ao `uses`. Na seção `const`:

```pascal
  PCC_MAX_OPCOES = 60;
```

- [ ] **Passo 2: classe da opção**

Antes de `TParcelamentoCartaoLimiteParcelasResult`:

```pascal
type
  {$M+}
  TParcelamentoCartaoOpcao = class
  private
    Fparcelas     : Integer;
    Fjuros        : Double;
    FvalorTotal   : Double;
    FvalorParcela : Double;
  published
    [MVCSwagJsonSchemaField(stInteger, 'parcelas', 'Numero de parcelas desta opcao', True, False)]
    property parcelas: Integer read Fparcelas write Fparcelas;

    [MVCSwagJsonSchemaField(stNumber, 'juros', 'Juros de parcelamento desta opcao', True, False)]
    property juros: Double read Fjuros write Fjuros;

    [MVCSwagJsonSchemaField(stNumber, 'valorTotal', 'Valor consultado acrescido do juros', True, False)]
    property valorTotal: Double read FvalorTotal write FvalorTotal;

    [MVCSwagJsonSchemaField(stNumber, 'valorParcela', 'Valor de cada parcela. A ultima absorve a sobra de centavos e vale valorTotal - valorParcela x (parcelas - 1)', True, False)]
    property valorParcela: Double read FvalorParcela write FvalorParcela;
  end;
```

- [ ] **Passo 3: campos novos no result**

Em `TParcelamentoCartaoLimiteParcelasResult`, na seção `private`:

```pascal
    FpercentualJurosMes : Double;
    FopcoesParcelamento             : TObjectList<TParcelamentoCartaoOpcao>;
```

Na seção `public`, junto de `Create` e `Destroy`:

```pascal
    function NovaOpcao: TParcelamentoCartaoOpcao;
```

Na seção `published`, depois de `faixa`:

```pascal
    [MVCSwagJsonSchemaField(stNumber, 'percentualJurosMes', 'Percentual de juros ao mes cadastrado na faixa. Zero quando nao cadastrado', True, False)]
    property percentualJurosMes: Double read FpercentualJurosMes write FpercentualJurosMes;

    [MVCSwagJsonSchemaField(stArray, 'opcoesParcelamento', 'Uma linha por opcao de parcelamento, de 1 ate limiteParcelas', True, False)]
    [MVCListOf(TParcelamentoCartaoOpcao)]
    property opcoesParcelamento: TObjectList<TParcelamentoCartaoOpcao> read Fopcoes;
```

- [ ] **Passo 4: construtor, destrutor e fábrica**

```pascal
constructor TParcelamentoCartaoLimiteParcelasResult.Create;
begin
  inherited Create;

  Ffaixa  := TParcelamentoCartaoFaixa.Create;
  FopcoesParcelamento := TObjectList<TParcelamentoCartaoOpcao>.Create(True);
end;

destructor TParcelamentoCartaoLimiteParcelasResult.Destroy;
begin
  FopcoesParcelamento.Free;
  Ffaixa.Free;

  inherited;
end;

function TParcelamentoCartaoLimiteParcelasResult.NovaOpcao: TParcelamentoCartaoOpcao;
begin
  Result := TParcelamentoCartaoOpcao.Create;
  FopcoesParcelamento.Add(Result);
end;
```

## Tarefa 4: Cálculo no service

**Arquivo:** modificar `Core/financeiro/services/Financeiro.Services.ParcelamentoCartao.pas`

- [ ] **Passo 1: `uses`** — acrescentar `System.Math` (para `Min`)

- [ ] **Passo 2: SQL** — acrescentar a coluna no `SELECT`:

```pascal
    LSQL := LSQL + 'SELECT FAI_VALINI, FAI_VALFIN, FAI_QTDPAR, FAI_PERJUR ';
```

- [ ] **Passo 3: inicializar o campo novo**

Junto das inicializações que já existem, antes do `Exit` de valor negativo:

```pascal
    Result.percentualJurosMes := 0;
```

- [ ] **Passo 4: ler o percentual e montar a tabela**

Depois de `Result.limiteParcelas := ...`, ao final do método:

```pascal
    Result.percentualJurosMes := LConsulta.FieldByName('FAI_PERJUR').AsFloat;

    LQuantidade := Min(Result.limiteParcelas, PCC_MAX_OPCOES);

    For LParcela := 1 To LQuantidade Do
    Begin
      LOpcao := Result.NovaOpcao;

      LOpcao.parcelas     := LParcela;
      LOpcao.valorTotal   := fFormataFloat(AParams.valor *
                             (1 + (Result.percentualJurosMes * LParcela) / 100), 2);
      LOpcao.juros        := fFormataFloat(LOpcao.valorTotal - AParams.valor, 2);
      LOpcao.valorParcela := fFormataFloat(LOpcao.valorTotal / LParcela, 2);
    End;
```

Declarar no `Var` do método:

```pascal
    LParcela    : Integer;
    LQuantidade : Integer;
    LOpcao      : TParcelamentoCartaoOpcao;
```

`FAI_PERJUR` nulo devolve `0` em `AsFloat`, então R5 sai de graça: percentual zero produz a tabela
inteira com juros zero, sem `If` nenhum.

`limiteParcelas` continua recebendo o `FAI_QTDPAR` cru — o `Min` limita só o laço, conforme spec 3.

## Tarefa 5: Swagger do endpoint

**Arquivo:** modificar `Financeiro.Services.API/.../api.controller.parcelamentocartao.pas`

Nenhuma mudança de lógica: o controller já monta o result e o serializa. Só a descrição.

- [ ] **Passo 1:** atualizar `PCC_SWAGGER_SUMMARY` para mencionar que a resposta traz a tabela de
  parcelamento com o juros de cada opção, além do teto
- [ ] **Passo 2:** compilar `Services.groupproj` para Linux e conferir o `/swagger`
- [ ] **Passo 3: commit** — `Req. 458948` + token DelphAI

---

# Frente C — Baixa com juros de parcelamento

## Tarefa 6: Campo no movimento de cartão

**Arquivo:** modificar `Core/financeiro/services/types/Financeiro.Services.Cobranca.Baixa.Types.pas`

- [ ] **Passo 1: constante de mensagem**, junto das existentes:

```pascal
  BXA_MSG_JUROS_PARC_SEM_BASE = 'Nao e possivel ratear o jurosParcelamento: nenhuma duplicata ' +
                                'do lote tem valorRecebido positivo.';
```

- [ ] **Passo 2: propriedade em `TBaixaCartaoItem`**, logo após `valor`

```pascal
    FjurosParcelamento  : Double;
```

```pascal
    [MVCSwagJsonSchemaField(stNumber, 'jurosParcelamento',
      'Quanto do valor acima e juros de parcelamento. Opcional; ausente ou zero mantem o ' +
      'comportamento sem juros. O servico rateia este juros entre as duplicatas do lote, ' +
      'proporcionalmente ao valorRecebido de cada uma - o consumidor nao rateia, e os valores ' +
      'em duplicatas[] permanecem sem ele. A soma dos valorRecebido mais a soma dos ' +
      'jurosParcelamento de todos os cartoes deve fechar com a soma dos valor',
      False, False)]
    property jurosParcelamento: Double read FjurosParcelamento write FjurosParcelamento;
```

Ajustar também a descrição de `valor`, que passa a dizer que já inclui o juros.

O campo fica no cartão, e não no lote, porque o juros é função da `quantidadeParcelas`, que é
atributo do cartão: dois cartões em parcelamentos diferentes têm juros diferentes.

Nada muda em `TBaixaDuplicataItem`. É decisão de desenho, registrada na spec seção 8: manter o
contrato das duplicatas intocado é o que dispensa alterar a validação de teto do recebido e o que
impede o juros de contaminar o `ValorPago` do cálculo parcial.

## Tarefa 7: Fechamento do lote

**Arquivo:** modificar `Core/financeiro/services/Financeiro.Services.Cobranca.Baixa.pas`

- [ ] **Passo 1: soma dos juros dos cartões**, função nova:

```pascal
class function TBaixaService.SomaJurosParcelamento(
  const AParams: TBaixaDuplicatasParams): Double;
  Var
    LIndice: Integer;
begin
  Result := 0;

  For LIndice := 0 To AParams.movimentos.cartao.cartoes.Count - 1 Do
    Result := Result + AParams.movimentos.cartao.cartoes[LIndice].jurosParcelamento;
end;
```

- [ ] **Passo 2: `ValidarSomaContraMovimentos`** — somar o juros do lado das duplicatas. Declarar
  `LTotalJuros : Double;` no `Var` do método:

```pascal
  LTotalJuros := SomaJurosParcelamento(AParams);

  If fFormataFloat(LTotalDuplicatas + LTotalJuros, 2) <>
     fFormataFloat(LTotalMovimentos, 2) Then
    Raise EInvalidParams.Create('A soma dos valorRecebido das duplicatas (' +
                                FloatToStrF(LTotalDuplicatas, ffNumber, 15, 2) +
                                ') mais o jurosParcelamento dos cartoes (' +
                                FloatToStrF(LTotalJuros, ffNumber, 15, 2) +
                                ') difere da soma dos movimentos (' +
                                FloatToStrF(LTotalMovimentos, ffNumber, 15, 2) + ').');
```

- [ ] **Passo 3: validação do campo em `ValidarCartao`**, logo após a de `quantidadeParcelas`:

```pascal
  If ACartao.jurosParcelamento < 0 Then
    Raise EInvalidParams.Create(LPrefixo + 'jurosParcelamento nao pode ser negativo.');

  If (ACartao.jurosParcelamento > 0) And
     (fFormataFloat(ACartao.jurosParcelamento, 2) >= fFormataFloat(ACartao.valor, 2)) Then
    Raise EInvalidParams.Create(LPrefixo + 'jurosParcelamento (' +
                                FloatToStrF(ACartao.jurosParcelamento, ffNumber, 15, 2) +
                                ') deve ser menor que o valor do cartao (' +
                                FloatToStrF(ACartao.valor, ffNumber, 15, 2) +
                                '), que ja o inclui.');
```

`ValidarCartao` já é chamada por `ValidarDadosDosMovimentos`, que roda antes de
`ValidarSomaContraMovimentos` — então o erro específico do campo aparece antes do erro genérico de
fechamento, sem precisar registrar nada novo em `ValidarParametros`.

## Tarefa 8: Rateio e gravação

**Arquivo:** modificar `Core/financeiro/services/Financeiro.Services.Cobranca.Baixa.pas`

- [ ] **Passo 1: função de rateio**

```pascal
class function TBaixaService.RatearJurosParcelamento(
  const AParams: TBaixaDuplicatasParams): TArray<Double>;
  Var
    LIndice     : Integer;
    LQuantidade : Integer;
    LBase       : Double;
    LAcumulado  : Double;
begin
  LQuantidade := AParams.ItensDoLote.Count;
  SetLength(Result, LQuantidade);

  For LIndice := 0 To LQuantidade - 1 Do
    Result[LIndice] := 0;

  // O juros vem por cartao, mas o rateio e do lote: os cartoes pagam as mesmas
  // duplicatas, entao nao ha vinculo entre um cartao e um titulo especifico.
  LTotalJuros := SomaJurosParcelamento(AParams);

  If (LTotalJuros = 0) Or (LQuantidade = 0) Then
    Exit;

  LBase := 0;
  For LIndice := 0 To LQuantidade - 1 Do
    If (AParams.ItensDoLote[LIndice].valorRecebido > 0) Then
      LBase := LBase + AParams.ItensDoLote[LIndice].valorRecebido;

  If (LBase <= 0) Then
    Raise EInvalidParams.Create('Nao e possivel ratear o jurosParcelamento: ' +
                                'nenhuma duplicata do lote tem valorRecebido positivo.');

  LAcumulado := 0;

  For LIndice := 0 To LQuantidade - 1 Do
  Begin
    If (AParams.ItensDoLote[LIndice].valorRecebido <= 0) Then
      Continue;

    If (LIndice = LUltimoPositivo) Then
      Result[LIndice] := fFormataFloat(LTotalJuros - LAcumulado, 2)
    Else
    Begin
      Result[LIndice] := fFormataFloat(LTotalJuros *
                         (AParams.ItensDoLote[LIndice].valorRecebido / LBase), 2);

      LAcumulado := LAcumulado + Result[LIndice];
    End;
  End;
end;
```

`LUltimoPositivo` é apurado no mesmo laço que soma `LBase`, para a sobra cair na última duplicata
**com valor positivo** — não simplesmente na última do array, que pode ser um crédito. `LAcumulado`
soma os rateios já atribuídos conforme o laço avança, e a última posição recebe o que falta para
fechar o total exato.

**Duplicatas de crédito ficam fora do rateio.** Elas entram no lote com `valorRecebido` negativo; o
rateio proporcional produziria juros negativo nelas. Ver pendência 4 da spec.

- [ ] **Passo 2: calcular antes do laço de gravação**

`PrepararDuplicatas` recebe `TBaixaLoteParams` e também serve a reserva, que não tem cartão nem
juros. Por isso o rateio passa por um intermediário que só o calcula quando o parâmetro é do tipo
certo, e um acessador que devolve zero fora dos limites:

```pascal
class function TBaixaService.RateioDoLote(const AParams: TBaixaLoteParams): TArray<Double>;
begin
  If (AParams is TBaixaDuplicatasParams) Then
    Result := RatearJurosParcelamento(TBaixaDuplicatasParams(AParams))
  Else
    SetLength(Result, 0);
end;

class function TBaixaService.RateioNoIndice(const ARateio: TArray<Double>;
  const AIndice: Integer): Double;
begin
  If (AIndice >= 0) And (AIndice <= High(ARateio)) Then
    Result := ARateio[AIndice]
  Else
    Result := 0;
end;
```

Antes do `For LIndice := 0 To AParams.ItensDoLote.Count - 1 Do`:

```pascal
  LJurosParc := RateioDoLote(AParams);
```

Declarar `LJurosParc : TArray<Double>;` no `Var` do método.

- [ ] **Passo 3: gravação — duas linhas**

`TCalculoBaixaParcial.Calcular` roda para baixa total e parcial (só a linha 740 distingue), então há
um ponto único de gravação. A linha 704, `LParams.ValorPago := LItem.valorRecebido`, **não muda** —
é ela que mantém o `ValorPago` limpo.

`CTR_VALREC`:

```pascal
    AcdsCtaRec.FieldByName('CTR_VALREC').AsFloat := fFormataFloat(LItem.valorRecebido +
                                                     RateioNoIndice(LJurosParc, LIndice), 2);
```

`CTR_VALJUR`:

```pascal
    AcdsCtaRec.FieldByName('CTR_VALJUR').AsFloat := fFormataFloat(LParcial.JurosBaixaDuplicata +
                                                     RateioNoIndice(LJurosParc, LIndice), 2);
```

- [ ] **Passo 4:** compilar `Services.groupproj` para Linux
- [ ] **Passo 5: commit** — `Req. 458948` + token DelphAI

---

# Frente D — Massa de teste e casos

## Tarefa 9: Massa de teste (implementador)

**Arquivo:** criar `Financeiro.Services.API/Scripts/testes/008_INFRA_FAIXA_JUROS.sql`

Seguir o padrão do `007_INFRA_FAIXA_CARTAO.sql`: cabeçalho explicando por que o script existe,
`REPLACE INTO` em vez de `INSERT` para ser reaplicável, e bloco de conferência ao final.

- [ ] Aplicar o `ALTER TABLE` da Tarefa 1 também na base de teste
- [ ] Preencher `FAI_PERJUR` nas duas faixas do `007`: a de 200,00–255,00 com `10.00`, a de
      5.000,00–7.000,00 com `0.00`, para cobrir o caso com juros e o caso R5 na mesma massa
- [ ] Manter o vão proposital entre as faixas — é o que sustenta o caso 8 (404)

## Tarefa 10: Casos de teste — **ANALISTA**

> **Esta tarefa não é de quem implementa.** Conforme o CLAUDE.md, na zona moderna o caso de teste é
> escrito por analista humano. A entrega do implementador é o contrato e a lista de casos, que estão
> na seção 7 da `spec.md` — casos 1 a 13 para a Frente B, 19 a 30 para a Frente C.

- [ ] Casos 1–13 em `Test_Cases/Cartao/LimiteParcelasTest.inc`
- [ ] Casos 19–30 em `Test_Cases/Cobranca/BaixaTest.inc`
- [ ] Compilar e rodar `FinanceiroServicesTEST.dpr`

## Tarefa 11: Validação manual do cadastro (Zona Legado)

Não há infraestrutura de teste automatizado em `fontes/`. Roteiro no `tasks.md`.

---

# Ordem e dependências

```
Tarefa 1 (DDL)
   |
   +--> Tarefa 2 (cadastro)  ....... independente daqui pra frente
   |
   +--> Tarefa 3 (DTOs) --> Tarefa 4 (calculo) --> Tarefa 5 (swagger)
   |
   +--> Tarefa 6 (campo lote) --> Tarefa 7 (fechamento) --> Tarefa 8 (rateio)
                                                                |
                        Tarefa 9 (massa) ---------------------- +
                                                                |
                        Tarefa 10 (casos, ANALISTA) ----------- +
```

A Tarefa 1 destrava tudo. Frente A, B e C não se tocam depois disso e podem ser feitas em qualquer
ordem, inclusive por pessoas diferentes.

# Riscos

| Risco | Mitigação |
|-------|-----------|
| Somar o rateio antes de chamar `TCalculoBaixaParcial` | Encolhe o saldo da duplicata em silêncio. Contraexemplo numérico na spec 6.5; caso 23 existe para pegar isso |
| Alterar `valorRecebido` no contrato "para simplificar" | Reintroduz o risco acima e obriga a mexer na validação de teto. Registrado na spec seção 8 |
| Faixas de produção com `FAI_PERJUR` nulo | Comportamento definido (R5, juros zero), mas alguém precisa preencher — pendência 2 |
| `.dfm` editado com encoding errado | Hook de encoding cuida; não converter à mão |
