# Req. 455096 — Plano de implementação

> **Para quem executa:** sub-skill obrigatória — `superpowers:subagent-driven-development` (recomendado) ou `superpowers:executing-plans`, tarefa a tarefa. Os passos usam `- [ ]`.

**Objetivo:** `POST /cotacao/importacao/gerar` (multipart) e `GET /cotacao/importacao/{idProcessamento}` na Suprimento.Services.API: recebe o `.xlsx` devolvido pelo fornecedor e grava preços e condições na cotação oficial com o motor da `TCotacao`, em tarefa assíncrona com `MENREP`.

**Arquitetura:** o controller valida formato, pede o pré-voo ao worker, enfileira na `SSATSK`, grava o arquivo em disco e dispara o filho. O filho lê o OOXML com leitor próprio, interpreta a planilha, abre a `TCotacao` sem tela como a exportação, aplica cada linha por `pAtualizaUnitarioItemfornecedor`, calcula `FORMEN` e grava numa transação.

**Stack:** Delphi (Services Linux, DMVCFramework 3.4.1-sodium), UniDAC/MySQL, `System.Zip`, legado `untCotacao.pas`.

**Spec:** `IA/specs/455096/spec.md` — as RN citadas abaixo são as de lá. Jornada e medições: `record.md`.

## Restrições globais

- Zona Moderna em `padra_atualizado/Services/` (dot-notation, sem Hungarian); zona Legado em `padra_atualizado/fontes/` (Hungarian, prefixos `p`/`f`, `F`/`A`). Ver `CLAUDE.md`, seção Padrões de Código.
- Travas do pre-commit: nada de `Now` gravado (usar `fNow()`), `StrToFloat(` (usar `fStrToFloat`), `.SetFocus`, `TClientDataSet`.
- Toda SQL com `ParamByName`. Nenhuma concatenação de valor vindo do request.
- `const` em parâmetro não alterado; `out` só em saída.
- Comentário: na declaração só o que a assinatura não diz; o porquê na implementação. Não narrar a mudança (memória `feedback-comentario-nao-e-svn-log`).
- Endpoint despacha ao filho: sobrecarga tipada via `fExecuteTask` **e** `AddMethod` (`IA/rules/services-workers.md`).
- Encoding: conferir com `file` antes de editar cada arquivo; `untCotacao.pas` e `untTypesSistema.pas` são cp1252; `svn diff | wc -l` depois (memória `feedback-edit-tool-corrompe-untfuncoesgenerica`). Edit com `replace_all=false`.
- **Testes:** casos escritos por quem implementa, junto ou logo depois da implementação — **sem teste-primeiro** (CLAUDE.md, seção Testes). Por isso as tarefas não têm passo "ver falhar".
- **Commit:** SVN, só quando o João pedir. Nenhuma tarefa commita; a Tarefa 17 prepara.
- **Compilar:** `python padra_atualizado/Services/TestExecute/_ci/ci.py --projeto SuprimentoServicesAPI` (e `--projeto SuprimentoServicesTEST`), em background, ~5 min. Antes, conferir que o TestExecute.exe não está compilando (memória `autpas-ci-py-compila-sem-ide`).

## Review Focus

1. **Arquivo do Excel real com estrutura que o LibreOffice não produz** — rich text em `sharedStrings` (`<si><r><t>..</t></r><r><t>..</t></r></si>`), prefixo de namespace nos elementos, `<c>` sem atributo `r`. Esperado: lê igual. Coberto na Tarefa 3 (varredor tolera os três) e no caso da Tarefa 16 com o arquivo do João.
2. **Célula de preço com fórmula** (`<c><f>B2*2</f><v>10</v></c>`) — o fornecedor calcula na planilha. Esperado: lê o valor em cache `10`. Tarefa 3, passo de verificação.
3. **Código do item lido como número** (`<c t="n"><v>1234</v></c>` com Excel tirando zeros à esquerda). Esperado: `fPadL` com `fTamCodIte` recompõe `00001234` (paridade). Tarefa 7, e caso na Tarefa 16.
4. **Planilha com linhas vazias depois dos itens, ou `<dimension>` mentindo** — Excel grava formatação em linhas vazias. Esperado: linhas sem `Código` ignoradas, sem aviso. Tarefa 7.
5. **Trava da `LCKATC` do REPOR+ de outro operador vs. do mesmo operador em outra aba** — mesmo `LCK_CODOPE`, duas abas. Esperado: importa (é o mesmo operador; RN14). Caso na Tarefa 16.

---

## Estrutura de arquivos

| Arquivo | Novo? | Responsabilidade |
|---|---|---|
| `fontes/genericos/untOOXMLReader.pas` | novo | Lê `.xlsx` em grade de células texto/número/vazia. Não sabe o que é cotação |
| `fontes/movimentacaoitens/Cotacao/untCotacao.pas` | altera | 4 métodos públicos que expõem, sem copiar, o que a importação usa dos privados |
| `fontes/genericos/untTypesSistema.pas` | altera | 3 exceções novas, ao lado das da exportação |
| `Services/Core/Services.Core.Worker.pas` | altera | Relevantar as 3 exceções no `fExecuteTask` |
| `Services/Core/suprimento/services/types/Suprimento.Services.Cotacao.Types.pas` | altera | DTOs, constantes, aliases |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Importacao.Arquivos.pas` | novo | Diretório/arquivo do processamento + registro no expurgo |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Importacao.Planilha.pas` | novo | Interpreta a grade: cabeçalho, colunas, linhas, avisos, erros (RN02–RN04). Sem banco |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Importacao.PreCondicoes.pas` | novo | 404/409/422 contra o banco: cotação, `COT_DTAFIN`, `COT_LIBBID`, `COTCFO`, `COTGER_RES`, `LCKATC` (RN08, RN14) |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Abertura.pas` | novo | `pAbrirCotacao` extraído da exportação, usado pelas duas (Tarefa 10) |
| `fontes/movimentacaoitens/Cotacao/untCotacaoTypesAndConst.pas` | altera | Recebe os `TIT_*` e os rótulos do cabeçalho, para exportação e importação lerem a mesma constante (Tarefa 7) |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Importacao.pas` | novo | Orquestrador no filho: lê, interpreta, aplica, `FORMEN`, grava (RN05–RN07) |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Concorrencia.pas` | altera | `TCotacaoImportacaoConcorrencia` (GET_LOCK + órfãs) |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Notificacao.pas` | altera | `TCotacaoImportacaoNotificacao` |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Consulta.pas` | altera | `TCotacaoImportacaoAndamentoService` |
| `Services/Core/suprimento/services/Suprimento.Services.Workers.pas` | altera | Worker, `LoadMethods`, `pNotifyFinish` |
| `Services/Suprimento.Services.API/Source/api/controller/api.controller.cotacao.pas` | altera | Rotas POST multipart e GET |
| `Services/Suprimento.Services.API/Target/Linux/SuprimentoServicesAPI.dpr` | altera | `uses` das units novas |
| `Services/Core/api/core/api.core.test.utils.pas` | altera | `PostMultipartMethod` / `RunPostMultipartMethodTest` |
| `Services/Suprimento.Services.API/Scripts/testes/arquivos/*.xlsx` | novo | Arquivos de teste versionados |
| `Services/Suprimento.Services.API/Scripts/testes/casos/NNNN_*.sql`, `Test_Cases/cotacao/*.inc`, `api.controller.cotacao.test.pas` | novo/altera | Casos |

Por que a `TCotacao` ganha métodos públicos em vez de o serviço tocar nos privados: mesmo precedente do `fExportarPlanilhaFornecedor` (`untCotacao.pas:995`) — a sequência depende de campos privados (`FImportandoFornecedor`, `FFornecedoresAtivos`, `cfgfrmCus`) e de preparação de dataset que só a classe conhece.

---

## Fase 0 — Provas (descartáveis)

### Tarefa 1: Spike — multipart no binário Linux

Responde uma pergunta só: o DMVC no binário Linux entrega `Request.Files` com o conteúdo binário íntegro. **Se reprovar, parar e voltar ao João** (spec, RF01).

**Arquivos (temporários, revertidos no passo 5):**
- Modificar: `Services/Suprimento.Services.API/Source/api/controller/api.controller.cotacao.pas`

- [ ] **Passo 1: rota temporária.** Acrescentar `Web.ReqMulti` ao `uses` da implementation (registra o `TMultipartContentParser` do WebBroker — sem ele `Files.Count` é sempre 0) e a action:

