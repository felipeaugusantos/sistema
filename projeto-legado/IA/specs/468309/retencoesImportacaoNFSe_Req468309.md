# Análise — Req. 468309 — Retenções PIS/COFINS/CSLL na importação de NFSe

## 1. Contexto de negócio

Na importação de NFSe por XML (`TEntImpNFSe`), o fornecedor pode ter retenções cadastradas (tabela `FORRET`: PIS, COFINS,
CSSL, IRRF, INSS, ISS). Nesse caso, o contas a pagar deve ter:

- a duplicata principal do prestador com valor **líquido** (valor da nota menos as retenções); e
- um título de retenção por tributo retido (CADPAG, fornecedor da retenção), com o respectivo registro em `RETFIS`.

Na 74.150 esse tratamento foi feito pelas revisões r473009 (Req. 432369) e r498495 (Req. 465130). A 74.111 gravava a duplicata
pelo valor bruto e não gerava os títulos de retenção. O requisito portou esse comportamento para a 74.111 e para a 74.111.184.

## 2. Problema e causa raiz

- Importação do XML 54092: o contas a pagar saía com duplicata bruta e sem títulos de retenção, porque a importação não
  utilizava a classe de retenções (`TRetencoesNoFrame`), inexistente na 74.111.
- Padrão Nacional: o tipo de retenção PIS/COFINS (`tpRetPisCofins`) não era lido do XML.

## 3. Solução aplicada

| Item | Arquivo | Alteração |
|------|---------|-----------|
| Unit de retenções | `fontes/cadastros/untLancamentoRetencoes.pas` | Trazida inteira da 74.150 (criada) e incluída no `autcom.dpr` |
| Importação | `fontes/movimentacaoitens/untEntImpNFSe.pas` | Calcula retenções, grava duplicata líquida e os títulos de retenção; 3 campos novos na tabela temporária (PCXMLD, VALPIS, VALCOF) |
| Layout | `fontes/movimentacaoitens/untXMLNFSePadrao.pas` | Novo campo FIS_TRPICO mapeado em `tpRetPisCofins` nos dois layouts Nacionais |

Ajustes feitos sobre a cópia da 74.150:

- `fGravaCadPag` tem assinatura diferente na 74.111 (parâmetro `AUsaMca`) e na 74.111.184 (sem `AUsaMca`); a chamada foi adaptada.
- `fIncluiRETFIS` gravava `RET_CODPOR = ''`, mas `FORRET.RET_CODPOR` é NULL quando não há portador, e a FK `FK_RETFIS_05`
  (→ CADPOR) rejeitava o vazio. Passou a gravar NULL quando vazio. A 74.150 tem o mesmo problema latente (não alterada).
- `TRetencoesNoFrame.fCriarParcelasRetencoesFornecedor` engole exceções e devolve False. O chamador ignorava o retorno, então
  a falha deixava a nota gravada sem retenções, XML renomeado para `.old` e sem marca de erro. Agora, se retornar False, é
  levantada exceção em `fConfirmaImportacao`, acionando o rollback e o tratamento de erro já existente (linha do XML marcada
  com "Erro ao gravar registro", arquivo não renomeado).

Consulta de retenções no livro fiscal: `TConsultarFinanceiro.fConsultarContasPagar` (`untConsultarFinanceiro.pas`, usada por
`untCadLivroFiscal`) não trazia as retenções, pois o join de CADPAG com CADFIS comparava `CTP_DTACAD` com `FIS_DTADOC`. O título
de retenção é gravado com a data de entrada da nota; o join passou a usar `FIS_DTAENT` (e `CTP_NUMDOC` em maiúsculas).

Aplicado nas duas working copies (74.111 e 74.111.184).

### 3.1 Ajustes pós-revisão (`untEntImpNFSe.pas` e `untConsultarFinanceiro.pas`, nas duas working copies)

1. **Valor da duplicata:** `fValorTotalLiquido` parte de `FValTot` (soma de FValCo1..5, editável no grid) e só desconta
   `fRetTotalImpostos` quando o fornecedor tem retenções (`TemRetencoes`). A cópia da 74.150 partia de `FVlServ`, o que
   alteraria o valor de notas sem retenção e ignoraria a edição do grid.
