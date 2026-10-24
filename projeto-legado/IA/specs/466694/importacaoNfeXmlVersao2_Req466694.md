# Req. 466694 — Importação de NF-e XML versão 2.00 falhava silenciosamente

## 1. Contexto de negócio
- Menu: Principal > Movimentação de Itens > Importação de Nota Fiscal Eletrônica.
- O cliente (solicitante/contato: Kleyton) precisava importar uma NF-e emitida pelo sistema anterior para realizar uma devolução.
- Ao importar, o sistema não localizava os itens, não importava a nota e não exibia nenhum erro.
- Ticket Zendesk: https://citelsoftware.zendesk.com/agent/tickets/1695965
- XML de simulação: chave `35140461143632000107550010001817671006925604`, `<infNFe versao="2.00">`.
- Caminho de simulação: `\\CITEL-FILESERVE\AUTDBF\ALVESHOMECEN\01.10.2026`.

## 2. Problema e causa raiz
- O XML é do layout **2.00**. A tag `<ide>` não possui `idDest`, `indPres` e `indFinal` (inexistentes nesse layout). Usa `dEmi`/`dSaiEnt` (a rotina já trata `dhEmi`/`dEmi`).
- Em `TNFeXml.fGetIde` (`untEntNfeXml.pas`) esses valores eram lidos com `fGetValorXml(nodIde, '<tag>')` e atribuídos a `B11A_IDDEST`, `B25B_INDPRES` e `B25B_INDFINAL`, todos `Integer`.
- `fGetValorXml` (`genericos/untFuncoes.pas`) **não lança exceção** quando a tag não existe: devolve `''` (varString). Atribuir `''` a um `Integer` gera erro de conversão de Variant.
- Esse erro era capturado pelo `Except` de `fGetIde`, que fazia apenas `Result := FALSE`, **sem `pIncluiErro`** — daí a falha silenciosa (nenhum registro de erro para o usuário).
- Problema adicional: a leitura da versão com `StrToIntDef(versao, 0)` retorna 0 para "2.00" (não é inteiro), o que inviabilizaria qualquer decisão por versão.
- A explicação do erro de conversão foi obtida pela leitura do código; o comportamento final foi validado pelo solicitante após a correção.

## 3. Investigação e decisões
| Tema | Decisão | Motivo |
|------|---------|--------|
| Tratar a ausência no `Except` (ideia inicial) | Descartado | `fGetValorXml` não lança exceção para tag ausente; no `Except` não se sabe qual tag faltou, e ele captura qualquer erro. Usado `fExistNode` antes de ler. |
| Leitura da versão | `fStrToFloat(AnsiReplaceStr(VarToStr(versao), '.', ','))` | `StrToIntDef` dá 0 para "2.00"; `StrToFloat`/`StrToFloatDef` são proibidos no pre-commit; `fStrToFloatDef` não está definida no código. Mesmo padrão já usado em `fGetValorXml`. |
| Versão mínima de cada tag | `idDest` ≥ 4.00; `indPres` e `indFinal` ≥ 3.10 | Definição do solicitante da análise. |
| Valor quando a tag não existe e a versão não a exige | 0 | Consultas existentes usam `B25B_INDPRES IN (1, 5)`, que continuam funcionando com 0. |
| `Except` de `fGetIde` | Passou a registrar o erro | Evitar novas falhas silenciosas por outros motivos. |

## 4. Solução aplicada
Unit: `padra_atualizado/fontes/movimentacaoitens/untEntNfeXml.pas`.

1. Campo `fltVersaoXml: Double`, declarado junto de `blnVersao4`, atribuído logo após a leitura de `infNFe` e antes da chamada de `fGetIde`:
   ```pascal
   fltVersaoXml := fStrToFloat(AnsiReplaceStr(VarToStr(nodInfNFe.Attributes['versao']), '.', ','));
   ```
2. `fGetIde` — para cada tag, se existir, lê normalmente; se não existir e a versão a exige, inclui erro e interrompe; caso contrário assume 0:
   ```pascal
   If fExistNode(nodIde, 'idDest') Then
     B11A_IDDEST := fGetValorXml(nodIde, 'idDest')
   Else If fltVersaoXml >= 4 Then
   Begin
     pIncluiErro('Nota ' + String(B08_NNF) + ': XML invalido. Estrutura do arquivo incompativel (sem "idDest").');
     Exit(False);
   End Else
     B11A_IDDEST := 0;
   ```
   Mesma lógica para `indPres` e `indFinal`, com corte em `fltVersaoXml >= 3.1`.
3. `Except` de `fGetIde`:
   ```pascal
   Except
     On E: Exception Do
     Begin
       pIncluiErro('Nota ' + String(FGerEle.B08_NNF) + ': Erro ao ler a identificação (ide) do XML na função fGetIde: ' + E.Message);
       Result := FALSE;
     End;
   End;
   ```