```pascal
    [MVCHTTPMethod([httpPOST])]
    [MVCPath('/importacao/spike')]
    procedure SpikeMultipart;
...
procedure TCotacaoController.SpikeMultipart;
var
  LArq: TAbstractWebRequestFile;
  LMem: TBytesStream;
begin
  if Context.Request.RawWebRequest.Files.Count = 0 then
  begin
    Render(Format('{"files":0,"campo":"%s"}', [Context.Request.ContentParam('codFornecedor')]));
    Exit;
  end;
  LArq := Context.Request.RawWebRequest.Files[0];
  LMem := TBytesStream.Create;
  try
    LMem.CopyFrom(LArq.Stream, 0);
    Render(Format('{"files":%d,"campo":"%s","nome":"%s","tamanho":%d,"pk":%s}',
      [Context.Request.RawWebRequest.Files.Count, Context.Request.ContentParam('codFornecedor'),
       LArq.FileName, LMem.Size, BoolToStr((LMem.Size > 2) and (LMem.Bytes[0] = $50) and (LMem.Bytes[1] = $4B), True).ToLower]));
  finally
    LMem.Free;
  end;
end;
```

- [ ] **Passo 2: compilar** `ci.py --projeto SuprimentoServicesAPI` e implantar no ambiente de teste (pedir ao João se o deploy não for pelo `deploy.py`).
- [ ] **Passo 3: medir.** Com um `.xlsx` real (`c:\tmp\espelho_cotacao.xlsx`), token válido:
  `curl -s -H "Authorization: Bearer <tok>" -H "Empresa: 022" -F "codFornecedor=000045" -F "arquivo=@c:/tmp/espelho_cotacao.xlsx" http://<host>:<porta>/api/cotacao/importacao/spike`
  Esperado: `files:1`, `campo:"000045"`, `tamanho` igual a `wc -c` do arquivo, `pk:true`. Repetir com arquivo de 5 MB (gerar com `head -c`) para ver se há teto de corpo.
- [ ] **Passo 4: registrar** o resultado no `record.md` (tamanho medido, teto encontrado, se `ContentParam` lê campo de multipart).
- [ ] **Passo 5: reverter** a action e o `Web.ReqMulti` (`svn diff` do arquivo vazio). O `Web.ReqMulti` volta de verdade na Tarefa 12.

### Tarefa 2: Prova — arquivo de teste chega ao binário de teste no Linux

> **Pulada em 30/09/2026 por decisão do João.** Os passos 1 e 2 (`.rc` e `{$R}` no `.dpr`) passam a ser feitos na Tarefa 15; a prova de que o resource é lido no Linux fica para a primeira rodada da suíte (Tarefa 16). Se reprovar lá, o plano B abaixo vale e a Tarefa 14 muda de fonte do arquivo.

Resource embutido no `SuprimentoServicesTEST`. Se reprovar: plano B é caminho ao lado do binário, e então conferir se `deploy.py` leva `Scripts/testes/arquivos/` (ler `deploy.ini`).

**Arquivos:**
- Criar: `Services/Suprimento.Services.API/Target/Linux/ArquivosTeste.rc`
- Modificar: `Services/Suprimento.Services.API/Target/Linux/SuprimentoServicesTEST.dpr`

- [ ] **Passo 1:** `ArquivosTeste.rc`, caminho relativo ao `.rc`:

```
IMP_0001_LIBREOFFICE RCDATA "..\\..\\Scripts\\testes\\arquivos\\0001_libreoffice_ok.xlsx"
```

(Para a prova, copiar `c:\tmp\espelho_cotacao.xlsx` como `0001_libreoffice_ok.xlsx`; o definitivo vem na Tarefa 15.)

- [ ] **Passo 2:** no `.dpr`, ao lado dos demais `{$R}`: `{$R 'ArquivosTeste.res' 'ArquivosTeste.rc'}`. É o `.dpr` que se edita, não o `.dproj` (CLAUDE.md, regra de projetos).
- [ ] **Passo 3:** ramo temporário no despacho do `.dpr` de teste (método da memória `metodologia-spike-descartavel-modo-binario`):

```pascal
  if ParamStr(1) = 'provaresource' then
  begin
    with TResourceStream.Create(HInstance, 'IMP_0001_LIBREOFFICE', RT_RCDATA) do
    try
      Writeln('tamanho=', Size);
    finally
      Free;
    end;
    Halt(0);
  end;
```

- [ ] **Passo 4:** compilar `ci.py --projeto SuprimentoServicesTEST`, rodar `./SuprimentoServicesTEST provaresource` no Linux. Esperado: `tamanho=` igual ao `wc -c` do arquivo.
- [ ] **Passo 5:** remover o ramo do passo 3; **manter** o `.rc` e o `{$R}`. Registrar no `record.md`.

---

## Fase 1 — Leitor OOXML

### Tarefa 3: `untOOXMLReader`

**Arquivos:**
- Criar: `padra_atualizado/fontes/genericos/untOOXMLReader.pas` (ASCII, CRLF, como o `untOOXMLWriter.pas` vizinho)

**Interfaces — Produz:**

```pascal
type
  TOOXMLTipoLido = (tlVazia, tlTexto, tlNumero);

  TOOXMLCelulaLida = record
    Tipo    : TOOXMLTipoLido;
    strValor: String;   { texto como está; número no formato invariante do arquivo ('12.5', '46295') }
  end;

  EOOXMLInvalido = class(Exception);

  TOOXMLPlanilhaLida = class
  public
    function fQtdLinhas: Integer;
    { Índices a partir de 0. Fora dos limites devolve célula tlVazia. }
    function fCelula(const AintLinha, AintColuna: Integer): TOOXMLCelulaLida;
    function fQtdColunas(const AintLinha: Integer): Integer;
  end;

  TOOXMLReader = class
  public
    { Primeira planilha do workbook. Quem recebe libera. Levanta EOOXMLInvalido se não for ZIP ou faltar parte. }
    class function fLer(AStream: TStream): TOOXMLPlanilhaLida;
  end;
```

Não usa `Xml.XMLDoc`: não há precedente de DOM vendor no binário Linux, e os testes do projeto já leem OOXML por varredura (`api.controller.cotacao.test.pas:778`). Varredor próprio, pequeno, que só entende o que precisa.

- [ ] **Passo 1: localizar a primeira planilha** pelo `workbook.xml` e `.rels`, não por nome fixo:

```pascal
class function TOOXMLReader.fCaminhoPrimeiraPlanilha(LZip: TZipFile): String;
var
  strWorkbook, strRels, strRid, strAlvo: String;
begin
  strWorkbook := fParte(LZip, 'xl/workbook.xml');
  { Primeiro <sheet .../> em ordem de documento é a primeira aba, a que o autcom lê. O prefixo de
    namespace varia por produtor - 'r:id' no LibreOffice e no Excel, mas não é garantido. }
  strRid := fAtributo(fPrimeiraTag(strWorkbook, 'sheet'), 'id');
  strRels := fParte(LZip, 'xl/_rels/workbook.xml.rels');
  strAlvo := fAtributo(fTagComAtributo(strRels, 'Relationship', 'Id', strRid), 'Target');
  if strAlvo.StartsWith('/') then
    Result := strAlvo.Substring(1)
  else
    Result := 'xl/' + strAlvo;
end;
```

- [ ] **Passo 2: varredor de tags.** Funções privadas sobre `String`: `fPrimeiraTag(AXml, ANome)`, `fProximaTag(AXml, ANome, var APos)`, `fAtributo(ATag, ANome)`, `fConteudo(AXml, ATagIni, APosIni)`. **Nome local sem prefixo**: `x:c` e `c` casam igual — comparar o que vem depois do `:`. Tag auto-fechada `<c r="B2" s="1"/>` é célula vazia, e o conteúdo não pode ser procurado adiante (armadilha registrada em `api.controller.cotacao.test.pas:797-799`). Desfazer entidades no texto: `&amp;`, `&lt;`, `&gt;`, `&quot;`, `&apos;`, `&#NNN;`, `&#xHH;`.

- [ ] **Passo 3: `sharedStrings` opcional.** Ausente é válido (é o nosso próprio arquivo, só `inlineStr`). Cada `<si>` é **a concatenação de todos os `<t>` dentro dele** — rich text do Excel quebra em `<r><t>`. Parte decodificada com `TEncoding.UTF8`.

