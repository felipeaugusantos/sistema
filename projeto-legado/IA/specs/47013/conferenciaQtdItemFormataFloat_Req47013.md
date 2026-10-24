# Análise — Req. 47013 — Falso "item ultrapassou a quantidade da Nota" na conferência de entrada

## 1. Contexto de negócio
Na tela de Entrada de Mercadorias Simplificada - Entre Lojas (acessada por Principal > Movimentação de Itens > Fluxo de
Processo de Compras > botão Conferência), o usuário informa o código do produto, a quantidade (F6) e confirma com Enter. A rotina
`fQtdItemOk` (classe `TRecConferEntrada`, unit `untRecConferEntrada.pas`) valida se a quantidade acumulada conferida
(`QTDCON` + quantidade informada) ultrapassa a quantidade do documento (`QTDITE`). Se ultrapassa, exibe a mensagem
"O Item X ultrapassou a quantidade da(s) Nota(s)!" (ou, com `FblnGerTrf`, pergunta se deve gerar pedido de transferência
pelo excedente).

Ocorrência original: cliente CONARA, nota 2428, item CODITE = 1026930. O sistema acusava excesso mesmo com a quantidade
conferida exatamente igual à da nota (3,38).

## 2. Problema e causa raiz
- Em `fQtdItemOk`, `fltQtdDoc` e `fltQtdCon` eram obtidos com `System.Math.RoundTo(x, -intDeqTem)`, algoritmo numérico
  (multiplica pelo fator de casas, arredonda, divide de volta) que não garante cair no Double canônico do valor decimal.
- `fltQtdIte` (parâmetro) chega normalizado pelo chamador via `fFormataFloat` (arredondamento por round-trip de string,
  que sempre produz o Double canônico).
- Comparar um valor vindo de `RoundTo` com outro vindo de `fFormataFloat` podia gerar Doubles diferentes por 1 ULP para a
  mesma quantidade decimal (ex.: 3,3799999999999999 vs 3,38), quebrando a comparação `fltQtdDoc < ...`.
- Evidência (instrumentação temporária feita na revisão original): `QtdDoc=3,3799999999999999 QtdCon=0
  QtdIte=3,3799999999999999 RoundExpr=3,38 Cond=True`. Após a correção, `FormatExpr=3,3799999999999999 Cond=False`,
  reprodução consistente em 2 execuções.
- Hipótese descartada: alteração de FPU Control Word por biblioteca de terceiros (não há Set8087CW/ControlFP/
  SetPrecisionMode na árvore). Achado de processo: Evaluate/Modify do Delphi Seattle não é confiável para expressões de
  ponto flutuante com chamada de função; a confirmação veio de instrumentar o código.
- Precedente no projeto: comentário em `PainelNfe/libNfe/untUtil.pas` (~2177-2184) documenta bug equivalente que motivou a
  criação de `fFormataFloat`.

## 3. Solução aplicada
Em `fQtdItemOk`, os 5 usos de `RoundTo(x, -intDeqTem)` foram substituídos por `fFormataFloat(x, intDeqTem)`:

| Variável / expressão | Antes | Depois |
|----------------------|-------|--------|
| `fltQtdDoc` | `RoundTo(QTDITE, -intDeqTem)` | `fFormataFloat(QTDITE, intDeqTem)` |
| `fltQtdCon` | `RoundTo(QTDCON, -intDeqTem)` | `fFormataFloat(QTDCON, intDeqTem)` |
| condição de excesso | `RoundTo(fltQtdIte + fltQtdCon, -intDeqTem)` | `fFormataFloat(fltQtdIte + fltQtdCon, intDeqTem)` |
| `fltAcomoda` | `RoundTo(fltQtdDoc - fltQtdCon, -intDeqTem)` | `fFormataFloat(fltQtdDoc - fltQtdCon, intDeqTem)` |
| `fltExcede` | `RoundTo(fltQtdIte - fltAcomoda, -intDeqTem)` | `fFormataFloat(fltQtdIte - fltAcomoda, intDeqTem)` |

## 4. Decisões e alternativas descartadas
- Operador `<` mantido: o aviso só dispara quando o confirmado realmente excede o documento; confirmar igual ou menos segue
  válido. Trocar por `<>` foi descartado (dispararia também em conferência parcial).
- `FormatFloat` nativo do Delphi descartado: reintroduziria a assimetria de algoritmo, já que o chamador usa `fFormataFloat`
  (que pode aplicar arredondamento ABNT NBR 5891/77 conforme USASAT/RAABNT).
- As linhas 295-296 da mesma unit (`RoundTo(..., -4)`) estão fora do escopo e não foram alteradas.
- Nenhum comentário adicional no fonte; não há "Notas" referenciadas.

## 5. Origem e replicação
- Correção original: revisão SVN **489683**, working copy `379.48.2.30.74.150` (commit registrado sob Req. 456551);
  replicada também em `.150.45` e `.150.100` na sessão original.
- Aplicada nesta sessão (via citel-applyPatch, edição em Python cp1252, EOL misto preservado, sem U+FFFD) em:
  - `379.48.2.30.74.111` — linhas 775, 776, 778, 792, 796;
  - `74.Fechadas\74.111.Fechadas\379.48.2.30.74.111.191` — mesmas linhas.
- `svn diff` em ambas conferido: somente as 5 linhas acima.
- Não compilado e sem testes automatizados executados.

## 6. Achados colaterais (não corrigidos)
- Na revisão original, a instrumentação gerou erro E2034 com `Append(fslog)` por `TRecConferEntrada` herdar de
  `TZClient/TDataSet`; resolvido com `System.Append(fslog)` (código de diagnóstico, não faz parte da correção).