2. **Títulos de retenção só com a duplicata principal:** variável local `blnGravouCtp` em `fConfirmaImportacao`, zerada por
   documento e marcada após a gravação do contas a pagar principal (cobre `FblnGraCTP`, complemento/`FValCo1`, `ENTCTP` e
   `fFornecedorGravaCtp`). A gravação das retenções exige `FblnGravarPagamentoRetido` e `blnGravouCtp`.
3. **Log de sucesso:** "Gravação efetuada com sucesso!" passou a ser escrita depois da gravação das retenções, para não
   aparecer sucesso e erro no mesmo documento.
4. **`lstMemLog`/`lstMemErr`:** variáveis locais já existentes na BASE e nunca atribuídas (o `Finally` testava `Assigned` sobre
   lixo). Passaram a ser inicializadas com `nil` antes do `Try`. Os campos usados de fato são `FMemLog`/`FMemErr`.
5. **Retenção do XML sem cadastro na FORRET:** novo `pAvisarRetencaoSemCadastro`, chamado em `pCalcularRetencoes` para IRRF,
   PIS, COFINS, CSLL, ISS e INSS. Se o XML traz valor > 0 de um tributo que não está em `TRetencoesNoFrame.Retencoes`, grava
   aviso no `FMemLog` ("XML traz retenção de X sem cadastro na FORRET do fornecedor"). Não bloqueia a importação. O
   comportamento anterior (CADFIS com o valor do XML, duplicata sem desconto) já era o da 74.150.
6. **Join de retenções no livro fiscal:** o UNION de retenções de `fConsultarContasPagar` casava só por NUMDOC + CODEMP +
   DTACAD. Retenção é gravada com `CTP_CODFOR` = fornecedor da retenção (não o do documento) e com `CTP_INCFIS` =
   `CADFIS.AUTOINCREM` (parâmetro `AIncCadFis` de `fGravaCadPag`). Foi acrescentado
   `CTP_INCFIS = CADFIS.AUTOINCREM OR CTP_INCFIS vazio`. O "vazio" mantém títulos de outros fluxos sem vínculo; se for
   desejado o vínculo estrito, basta remover essa alternativa (pode ocultar retenções sem `CTP_INCFIS`).
7. **`blnGravouCtp` e reimportação:** a variável só vira True quando a parcela é realmente gravada em `fGravaCadPag`, e não
   quando `fVerificaTemCadPag` pula a parcela por já existir. Evita títulos de retenção duplicados na CADPAG.
8. **Retorno de `fGravaCadFis`:** (já ignorado na BASE) se retornar False, `fConfirmaImportacao` levanta exceção
   "Erro ao gravar o livro fiscal", acionando o rollback e a marcação de erro. Muda o comportamento de toda importação de NFSe.
9. **Retenção descontada duas vezes (ABRASF V1/V2):** nesses layouts `FIS_VLCON1` lê `ValorLiquidoNfse` (já líquido) e
   `FIS_VLSERV` não estava mapeado, então o ajuste `FVlServ > FValDoc` nunca entrava e a base das retenções da FORRET era
   líquida. Mapeado `FIS_VLSERV` = `InfNfse;Servico;Valores;ValorServicos` em `fLayoutABRASF_V1` e `fLayoutABRASF_V2`
   (como no V2_04). Efeito: com retenção no XML, `FValCo1`/`FValDoc` passam a ser o valor bruto; fornecedor sem FORRET
   mantém a duplicata pelo líquido do XML (ver item 16); valor contábil/livro fiscal pelo bruto. Caminho do V2 conforme
   ABRASF 2.01, não conferido contra XML real.

10. **Retenção descontada sem virar título:** `fRetTotalImpostos` (`untLancamentoRetencoes.pas`) passou a ignorar itens com
    `RET_ALIQUO <= 0`, o mesmo critério de `fCriarParcelasRetencoesFornecedor`. Antes, valor vindo do XML num tributo com
    alíquota 0 na FORRET saía da duplicata e não gerava título de retenção.
11. **CSLL no Padrão Nacional:** com `FPisCofDefXML`, a CSLL passa a seguir o valor do XML (inclusive 0), como PIS/COFINS, sem
    cair no cálculo da FORRET quando o `tpRetPisCofins` indica CSLL não retida.