- [ ] **Passo 4: células.** Para cada `<row>`: índice pelo atributo `r` (1-based) se houver, senão o seguinte ao anterior. Para cada `<c>`: coluna pela letra de `r` (`AB12` → 27, 0-based), senão a seguinte. Tipo pelo atributo `t`:
  - `s` → `tlTexto`, `strValor` = sharedString[índice do `<v>`]
  - `inlineStr` → `tlTexto`, texto do `<is>` (concatenação de `<t>`)
  - `str` (resultado de fórmula texto) → `tlTexto`, `<v>`
  - `b` → `tlTexto`, `'0'`/`'1'`
  - `e` → `tlTexto`, o `<v>` (ex.: `#DIV/0!`) — a interpretação trata como ilegível
  - ausente ou `n` → `tlNumero` com `<v>`; sem `<v>` → `tlVazia`
  - `<f>` é ignorado; vale o `<v>` em cache.

- [ ] **Passo 5: verificação por modo descartável** no binário de teste (mesma técnica da Tarefa 2): ramo `ooxmldump <arquivo>` que imprime `linha;coluna;tipo;valor` de toda célula não vazia. Rodar em `c:\tmp\espelho_cotacao.xlsx` e na saída do round-trip do LibreOffice (`scratchpad/rt/out/orig.xlsx`, `record.md`). Conferir contra `unzip -p ... xl/worksheets/sheet1.xml` a mão em 10 células: cabeçalho, uma de preço, a de `CNPJ :`, uma vazia no meio. **Os dois arquivos têm de dar a mesma grade.** Conferir também uma célula com fórmula (criar no LibreOffice: `=B20*2`) lendo o cache. Remover o ramo depois.

- [ ] **Passo 6: compilar** os dois projetos.

---

## Fase 2 — Legado

### Tarefa 4: Métodos públicos na `TCotacao`

**Arquivos:**
- Modificar: `padra_atualizado/fontes/movimentacaoitens/Cotacao/untCotacao.pas` — declaração na seção `Public` (começa em `:789`), corpo ao lado de `pAtualizaUnitarioItemfornecedor` (`:5743`). cp1252: `file` antes.

**Interfaces — Produz:**

```pascal
    { Prepara os datasets como pImportaArquivos faz antes do laço. Par obrigatório com pEncerrarImportacaoFornecedor. }
    Procedure pIniciarImportacaoFornecedor;
    Procedure pEncerrarImportacaoFornecedor;
    { False quando o item não está na cotação daquele fornecedor - a linha foi ignorada. }
    Function fAplicarLinhaImportada(Const AstrCodIte, AstrCodFor, AstrObsFor: String;
                                    Const AfltPreco, AfltIpi, AfltSt, AfltFrete, AfltDivisor,
                                    AfltCreIcm: Double): Boolean;
    Function fFornecedorAtivoNaCotacao(Const AstrCodFor: String): Boolean;
    { fSQLUpdateVlrTot com o join pelo vencedor efetivo, COALESCE(FORESC, FORMEN). Parâmetro :AUTOINCREM. }
    Function fSQLUpdateVlrTotVencedorEfetivo: String;
```

- [ ] **Passo 1: `pIniciarImportacaoFornecedor`** — reproduz a preparação de `pImportaArquivos` (`:13971-13980`) **sem** a parte de tela e sem multiloja (fora de escopo, spec §7.6):

```pascal
Procedure TCotacao.pIniciarImportacaoFornecedor;
Begin
  { Mesma preparacao do laco de pImportaArquivos: o fFindItemForncedor procura pelo indice
    COT_CODITE;COT_CODFOR, e os eventos de item desligados evitam o BeforePost de item recalcular a
    cada linha. Sem isto a primeira linha ja cai no fornecedor errado. }
  cdsPrecosItemfornecedor.IndexFieldNames := 'COT_CODITE;COT_CODFOR';
  pSetaEventosItem(False, True, True, False);
  If cdsItens.IndexFieldNames <> 'CODITE' Then
    cdsItens.IndexFieldNames := 'CODITE';
  FImportandoFornecedor := True;
End;

Procedure TCotacao.pEncerrarImportacaoFornecedor;
Begin
  FImportandoFornecedor := False;
  cdsItens.BeforePost := pBeforePostItens;
  pSetaEventosItem(True, True, True, False);
End;
```

  **Antes de escrever, reler `:13966-13990` e `:14085-14125`** e conferir que a lista acima é a mesma — se `pImportaArquivos` fizer algo a mais entre o `ShowModal` e o laço que não seja tela ou multiloja, incluir.

- [ ] **Passo 2: `fAplicarLinhaImportada`** — `fFindItemForncedor` antes, para devolver o "ignorado" que `pAtualizaUnitarioItemfornecedor` engole com `Exit`:

```pascal
Function TCotacao.fAplicarLinhaImportada(Const AstrCodIte, AstrCodFor, AstrObsFor: String;
  Const AfltPreco, AfltIpi, AfltSt, AfltFrete, AfltDivisor, AfltCreIcm: Double): Boolean;
Begin
  Result := fFindItemForncedor(AstrCodIte, AstrCodFor);
  If Result Then
    pAtualizaUnitarioItemfornecedor(AstrCodIte, AstrCodFor, AstrObsFor,
                                    AfltPreco, AfltIpi, AfltSt, AfltFrete, AfltDivisor, AfltCreIcm);
End;
```

  `AstrObsFor = STR_NAO_ATUALIZA` quando a coluna de observação não existe — é o sentinela que o próprio `pAtualizaUnitarioItemfornecedor` respeita (`:5788`, `untCotacaoTypesAndConst.pas:6`).

- [ ] **Passo 3: `fFornecedorAtivoNaCotacao`** — uma linha, delega a `fFornecedorAtivo` (privado, `:5119`).

- [ ] **Passo 4: `fSQLUpdateVlrTotVencedorEfetivo`** — troca o join e **recusa se não achou** o trecho, para a fórmula do autcom não mudar em silêncio e deixar a API somando pelo vencedor errado:

```pascal
Function TCotacao.fSQLUpdateVlrTotVencedorEfetivo: String;
Const
  JOIN_AUTCOM   = 'F.COT_CODFOR = I.COT_FORESC';
  JOIN_EFETIVO  = 'F.COT_CODFOR = COALESCE(I.COT_FORESC, I.COT_FORMEN)';
Var
  strSQL: String;
Begin
  strSQL := fSQLUpdateVlrTot(blnMulCot);
  { Req. 455096 RN07: a API nunca grava COT_FORESC, e o total do autcom soma so pelo escolhido. Se o
    trecho mudar em fSQLUpdateVlrTot, falhar aqui e melhor que gravar total parcial. }
  If Pos(JOIN_AUTCOM, strSQL) = 0 Then
    Raise Exception.Create('fSQLUpdateVlrTot mudou: o join pelo vencedor nao foi encontrado.');
  Result := StringReplace(strSQL, JOIN_AUTCOM, JOIN_EFETIVO, []);
End;
```

- [ ] **Passo 5:** `svn diff untCotacao.pas | wc -l` — só as linhas novas; `file` continua cp1252. Compilar `SuprimentoServicesAPI` (a unit já está no `.dpr`).

---

## Fase 3 — Serviço

### Tarefa 5: Tipos, constantes e exceções

**Arquivos:**
- Modificar: `padra_atualizado/fontes/genericos/untTypesSistema.pas:231-233` (cp1252)
- Modificar: `padra_atualizado/Services/Core/Services.Core.Worker.pas:1213-1215`
- Modificar: `padra_atualizado/Services/Core/suprimento/services/types/Suprimento.Services.Cotacao.Types.pas`

**Interfaces — Produz** (os nomes que as tarefas seguintes usam):