4. Ordem de leitura de `infNFe`: `blnVersao4`, `fltVersaoXml` e `FNotaImportacao := fEhNotaImportacao(...)` foram movidos para dentro do `If Assigned(nodInfNFe)`. Antes eram executados logo após `FindNode('infNFe')`, e um XML sem `<infNFe>` causaria acesso a ponteiro nulo (`Attributes['versao']` em `nil`). Sem `Else` para a ausência da tag (comportamento mantido).

- Arquivo em cp1252 + CRLF; edição feita via Python, sem a ferramenta Edit.
- A mesma alteração foi aplicada nas working copies `379.48.2.30.74.150.45`, `379.48.2.30.74.150` e `379.48.2.30.74.150.100` (mesma unit, mesmo trecho).

5. Proteção do `xmlDoc` (`Try/Finally`) na rotina de leitura do XML de `TNFeXml`:
   - Problema: o `TXMLDocument.Create(Self)` não estava protegido; cada `Exit` antecipado (inclusive os gerados por `Exit(False)` de `fGetIde`, via `If Not Result Then Exit`) saía sem executar o `FreeAndNil(xmlDoc)`, nem `pMarcaMostrar` nem `cdsDiverg := Self.FCdsIncon`. Na importação em lote, cada XML rejeitado mantinha a árvore DOM viva até a destruição do `TNFeXml`, e a nota rejeitada não era marcada como não exibida.
   - Solução: corpo envolvido em `Try ... Finally FreeAndNil(xmlDoc); End;`. Variável local `blnSaiuPorExit` (True no início; False ao chegar ao pós-processamento normal e no início do `Except`). No `finally` externo, se ainda True (saída por `Exit`): `Result := Result And (Not FErro)`, `pMarcaMostrar` (mesma regra de cancelamento/indefinido do fluxo normal) e `cdsDiverg := Self.FCdsIncon`.
   - Decisões: no caminho de `Raise` (fulfillment/importação) o `finally` não chama `pMarcaMostrar` (comportamento mantido); `processaCapa_x_Detalhes` permanece só no fluxo normal (nos `Exit`, `Result` já é falso).
   - Exceção deliberada: o `Exit` do ramo sem `protNFe` (`If fEmptyStr(PR07_CHNFE) And Not blnEhEmissaoImportacao Then Exit`) pode sair com `Result = True`; nele `blnSaiuPorExit := False` antes do `Exit`, mantendo o comportamento anterior (retorno inalterado e nota NÃO marcada por `pMarcaMostrar`).
   - `Finalize(FGerEle)` antes do `FillChar(FGerEle, SizeOf(FGerEle), #0)` da rotina: o record tem campos String/WideString (chave, status, motivo, infCpl, infAdFisco); o `FillChar` sozinho sobrescrevia os ponteiros sem liberar as strings da nota anterior (vazamento por XML lido). Só o `FillChar` dentro da rotina de leitura foi alterado (o outro `FillChar(FGerEle...)` do arquivo, em outra rotina, não).
   - Aplicado em `74.150.45`, `74.150` e `74.150.100`. `74.111` e `72` não têm o `Exit(False)` novo, mas têm o mesmo vazamento antigo (não alteradas).

## 5. Escopo
- Dentro: tratamento das três tags de layout posterior na `<ide>`; leitura numérica da versão; mensagem de erro no `Except`.
- Fora: outras tags ausentes em layouts antigos além das três tratadas (nenhuma outra divergência apareceu na validação do XML anexado).

## 6. Validação
- Solicitante informou "validado tudo OK" (importação do XML 2.00 e cenários de versões 3.10/4.00 conforme `tasks.md`).

## 7. Achados colaterais não corrigidos
- (Corrigido) Em `untEntNfeXml.pas`, a leitura de `nodInfNFe.Attributes['versao']` (`blnVersao4`, `fltVersaoXml`) e a chamada de `fEhNotaImportacao` ocorriam antes do `If Assigned(nodInfNFe)`; num XML sem `<infNFe>` haveria acesso a ponteiro nulo. As três linhas foram movidas para dentro do `If Assigned(nodInfNFe)`, nas 3 working copies. Sem `Else` para a ausência de `infNFe` (comportamento mantido).
- Na working copy `74.150.100`, `fGetIde` não possui o tratamento de `tpNFDebito`/`tpNFCredito` das demais; sem relação com este requisito.

## 8. Lições de ferramenta/processo
- `fGetValorXml` retorna `''`/`0` para tag ausente (não lança exceção): para tags opcionais ou dependentes de versão usar `fExistNode` antes.
- `fStrToFloatDef` não existe no código; usar `fStrToFloat` (com `AnsiReplaceStr` de `.` por `,`).
- Fontes em cp1252: nunca usar `Edit`; usar Python com encoding explícito.

## NOTAS REFERENCIADAS NO CÓDIGO-FONTE
Nenhuma — esta correção não adicionou comentários do tipo "Verificar Nota N" no fonte.