12. **Layout configurado sem FIS_VLSERV:** `pCalcularRetencoes` levanta exceção ("layout sem Valor do Serviço (FIS_VLSERV);
    não é possível calcular as retenções") quando o fornecedor tem retenções e `FVlServ <= 0`, bloqueando o documento (rollback
    e erro de importação). Substitui o aviso em log: ele deixava a duplicata sem desconto mas ainda gerava títulos, FRetTot,
    histórico do livro fiscal e zeramento do ISS. `fValorTotalLiquido` voltou a só descontar `fRetTotalImpostos`.
13. **Falha no contas a pagar principal:** após o laço de duplicatas, `Result = False` (fGravaMovBan/fGravaCadPag) levanta
    "Erro ao gravar o contas a pagar", acionando rollback, em vez de seguir para sucesso/commit sem duplicata.

14. **Vazamento de `lstBanCtp`:** na baixa automática (CTPAVI) o objeto era liberado fora de try/finally; o bloco foi
    reindentado e envolvido em `Try ... Finally FreeAndNil(lstBanCtp)`.

15. **Rótulo do log:** o `Except` de `fCriarParcelasRetencoesFornecedor` gravava '[TfraCadImpostosNFS...]' (classe de
    origem na 74.150); passou a '[TRetencoesNoFrame.fCriarParcelasRetencoesFornecedor]'.

16. **Duplicata pelo líquido do XML sem FORRET (achado de revisão):** com `FIS_VLSERV` mapeado em ABRASF V1/V2, o valor contábil passa a ser o bruto, e a duplicata sairia pelo bruto para fornecedor sem FORRET. O aviso em log (já após o commit) não permitia ao operador decidir antes da gravação, e o pagamento sairia a maior em silêncio. `fValorTotalLiquido` passou a devolver `FVlLiqXML` (valor líquido original do XML, `FIS_VLCON1` antes da troca por `FVlServ`; campo `VLLIQX` da tabela temporária, arrays 0..166) quando o fornecedor não tem retenções e `FVlServ > FVlLiqXML`: mantém o comportamento anterior da duplicata. O livro fiscal continua pelo valor dos serviços. `pAvisarValorLiquidoXML` permanece como informação no `FMemLog` (duplicata pelo líquido do XML). Limitação: nesse caso a edição do valor no grid não altera a duplicata.

17. **Sequência da RETFIS (`untFuncoesSimples.pas`, incluída pelo solicitante):** `fIncluiRETFIS` obtém o `AUTOINCREM` por `fRetAutoincrem('RETFIS', VS_StrCodEmp)`. Foi cadastrada a tabela `RETFIS` na lista de sequências (`arrProCod`: código inicial '0000000000000000001', tamanho 20, automático 'S', incremento 1), no mesmo padrão das demais entradas (ex.: NOTOPE).

Achados colaterais não alterados: a 74.150 tem os mesmos pontos 1 (partida em FVlServ), 4 e o `RET_CODPOR = ''`. 

## 4. Evidências (LOGREP, transação 2552076837639745996, doc 000000064092)

CADPAG principal 1481,80 (líquido) e CADPAG de retenção 72,26 (CSSL), RETFIS com portador NULL; FKs de RETFIS (03 a 08) existem.
Líquido = 1554,06 − 72,26.

## 5. Decisões de escopo

- Rateio de PIS/COFINS/CSLL do XML 54092 (`vRetCSLL` traz o total dos três e `vPis`/`vCofins` não vêm no XML): fora de escopo;
  nenhuma das revisões da 74.150 trata esse caso.
- A unit de retenções foi trazida inteira, mas é usada somente pela importação de NFSe.

## 6. Pendências / achados colaterais

- Testes a cargo da equipe de testes (tasks.md marcado como OK pelo solicitante): fornecedor com FORRET, sem FORRET, XML Nacional com/sem `tpRetPisCofins`, falha de retenção (XML com erro e
  sem `.old`), e a aba de contas a pagar do livro fiscal.
- Mesmo problema de `RET_CODPOR = ''` existe na 74.150.

## NOTAS REFERENCIADAS NO CÓDIGO-FONTE

Nenhuma nota nesta entrega.