```pascal
{ untTypesSistema, ao lado de ECotacaoExportacao* }
  ECotacaoImportacaoNaoEncontrada = class(Exception);   { 404 }
  ECotacaoImportacaoConflito      = class(Exception);   { 409 - finalizada, BID, rascunho, trava, em andamento }
  ECotacaoImportacaoFornecedor    = class(Exception);   { 422 }
  { Recusa do arquivo no filho. A mensagem E o JSON de TCotacaoImportacaoResultado. }
  ECotacaoImportacaoRecusada      = class(Exception);

{ Suprimento.Services.Cotacao.Types }
const
  COTIMP_SERVICO_TAREFA   = 'TCotacaoImportacaoService';
  COTIMP_METODO_TAREFA    = 'fImportar';
  COTIMP_METODO_VALIDAR   = 'fValidarSolicitacao';
  COTIMP_METODO_CONSULTAR = 'fConsultarAndamento';
  CImportacaoConcluida    = 'Planilha importada.';

type
  TCotacaoImportacaoParams = class          { vai em SST_PARAMS; sem o arquivo (RN09) }
  published
    property sequencialCotacao: String;
    property codigoFornecedor: String;
    property nomeArquivo: String;           { só para mensagem }
    property tamanho: Int64;
    property sha256: String;
  end;

  TCotacaoImportacaoValidarParams = class   { pré-voo }
  published
    property sequencialCotacao, codigoFornecedor, codigoEmpresa, operador: String;
  end;

  TCotacaoImportacaoOcorrencia = class      { aviso ou erro, RN12 }
  published
    property linha: Integer;                { 0 = do arquivo; sai null no JSON - ver passo 3 }
    property codigoItem: String;
    property tipo: String;
    property mensagem: String;
  end;

  TCotacaoImportacaoResultado = class       { SST_RESULT em sucesso; mensagem da ECotacaoImportacaoRecusada em recusa }
  published
    property itensAtualizados: Integer;
    property avisos: TObjectList<TCotacaoImportacaoOcorrencia>;   [MVCListOf]
    property erros: TObjectList<TCotacaoImportacaoOcorrencia>;    [MVCListOf]
  end;

  TCotacaoImportacaoAndamento = class       { GET, formato do 459763 }
  published
    property idProcessamento, status, dataInicio, dataFim, mensagem: String;
    property itensAtualizados: Integer;
    property avisos, erros: TObjectList<TCotacaoImportacaoOcorrencia>;
  end;

  TCotacaoImportacaoAndamentoParams = class (idProcessamento, codigoEmpresa)
  TCotacaoImportacaoAndamentoResult = class (encontrado: Boolean; andamento: TCotacaoImportacaoAndamento)
  TCotacaoImportacaoGerarAceito     = class (idProcessamento: String)
```

  Constantes de tipo de ocorrência (RN12), em `const`, para a interpretação e os testes usarem o mesmo texto: `COTIMP_OC_ITEM_FORA_DA_COTACAO`, `..._ITEM_COM_PEDIDO_GERADO`, `..._FORNECEDOR_NAO_UTILIZADO`, `..._NOME_FORNECEDOR_DIVERGENTE`, `..._VALOR_ILEGIVEL`, `..._VALOR_NEGATIVO`, `..._CODIGO_REPETIDO`, `..._DATA_ENTREGA_ILEGIVEL`, `..._CONDICAO_PAGAMENTO_INVALIDA`; e de erro: `COTIMP_ER_COLUNA_AUSENTE`, `..._COTACAO_DIVERGENTE`, `..._CNPJ_DIVERGENTE`, `..._RASCUNHO_ATIVO`, `..._COTACAO_TRAVADA`, `..._ARQUIVO_INVALIDO`.

- [ ] **Passo 1:** exceções em `untTypesSistema.pas` logo após `:233`, e aliases em `Suprimento.Services.Cotacao.Types.pas` ao lado de `:37` (mesmo padrão `ECotacaoExportacaoEmAndamento = untTypesSistema.ECotacaoExportacaoEmAndamento;`).
- [ ] **Passo 2:** relevantar em `Services.Core.Worker.pas`, depois de `:1215`:

```pascal
  else if LErrorClass = 'ECotacaoImportacaoNaoEncontrada' then raise ECotacaoImportacaoNaoEncontrada.Create(Result)
  else if LErrorClass = 'ECotacaoImportacaoConflito' then raise ECotacaoImportacaoConflito.Create(Result)
  else if LErrorClass = 'ECotacaoImportacaoFornecedor' then raise ECotacaoImportacaoFornecedor.Create(Result)
```

  A `ECotacaoImportacaoRecusada` **não** entra: ela nasce na tarefa assíncrona, que não passa por `fExecuteTask`.
- [ ] **Passo 3:** DTOs com `MVCSwagJsonSchemaField` como os da exportação (`Types.pas:768-1060`). `linha` em ocorrência de arquivo: seguir o que o 459763 fez para campo sem valor — conferir em `TCotacaoExportacaoAndamento` como `dataFim` sai `null` (propriedade string vazia omitida? `Nullable`?) e usar o mesmo mecanismo; **não inventar** um terceiro.
- [ ] **Passo 4:** compilar.

### Tarefa 6: Diretório do processamento

**Arquivos:**
- Criar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Importacao.Arquivos.pas`

**Interfaces — Produz:**

```pascal
  TCotacaoImportacaoArquivos = class sealed
  public
    class function fDiretorioBase: String;
    { Cria o diretório se não existir. Levanta se o id não for numérico. }
    class function fCaminhoDoArquivo(const AIdProcessamento: String): String;
  end;
```

- [ ] **Passo 1:** copiar a estrutura de `Suprimento.Services.Cotacao.Arquivos.pas` inteira (116 linhas), trocando `NOME_DIRETORIO = 'CotacaoImportacao'`, `MASCARA = '*.xlsx'`, `RETENCAO_HORAS = 48` (RN10) e o nome fixo `arquivo.xlsx` — **nunca** o nome enviado (RN09). Validação do id igual à `fDiretorioDoProcessamento` de lá (`:67-79`). `initialization` com `TApiCleaner.Add(..., True, True)`.
- [ ] **Passo 2:** compilar.

### Tarefa 7: Interpretação da planilha

**Arquivos:**
- Criar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Importacao.Planilha.pas`

Sem banco e sem `TCotacao`: recebe a grade e o que precisa saber da cotação. É o que concentra as RN02–RN04, e por isso separado do orquestrador.

**Interfaces:**
- Consome: `TOOXMLPlanilhaLida` (Tarefa 3); `TCotacaoImportacaoOcorrencia`, constantes `COTIMP_*` (Tarefa 5); `fStrToFloat`, `fPadL`, `fValidaCndPag`, `fRemoveCaracteres`, constantes `TIT_*`.
- Produz:

```pascal
  TCotacaoImportacaoContexto = record
    NumeroCotacao, CnpjEmpresa, NomeFornecedor: String;
    TamanhoCodigoItem: Integer;
    UsaCreditoIcms: Boolean;
  end;

  TCotacaoImportacaoLinha = record
    Linha: Integer;            { 1-based, como o usuário vê no Excel }
    CodigoItem, Observacao: String;   { Observacao = STR_NAO_ATUALIZA sem a coluna }
    Preco, Ipi, St, Frete, Divisor, CreditoIcms: Double;  { Divisor = -1 sem a coluna, paridade }
  end;

  TCotacaoImportacaoLeitura = class
  public
    Linhas: TList<TCotacaoImportacaoLinha>;          { já sem repetidos: vence a última (paridade) }
    CondicaoPagamento: String;                        { vazio = manter }
    DataEntrega: TDateTime;                           { 0 = manter }
    Avisos, Erros: TObjectList<TCotacaoImportacaoOcorrencia>;
    function fRecusada: Boolean;                      { Erros.Count > 0 }
  end;

  TCotacaoImportacaoPlanilha = class
  public
    { Quem recebe libera. Nunca levanta por conteúdo: problema vira Erro ou Aviso. }
    class function fInterpretar(APlanilha: TOOXMLPlanilhaLida;
                                const AContexto: TCotacaoImportacaoContexto): TCotacaoImportacaoLeitura;
  end;
```

**Os `TIT_*` estão na implementation de `untCotacao.pas` (`:1212-1224`), não na interface** — não dá para usá-los de fora. Mover as constantes para `untCotacaoTypesAndConst.pas` (onde já está `STR_NAO_ATUALIZA`) e remover de `untCotacao.pas`, que já usa essa unit. É o jeito de cumprir "reusadas e não redigitadas" da RN03. Conferir antes com grep que nenhuma outra unit declara `TIT_CODIGO` com valor diferente.

- [ ] **Passo 1: localizar** (RN03). Célula comparada por `SameText(Trim(celula), titulo)`. Linha de títulos = primeira com célula igual a `TIT_CODIGO`. Obrigatórias ausentes → **um** erro `COTIMP_ER_COLUNA_AUSENTE` nomeando todas. Rótulos por prefixo em qualquer linha acima da de títulos: `COTAÇÃO DE PREÇOS:`, `CNPJ :`, `Fornecedor:` (valor depois do prefixo, `Trim`); `TIT_CND` e `TIT_DTENT`: valor na célula à direita.

  `COTAÇÃO DE PREÇOS:` e `CNPJ :` não têm constante no autcom (são literais em `fExportarExcelNovoPrg`, `untCotacao.pas:14855` e `:14866`). Declarar em `untCotacaoTypesAndConst.pas` junto dos `TIT_*` e **trocar os literais de `fExportarExcelNovoPrg` por elas** — senão exportação e importação divergem na primeira edição do texto.

- [ ] **Passo 2: cabeçalho** (RN02). Número divergente de `AContexto.NumeroCotacao` (comparar sem zeros à esquerda e sem espaço) ou ausente → erro `COTIMP_ER_COTACAO_DIVERGENTE`. CNPJ comparado só por dígitos → `COTIMP_ER_CNPJ_DIVERGENTE`. Nome do fornecedor divergente (`SameText` após `Trim`) → aviso.

- [ ] **Passo 3: número** (RN04):

```pascal
function fLerNumero(const ACelula: TOOXMLCelulaLida; out AfltValor: Double): Boolean;
begin
  AfltValor := 0;
  Result := True;
  case ACelula.Tipo of
    tlVazia: ;   { 0 - nao cotou }
    { Numerico no arquivo e SEMPRE invariante. Nao passa pelo fStrToFloat: ele tira todo '.', e
      '12.5' viraria 125. }
    tlNumero: Result := TryStrToFloat(ACelula.strValor, AfltValor, TFormatSettings.Invariant);
    { Texto e o que o fornecedor digitou numa celula formatada como texto: pt-BR, como o autcom. }
    tlTexto:
      begin
        AfltValor := fStrToFloat(ACelula.strValor, NaN);
        Result := not IsNan(AfltValor);
        if not Result then AfltValor := 0;
      end;
  end;
end;
```

  `fStrToFloat` aceita o default (`untFuncoesSimples.pas:6137`); `NaN` distingue ilegível de zero digitado. Ilegível → valor 0 + aviso `VALOR_ILEGIVEL`; negativo → mantém + aviso `VALOR_NEGATIVO`. Célula de texto vazia após `Trim` = vazia.

- [ ] **Passo 4: linhas.** Da linha seguinte à de títulos até `fQtdLinhas - 1`. Código: célula numérica vira texto sem casas (`'1234'`), texto com `Trim`; vazio → linha ignorada, sem aviso. `Length < TamanhoCodigoItem` → `fPadL(..., '0')`. Crédito ICMS só com `UsaCreditoIcms`, senão 0. Divisor ausente → `-1`. Código repetido: substituir a entrada anterior na lista (vence a última) e aviso `CODIGO_REPETIDO` com as duas linhas na mensagem.

- [ ] **Passo 5: condição e data.** Condição: `fRemoveCaracteres(valor, '().')`; vazio → manter; `fValidaCndPag` falso → manter + aviso. Data: célula numérica → serial (`valor + EncodeDate(1899,12,30)`, o epoch do Excel); texto → `StrToDateDef(valor, 0)`; vazia → manter; resultado 0 → manter + aviso. **Conferir onde `fValidaCndPag` e `fRemoveCaracteres` moram e se compilam no Linux** (`grep` + memória `autpas-verificar-unit-compila-linux`).

- [ ] **Passo 6:** compilar.

### Tarefa 8: Pré-condições

**Arquivos:**
- Criar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Importacao.PreCondicoes.pas`

**Interfaces — Produz:**

```pascal
  TCotacaoImportacaoPreCondicoes = class
  public
    { Levanta ECotacaoImportacaoNaoEncontrada / Conflito / Fornecedor com a mensagem ao usuário. }
    class procedure pVerificar(const ASeqCotacao, ACodEmp, ACodFor, AOperador: String);
    { Só rascunho e trava - o que pode mudar entre o POST e a execução. Mesmas exceções. }
    class procedure pReverificarConcorrencia(const ASeqCotacao, ACodEmp, AOperador: String);
  end;
```

- [ ] **Passo 1:** cotação por `AUTOINCREM` + `COT_CODEMP` (mesma consulta de `TCotacaoOficialService.fExiste`, `Consulta.pas:154`, mas trazendo `COT_NUMCOT`, `COT_DTAFIN`, `COT_LIBBID`). Ausente → `NaoEncontrada`. `COT_DTAFIN` não nulo → `Conflito` "finalizada". `COT_LIBBID = 'E'` → `Conflito` "BID encerrado".
- [ ] **Passo 2:** `SELECT 1 FROM COTCFO WHERE COT_SEQGER = :SEQ AND COT_CODFOR = :FOR` vazio → `Fornecedor` (422).
- [ ] **Passo 3: rascunho** (RN08):

```sql
SELECT AUTOINCREM, COT_DESCRI FROM COTGER_RES
 WHERE COT_CODEMP = :CODEMP AND COT_NUMCOT = :NUMCOT AND IFNULL(COT_EXCLUI, 'N') <> 'S'
 LIMIT 1
```

  Achou → `Conflito` citando o `AUTOINCREM` e a descrição, pedindo salvar ou descartar no autcom.
- [ ] **Passo 4: trava** (RN14). O prefixo da base é obrigatório:

```sql
SELECT LCK_ORIGEM, LCK_CODOPE, LCK_NUM_IP, LCK_NOMMAQ FROM LCKATC
 WHERE LCK_CHAACE = CONCAT(DATABASE(), '.', :CHAVE)
```

  `:CHAVE = 'COTACAO_' + NUMCOT + '_' + CODEMP`. Sem linha → passa. `LCK_ORIGEM = 'REPORMAIS'` e `LCK_CODOPE = AOperador` → passa. Qualquer outra → `Conflito` "em uso por outra estação: <LCK_NOMMAQ ou LCK_NUM_IP>, operador <LCK_CODOPE>". **Conferir no MCP** que `LCK_NOMMAQ` existe na `LCKATC` da base de teste (`DESCRIBE LCKATC`) — o INSERT do autcom o grava (`untFuncoesGenerica.pas`, linha do `INSERT INTO LCKATC`), o do REPOR+ não mapeia.
- [ ] **Passo 5:** `pReverificarConcorrencia` = passos 3 e 4, lendo `COT_NUMCOT` de novo.
- [ ] **Passo 6:** compilar.

### Tarefa 9: Concorrência

**Arquivos:**
- Modificar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Concorrencia.pas`

- [ ] **Passo 1:** classe `TCotacaoImportacaoConcorrencia` com `fEmAndamento`, `pAdquirirLock`, `pLiberarLock`, `pEncerrarOrfas` — **copiando** a `TCotacaoExportacaoConcorrencia` (`:78-111` e implementação), com `fNomeLock = 'COTIMP:COT_' + seq` e `SERVICO/METODO = COTIMP_*`. **Sem teto**: a spec não pede, e o teto da exportação exige registrar CFGSIS em duas listas de `untCfgRepositorio.pas` — fica registrado como fora de escopo no `record.md`. A órfã notifica pela `TCotacaoImportacaoNotificacao` (Tarefa 11).
- [ ] **Passo 2:** compilar.

### Tarefa 10: Orquestrador

**Arquivos:**
- Criar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Importacao.pas`

**Interfaces:**
- Consome: Tarefas 3, 4, 5, 6, 7, 8.
- Produz:

```pascal
  TCotacaoImportacaoProcessador = class
  public
    { Quem recebe libera. Recusa do arquivo levanta ECotacaoImportacaoRecusada com o JSON do resultado. }
    class function fImportar(AParams: TCotacaoImportacaoParams; const ACodEmp, AOperador,
                             AIdProcessamento: String): TCotacaoImportacaoResultado;
  end;
```

- [ ] **Passo 1: ler e interpretar.** `TFileStream` do `fCaminhoDoArquivo`; conferir `tamanho` e `sha256` contra `AParams` (arquivo trocado no disco → erro `ARQUIVO_INVALIDO`). `TOOXMLReader.fLer` — `EOOXMLInvalido` vira erro `ARQUIVO_INVALIDO`. Contexto: `COT_NUMCOT` da cotação, `EMP_CNPJ` de `CADEMP` da empresa, `NOMFOR` do fornecedor (mesma fonte que a exportação usa em `fNomeDoFornecedor`, `Exportacao.pas`), `fTamCodIte`, `fCfgSis('CRICCO', varBoolean)`. Recusada → `raise ECotacaoImportacaoRecusada.Create(TApiUtils.ToJson(resultado))` **antes** de abrir a `TCotacao`.

- [ ] **Passo 2: abrir a cotação** — **extrair** `TCotacaoExportacaoGerador.pAbrirCotacao` (`Exportacao.pas:70-110`) para uma classe comum em vez de copiar 40 linhas de preconditions caladas. Destino: `TCotacaoOficialAbertura.pAbrir(AobjCotacao, AstrSeqGer)` numa unit nova `Suprimento.Services.Cotacao.Abertura.pas`, e a exportação passa a chamá-la. Comportamento idêntico — mover, não reescrever.

- [ ] **Passo 3: aplicar.**

```pascal
    objCotacao.pIniciarImportacaoFornecedor;
    try
      for LLinha in LLeitura.Linhas do
        if not objCotacao.fAplicarLinhaImportada(LLinha.CodigoItem, AParams.codigoFornecedor,
                 LLinha.Observacao, LLinha.Preco, LLinha.Ipi, LLinha.St, LLinha.Frete,
                 LLinha.Divisor, LLinha.CreditoIcms) then
          pAviso(LLeitura, LLinha.Linha, LLinha.CodigoItem, COTIMP_OC_ITEM_FORA_DA_COTACAO, ...)
        else
          LItensAplicados.Add(LLinha.CodigoItem);
    finally
      objCotacao.pEncerrarImportacaoFornecedor;
    end;
```

  Fornecedor com `not objCotacao.fFornecedorAtivoNaCotacao(...)` → aviso `FORNECEDOR_NAO_UTILIZADO` (uma vez).

- [ ] **Passo 4: menor preço** (RN06). Para cada item de `LItensAplicados`, posicionar `cdsItens` (`FindKey`), pular se `GERPED = 'S'` (aviso `ITEM_COM_PEDIDO_GERADO`) ou `QTDTOT <= 0`. Percorrer as linhas do item em `cdsPrecosItemfornecedor` (índice `COT_CODITE;COT_CODFOR`, filtro desligado):

```pascal
      strMenor := '';
      fltMenor := 0;
      strAtual := objCotacao.cdsItens.FieldByName('FORMEN').AsString;
      { mesmo criterio do fSelecionaMenoresPrecosPrg (untCotacao.pas:6437): preco > 0 e ativo }
      if (PRECOM_FOR > 0) and objCotacao.fFornecedorAtivoNaCotacao(COT_CODFOR) then
        if (strMenor = '') or (UNITOT < fltMenor) or
           ((UNITOT = fltMenor) and fDesempata(COT_CODFOR, strMenor, strAtual)) then
        begin strMenor := COT_CODFOR; fltMenor := UNITOT; end;
```

  `fDesempata(ANovo, AGanhando, AAtual)`: verdadeiro se `ANovo = AAtual`; falso se `AGanhando = AAtual`; senão `ANovo < AGanhando`. Comparar `UNITOT` com `SameValue(a, b, 1e-9)`, não `=`. Resultado vai para um dicionário `item → FORMEN` que o passo 5 grava — **não** editar `cdsItens` (o `BeforePost` de item dispararia recálculo de tela).

- [ ] **Passo 5: gravar** (RN07), dentro de `TCotacaoImportacaoConcorrencia.pAdquirirLock` já adquirido pelo worker:

```pascal
      LblnTransacao := fStartTransaction;
      try
        TCotacaoImportacaoPreCondicoes.pReverificarConcorrencia(AParams.sequencialCotacao, ACodEmp, AOperador);
        pGravarPrecos(objCotacao, AParams, LItensAplicados);  { UPDATE COTFOR ... WHERE COT_SEQGER, COT_CODITE, COT_CODFOR }
        pGravarMenores(AParams.sequencialCotacao, LMenores);  { UPDATE COTITE SET COT_FORMEN }
        pGravarFornecedor(AParams, LLeitura);                 { UPDATE COTCFO: CONPAG/DTAENT se preenchidos, IMPEXC='S' }
        pGravarTotal(objCotacao, AParams.sequencialCotacao);  { fSQLUpdateVlrTotVencedorEfetivo, :AUTOINCREM }
        if LblnTransacao then fCommit;
      except
        if LblnTransacao then fRollback;
        raise;
      end;
```

  `pGravarPrecos` lê do `cdsPrecosItemfornecedor` posicionado os campos `PRECOM_FOR→COT_VALUNI`, `IPI_FOR→COT_IPIENT`, `FRETE_FOR→COT_FREENT`, `ST_FOR→COT_SUBSTI`, `CREICM_FOR→COT_CREICM`, `DIVISO→COT_DIVISO`, `UNITOT→COT_UNITOT`, `COT_OBSITE`, e `COT_IMPPLA := fNow()` (**não** o `Now` que o `pAtualizaUnitarioItemfornecedor` pôs no dataset — `untCotacao.pas:5770`). Mapeamento em `untCotacao.pas:4359-4384`. Uma `fCriaQuery` preparada, `ParamByName` por linha; 30 mil itens é teto conhecido — se ficar lento, `TBatchSQL` (CLAUDE.md, acesso a dados), medido antes de trocar.

  Conflito na reverificação → `ECotacaoImportacaoConflito` sobe do filho; o `ProcessTask` grava `SST_SUCESS='N'` e a mensagem — tarefa `ERRO`, nada gravado.

- [ ] **Passo 6:** compilar.

### Tarefa 11: Worker, notificação e andamento

**Arquivos:**
- Modificar: `Suprimento.Services.Workers.pas`, `Suprimento.Services.Cotacao.Notificacao.pas`, `Suprimento.Services.Cotacao.Consulta.pas`

- [ ] **Passo 1: `TCotacaoImportacaoServiceWorker`**, espelho de `TCotacaoExportacaoServiceWorker` (`Workers.pas:57-76`, `:156-325`):
  - `fValidarSolicitacao(string)` (no filho): operador em `CADOPE` (`:249-251`), `TCotacaoImportacaoPreCondicoes.pVerificar`, `TCotacaoImportacaoConcorrencia.pEncerrarOrfas`, `fEmAndamento` → `Conflito`.
  - `pValidarSolicitacao(TCotacaoImportacaoValidarParams)` (no pai): `fExecuteTask(COTIMP_SERVICO_TAREFA, COTIMP_METODO_VALIDAR, ...)`, resultado descartado.
  - `fImportar(string)` (no filho): `JsonAs<TCotacaoImportacaoParams>`, lock, `TCotacaoImportacaoProcessador.fImportar`, `ToJson`, libera lock. Empresa e operador: **da linha da tarefa**, não do JSON — `SST_CODEMP`/`SST_CODOPE`. Conferir como o `fGerar` da exportação os obtém dentro do filho (`VS_strCodEmp` e o usuário definido pelo `ProcessTask` a partir de `_CODOPE`, `Services.Core.Worker.pas:185-195`).
  - `fConsultarAndamento` nas duas sobrecargas, via `TConsultaAndamentoCache.fEnvelope`.
- [ ] **Passo 2: `LoadMethods`** — três `AddMethod(COTIMP_SERVICO_TAREFA + '.' + COTIMP_METODO_*, ...)`. Conferir com `grep -n "COTIMP_" Suprimento.Services.Workers.pas` que cada método aparece no `fExecuteTask` **e** no `AddMethod` (regra `services-workers`).
- [ ] **Passo 3: `pNotifyFinish`** — terceiro ramo, `METODO_IMPORTACAO = COTIMP_SERVICO_TAREFA + '.' + COTIMP_METODO_TAREFA`, chamando `pNotificarImportacao(AQuery)` no mesmo desenho de `pNotificarExportacao` (`:661-716`). Em sucesso, `itensAtualizados` e `avisos.Count` do `SST_RESULT`; em erro, tentar ler `SST_RESULT` como `TCotacaoImportacaoResultado` para contar `erros` — se não for JSON (conflito, exceção técnica), contagem 0.
- [ ] **Passo 4: `TCotacaoImportacaoNotificacao.pNotificarConclusao(codEmp, codOpe, workId, seqCotacao, codFor, sucesso, itens, avisos, erros, mensagemErro)`** — espelho da da exportação (`Notificacao.pas:250-303`), `MEN_NUMDOC = 'COT_' + seq`. Textos com `#231#227` como lá (arquivo cp1252 com escapes, não acento cru): "Importação da cotação %s, fornecedor %s concluída: %d item(ns) importado(s)[, %d aviso(s)]." / "Importação da cotação %s, fornecedor %s recusada: %d erro(s). Consulte o andamento." / sem contagem quando `erros = 0` em falha.
- [ ] **Passo 5: `TCotacaoImportacaoAndamentoService.fConsultar(id, codEmp)`** em `Consulta.pas`, espelho de `TCotacaoExportacaoAndamentoService.fConsultar` (`:710-812`), filtrando `SST_SERVIC/SST_METHOD = COTIMP_*` e reusando `fSqlStatusDerivado`. Sem etapa (a importação não publica progresso — YAGNI). `CONCLUIDO`: `itensAtualizados` e `avisos` do `_RESULT`, `mensagem = CImportacaoConcluida`. `ERRO`: `_RESULT` parseável como `TCotacaoImportacaoResultado` → `erros` e `avisos` dele e `mensagem` "Arquivo recusado: N erro(s)"; senão `mensagem = _RESULT` (conflito da reverificação, exceção técnica).
- [ ] **Passo 6:** compilar.

### Tarefa 12: Controller

**Arquivos:**
- Modificar: `Services/Suprimento.Services.API/Source/api/controller/api.controller.cotacao.pas`

- [ ] **Passo 1: declarações**, com Swagger no padrão das vizinhas (`:79-117`): `ImportarPlanilha` (`POST /importacao/gerar`, `MVCConsumes('multipart/form-data')`, parâmetros `plFormData` para `arquivo`, `sequencialCotacao`, `codFornecedor` — **conferir no fonte do DMVC 3.4.1** (`MVCFramework.Swagger.Commons.pas`) que `plFormData` e arquivo existem; se não, documentar no `MVCSwagSummary`), respostas 202/400/401/404/409/413 (do DMVC)/415/422. `ConsultarAndamentoImportacao` (`GET /importacao/($idProcessamento)`).
- [ ] **Passo 2:** ~~`Web.ReqMulti` no controller~~ — **desnecessário**: já está no `SuprimentoServicesAPI.dpr:14` (spike da Tarefa 1). Usar `Context.Request.Files` e `Context.Request.ContentParam`, medidos no spike.
- [ ] **Passo 3: `ImportarPlanilha`:**

```pascal
procedure TCotacaoController.ImportarPlanilha;
var
  LArquivo: TAbstractWebRequestFile;
  LParams: TCotacaoImportacaoParams;
  LValidar: TCotacaoImportacaoValidarParams;
  LBytes: TBytes;
  LId, LOperador: String;
begin
  try
    LOperador := fOperadorDoHeader;

    if Context.Request.Files.Count <> 1 then
      raise EInvalidParams.Create('Envie exatamente um arquivo no campo "arquivo".');
    LArquivo := Context.Request.Files[0];

    { Formato antes de banco: 415 e 413 nao precisam de pre-voo. }
    if not SameText(ExtractFileExt(LArquivo.FileName), '.xlsx') then
      pRecusar(HTTP_STATUS.UnsupportedMediaType, 'Envie a planilha em .xlsx. O formato .xls nao e lido.');
    { Sem teto proprio: o DMVC recusa corpo acima de 5 MiB com 413 antes de chegar aqui
      (api.core.webmodule.pas:68-69, medido no spike do Req. 455096). }
    LBytes := fLerTudo(LArquivo.Stream);
    if (Length(LBytes) < 4) or (LBytes[0] <> $50) or (LBytes[1] <> $4B) then
      pRecusar(HTTP_STATUS.UnsupportedMediaType, 'O arquivo enviado nao e uma planilha .xlsx.');

    LParams := TCotacaoImportacaoParams.Create;
    try
      LParams.sequencialCotacao := Context.Request.ContentParam('sequencialCotacao').Trim;
      LParams.codigoFornecedor  := Context.Request.ContentParam('codFornecedor').Trim;
      { vazio -> EInvalidParams }
      LParams.nomeArquivo := ExtractFileName(LArquivo.FileName);
      LParams.tamanho     := Length(LBytes);
      LParams.sha256      := THashSHA2.GetHashString(...);

      { pre-voo no filho - ver GerarExportacao }
      LValidar := ...; TCotacaoImportacaoServiceWorker.pValidarSolicitacao(LValidar);

      LId := TSuprimentoWorkersManager.fEnqueueAsyncTask(VS_strCodEmp, COTIMP_SERVICO_TAREFA,
               COTIMP_METODO_TAREFA, TApiUtils.ToJson(LParams));
      try
        TFile.WriteAllBytes(TCotacaoImportacaoArquivos.fCaminhoDoArquivo(LId), LBytes);
        TSuprimentoWorkerServer.SpawnTask(LId, VS_strCodEmp);
      except
        { RF03: nao deixar tarefa PENDENTE sem arquivo. A varredura de orfas nao pega linha que
          nunca teve _DTAINI. }
        pMarcarTarefaComoErro(LId, ...);
        raise;
      end;
      { 202 com TCotacaoImportacaoGerarAceito }
    finally
      LParams.Free;
    end;
  except
    on e: EInvalidParams do RenderStatusMessage(HTTP_STATUS.BadRequest, ...);
    on e: ECotacaoImportacaoNaoEncontrada do RenderStatusMessage(HTTP_STATUS.NotFound, ...);
    on e: ECotacaoImportacaoConflito do RenderStatusMessage(HTTP_STATUS.Conflict, ...);
    on e: ECotacaoImportacaoFornecedor do RenderStatusMessage(HTTP_STATUS.UnprocessableEntity, ...);
    on e: Exception do raise;
  end;
end;
```

  `pMarcarTarefaComoErro`: **não** fazer SQL no controller (regra do 460364, `:430-441`). Levar para um método do worker (`TCotacaoImportacaoServiceWorker.pDescartarTarefa(LId, motivo)` via `fExecuteTask`) ou, se for estado da infra, para `TWorkersManagerBase` — ver primeiro se o `Services.Core.Worker` já tem algo que encerra linha assíncrona (`pEncerrarOrfas` do giro faz o UPDATE; reusar a forma). `ContentParam` para campo de multipart: confirmado ou não na Tarefa 1; se não, `RawWebRequest.ContentFields.Values[...]`.
- [ ] **Passo 4: `ConsultarAndamentoImportacao`** — cópia de `ConsultarAndamentoExportacao` (`:537-572`) com os tipos da importação.
- [ ] **Passo 5:** compilar.

### Tarefa 13: Registro no `.dpr`

**Arquivos:**
- Modificar: `Services/Suprimento.Services.API/Target/Linux/SuprimentoServicesAPI.dpr` (perto de `:243`) e `SuprimentoServicesTEST.dpr` se ele listar as units de serviço (conferir).

- [ ] **Passo 1:** `uses` com `untOOXMLReader`, `Suprimento.Services.Cotacao.Abertura`, `...Importacao.Arquivos`, `...Importacao.Planilha`, `...Importacao.PreCondicoes`, `...Importacao`, caminhos relativos no estilo das vizinhas. Não mexer no `.dproj`.
- [ ] **Passo 2:** compilar os dois; rodar a suíte de exportação existente (casos 0040–0059) — a Tarefa 10 passo 2 mexeu na abertura da cotação que eles exercitam.

---

## Fase 4 — Testes

### Tarefa 14: POST multipart no runner

**Arquivos:**
- Modificar: `Services/Core/api/core/api.core.test.utils.pas` (compartilhado pelos 3 serviços — mudança **aditiva**, nenhuma assinatura existente muda)

**Interfaces — Produz:**

```pascal
    function PostMultipartMethod(const ACompany, APath: string; const ACampos: TArray<TPair<string, string>>;
      const ACampoArquivo, ACaminhoArquivo: string; var AResponseCode: Integer; ACheckError: Boolean = True): string;
    { ARequestJson do caso: {"campos":{...},"arquivo":"<recurso>"}. Extrai o recurso para arquivo temporário. }
    function RunPostMultipartMethodTest(const APath, ATextPrefix: string; const ATestID: Integer;
      AssertMethod: TAssertMethod): string;
```

- [ ] **Passo 1:** `PostMultipartMethod` sobre o mesmo `TRESTClient`/`TRESTRequest` do `PostMethod` (`:529-560`): `AddParameter(nome, valor, TRESTRequestParameterKind.pkREQUESTBODY)` por campo e `AddFile(ACampoArquivo, ACaminhoArquivo)` — **conferir** que o `REST.Client` da versão do Delphi dos Services tem `TRESTRequest.AddFile` e que ele monta `multipart/form-data` sozinho; **não** definir `Content-Type` à mão (quebraria o boundary). Mesmos headers `Empresa`/`Authorization` do `PostMethod`.
- [ ] **Passo 2:** `RunPostMultipartMethodTest`, espelho do `RunPostMethodTest(APath, ATextPrefix, ATestID, ...)` (`:603-650`): lê a linha do caso, interpreta o `request` como `{"campos":{...},"arquivo":"IMP_0001_LIBREOFFICE"}`, extrai o resource (`TResourceStream`, Tarefa 2) para `TPath.GetTempFileName + '.xlsx'`, posta, apaga o temporário no `finally`, e segue o mesmo fluxo de `sql_before`, assert e `sql_after` — **reusar** a função interna que o `RunPostMethodTest` usa depois de obter a resposta, não duplicar o fluxo.
- [ ] **Passo 3:** compilar os **três** projetos de teste (`SuprimentoServicesTEST`, `FaturamentoServicesTEST`, `FinanceiroServicesTEST`) — a unit é compartilhada.

### Tarefa 15: Arquivos de teste

**Arquivos:**
- Criar: `Services/Suprimento.Services.API/Scripts/testes/arquivos/*.xlsx`, `README.md` da pasta
- Modificar: `Target/Linux/ArquivosTeste.rc`

- [ ] **Passo 1: base.** Pelo MCP, confirmar na base `2_30_BELAT_TC` a cotação `02200000000003542022` (a dos casos 0041–0043): `COT_NUMCOT`, `COT_DTAFIN` nulo, `COT_LIBBID <> 'E'`, fornecedores em `COTCFO` com `COT_UTILIZ`, e pelo menos um item com `COT_GERPED='S'` e um fornecedor com `COT_UTILIZ='N'` — se não houver, o caso monta no `sql_before`. Registrar os códigos escolhidos no `README.md` da pasta.
- [ ] **Passo 2: exportar** a planilha do fornecedor escolhido pela própria API (`POST /cotacao/exportacao/gerar` + download). É o arquivo que o fornecedor recebe.
- [ ] **Passo 3: gerar as variações no LibreOffice**, preenchendo por script Python sobre o XML e **salvando pelo `soffice --convert-to xlsx`** (é o que garante estrutura de produtor real, `record.md`): `0001_libreoffice_ok`, `0003_coluna_ausente`, `0004_cotacao_divergente`, `0005_cnpj_divergente`, `0006_valores_estranhos` (ilegível, negativo, repetido, data e condição inválidas, código fora, código numérico sem zeros), `0007_colunas_reordenadas`, `0008_texto_12_50`, `0009_formula`. Cada um com o que tem dentro descrito no `README.md`.
- [ ] **Passo 4: pedir ao João o `0002_excel_ok.xlsx`**: o `0001` aberto e salvo no Excel real, sem mudar nada, **e** uma segunda versão com um preço alterado e uma célula de preço digitada como fórmula. Critério 2 da spec — **bloqueia o fechamento**.
- [ ] **Passo 5:** uma linha `RCDATA` por arquivo no `.rc`; `svn add` dos `.xlsx` com `svn:mime-type application/octet-stream` (conferir que o SVN não marcou como texto).

### Tarefa 16: Casos de teste

**Arquivos:** os três artefatos por caso (memória `autpas-caso-de-teste-services-tres-artefatos`): `Scripts/testes/casos/NNNN_TEST_IMPORTACAO_*.sql`, `Target/Linux/Test_Cases/cotacao/<Metodo>.inc`, método em `api.controller.cotacao.test.pas`. Assert de banco: procedure nova `pProcessoCotacaoImportacaoResponse` em `Scripts/testes/004_INFRA_PROCEDURE_IMPORTACAO.sql`, com marcador `VERSAO_PROCEDURE:` e a constante na unit de teste (memória `autpas-runner-suprimento-mecanica`), **um bloco por tabela** — `COTFOR`, `COTITE`, `COTCFO`, `COTGER` (memória `autpas-assert-de-banco-bloco-por-tabela`).

- [ ] **Passo 1: métodos.** `ImportarPlanilhaTest` (`RunPostMultipartMethodTest` + `pAguardarConclusao` + GET + assert de banco), `ImportarPlanilhaOperadorTest` (header `OperadorLogado` próprio, para os casos de `LCKATC` — o header não cabe na tabela), `ConsultarAndamentoImportacaoTest`.
- [ ] **Passo 2: casos**, um por critério de aceitação da spec §6, com `sql_before` que **restaura** `COTFOR`/`COTITE`/`COTCFO`/`COTGER` do fornecedor e item usados (os casos escrevem na base) e `sql_after` limpando `LCKATC`/`COTGER_RES` que o caso criou:

  | Critério | Caso |
  |---|---|
  | 1, 3 | `0001`: todos os campos gravados, `COT_IMPPLA` preenchido, `COT_IMPEXC='S'`, `UNITOT` conferido contra valor calculado à mão para o `FRMCUS` da base |
  | 2 | `0002` (arquivo do João) — mesmo assert do 1 |
  | 3 (variantes) | `FRMCUS` 1, 2, 3 e `CRICCO` ligada/desligada via `sql_before` na `CFGSIS`, restaurada no `sql_after` — conferir antes o valor atual na base |
  | 4, 5, 6 | `FORESC` manual preservado, `FORMEN` e `VLRTOT` recalculados; empate montado no `sql_before` |
  | 7 | coluna ausente → `ERRO`, nenhuma das 4 tabelas alterada |
  | 7a | `0006` → `CONCLUIDO`, cada aviso na linha certa |
  | 8, 9 | fora da cotação, `GERPED='S'`, `UTILIZ='N'`, cotação e CNPJ divergentes, nome divergente |
  | 10, 10a | `COTGER_RES` ativo; `LCKATC` do autcom, do REPOR+ de outro operador (409) e do REPOR+ do mesmo operador (importa) — chave com `CONCAT(DATABASE(), '.', ...)` |
  | 11 | 404, 409 finalizada, 409 BID, 422, 415 `.xls`, 415 não-ZIP, 413 |
  | 12 | `0007` e `0008` |
  | 13 | GET de id inexistente 404; `MENREP` com `MEN_WORKID`/`MEN_CODOPE` |
  | 14 | **[manual]** duas importações simultâneas — roteiro em `Scripts/testes/ROTEIRO_MANUAL.md` |
  | 10 (entre POST e execução) | **[manual]** — roteiro em `ROTEIRO_MANUAL.md` |

- [ ] **Passo 3:** `python validar_casos.py` na pasta dos scripts; aplicar `004_...` pelo Workbench (`DELIMITER` não passa no `autcom_db.py`) e os casos na base.
- [ ] **Passo 4:** compilar `SuprimentoServicesTEST`, implantar, rodar a suíte inteira (Suprimento). **Registrar a saída** no `record.md`, verdes e vermelhos.
- [ ] **Passo 5:** atualizar `Scripts/testes/README.md` (seção do que a suíte garante) com a importação.

### Tarefa 17: Fechamento

- [ ] **Passo 1:** `svn st` e `svn diff` de tudo; conferir encoding de cada `.pas` alterado contra `svn cat` (memória `autpas-python-converte-eol-infla-diff`).
- [ ] **Passo 2:** `/review` sobre o diff; `superpowers:requesting-code-review`.
- [ ] **Passo 3:** `record.md` — o que foi executado, desvios deste plano, pendências; **caso 2 (Excel) marcado como pendente enquanto o arquivo do João não tiver rodado**.
- [ ] **Passo 4:** entregar ao João para DelphAI e commit (`Req. 455096` na primeira linha, token do DelphAI). Não commitar sem pedido.

---

## Fora deste plano (registrado)

- Teto de importações simultâneas (CFGSIS nova em duas listas de `untCfgRepositorio.pas`) — a spec não pede.
- Etapa/progresso no andamento — a importação é curta frente ao giro.
- Tudo o que a spec §7 lista.
