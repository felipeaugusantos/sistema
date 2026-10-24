# Req. 455094 — Plano de implementação

> **Para quem executa:** as tarefas estão em ordem de dependência. Cada uma termina em algo verificável
> sozinho. Passos usam `- [ ]` para acompanhamento.

**Objetivo:** Expor na Suprimento.Services.API a exportação da cotação oficial em planilha, um arquivo por
fornecedor, com envio opcional por e-mail, em execução assíncrona.

**Arquitetura:** Espelha o Req. 454895. O controller valida, enfileira em `SSATSK` e responde 202; o
processo separado no modo `task` gera as planilhas e envia os e-mails; dois GET consultam andamento e
baixam arquivo. A regra da planilha continua no legado (`untGeraExcelHtml` + `fExportarExcelNovoPrg`), que
ganha ramo Linux; o laço de fornecedores e a leitura de opções, hoje presos a form, são substituídos por um
orquestrador sem GUI em `Services/Core/suprimento/services/`.

**Tecnologias:** Delphi (Linux64 via PAServer), DMVCFramework, UniDAC, Indy/OpenSSL para SMTP, MySQL.

**Spec:** `IA/specs/455094/spec.md` — ler antes de começar. O plano argumenta a partir dela.

## Restrições globais

Valem para **todas** as tarefas, sem repetição em cada uma:

- **Zona Legado** (`fontes/`): Hungarian style obrigatório, prefixos `p`/`f` em métodos, `F` em campos.
  Não refatorar proativamente. **Zona Moderna** (`Services/`): sem Hungarian, dot-notation nas units.
- **Travas do pre-commit:** proibidos `TBitBtn`, `TButton`, `TDataSetProvider`, `TClientDataSet`, `TDBGrid`,
  `dxSkin*`, `.SetFocus`, `StrToFloat(`, `StrToFloatDef(`, `Application.CreateForm(`, `ActiveControl :=`,
  `FOREIGN_KEY_CHECKS`. Usar `fStrToFloat`, `pSetFocus`, `pCriarForm`.
- **`fNow()`** em todo timestamp persistido. Nunca `Now`/`NOW()`.
- **Todo SQL novo** com `fCriaQuery` e `ParamByName()`. Concatenação de string em SQL é violação real,
  não estilística.
- **Encoding:** fontes `.pas` em latin1. Ao editar via ferramenta, digitar o caractere acentuado correto e
  deixar o hook `delphi-encoding.ps1` resolver. Conferir `svn diff | wc -l` depois de cada edição — Python
  reescrevendo `.pas` converte EOL e infla o diff sem sintoma.
- **Compilação Linux:** **não disparar `msbuild`.** Pedir ao usuário e aguardar o resultado.
- **Casos de teste são do analista.** A entrega de quem implementa é o contrato e a lista de casos a cobrir
  (Tarefa 12). Não escrever casos de teste como tarefa própria.
- **Commit só na Tarefa 13**, com `Req. 455094` na primeira linha e o token do DelphAI. Não commitar antes.
- **Retenção do arquivo:** 48 horas. **`MEN_TIPO__`:** token textual `'COTACAO'`, o mesmo do giro.

---

## Estrutura de arquivos

| Arquivo | Responsabilidade | Ação |
|---|---|---|
| `fontes/genericos/untGeraExcelHtml.pas` | Gerador HTML da planilha (`TGeraArquivo`) | Modificar — ramo Linux, sair da cadeia OLE |
| `fontes/genericos/untGeraExcelHtmlTypes.pas` | Tipos de formatação sem VCL (`TFonteExcel`, `fCorParaHtml`, `fLarguraEstimada`) | **Criar** |
| `fontes/genericos/untOOXMLWriter.pas` | Empacotador OOXML: partes XML, estilos, proteção, validação, ZIP | **Criar** |
| `fontes/genericos/untGeraExcelXlsx.pas` | `TEscreveXLSX` — liga o layout do `TGeraArquivo` ao empacotador | **Criar** |
| `fontes/movimentacaoitens/Cotacao/untCotacao.pas` | `fExportarExcelNovoPrg` — regra da planilha | Modificar — implementação Linux |
| `Services/Core/suprimento/services/types/Suprimento.Services.Cotacao.Types.pas` | DTOs do recurso | Modificar — acrescentar DTOs da exportação |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Exportacao.pas` | Orquestrador: laço de fornecedores, geração, envio, status | **Criar** |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Arquivos.pas` | Diretório por processamento, resolução de caminho, expurgo | **Criar** |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Concorrencia.pas` | Lock, teto, órfãs | Modificar — variante por cotação |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Consulta.pas` | Andamento e situação | Modificar — andamento da exportação |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Notificacao.pas` | `MENREP` | Modificar — notificação da exportação |
| `Services/Core/suprimento/services/Suprimento.Services.Workers.pas` | Registro do método e `pNotifyFinish` | Modificar |
| `Services/Suprimento.Services.API/Source/api/controller/api.controller.cotacao.pas` | Três rotas novas | Modificar |
| `Services/Suprimento.Services.API/Target/Linux/SuprimentoServicesAPI.dpr` | Cláusula `uses` | Modificar |

Dois arquivos novos em vez de um só porque separam responsabilidades que mudam por motivos diferentes: o
orquestrador muda quando a regra de exportação muda; o de arquivos muda quando a política de armazenamento
e retenção muda.

Mesma lógica na dupla `untOOXMLWriter` / `untGeraExcelXlsx`: o empacotador sabe de OOXML e não sabe de
cotação, o renderizador sabe de `TGeraArquivo` e não sabe de ZIP. **Ler a planilha é o próximo requisito**,
e a leitura vai reaproveitar o empacotador — se nascer misturado ao `TEscreve`, o próximo requisito
recomeça do zero.

---

## Revisão de 31/08/2026 (tarde) — o desenho da Fase 1 mudou

**Descoberto durante a execução:** o caminho do autcom depende de COM. O `TEscreveHTML.pSaveFile` abre a
planilha no Excel ou no BrOffice para re-salvar como XLS de verdade, auto-ajustar colunas, **bloquear
células**, validar faixa e proteger a estrutura. O HTML era intermediário, não o produto. Ver RN01 da spec.

O bloqueio não é cosmético: a planilha vai travada em tudo menos preço, IPI, ST e frete, com validação
numérica — e o arquivo **retorna** para importação (RN17). Sem isso o fornecedor poderia alterar código de
item e quantidade antes de devolver.

**Novo desenho:** `taXLSX` no enum e um `TEscreveXLSX` que grava OOXML — `.xlsx` de verdade — com bloqueio
por célula, senha e validação no próprio XML, empacotado por `System.Zip`, sem COM. É a extensão que a
arquitetura já previa — `TEscreve` é base abstrata com sete métodos virtuais puros e o construtor já
despacha por tipo.

> *Corrigido em 31/08/2026, 21h.* Este bloco dizia `taXLS` sobre o `XLSWriter`, em SpreadsheetML. O spike da
> RN18 derrubou essa rota: o LibreOffice descarta `sheetProtection` e `DataValidation` do SpreadsheetML, e
> a trava por célula sozinha é inerte — a planilha sai editável. Descoberto porque o usuário abriu o
> arquivo de amostra e conseguiu editar tudo.

**O que sobrevive das Tarefas 1 e 2, já executadas:**

- [x] Tudo. O `TGeraArquivo` e a base `TEscreve` moram no `untGeraExcelHtml`, então essa unit tem de
      compilar em Linux de qualquer forma. As adições ao `Services.Core.Types` valem igual.
- O que muda: `TEscreveHTML` passa a ser Windows-only — seu `pSaveFile` é o único ponto com COM —, e o
  Linux instancia `TEscreveXLSX`.
- O `XLSWriter` **não entra no requisito**. Ele foi avaliado a fundo e a avaliação continua útil como
  registro, mas não há alteração a fazer nele.

**O que muda nas tarefas seguintes:** entra a **Tarefa 3-B**, abaixo, e ela é a maior do plano.

---

## Fase 1 — Gerador da planilha em Linux

É a fase de risco. Nada depois dela funciona se ela não fechar, então vem primeiro.

### Tarefa 1: Extrair os tipos de formatação do gerador para uma unit sem VCL

**Arquivos:**
- Criar: `padra_atualizado/fontes/genericos/untGeraExcelHtmlTypes.pas`
- Modificar: `padra_atualizado/fontes/genericos/untGeraExcelHtml.pas` (cláusula `uses` e declarações)

**Interfaces:**
- Consome: nada.
- Produz: `TFonteExcel = class`, as constantes `ceBlack` / `ceWhite` / `ceRed` como `TColor`,
  `fCorParaHtml(TColor): String` e `fLarguraEstimada(String, Integer, TFontStyles): Integer` — usados pela
  Tarefa 2 e pelo `fExportarExcelNovoPrg` da Tarefa 3.

O gerador hoje declara formatação com `TFont` e `TColor` de `Vcl.Graphics`, e por causa disso arrasta
`untGeraExcel` → `untExcel`, que é automação COM. O COM não pode entrar no binário Linux. Mas nada da
formatação precisa de VCL: o gerador só usa tamanho, negrito/itálico, nome da fonte e cor, e escreve tudo
como atributo de HTML.

- [ ] **Passo 1: Levantar exatamente quais membros de `TFont` e `TColor` o gerador usa**

Não presumir pelos nomes. Rodar as duas buscas e listar as ocorrências:

```bash
grep -n "TFont\|TColor\|clBlack\|clWhite\|clRed\|fsBold\|fsItalic\|\.Size\|\.Style\|\.Name" \
  padra_atualizado/fontes/genericos/untGeraExcelHtml.pas
grep -n "fSetFont" padra_atualizado/fontes/genericos/untGeraExcelHtml.pas
```

Esperado: usos de `Size`, `Style` (`fsBold`, `fsItalic`), `Name`, `Color`, e a fábrica `fSetFont`.
**Se aparecer qualquer membro fora dessa lista** — `Handle`, `PixelsPerInch`, `Charset` —, parar e reavaliar:
significa que a formatação depende do device context e a extração fica maior do que esta tarefa.

- [ ] **Passo 2: Criar a unit de tipos**

```pascal
unit untGeraExcelHtmlTypes;

{ Tipos de formatacao do gerador de planilha HTML, sem dependencia de VCL.
  Existem para que untGeraExcelHtml possa ser compilada no binario Linux dos Services: a versao
  anterior usava TFont/TColor de Vcl.Graphics e, por isso, arrastava untGeraExcel -> untExcel, que e
  automacao COM e nao existe em Linux. }

interface

{ REVISADO em 31/08/2026, apos medir: CLASSE, nao record. O gerador usa nil como sentinela em quatro
  parametros default, com Assigned() decidindo se cria a fonte (untGeraExcelHtml.pas:337 e :393).
  Record nao aceita nil. Ver RN16 da spec.

  TColor e TFontStyles NAO precisam de substituto: os dois vivem em System.UITypes, que e RTL neutra.
  So a CLASSE TFont e VCL. Por isso fSetFont conserva os tipos de parametro e muda apenas o tipo de
  retorno - e as 81 chamadas existentes nao mudam, apenas as declaracoes locais de variavel. }

type
  TFonteExcel = class
  public
    intTamanho: Integer;
    strNome: String;
    setEstilos: TFontStyles;
    corFonte: TColor;
    constructor Create; overload;
    constructor Create(AintTamanho: Integer; AsetEstilos: TFontStyles;
                       AcorFonte: TColor; AstrNome: String); overload;
  end;

const
  { Equivalentes neutros de clBlack/clWhite/clRed, que sao da VCL. Valores em TColor, que e
    System.UITypes e vale nas duas plataformas. Usados apenas onde o codigo precisa compilar em
    Linux - no Windows as constantes da VCL continuam valendo e nao ha por que troca-las. }
  ceBlack: TColor = $000000;
  ceWhite: TColor = $FFFFFF;
  ceRed:   TColor = $0000FF;   { TColor e BGR, nao RGB: vermelho e $0000FF }

{ Alem da classe e das constantes, a unit expoe duas rotinas: }

function fCorParaHtml(AcorFonte: TColor): String;
function fLarguraEstimada(const AstrTexto: String; AintTamanhoFonte: Integer;
                          AsetEstilos: TFontStyles): Integer;
```

**`fCorParaHtml` substitui macros do Windows, nao inventa conversao.** O `ColorToHtml` do gerador
(`untGeraExcelHtml.pas:1168`) usa `GetRValue` / `GetGValue` / `GetBValue`, que sao de `Winapi.Windows`.
A conversao dele ja esta correta — `TColor` e BGR e a saida e RRGGBB. A rotina nova faz a mesma
aritmetica explicitamente, e o `ColorToHtml` passa a delegar nela nas duas plataformas.

**`fLarguraEstimada` existe por causa do `GetVirtualWidth`** — ver Passo 3-A abaixo e RN15 da spec.

> **Estado: FEITO em 31/08/2026.** O arquivo esta criado, com 136 linhas, e adicionado ao SVN.
> A implementacao real esta nele; o que ficou aqui e o contrato e o porque.

- [ ] **Passo 3: Trocar as declarações no gerador e condicionar o `uses`**

Em `untGeraExcelHtml.pas`, a cláusula `uses` atual é:

```pascal
uses Classes, Dialogs, ComObj, Variants, SysUtils, untExcel, Windows, DateUtils,
     System.Generics.Collections, Vcl.Graphics, Data.DB, Vcl.ComCtrls, Forms, Vcl.Controls,
     cxProgressBar, untGeraExcel;
```

Passa a:

```pascal
uses
{$IFDEF LINUX}
  {$I '..\..\Services\Core\services.core.uses.inc'},
  untGeraExcelHtmlTypes,
{$ELSE}
  Dialogs, ComObj, untExcel, Windows, Vcl.Graphics, Vcl.ComCtrls, Forms, Vcl.Controls,
  cxProgressBar, untGeraExcel, untGeraExcelHtmlTypes,
{$ENDIF}
  Classes, Variants, SysUtils, DateUtils, System.Generics.Collections, Data.DB;
```

Conferir o caminho relativo do `.inc` contra o que `untTEnvioEmail.pas:7` usa — ele é a referência de
unit legada que compila nos dois lados, e o número de `..\` depende da profundidade da pasta.

Trocar **somente** `TFont` por `TFonteExcel`. **`TColor` e `TFontStyles` ficam como estão** — os dois são
de `System.UITypes`, RTL neutra, e trocá-los seria churn sem ganho. `TFontName` também sai: é
`Vcl.Graphics`; usar `String`.

Nas declarações de campo **não** criar ramo condicional: o tipo novo vale nas duas plataformas, e um
`IFDEF` ali faria o mesmo código-fonte ter duas formas, divergindo autcom e Linux.

- [ ] **Passo 3-A: Resolver `GetVirtualWidth`, que é o bloqueio real**

*Descoberto em 31/08/2026, antes de compilar. É maior que a questão de tipo.*

`untGeraExcelHtml.pas:663` mede a largura do texto em pixels assim:

```pascal
ACanvas := TControlCanvas.Create;
TControlCanvas(ACanvas).Control := Application.MainForm;
AFont.Size := SetFontSize(Afont.Size);
ACanvas.Font.Assign(AFont);
result := ACanvas.TextWidth(AValue);
```

Depende de `Application.MainForm`. Serviço Linux não tem — e não teria nem com FMX, porque serviço não
tem form principal. É chamada em duas linhas, 343 e 398, para dimensionar coluna: mede o título, compara
com `Field.Size`, usa o maior.

Partir a função por plataforma, mantendo assinatura:

```pascal
function TEscreve.GetVirtualWidth(AValue: String; AFont: TFonteExcel): integer;
{$IFDEF LINUX}
Begin
  { Largura estimada. Medir de verdade exige device context, que servico nao tem. Largura de coluna e
    atributo cosmetico no HTML - conteudo, ordem e valores nao mudam. Ver RN15 da spec. }
  Result := fLarguraEstimada(AValue, AFont.intTamanho, AFont.setEstilos);
End;
{$ELSE}
var
  ACanvas: TControlCanvas;
Begin
  { Ramo inalterado: o autcom continua medindo com Canvas, e a planilha que os usuarios recebem hoje
    sai exatamente como antes. }
  ...
End;
{$ENDIF}
```

**O ramo Windows não muda de comportamento**, só de tipo de parâmetro — `AFont.Size` passa a
`AFont.intTamanho` e `ACanvas.Font.Assign(AFont)` passa a preencher os membros um a um, porque
`TFonteExcel` não é `TPersistent` e não tem `Assign` compatível com `TFont`:

```pascal
  ACanvas.Font.Name  := AFont.strNome;
  ACanvas.Font.Size  := SetFontSize(AFont.intTamanho);
  ACanvas.Font.Style := AFont.setEstilos;
  ACanvas.Font.Color := AFont.corFonte;
```

**Verificação:** gerar a mesma planilha no autcom antes e depois desta mudança e comparar largura de
coluna. Tem de ser **idêntica** no Windows — se mudou, o `SetFontSize` foi aplicado fora de ordem.

- [ ] **Passo 4: Ajustar as declarações locais nos chamadores — não as chamadas**

**As 81 chamadas de `fSetFont` não mudam.** Medido em 31/08/2026: `fSetFont` conserva nome e tipos de
parâmetro (`Integer`, `TFontStyles`, `TColor` — todos neutros), mudando apenas o **retorno**. E os
chamadores passam o resultado adiante, não inspecionam membros. `TGeraArquivo.fSetFont(14, [fsBold], clRed)`
continua compilando no Windows, letra por letra.

O que muda são as **declarações de variável local** que recebem o retorno — tipicamente duas por função:

```bash
grep -rn "fSetFont" padra_atualizado/fontes --include=*.pas | grep -v __history
grep -rn ": *TFont *;" padra_atualizado/fontes --include=*.pas | grep -v __history
```

Cruzar as duas listas: os 8 arquivos que chamam `fSetFont` são
`untGeraExcelHtml`, `untCotacao` (32 chamadas, 14 delas na função que a Tarefa 3 porta),
`untRelEstItemsAcimaMax` (17), `untLotePrecosEfetivacaoCx` (10), `untPnlDadosOPI` (9),
`untTabelaPreco` (6), `untTSelecaoExportacaoCampos` (3) e `untAtualizacaoMargemParaFranquias` (2).
Em cada um, trocar `: TFont;` por `: TFonteExcel;` nas variáveis que recebem `fSetFont`.

**Não** deixar sobrecarga de compatibilidade retornando `TFont` — ela reintroduziria `Vcl.Graphics` na
cadeia e desfaria a tarefa.

- [ ] **Passo 5: Compilar o autcom (Windows) e conferir que nada regrediu**

Pedir ao usuário a compilação de `padra_atualizado/autcom.groupproj`.
Esperado: compila. Erro esperado e aceitável nesta etapa: chamador de `fSetFont` que o `grep` do Passo 4
não pegou — corrigir e recompilar.

- [ ] **Passo 6: Conferir o diff**

```bash
svn diff padra_atualizado/fontes/genericos/untGeraExcelHtml.pas | wc -l
svn status padra_atualizado/fontes/genericos/untGeraExcelHtmlTypes.pas
```

Esperado: diff proporcional à mudança (dezenas de linhas, não centenas — centenas indicam EOL convertido) e
a unit nova como `?`. Adicionar ao SVN: `svn add`.

---

### Tarefa 2: Compilar o gerador no binário Linux

**Arquivos:**
- Modificar: `padra_atualizado/Services/Suprimento.Services.API/Target/Linux/SuprimentoServicesAPI.dpr`

**Interfaces:**
- Consome: `untGeraExcelHtmlTypes` e `untGeraExcelHtml` da Tarefa 1.
- Produz: `TGeraArquivo` disponível no binário Linux, para a Tarefa 3.

- [ ] **Passo 1: Acrescentar as duas units ao `.dpr`**

Editar **apenas** o `.dpr` — a IDE sincroniza o `.dproj`. Inserir junto das outras units de `genericos`:

```pascal
  untGeraExcelHtmlTypes in '..\..\..\..\fontes\genericos\untGeraExcelHtmlTypes.pas',
  untGeraExcelHtml in '..\..\..\..\fontes\genericos\untGeraExcelHtml.pas',
```

- [ ] **Passo 2: Pedir a compilação Linux e ler o erro com atenção**

Pedir ao usuário a compilação de `SuprimentoServicesAPI` para Linux64.

O erro **esperado e informativo** é `untExcel` ou `ComObj` aparecendo na cadeia: significa que algum
identificador no corpo de `untGeraExcelHtml` ainda vem de lá e o `IFDEF` do `uses` não bastou. O compilador
aponta a linha. Cada ocorrência é uma decisão: ou o identificador tem equivalente em
`untGeraExcelHtmlTypes`, ou o trecho que o usa é Windows-only e recebe `{$IFDEF LINUX}` com `raise`, no
padrão do projeto:

```pascal
{$IFDEF LINUX}
  raise Exception.Create('TGeraArquivo.<metodo> ainda nao possui implementacao linux');
{$ELSE}
```

- [ ] **Passo 3: Confirmar que a unit está no binário, e não só no `.dpr`**

`grep` no `.dpr` dá falso positivo — nome igual, `IFNDEF` em volta, ou stub duplicado em
`Services.Core.Types`. A prova é a compilação do Passo 2 ter fechado **com** a unit no `uses` e um símbolo
dela sendo referenciado. Se nada referencia ainda, o linker pode descartá-la silenciosamente; nesse caso a
prova real vem na Tarefa 3.

---

### Tarefa 3: Implementação Linux de `fExportarExcelNovoPrg`

**Arquivos:**
- Modificar: `padra_atualizado/fontes/movimentacaoitens/Cotacao/untCotacao.pas:14665`

**Interfaces:**
- Consome: `TGeraArquivo` (Tarefa 2), `TFonteExcel` e `fLarguraEstimada` (Tarefa 1).
- Produz: `TCotacao.fExportarExcelNovoPrg` executável em Linux, gravando o `.xlsx` no caminho de
  `recExportaPreco.strNomArq`. Consumido pela Tarefa 6.

Esta é a única das quatro funções com `raise` que precisa de Linux — as outras três são laço de tela
(ver RF09 da spec). Ela já recebe parâmetros por record de campo (`recExportaPreco`), não por componente,
o que a torna a de menor atrito.

- [x] **Passo 1: Ler a função inteira antes de mexer**

```bash
sed -n '14665,14880p' padra_atualizado/fontes/movimentacaoitens/Cotacao/untCotacao.pas
```

Anotar cada dependência de UI e de Windows. O parâmetro `cxProgresso: TcxProgressBar` é a mais visível;
pode haver `Application.ExeName`, separador de caminho `\` e `TFont`.

- [x] **Passo 2: Trocar o `raise` por implementação, mantendo a assinatura**

O padrão do projeto é `IFDEF` no corpo, assinatura preservada, regra no `{$ELSE}`. Aqui a regra é a
**mesma** nos dois lados — o que difere são as dependências de UI. Então, em vez de duplicar o corpo,
extrair o corpo para um método sem UI e deixar a assinatura antiga delegando:

```pascal
Function TCotacao.fExportarExcelNovoPrg(cxProgresso: TcxProgressBar): Boolean;
{$IFDEF LINUX}
begin
  Result := fExportarExcelNovoInterno;
end;
{$ELSE}
Begin
  FcxProgressoExportacao := cxProgresso;
  Try
    Result := fExportarExcelNovoInterno;
  Finally
    FcxProgressoExportacao := Nil;
  End;
End;
{$ENDIF}
```

E dentro de `fExportarExcelNovoInterno`, cada atualização de progresso passa por guarda:

```pascal
If Assigned(FcxProgressoExportacao) Then
  FcxProgressoExportacao.Position := intContador;
```

Assim o Linux não tem barra de progresso e o Windows continua com a dele, **sem** duas cópias da regra de
formação da planilha. Duas cópias divergiriam na primeira alteração de layout — é exatamente o que a
RN01 da spec quer evitar.

- [x] **Passo 3: Trocar separador de caminho por `PathDelim`**

```bash
grep -n "'\\\\'" padra_atualizado/fontes/movimentacaoitens/Cotacao/untCotacao.pas | sed -n '1,40p'
```

Nas linhas **dentro desta função**, trocar `'\'` literal por `PathDelim`. Não sair corrigindo o arquivo
inteiro — as outras funções são Windows-only e mudá-las é refatoração proativa, proibida na zona legado.

- [x] **Passo 4: Pedir a compilação Linux**

Esperado: compila. Se aparecer identificador de VCL não previsto, ele entra no `{$IFDEF LINUX}` com guarda,
como o progresso do Passo 2.

- [x] **Passo 5: Compilar o autcom e conferir que a exportação da tela continua idêntica**

#### Executado em 31/08/2026, 23h — três desvios em relação ao que está escrito acima

**1. Não houve extração para `fExportarExcelNovoInterno`.** O Passo 2 previa separar o corpo por causa
do `cxProgresso`, mas isso deixou de ser problema: `Services.Core.Types` já declara `TcxProgressBar`, o
chamador passa `nil` e todo uso no gerador está sob `Assigned`. O corpo ficou **único**, com um
`{$IFDEF LINUX}` só no ponto do `fMensagem` e o tipo escolhido inline no construtor. Menos código e
nenhuma cópia da regra de layout para divergir.

**2. O Passo 3 não tinha o que fazer.** Não há barra invertida literal nem `Application.` dentro da
função — o caminho chega pronto em `recExportaPreco.strNomArq`.

**3. O plano não previu que quatro helpers da função só existem em `untFuncoesSimples`,** que é
Windows-only. Foi o trabalho real da tarefa:

| Helper | O que foi feito |
|---|---|
| `fRetNomVendRep` | já era wrapper de `untFuncoesGenerica.fRetNomVendedor` — passou a chamar o original |
| `fFormataCondPag` | movido para `untFuncoesGenerica`; `untFuncoesSimples` virou delegate |
| `fRetNomeEmpresa` / `fRetFantasiaEmpresa` | `pLeEmpresa` subiu e os dois títulos saem de `EMP_NOMEMP` / `EMP_NOMFAN` do mesmo SELECT — duas consultas a CADEMP a menos |

**Também saíram do `{$IFNDEF LINUX}`:** o campo `geraExcel`, e `pSomaTotaisCotacao` /
`pMontaResumoCotacao`, que estavam de fora só porque `TTotaisHTML` não era visível. Sem as duas a
planilha sairia sem linha de total.

**Bug latente corrigido no caminho:** `untGeraExcelHtmlTypes` duplicava `TcxProgressBar`, que
`Services.Core.Types:113` já declara — com `Position: Double` contra `Integer` do stub. Compilava porque
o stub ganhava por ordem de `uses` dentro do gerador; quebraria aqui, ao passar o objeto do `untCotacao`.
Stub removido.

**E `fsBold` precisou de alias.** `System.UITypes` declara `TFontStyle` com SCOPEDENUMS ligado; no
Windows quem reexporta sem escopo é a `Vcl.Graphics`. Os quatro membros entraram em
`Services.Core.Types`, ao lado da paleta `cl*` — mesmo papel, e vale para qualquer unit legada portada
daqui em diante.

Pedir a compilação de `autcom.groupproj`. A refatoração do Passo 2 mexeu no caminho que a tela usa, então
esta compilação não é formalidade. Roteiro manual mínimo, na tela de cotação: exportar um fornecedor em
XLS, abrir o arquivo, conferir cabeçalho da empresa, colunas e valores. Comparar com um arquivo gerado
antes da mudança.

---

### Tarefa 3-B: renderizador OOXML sem COM

*Acrescentada em 31/08/2026. **Reescrita em 31/08/2026, 21h, depois do spike da RN18** — a versão anterior
descrevia a rota A, SpreadsheetML sobre o `XLSWriter`, que foi descartada por evidência. É a maior tarefa do
plano.*

**A rota está fechada: OOXML (`.xlsx`) montado em Delphi com `System.Zip`.** O que fundamenta:

- SpreadsheetML **não serve** — o LibreOffice descarta `sheetProtection` e `DataValidation` na importação, e
  `locked` sem proteção de planilha é inerte. Resultado prático: planilha inteiramente editável. Ver RN18.
- O `.xlsx` mínimo com proteção, senha, trava por célula e validação foi medido no spike em **6 partes e
  ~80 linhas de XML**. Sobreviveu ao round-trip do LibreOffice com tudo preservado.
- `System.Zip` é RTL e já compila para Linux nesta base (`untTEnvioEmail.pas` o usa no `libGatIme.so`).
  Nenhuma dependência nova no container.

**Arquivos:**
- Criar: `padra_atualizado/fontes/genericos/untOOXMLWriter.pas` — o empacotador
- Criar: `padra_atualizado/fontes/genericos/untGeraExcelXlsx.pas` — o renderizador
- Modificar: `padra_atualizado/fontes/genericos/untGeraExcelHtml.pas` (enum e despacho do construtor)
- Modificar: `padra_atualizado/autcom.dpr` e `SuprimentoServicesAPI.dpr` (registro das duas units)

**Por que duas units e não uma.** O empacotador sabe de OOXML e não sabe de cotação; o renderizador sabe de
`TGeraArquivo` e não sabe de ZIP. A separação não é estética: **ler a planilha é o próximo requisito**, e a
leitura vai reaproveitar o conhecimento estrutural do empacotador — nomes das partes, relacionamentos,
convenção de índice de estilo. Se isso nascer misturado ao `TEscreve`, o próximo requisito recomeça do zero.

**Interfaces:**
- Consome: `TEscreve` e as listas `FListaTitulos` / `FListaCampos` de `untGeraExcelHtml`.
- Produz: `TOOXMLWorkbook` (em `untOOXMLWriter`), `TEscreveXLSX = class(TEscreve)` e o valor `taXLSX` no
  enum `TTipoArquivoHTML`. Consumido pela Tarefa 6, que escolhe o tipo conforme a plataforma.

- [x] **Passo 1: Criar `untOOXMLWriter.pas` com o modelo mínimo**

A superfície é pequena de propósito — só o que a declaração do layout usa. Nada de fórmula, gráfico,
`sharedStrings` ou múltiplas planilhas.

```pascal
unit untOOXMLWriter;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Zip;

type
  TOOXMLTipoCelula = (tcTexto, tcNumero);

  TOOXMLEstilo = record
    intIndice     : Integer;   // posicao em cellXfs
    strFormatoNum : String;    // '' = geral
    blnNegrito    : Boolean;
    strCorFonte   : String;    // 'FFFFFFFF', vazio = padrao
    strCorFundo   : String;    // 'FF4472C4', vazio = sem preenchimento
    blnTravada    : Boolean;
    strAlinhamento: String;    // 'center' | 'right' | ''
  end;

  TOOXMLValidacao = record
    strColuna : String;   // 'C'
    intLinIni : Integer;
    intLinFim : Integer;
    fltMinimo : Double;
    fltMaximo : Double;
    strTitulo : String;
    strMensagem: String;
  end;

  TOOXMLWorkbook = class
  private
    FlstLinhas     : TStringList;          // XML de <row> ja pronto
    FlstEstilos    : TList<TOOXMLEstilo>;
    FlstValidacoes : TList<TOOXMLValidacao>;
    FlstLarguras   : TDictionary<Integer, Double>;
    FstrNomePlanilha: String;
    FstrSenha      : String;
    FintLinhaAtual : Integer;
    FstrLinhaBuffer: String;
    FintColunaAtual: Integer;
    function fEscapaXml(const AstrTexto: String): String;
    function fHashSenhaLegado(const AstrSenha: String): String;
    function fMontaContentTypes: String;
    function fMontaRels: String;
    function fMontaWorkbook: String;
    function fMontaWorkbookRels: String;
    function fMontaStyles: String;
    function fMontaSheet: String;
  public
    constructor Create(const AstrNomePlanilha: String);
    destructor Destroy; override;

    function fAdicionaEstilo(const AEstilo: TOOXMLEstilo): Integer;
    procedure pDefineLargura(AintColuna: Integer; AfltLargura: Double);
    procedure pAdicionaValidacao(const AValidacao: TOOXMLValidacao);

    procedure pAbreLinha;
    procedure pEscreveCelula(AintColuna: Integer; const AstrValor: String;
                             ATipo: TOOXMLTipoCelula; AintEstilo: Integer);
    procedure pFechaLinha;

    procedure pSalvaEmArquivo(const AstrNomeArquivo: String);

    property Senha: String read FstrSenha write FstrSenha;
    property LinhaAtual: Integer read FintLinhaAtual;
  end;

function fLetraColuna(AintColuna: Integer): String;
```

Três pontos da implementação que o spike já resolveu, e que **não** devem ser reinventados:

**O hash da senha** é o algoritmo legado de 16 bits do Excel 97, aceito por Excel e LibreOffice:

```pascal
function TOOXMLWorkbook.fHashSenhaLegado(const AstrSenha: String): String;
var
  intHash, i: Integer;
begin
  intHash := 0;
  For i := Length(AstrSenha) DownTo 1 Do
  Begin
    intHash := ((intHash Shr 14) And $01) Or ((intHash Shl 1) And $7FFF);
    intHash := intHash Xor Ord(AstrSenha[i]);
  End;
  intHash := ((intHash Shr 14) And $01) Or ((intHash Shl 1) And $7FFF);
  intHash := intHash Xor Length(AstrSenha);
  intHash := intHash Xor $CE4B;
  Result := IntToHex(intHash, 4);
end;
```

**O `<sheetProtection>` omite `selectLockedCells` e `selectUnlockedCells`.** O default do schema é seleção
liberada, e é o comportamento de produção — o autcom chama `Protect(Password := Senha)` com os demais
parâmetros no default (`untExcelOfc.pas:518`), e o default do Excel permite selecionar célula travada. O
spike usou `selectLockedCells="1"` na primeira versão e o usuário não conseguia sequer clicar na descrição.

```pascal
  Result := Result + '<sheetProtection password="' + fHashSenhaLegado(FstrSenha) +
                     '" sheet="1" objects="1" scenarios="1"/>';
```

**O escape de XML não é opcional.** Descrição de produto com `&` produz arquivo corrompido, não célula
errada:

```pascal
function TOOXMLWorkbook.fEscapaXml(const AstrTexto: String): String;
begin
  Result := StringReplace(AstrTexto, '&', '&amp;',  [rfReplaceAll]);
  Result := StringReplace(Result,    '<', '&lt;',   [rfReplaceAll]);
  Result := StringReplace(Result,    '>', '&gt;',   [rfReplaceAll]);
end;
```

O `&` tem de ser trocado **primeiro**, senão os `&` das próprias entidades são re-escapados.

Número vai para o XML sempre com ponto decimal, independente do locale do servidor:

```pascal
  FloatToStr(fltValor, TFormatSettings.Invariant)
```

E o empacotamento fecha em `pSalvaEmArquivo`, com `TZipFile` gravando as seis partes. Os nomes das partes
usam **barra normal**, inclusive no Windows — é o separador do formato ZIP, não do sistema de arquivos.

Verificação: um programa mínimo que instancia o `TOOXMLWorkbook`, escreve três linhas com uma coluna
travada e uma destravada, aplica senha e validação, e grava. Abrir no LibreOffice e conferir contra
`c:\tmp\spike_455094_v2.xlsx`, que é a referência de comportamento aprovada.

- [x] **Passo 2: Compilar a unit nas duas plataformas**

`untOOXMLWriter` não tem VCL nem COM — o `uses` é só RTL. Registrar em `autcom.dpr` e no
`SuprimentoServicesAPI.dpr`, e pedir as duas compilações ao usuário.

*Lembrete da Tarefa 1: a pasta `genericos` não está no search path, cada unit é listada explicitamente no
`.dpr`. Esquecer isso dá `F2613 Unit not found`, que foi exatamente o erro da Tarefa 1.*

- [x] **Passo 3: Acrescentar `taXLSX` ao enum e ao despacho**

```pascal
  TTipoArquivoHTML = (taHtml, taCSV, taXLSX);
```

e no construtor de `TGeraArquivo`:

```pascal
  Case ATipoArquivo Of
    taHtml : FEscreve := TEscreveHtml.Create();
    taCSV  : FEscreve := TEscreveCSV.Create();
    taXLSX : FEscreve := TEscreveXLSX.Create();
  End;
```

O nome do enum continua `TTipoArquivoHTML` mesmo deixando de ser só HTML: renomear obrigaria a tocar os
oito chamadores, e a Tarefa 1 mostrou o que isso custa. **Não** renomear.

- [x] **Passo 4: Implementar os sete métodos em `untGeraExcelXlsx.pas`**

`TEscreve` declara sete virtuais puros — `fEscreveTitulos`, `fEscreveTitulosEditaveis`, `fEscreveFiltros`,
`fEscreveCampos`, `pSaveFile`, `fEscreveLinha`, `pFechaLinha`. `TEscreveHTML` é a referência de
comportamento: ~500 linhas. O mapeamento é direto, e `pSaveFile` — que no HTML é onde mora o COM — aqui é
só `FWorkbook.pSalvaEmArquivo(FNomeArquivo)`.

Quatro pontos a respeitar. Os três primeiros vêm da leitura do `TEscreveHTML`; o quarto é específico do
OOXML:

1. **`FLetra` é a coluna** — o bloqueio e a validação são endereçados por letra mais índice de linha
   (`pBloquearCelulas`, `untGeraExcelHtml.pas:979` e `:984`). O renderizador novo precisa da mesma
   correspondência entre campo e coluna, senão trava a célula errada.
2. **`iniDetalhes`** marca onde começam os dados, depois dos títulos. É de onde sai o `intLinIni` de cada
   `TOOXMLValidacao` — validação que comece na linha errada cobre o cabeçalho e deixa a última linha de
   dados sem cobertura.
3. **`FBloquear` por campo** vem da declaração: `False` nas colunas que o fornecedor preenche, default
   `True` nas descritivas. Inverter isso entrega ao fornecedor uma planilha onde ele pode alterar código
   de item — e o arquivo volta para importação.
4. **Estilo em OOXML é índice, não atributo inline.** Cada combinação distinta de formato, cor, negrito,
   alinhamento e trava é **uma entrada em `cellXfs`**, e a célula referencia pelo índice `s="N"`. O
   renderizador precisa deduplicar: montar a chave da combinação, procurar no que já existe e só então
   criar. Emitir um `xf` por célula gera arquivo enorme e alguns leitores recusam.

- [x] **Passo 5: Escolher o tipo por plataforma na cotação**

Em `fExportarExcelNovoPrg`, único ponto alterado:

```pascal
  geraExcel := TGeraArquivo.Create({$IFDEF LINUX}taXLSX{$ELSE}taHtml{$ENDIF},
                                   recExportaPreco.cdsDados, Nil, cxProgresso);
```

O resto da função — os títulos, as vinte e poucas colunas, as fontes, os mínimos e máximos — **não muda**.
É o que mantém um dono só para o layout.

**A extensão do arquivo acompanha.** `fExportarExcelNovoPrg` monta o nome com `.xls`; no ramo Linux tem de
ser `.xlsx`, senão o fornecedor recebe OOXML com extensão de `.xls` e alguns leitores reclamam. Conferir
também o `ChangeFileExt` que a Tarefa 6 usa ao devolver o caminho, e o `Content-Disposition` da Tarefa 11.

- [ ] **Passo 6: Comparar as duas saídas lado a lado**

Exportar o mesmo fornecedor da mesma cotação pelos dois caminhos e conferir, nesta ordem: mesmas colunas,
mesma ordem, mesmos valores, mesmo cabeçalho, **mesmas células travadas**, mesma faixa de validação, mesma
senha. Largura de coluna vai divergir e isso é aceito (RN15).

Duas ferramentas que o spike deixou prontas e que valem mais que inspeção visual:

```
soffice --headless --convert-to xlsx --outdir <saida> <arquivo>
```

e depois descompactar o resultado e conferir `xl/worksheets/sheet1.xml`. Se `sheetProtection` e
`dataValidation` sobrevivem ao round-trip, o leitor entendeu de verdade — abrir na tela mostra que o arquivo
não quebrou, mas não prova que a proteção foi importada.

- [ ] **Passo 7: Provar que a planilha volta**

Pegar o arquivo gerado pelo caminho Linux e passá-lo pela importação do autcom
(`untImportCotacaoItens.pas`). É o que a RN17 exige, e é barato de fazer agora — descobrir depois que o
formato não volta custaria o requisito inteiro.

O filtro da tela já aceita `*.xlsx` (RN17), e quem lê é o COM do Excel ou do BrOffice via
`untTValidaExcel.pas`, que salva como CSV e lê o CSV. Ambos abrem `.xlsx` nativamente. O risco real não é o
formato: é **a planilha protegida com senha** — conferir que o `SaveAs` para CSV do caminho de importação
não esbarra na proteção. Se esbarrar, é achado de escopo e vai para a spec, não remendo aqui.

---

## Fase 2 — Contrato e orquestrador

### Tarefa 4: DTOs da exportação

**Arquivos:**
- Modificar: `Services/Core/suprimento/services/types/Suprimento.Services.Cotacao.Types.pas`

**Interfaces:**
- Consome: nada.
- Produz: `TCotacaoExportacaoGerarParams`, `TCotacaoExportacaoOpcoes`, `TCotacaoExportacaoGerarAceito`,
  `TCotacaoExportacaoAndamento`, `TCotacaoExportacaoFornecedor`, `TCotacaoExportacaoGerarResult`,
  `ECotacaoExportacaoEmAndamento`, `ECotacaoExportacaoTetoAtingido`. Consumidos pelas Tarefas 6 a 11.

As opções espelham `frmCadCotEmail`, e a fonte de verdade dos nomes é a chamada de
`pExportarExcelNovo` em `untCotacao.pas:13186-13194` — dez booleanos mais `chkSepDes` e o modo sem preço.

- [x] **Passo 1: Declarar as opções**

```pascal
  { Espelha frmCadCotEmail, nao a tela do REPOR+. A ordem e os nomes seguem a chamada de
    pExportarExcelNovo em untCotacao.pas:13186 - trocar um por outro compila e produz planilha
    diferente em silencio, porque lah os parametros sao posicionais. }
  TCotacaoExportacaoOpcoes = class
  public
    exibirAplicacaoProduto: Boolean;
    exibirMensagemLivre: Boolean;
    todosOsItens: Boolean;
    exibirMarca: Boolean;
    exibirSemelhantes: Boolean;
    exibirCNA: Boolean;
    exibirReferencia: Boolean;
    similaresAgrupados: Boolean;
    exibirCodigosFabrica: Boolean;
    exibirCodigosFabricaFornecedor: Boolean;
    separarReferencia: Boolean;
    exportarSemPreco: Boolean;
    embalagemCompra: Boolean;
  end;
```

- [x] **Passo 2: Declarar os parâmetros do POST**

```pascal
  TCotacaoExportacaoGerarParams = class
  private
    FOpcoes: TCotacaoExportacaoOpcoes;
  public
    sequencialCotacao: String;
    fornecedores: TArray<String>;
    enviarEmail: Boolean;
    destinatarios: TArray<String>;
    constructor Create;
    destructor Destroy; override;
    property opcoes: TCotacaoExportacaoOpcoes read FOpcoes write FOpcoes;
  end;
```

O construtor aloca `FOpcoes` e o destrutor libera. É o mesmo desenho de `TCotacaoGiroGerarParams` — e
tem a mesma consequência já registrada na spec: `BodyAs<T>` nunca devolve `opcoes = nil`, então guarda
contra `nil` ali é código inalcançável.

- [x] **Passo 3: Declarar aceite, andamento e detalhe por fornecedor**

```pascal
  TCotacaoExportacaoGerarAceito = class
  public
    idProcessamento: String;
  end;

  { Um item por fornecedor pedido. 'arquivoGerado' e 'emailEnviado' sao independentes: planilha pode
    ficar pronta e o e-mail falhar, e o inverso nao acontece. 'mensagem' carrega o motivo da falha
    daquele fornecedor - a mensagem geral da tarefa fica no andamento. }
  TCotacaoExportacaoFornecedor = class
  public
    codigoFornecedor: String;
    nomeFornecedor: String;
    arquivoGerado: Boolean;
    quantidadeItens: Integer;
    emailEnviado: Boolean;
    destinatario: String;
    mensagem: String;
  end;

  TCotacaoExportacaoAndamento = class
  private
    FFornecedores: TObjectList<TCotacaoExportacaoFornecedor>;
  public
    idProcessamento: String;
    status: String;
    etapa: String;
    posicao: Integer;
    total: Integer;
    dataInicio: TDateTime;
    dataFim: TDateTime;
    mensagem: String;
    constructor Create;
    destructor Destroy; override;
    property fornecedores: TObjectList<TCotacaoExportacaoFornecedor> read FFornecedores;
  end;

  TCotacaoExportacaoGerarResult = class
  private
    FFornecedores: TObjectList<TCotacaoExportacaoFornecedor>;
  public
    arquivos: Integer;
    enviados: Integer;
    constructor Create;
    destructor Destroy; override;
    property fornecedores: TObjectList<TCotacaoExportacaoFornecedor> read FFornecedores;
  end;
```

- [x] **Passo 4: Declarar as duas exceções**

```pascal
  ECotacaoExportacaoEmAndamento = class(Exception);
  ECotacaoExportacaoTetoAtingido = class(Exception);
```

Classes próprias, e não reuso das do giro: o controller mapeia cada uma para o seu HTTP, e reusar faria
uma exportação em andamento responder mensagem de giro.

- [x] **Passo 5: Pedir a compilação Linux**

#### Executado em 01/09/2026 — dois desvios

**1. O estilo dos trechos acima não é o da unit.** Eles mostram campos públicos; a
`Suprimento.Services.Cotacao.Types` real usa campo privado com prefixo `F` mais propriedade
`published` com `[MVCSwagJsonSchemaField(...)]`. Segui a unit, não o plano — o atributo é o que
alimenta o Swagger, e sem ele os DTOs novos sairiam da documentação.

**2. `separarReferencia` não entrou.** O plano o listava entre as opções, mas `chkSepDes` só fica
visível quando o formato escolhido é PDF (`untCadCotEmail.pas:122` o amarra a
`rdgGerArq.ItemIndex = 1`), e a exportação deste requisito é a de planilha, `ItemIndex = 0`. Ficaram
doze opções: os dez booleanos posicionais de `pExportarExcelNovo` mais `exportarSemPreco` e
`embalagemCompra`, que viajam por campo do objeto e são atribuídos em `fPedeDadosExportacao`
(`untCotacao.pas:13467-13472`).

**Também entrou `TCotacaoExportacaoProgresso`**, que o plano não listava: o andamento do giro expõe
progresso como objeto aninhado, e manter as duas rotas com formas diferentes de resposta seria
gratuito. Classe dedicada em vez de reusar a do giro porque a unidade contada é fornecedor, não
item, e a descrição vai para o Swagger de rotas diferentes.

Esperado: compila. DTO sozinho não tem como ser exercitado ainda.

---

### Tarefa 5: Diretório do processamento e expurgo

**Arquivos:**
- Criar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Arquivos.pas`

**Interfaces:**
- Consome: nada.
- Produz:
  - `TCotacaoExportacaoArquivos.fDiretorioDoProcessamento(const AIdProcessamento: String): String`
  - `TCotacaoExportacaoArquivos.fCaminhoDoArquivo(const AIdProcessamento, ACodFornecedor, ANumCotacao, ACodEmpresa: String): String`
  - `TCotacaoExportacaoArquivos.pExpurgarExpirados`
  - `TCotacaoExportacaoArquivos.fRetencaoHoras: Integer`

  Consumidos pelas Tarefas 6, 10 e 11.

- [x] **Passo 1: Escrever a unit**

```pascal
unit Suprimento.Services.Cotacao.Arquivos;

{ Onde as planilhas geradas moram entre gerar e baixar, e por quanto tempo.
  Unit separada do orquestrador porque muda por outro motivo: o orquestrador muda quando a regra da
  exportacao muda, esta muda quando a politica de armazenamento muda. }

interface

uses
  {$I '..\..\..\core\services.core.uses.inc'},
  System.SysUtils,
  System.IOUtils,
  System.Classes,
  System.DateUtils;

type
  TCotacaoExportacaoArquivos = class sealed
  public
    class function fRetencaoHoras: Integer;
    class function fDiretorioBase: String;
    class function fDiretorioDoProcessamento(const AIdProcessamento: String): String;
    class function fCaminhoDoArquivo(const AIdProcessamento, ACodFornecedor,
                                     ANumCotacao, ACodEmpresa: String): String;
    class procedure pExpurgarExpirados;
  end;

implementation

const
  { 48 horas, confirmado com o usuario em 31/08/2026. Constante e nao configuracao em banco: nao ha
    consumidor para tornar isso parametrizavel, e CFGSIS nova exigiria tela de manutencao. }
  RETENCAO_HORAS = 48;

class function TCotacaoExportacaoArquivos.fRetencaoHoras: Integer;
begin
  Result := RETENCAO_HORAS;
end;

class function TCotacaoExportacaoArquivos.fDiretorioBase: String;
begin
  Result := IncludeTrailingPathDelimiter(
              IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'cotacoes_exportacao');

  if not TDirectory.Exists(Result) then
    TDirectory.CreateDirectory(Result);
end;

class function TCotacaoExportacaoArquivos.fDiretorioDoProcessamento(
  const AIdProcessamento: String): String;
begin
  { O id vem da SSATSK e e numerico. Validar aqui tambem, e nao confiar na validacao do controller:
    esta funcao compoe caminho de arquivo, e e o ultimo ponto antes do filesystem. }
  if (AIdProcessamento.Trim.IsEmpty) or (StrToInt64Def(AIdProcessamento, -1) < 0) then
    raise Exception.CreateFmt('Identificador de processamento invalido: "%s".', [AIdProcessamento]);

  Result := IncludeTrailingPathDelimiter(fDiretorioBase + AIdProcessamento.Trim);
end;

class function TCotacaoExportacaoArquivos.fCaminhoDoArquivo(
  const AIdProcessamento, ACodFornecedor, ANumCotacao, ACodEmpresa: String): String;
var
  LstrNome: String;
begin
  { Mesmo padrao de nome do autcom (untCotacao.pas:13175), para que o arquivo que o fornecedor recebe
    pelo REPOR+ seja reconhecivel por quem ja usa a tela. A extensao diverge: aqui e OOXML de verdade,
    nao o .xls binario que o COM produz no Windows. Ver RN18. }
  LstrNome := Format('COT%s_%s_%s.xlsx', [ANumCotacao, ACodEmpresa, ACodFornecedor]);

  { Recusa qualquer nome que nao seja o composto acima. Sem isto, codigo de fornecedor vindo da URL
    poderia conter '..' e o GET de download viraria travessia de diretorio. }
  if LstrNome <> ExtractFileName(LstrNome) then
    raise Exception.CreateFmt('Nome de arquivo invalido: "%s".', [LstrNome]);

  Result := fDiretorioDoProcessamento(AIdProcessamento) + LstrNome;
end;

class procedure TCotacaoExportacaoArquivos.pExpurgarExpirados;
var
  LarrDirs: TArray<String>;
  LstrDir: String;
  LdtaLimite: TDateTime;
begin
  LdtaLimite := IncHour(fNow(), -RETENCAO_HORAS);

  LarrDirs := TDirectory.GetDirectories(fDiretorioBase);

  for LstrDir in LarrDirs do
  begin
    try
      if TDirectory.GetCreationTime(LstrDir) < LdtaLimite then
        TDirectory.Delete(LstrDir, True);
    except
      { Diretorio em uso por um download em curso, ou permissao. Nao derrubar o expurgo dos outros
        por causa de um: a proxima varredura tenta de novo. }
      on E: Exception do
        WriteLog('pExpurgarExpirados: falha ao remover ' + LstrDir + ' - ' + E.Message);
    end;
  end;
end;

end.
```

- [x] **Passo 2: Acrescentar a unit ao `.dpr` e compilar**

```pascal
  Suprimento.Services.Cotacao.Arquivos in '..\..\..\Core\suprimento\services\Suprimento.Services.Cotacao.Arquivos.pas',
```

Conferir o caminho relativo contra as linhas vizinhas do `.dpr` — as outras units de
`Core\suprimento\services` já estão lá e mostram a profundidade correta.

Pedir a compilação Linux. Esperado: compila.

- [x] **Passo 3: Conferir o `fNow()` e o `WriteLog`**

```bash
grep -n "fNow()\|Now\b\|WriteLog" padra_atualizado/Services/Core/suprimento/services/Suprimento.Services.Cotacao.Arquivos.pas
```

Esperado: `fNow()` presente, `Now` ausente. Se `fNow` ou `WriteLog` não resolverem na compilação, eles vêm
do `services.core.uses.inc` — conferir contra `Suprimento.Services.Cotacao.Notificacao.pas`, que usa os dois.

#### Executado em 01/09/2026 — o expurgo próprio não foi escrito

O serviço **já tem** varredura por idade: `api.core.cleaner.pas`, acionada pelo `RunIfDue` no laço
principal do `.dpr` (`SuprimentoServicesAPI.dpr:929`), com throttle, execução em background e
tratamento de encerramento já resolvidos. A unit apenas **registra seu diretório** ali, na
`initialization` — 2.880 minutos, recursivo, removendo pasta vazia, a mesma combinação do alvo de
`PedidoCompra`. O `pExpurgarExpirados` do trecho acima teria duplicado tudo isso.

Ordem de inicialização é segura: `api.core.cleaner` está no `uses` da unit, então a `initialization`
dele — que cria a lista de alvos — roda antes.

**Armadilha evitada de propósito:** os alvos default do cleaner usam `GetCurrentDir`, e o PDF do
pedido de compra usa `ExtractFilePath(ParamStr(0))`. Coincidem só porque o serviço é iniciado por
script que faz `cd` na pasta da aplicação. Gravação e varredura aqui chamam a **mesma** função
`fDiretorioBase`, então não há como apontarem para lugares diferentes.

**Premissa para a Tarefa 11:** o cleaner apaga por idade de *arquivo*, não de diretório. Como a
planilha é escrita uma vez e nunca reescrita, equivale à idade do processamento — mas se algum dia
alguém regravar o arquivo, a retenção reinicia.

Sem `fNow()` e sem `WriteLog` na unit: os dois só existiriam para o laço de expurgo, que não existe.

---

### Tarefa 6: Orquestrador — geração das planilhas

**Arquivos:**
- Criar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Exportacao.pas`

**Interfaces:**
- Consome: `TCotacaoExportacaoGerarParams`, `TCotacaoExportacaoGerarResult`,
  `TCotacaoExportacaoFornecedor` (Tarefa 4); `TCotacaoExportacaoArquivos` (Tarefa 5);
  `TCotacao.fExportarExcelNovoPrg` (Tarefa 3).
- Produz:
  `TCotacaoExportacaoGerador.fGerar(AParams: TCotacaoExportacaoGerarParams; const AIdProcessamento: String; AProgresso: TProc<String, Integer, Integer>): TCotacaoExportacaoGerarResult`
  — consumido pela Tarefa 8.

Substitui `pExportarArquivos` e `fPedeDadosExportacao`, que são laço de tela. O laço aqui é sobre
`AParams.fornecedores`.

- [x] **Passo 1: Escrever as precondições da `TCotacao`, e contar linha na tabela**

Três precondições, e duas delas falham caladas — está registrado no Req. 454895:

```pascal
  { Ordem obrigatoria. FCotacao.Edit antes de qualquer FieldByName, senao a leitura devolve vazio
    sem erro. strSeqGerBKP VAZIO: a tela exporta do rascunho _RES, a API le as tabelas oficiais -
    ver RN12 da spec. Copiar o preenchimento que o orquestrador do giro faz troca a fonte de dados
    sem erro de compilacao e sem mensagem. }
  FCotacao.strSeqGerBKP := '';
  FCotacao.strSeqGer := AParams.sequencialCotacao;

  if not FCotacao.fCarregaCotacao then
    raise Exception.CreateFmt('Nao foi possivel carregar a cotacao %s.',
                              [AParams.sequencialCotacao]);

  { Flag False no segundo parametro: com True o SQL troca COTGER/COTITE/COTFOR pelas versoes _RES
    (untCotacao.pas:4602). }
  if not FCotacao.fAbreCdsPrecosItemFornecedor(AParams.sequencialCotacao, False) then
    raise Exception.Create('Nao foi possivel abrir os precos por item e fornecedor.');

  FCotacao.pSetaEventosItem(True);
```

**Verificação:** não confiar no `RecordCount` do dataset para provar que carregou. Contar linha na
tabela, pelo MCP MySQL só-leitura:

```sql
SELECT COUNT(1) FROM COTITE WHERE COT_SEQGER = <sequencialCotacao>;
```

e comparar com o que o dataset traz.

- [x] **Passo 2: Escrever o laço de fornecedores, com falha isolada por fornecedor**

```pascal
  for LintIdx := Low(AParams.fornecedores) to High(AParams.fornecedores) do
  begin
    LFornecedor := TCotacaoExportacaoFornecedor.Create;
    LFornecedor.codigoFornecedor := AParams.fornecedores[LintIdx];

    if Assigned(AProgresso) then
      AProgresso('Gerando planilha do fornecedor ' + LFornecedor.codigoFornecedor,
                 LintIdx + 1, Length(AParams.fornecedores));

    try
      { Falha de UM fornecedor nao derruba os outros - RN03 da spec. A tarefa so termina em erro se
        a exportacao inteira falhar, e por isso o try fica DENTRO do laco. }
      pGerarPlanilhaDoFornecedor(AParams, AIdProcessamento, LFornecedor);
      LFornecedor.arquivoGerado := True;
      Inc(Result.arquivos);
    except
      on E: Exception do
      begin
        LFornecedor.arquivoGerado := False;
        LFornecedor.mensagem := E.Message;
        WriteLog(Format('Exportacao %s: falha no fornecedor %s - %s',
                        [AIdProcessamento, LFornecedor.codigoFornecedor, E.Message]));
      end;
    end;

    Result.fornecedores.Add(LFornecedor);
  end;
```

- [x] **Passo 3: Escrever `pGerarPlanilhaDoFornecedor`, alimentando o record do legado**

```pascal
  { Filtro por fornecedor antes de gerar - e o que faz a planilha levar so os precos dele
    (untCotacao.pas:13166). Sem isto todos os arquivos sairiam iguais. }
  FCotacao.cdsPrecosItemfornecedor.Filter :=
    'COT_CODFOR = ' + QuotedStr(AFornecedor.codigoFornecedor);
  FCotacao.cdsPrecosItemfornecedor.Filtered := True;

  FCotacao.FCodForExportacao := AFornecedor.codigoFornecedor;
  FCotacao.FExportarSemPreco := AParams.opcoes.exportarSemPreco;

  FCotacao.recExportaPreco.strNomArq :=
    TCotacaoExportacaoArquivos.fCaminhoDoArquivo(AIdProcessamento,
                                                 AFornecedor.codigoFornecedor,
                                                 FCotacao.FieldByName('COT_NUMCOT').AsString,
                                                 FCotacao.FieldByName('COT_CODEMP').AsString);
  FCotacao.recExportaPreco.strCodFor      := AFornecedor.codigoFornecedor;
  FCotacao.recExportaPreco.blnAplicacao   := AParams.opcoes.exibirAplicacaoProduto;
  FCotacao.recExportaPreco.blnMsgLivre    := AParams.opcoes.exibirMensagemLivre;
  FCotacao.recExportaPreco.blnTodosItens  := AParams.opcoes.todosOsItens;
  FCotacao.recExportaPreco.blnMarca       := AParams.opcoes.exibirMarca;
  FCotacao.recExportaPreco.blnSemelhantes := AParams.opcoes.exibirSemelhantes;
  FCotacao.recExportaPreco.blnCNA         := AParams.opcoes.exibirCNA;
  FCotacao.recExportaPreco.blnReferencia  := AParams.opcoes.exibirReferencia;
  FCotacao.recExportaPreco.blnSimilaresAgrupados          := AParams.opcoes.similaresAgrupados;
  FCotacao.recExportaPreco.blnCodigosFabrica              := AParams.opcoes.exibirCodigosFabrica;
  FCotacao.recExportaPreco.blnCodigosFabricaFornecedor    := AParams.opcoes.exibirCodigosFabricaFornecedor;

  if not FCotacao.fExportarExcelNovoPrg(nil) then
    raise Exception.Create('O gerador nao produziu a planilha.');

  if not TFile.Exists(FCotacao.recExportaPreco.strNomArq) then
    raise Exception.CreateFmt('A planilha nao foi encontrada em "%s" apos a geracao.',
                              [FCotacao.recExportaPreco.strNomArq]);
```

**Conferir campo por campo** contra `untCotacao.pas:13186-13194` antes de dar por pronto. Os parâmetros
lá são posicionais: trocar dois booleanos compila e gera planilha errada em silêncio. Este é o mesmo
risco que a spec registra para os 60 parâmetros do motor de giro.

O `nil` no `cxProgresso` é o que a Tarefa 3 tornou possível.

- [ ] **Passo 4: Definir o usuário logado antes de qualquer gravação**

```pascal
  { Depois do BeginThreadConnection, nunca antes: pDefinirUsuario consulta banco. Sem isto, LOGREP e
    TRA_CODOPE ficam com o operador default '999'/OPEAUT. }
  pDefinirUsuario(AstrCodOperador);
```

O operador vem de `SST_CODOPE`, e quem o passa é a Tarefa 8.

- [x] **Passo 5: Pedir a compilação Linux**

Esperado: compila. Se `untCotacao` reclamar de identificador ausente, é unit legada faltando no `.dpr` —
acrescentar.

- [x] **Passo 6: Acrescentar a unit ao `.dpr`**

```pascal
  Suprimento.Services.Cotacao.Exportacao in '..\..\..\Core\suprimento\services\Suprimento.Services.Cotacao.Exportacao.pas',
```

#### Executado em 01/09/2026 — o orquestrador não podia tocar o que o plano mandava

**Os campos são privados.** `recExportaPreco`, `cdsItensFornec`, `FDadosExcel`, `FUnidadeCompra`,
`TipoUnidade`, `FCodForExportacao` e `FExportarSemPreco` estão todos na seção `private` da `TCotacao`
— o trecho do Passo 3 não compila de outra unit. O orquestrador do giro só toca membros públicos, e
segui o mesmo caminho: um método público novo na `TCotacao`,

```pascal
Function fExportarPlanilhaFornecedor(var ArecOpcoes: TRecExportaPreco;
                                     AblnUnidadeCompra, AblnSemPreco: Boolean): Integer;
```

que é o corpo do laço de `fGeraArquivosFornecedores` sem tela e sem e-mail. A sequência entre aqueles
sete campos é conhecimento da unit legada, não de quem chama. Também subiu para público a declaração
de `fAbreCdsPrecosItemFornecedor`, que estava privada enquanto as outras duas precondições da mesma
sequência já eram públicas.

**Três coisas que o esboço não tinha, e que produziriam planilha errada em silêncio:**

| O quê | Sem isso |
|---|---|
| `cdsItensFornec.AfterScroll := pAfterScrollDadosExcel` | o preço de um item só, repetido em todas as linhas |
| `fCarregaItensRelacionados` quando `todosOsItens` é falso | a opção não tem efeito nenhum |
| `TipoUnidade` junto com `FUnidadeCompra` | mostra uma unidade e calcula pela outra |

**Retorno é `Integer`, não `Boolean`** — a quantidade de itens. O DTO tem `quantidadeItens` e o
dataset que sabe disso é privado. Zero sem exceção significa "fornecedor sem item relacionado", que é
caso normal e não erro, como a tela trata.

**`stcTodas` ao abrir a cotação, não `stcAbertas`.** Recusar exportar cotação já baixada seria regra
nova, que o requisito não pede. Se for para restringir, pertence ao controller.

---

### Tarefa 7: Orquestrador — envio de e-mail e registro em `EMACOT`

**Arquivos:**
- Modificar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Exportacao.pas`

**Interfaces:**
- Consome: `TEnvioEmail.EnviarEmail` de `untTEnvioEmail`; o resultado da Tarefa 6.
- Produz: `TCotacaoExportacaoGerarResult.enviados` preenchido e `emailEnviado` por fornecedor.

**A implementação de referência é `untProcessaGatilhosImediatos.pas:793`, não a tela.** O robô de gatilhos
já roda em Linux e passa a combinação certa de argumentos; a tela passa `blnEmailAut = False` e cairia no
modal VCL. Ver RN14 da spec.

> **SUPERSEDIDA EM 14/09/2026 PELA TAREFA 20.** Esta tarefa foi implementada e funciona no papel, mas o
> envio nunca saiu em Linux: uma semana de investigação terminou em AV dentro do `TLSHandshake`, com a
> causa em aberto. A revisão da RN13 e as RN19 a RN24 mudaram a decisão — a exportação **não chama mais**
> `TEnvioEmail.EnviarEmail`; ela grava um gatilho e pede o processamento à libGatIme, que é a dona do
> envio. O código desta tarefa vira código morto e sai na Tarefa 20.
>
> **O que ela deixa de herança, e continua valendo:** a resolução de destinatários do Passo 1 (request tem
> precedência sobre o cadastro do fornecedor) e a gravação em `EMACOT`. As duas são reaproveitadas
> literalmente na Tarefa 20 — o que muda é só o mecanismo de envio no meio.

- [x] **Passo 1: Resolver os destinatários**

```pascal
  { Informados no request tem precedencia; sem eles, os do fornecedor. Nao mesclar os dois: o
    consumidor que informou destinatario esta redirecionando de proposito, e acrescentar o fornecedor
    mandaria a planilha para quem ele excluiu. }
  if Length(AParams.destinatarios) > 0 then
    LarrDestinatarios := AParams.destinatarios
  else
    LarrDestinatarios := fRetEmailDoFornecedor(AFornecedor.codigoFornecedor);

  if Length(LarrDestinatarios) = 0 then
  begin
    AFornecedor.emailEnviado := False;
    AFornecedor.mensagem := 'Fornecedor sem e-mail cadastrado.';
    Exit;
  end;
```

Para `fRetEmailDoFornecedor`, **reusar a regra que já existe** — `fSQLFornecedorEmail` em
`untCotacao.pas:13487`. Ler aquela função e usar o mesmo SQL, com `ParamByName`. Não escrever consulta
nova a `CADFOR`: a regra de qual e-mail vale, quando há mais de um contato, está lá.

- [x] **Passo 2: Enviar, com os dois argumentos decisivos**

```pascal
  { AAbrirEditor = False e blnEmailAut = True, copiados de untProcessaGatilhosImediatos.pas:801 e 806.
    Com AAbrirEditor True cai em EnviarEmailEditor, que tem raise em Linux (untTEnvioEmail.pas:4328).
    Com blnEmailAut False passa por TfrmGravando.fExecutarModal e fMensagem, que sao VCL. }
  AFornecedor.emailEnviado :=
    TEnvioEmail.EnviarEmail(nil,
                            AstrCodOperador,
                            'COTAÇÃO Nº ' + FCotacao.FieldByName('COT_NUMCOT').AsString,
                            LarrDestinatarios,
                            [],
                            [],
                            [fCfgSis('MSGCOT', varString)],
                            [AFornecedor.caminhoArquivo],
                            False,   { AAbrirEditor }
                            False,   { AImportante }
                            '',      { strAutInc }
                            '',      { strIncCon }
                            0,       { intCodEma }
                            True     { blnEmailAut }
                            { ... demais parametros: copiar a lista de untProcessaGatilhosImediatos.pas:807-834 });
```

Assunto e corpo saem de onde a tela os pega — `untCotacao.pas:13341` e `fCfgSis('MSGCOT')` — para que o
fornecedor receba a mesma mensagem, venha do autcom ou do REPOR+.

- [x] **Passo 3: Registrar em `EMACOT`, mantendo a paridade**

Só quando o envio deu certo, como a tela faz em `untCotacao.pas:13381`:

```pascal
  if AFornecedor.emailEnviado then
  begin
    Inc(Result.enviados);
    FCotacao.fGravarEmaCot(LarrDestinatarios,
                           LstrAssunto,
                           AFornecedor.codigoFornecedor);
  end;
```

Se `fGravarEmaCot` tiver `raise` de Linux, portá-la é parte desta tarefa — é gravação em tabela, sem UI.
Conferir antes:

```bash
grep -n "fGravarEmaCot" padra_atualizado/fontes/movimentacaoitens/Cotacao/untCotacao.pas
```

E **não** buscar por `implementação linux` com acento: em arquivo latin1 o grep devolve zero sem
significar ausência. Buscar `possui implementa` ou `{$IFDEF LINUX}`.

- [x] **Passo 4: Pedir a compilação Linux**

Esperado: compila.

- [ ] **Passo 5: Prova de vida do envio, isolada**

Antes de amarrar tudo, provar só o e-mail. Executar o binário no modo `task` com uma cotação de um
fornecedor só, `enviarEmail = true` e `destinatarios` apontando para uma caixa sua.
Esperado: mensagem chega, com o `.xlsx` anexado e abrível.

Se falhar aqui, o plano B da RN13 (enfileirar em `libGatIme`) entra — e nesse caso as Tarefas 7 e 9 mudam
de forma. **Não seguir para a Tarefa 8 antes deste passo fechar.**

#### Executado em 01/09/2026

**`strSeqGerOriginal` era o elo que faltava.** A tela grava em `EMACOT` sob
`If Not strSeqGerOriginal.IsEmpty`, e quem preenche esse campo é a tela que abre a cotação
(`untCadCotacaoCX.pas:98`), não o `fAbreCotacao`. Sem setá-lo, o envio funcionaria e o registro
simplesmente não aconteceria, sem erro nenhum. Agora é setado em `pAbrirCotacao`.

**`fGravarEmaCot` era privado** — subiu para público, como o `fAbreCdsPrecosItemFornecedor` da
Tarefa 6.

**`fCampoTabela` escalar não serve:** mora em `untFuncoesSimples`, Windows-only. O e-mail do cadastro
sai de consulta parametrizada explícita a `FOR_EMAPED`/`CADFOR` — mesma origem da
`fSQLFornecedorEmail`, que monta `IN` por concatenação porque atende vários fornecedores de uma vez.

**Envio em `try` separado da geração**, e não no mesmo `except`: e-mail que falha não desfaz a
planilha, que continua disponível para download. Unir os dois marcaria `arquivoGerado := False` numa
planilha que existe.

**Sobre o Passo 5 (prova de vida), que este plano manda fazer antes da Tarefa 8:** não dá — o modo
`task` só existe depois que o método está registrado no worker, que é justamente a Tarefa 8. A prova
foi movida para depois dela, antes das rotas HTTP das Tarefas 10 e 11. O gate continua valendo, só
mudou de lugar.

---

### Tarefa 8: Registro no worker e notificação

**Arquivos:**
- Modificar: `Services/Core/suprimento/services/Suprimento.Services.Workers.pas`
- Modificar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Notificacao.pas`

**Interfaces:**
- Consome: `TCotacaoExportacaoGerador.fGerar` (Tarefas 6 e 7).
- Produz: chave de tarefa `'TCotacaoExportacaoService.fGerar'` e
  `TCotacaoExportacaoNotificacao.pNotificarConclusao(...)`. Consumidos pela Tarefa 9.

- [x] **Passo 1: Declarar e implementar o worker, espelhando `TCotacaoGiroServiceWorker`**

```pascal
type
  TCotacaoExportacaoServiceWorker = class sealed
  public
    class function fGerar(const AParams: string): string;
  end;
```

O corpo segue `Suprimento.Services.Workers.pas:70-123`: `JsonAs` nos params, adquirir lock, chamar o
gerador com o callback de progresso, `ToJson` no resultado, liberar lock no `finally`.

- [x] **Passo 2: Registrar em `LoadMethods`**

```pascal
  AddMethod('TCotacaoExportacaoService.fGerar', TCotacaoExportacaoServiceWorker.fGerar);
```

A chave é `SST_SERVIC + '.' + SST_METHOD` e tem de casar **exatamente** com as constantes do controller na
Tarefa 9. Divergência produz tarefa enfileirada que o `ProcessTask` recusa com "Nao foi possivel
identificar um metodo" — falha tardia e obscura. O comentário em `api.controller.cotacao.pas:77` diz isso.

- [x] **Passo 3: Estender `pNotifyFinish` para a chave nova**

Hoje ele sai cedo quando a chave não é a do giro (`Suprimento.Services.Workers.pas:190`). Passa a tratar as
duas, sem duplicar o `inherited`:

```pascal
  LstrChave := AQuery.FieldByName('SST_SERVIC').AsString + '.' +
               AQuery.FieldByName('SST_METHOD').AsString;

  if LstrChave = METODO_GIRO then
    pNotificarGiro(AQuery)
  else if LstrChave = METODO_EXPORTACAO then
    pNotificarExportacao(AQuery);
```

O `inherited` continua **antes** de tudo: é ele que grava `SST_DTAFIN`, e notificar antes abriria janela em
que o usuário recebe "já pode olhar" e o GET ainda responde processando.

- [x] **Passo 4: Escrever a notificação da exportação**

Em `Suprimento.Services.Cotacao.Notificacao.pas`, espelhando `pNotificarConclusao` do giro:

```pascal
  { MEN_TIPO__ recebe 'COTACAO', o mesmo token do giro - decidido em 31/08/2026. O REPOR+ distingue
    pelo MEN_WORKID, que e o id que ele recebeu no 202 e guardou. Transacao propria, DEPOIS do fim da
    tarefa, e falha aqui nao derruba exportacao que concluiu: WriteLog e segue (RN09 da spec). }
```

A mensagem cita a cotação e a contagem, e sai do resultado da tarefa — não de contagem nova, senão o aviso
pode afirmar o que o GET desmente:

```pascal
  LstrMensagem := Format('Exportacao da cotacao %s concluida: %d planilha(s) gerada(s), %d e-mail(s) enviado(s).',
                         [LstrNumCotacao, LResult.arquivos, LResult.enviados]);
```

- [x] **Passo 5: Pedir a compilação Linux**

Esperado: compila.

- [ ] **Passo 6: Provar a linha na `MENREP`, e não só o log**

Disparar uma exportação pelo modo `task` e conferir no banco:

```sql
SELECT MEN_CODOPE, MEN_TIPO__, MEN_WORKID, MEN_NUMDOC, MEN_LIDA__, MEN_DTALEI, MEN_MENSAG
  FROM MENREP WHERE MEN_WORKID = '<idProcessamento>';
```

Esperado: uma linha, `MEN_TIPO__ = 'COTACAO'`, `MEN_LIDA__ = 'N'`, `MEN_DTALEI` nulo, `MEN_CODOPE` igual ao
operador enviado.

#### Executado em 01/09/2026 — Tarefas 8 e 9 saíram juntas

A 8 precisa do lock que a 9 define; escrever o worker sem ele seria código que não compila.

**Um defeito no giro, corrigido antes de existir.** A varredura de órfãs do giro monta o nome do
lock a partir de `SST_PARAMS ->> '$.sequencialRascunho'`. Nos params da exportação esse campo não
existe: o `CONCAT` sai `NULL`, `IS_USED_LOCK(NULL)` é `NULL`, e o critério "sem lock ativo" passa a
valer. A **primeira** exportação enfileirada seria encerrada como órfã no meio da execução, pela
varredura do *giro*, com erro gravado e notificação de giro. Os dois `SELECT` do giro
(`fProcessosAtivos` e `pEncerrarOrfas`) agora discriminam por `SST_SERVIC` e `SST_METHOD`.

**O worker não sabia o próprio id.** A assinatura é `string → string` — o giro nunca precisou, e o
comentário dele registra isso. A exportação precisa, para nomear o diretório. Entrou
`pDefinirTarefa` / `fIdTarefa` no `TWorkerTaskProgress`, que já é o porta-valores do escopo da
tarefa, preenchido no mesmo ponto onde o operador é definido.

*Alternativa descartada:* derivar o diretório da cotação em vez do id, sem tocar na infra. Duas
exportações sequenciais da mesma cotação compartilhariam a pasta, e o download do primeiro
`idProcessamento` serviria os arquivos do segundo.

**O `INSERT` da MENREP foi extraído** para `TMenRep`. As duas notificações gravam a mesma linha —
muda o texto e o `MEN_NUMDOC`. O prefixo difere: `COTRES_` no giro, `COT_` na exportação, que lê as
tabelas oficiais.

**Teto próprio** (`EXPMAX`, default 3): a exportação escreve arquivo e fala SMTP, o giro só calcula.

**`pDefinirUsuario` não precisa ser chamado pelo orquestrador** — o `ProcessTask` já o faz a partir
de `SST_CODOPE`. O Passo 4 da Tarefa 6 está coberto pela infraestrutura.


---

### Tarefa 9: Concorrência por cotação

**Arquivos:**
- Modificar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Concorrencia.pas`

**Interfaces:**
- Consome: nada novo.
- Produz: `TCotacaoExportacaoConcorrencia` com `pEncerrarOrfas`, `fEmAndamento(const ASequencialCotacao: String): Boolean`,
  `fTetoAtingido: Boolean`, `fTeto: Integer`, `pAdquirirLock`, `pLiberarLock`. Consumidos pelas Tarefas 8 e 10.

- [ ] **Passo 1: Ler a unit existente inteira antes de mexer**

```bash
sed -n '1,120p' padra_atualizado/Services/Core/suprimento/services/Suprimento.Services.Cotacao.Concorrencia.pas
```

Decidir, com o código na frente, entre generalizar a classe existente por parâmetro de chave ou
acrescentar uma classe irmã. Preferir generalizar **se** a diferença for só o nome do lock e a chave da
tarefa; acrescentar irmã se houver regra de negócio diferente.

- [ ] **Passo 2: Implementar, com o lock nomeado por cotação**

O nome do lock tem de ser distinto do do giro, senão uma exportação bloquearia um giro do mesmo
sequencial — e são operações independentes: uma lê o oficial, a outra grava no rascunho.

- [ ] **Passo 3: Contar o teto junto com as tarefas de giro**

O teto é de processos simultâneos da API, não por tipo de tarefa. Contar as duas chaves na mesma consulta —
senão N giros mais N exportações passam do dobro do teto e derrubam a máquina por memória, que é
exatamente o que o comentário em `api.controller.cotacao.pas:147` explica.

- [ ] **Passo 4: Pedir a compilação Linux**

Esperado: compila.

---

## Fase 3 — Rotas

### Tarefa 10: `POST /cotacao/exportacao/gerar`

**Arquivos:**
- Modificar: `Services/Suprimento.Services.API/Source/api/controller/api.controller.cotacao.pas`

**Interfaces:**
- Consome: DTOs (Tarefa 4), `TCotacaoExportacaoConcorrencia` (Tarefa 9), chave do worker (Tarefa 8),
  `TCotacaoExportacaoArquivos.pExpurgarExpirados` (Tarefa 5).
- Produz: rota respondendo 202 com `idProcessamento`.

- [x] **Passo 1: Declarar as constantes de chave**

```pascal
  SERVICO_EXPORTACAO = 'TCotacaoExportacaoService';
  METODO_EXPORTACAO  = 'fGerar';
```

Conferir contra o `AddMethod` da Tarefa 8 — caractere por caractere.

- [x] **Passo 2: Declarar a action com os atributos de Swagger**

Seguir o desenho de `GerarPorGiro` (`api.controller.cotacao.pas:42-53`), com os dois headers
(`Empresa`, `OperadorLogado`) e os quatro códigos de resposta: 202, 400, 409, 429.

No `MVCSwagSummary`, **declarar o formato do arquivo** — critério 21 da spec: a planilha é XLSX (OOXML),
MIME `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`. Enriquecer a documentação só com
fato verificado; não inventar exemplo, default nem validação não confirmada.

- [x] **Passo 3: Escrever o corpo, na mesma ordem do `GerarPorGiro`**

Ordem deliberada, e cada passo tem motivo já documentado no giro:

1. `fOperadorValidado` — reusar o método privado que já existe. Header ausente é o erro mais barato de
   detectar, e não há por que desserializar o body para descobrir.
2. `BodyAs<TCotacaoExportacaoGerarParams>`.
3. Validar `sequencialCotacao` não vazio.
4. **Validar `fornecedores` não vazio** — RF03 da spec: a API não assume "todos". Mensagem citando que a
   lista é obrigatória.
5. Validar que a cotação existe na empresa; 400 com mensagem específica se não.
6. `TCotacaoExportacaoArquivos.pExpurgarExpirados` — aproveitar o POST para a varredura, como o giro
   aproveita para `pEncerrarOrfas`. Roda sobre poucos diretórios.
7. `TCotacaoExportacaoConcorrencia.pEncerrarOrfas`.
8. `fEmAndamento` → 409.
9. `fTetoAtingido` → 429.
10. `fEnqueueAsyncTask` com o **body original**, não um JSON remontado.
11. `SpawnTask`.
12. `ResponseStatus(HTTP_STATUS.Accepted)` + `Render(LAceito, False)`.

O `Render(objeto, False)` e não `Render(status, objeto)`: a sobrecarga com status libera o objeto ela
mesma e daria dupla liberação com o `Free` do `finally` — está comentado em
`api.controller.cotacao.pas:170`.

- [x] **Passo 4: Mapear as exceções no `except`**

`EInvalidParams` → 400; `ECotacaoExportacaoEmAndamento` → 409; `ECotacaoExportacaoTetoAtingido` → 429;
`Exception` → `raise`.

- [ ] **Passo 5: Pedir a compilação Linux e exercitar a rota**

Esperado: 202 com `idProcessamento`, em milissegundos. Conferir a linha:

```sql
SELECT AUTOINCREM, SST_SERVIC, SST_METHOD, SST_CODEMP, SST_CODOPE, SST_DTAINI, SST_DTAFIN
  FROM SSATSK WHERE AUTOINCREM = <id>;
```

Esperado: `SST_SERVIC`/`SST_METHOD` iguais às constantes, `SST_CODOPE` igual ao header, `SST_DTAINI`
preenchida.

- [ ] **Passo 6: Provar os três erros**

Sem header `OperadorLogado` → 400. Operador inexistente → 400. Lista de fornecedores vazia → 400. Segundo
POST com o primeiro em andamento → 409.

---

### Tarefa 11: `GET` de andamento e `GET` de download

**Arquivos:**
- Modificar: `Services/Suprimento.Services.API/Source/api/controller/api.controller.cotacao.pas`
- Modificar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Consulta.pas`

**Interfaces:**
- Consome: `TCotacaoExportacaoAndamento` (Tarefa 4), `TCotacaoExportacaoArquivos.fCaminhoDoArquivo` (Tarefa 5).
- Produz: as duas rotas de leitura.

- [x] **Passo 1: Escrever o serviço de andamento**

Espelhar `TCotacaoGiroAndamentoService.fConsultar`. O status é **derivado** de `SST_DTAINI`, `SST_DTAFIN`,
`SST_SUCESS` e `SST_TYPERR` — e a condição de erro **precisa** considerar `SST_TYPERR`: quando o disparo
falha, o tratamento existente grava `SST_RESULT` e `SST_TYPERR` sem gravar `SST_SUCESS`, e um status
derivado só de `SST_SUCESS` deixaria esse caso eternamente como processando (RN05 da spec).

O detalhe por fornecedor vem de `SST_RESULT` quando a tarefa terminou, e de `SST_STATUS` durante a
execução. Devolver `nil` quando não existir para a empresa.

- [x] **Passo 2: Declarar e escrever a action de andamento**

Espelhar `ConsultarAndamentoGiro` (`api.controller.cotacao.pas:201`). `nil` → 404 com mensagem citando o
identificador. 404 e não 403 também para id de outra empresa: responder 403 confirmaria que o id existe.

- [x] **Passo 3: Escrever a action de download, com o padrão do PDF**

O padrão está resolvido em `api.controller.pedidocompra.pas:144-155` e a ordem das três linhas importa:

```pascal
  Self.Context.Response.SetCustomHeader('Content-Disposition',
    Format('attachment; filename=%s', [ExtractFileName(LstrCaminho)]));

  { ContentType ANTES do SendFile e sem charset. O BuildContentType do DMVCFramework anexa
    ";charset=utf-8" a qualquer application/*; o SendFile propaga o ContentType corrente e o setter
    grava direto, sem reaplicar o BuildContentType - e por isso o valor limpo sobrevive. }
  Self.Context.Response.ContentType :=
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';

  Self.SendFile(LstrCaminho);
```

**Diferença deliberada em relação ao PDF:** ali o arquivo é apagado depois de servido; aqui **não** —
ele vive 48 horas e pode ser baixado mais de uma vez. Não copiar o `finally` de limpeza.

- [x] **Passo 4: Fechar a travessia de diretório**

O `codFornecedor` vem da URL. Antes de compor caminho, validar que ele está na lista de fornecedores
**daquele** processamento, lida de `SST_PARAMS`. Não basta validar o formato: `fCaminhoDoArquivo` já
recusa nome composto inválido, mas a checagem contra a lista é o que impede ler o arquivo de outro
processamento.

- [x] **Passo 5: Arquivo ausente responde 404 com mensagem clara**

Expirado, fornecedor que falhou na geração, ou id inexistente — os três dão 404, e a mensagem diz qual é o
caso. Critério 20 da spec: não erro genérico.

- [ ] **Passo 6: Pedir a compilação Linux e exercitar**

Esperado: o `.xlsx` baixa, abre no Excel e no LibreOffice, e **os acentos estão corretos**.

O encoding do arquivo deixou de ser risco com a rota C — partes de OOXML são UTF-8 por definição do
formato (RN18). O que resta como risco é a **resposta HTTP**: o `;charset=utf-8` do `BuildContentType`
grudado num MIME binário. É o mesmo defeito já registrado para PDF na memória do projeto, e o Passo 3
acima é o que o previne. Conferir com:

```bash
file <arquivo>.xlsx          # esperado: Microsoft Excel 2007+ / Zip archive
unzip -l <arquivo>.xlsx      # esperado: as 6 partes, [Content_Types].xml inclusa
curl -sD - -o /dev/null <url-do-download> | grep -i content-type
```

A terceira linha é a que importa: se o `Content-Type` vier com `;charset=utf-8`, o Passo 3 não pegou.

- [ ] **Passo 7: Conferir o critério 04 — equivalência com a tela**

Exportar o **mesmo** fornecedor da **mesma** cotação pelos dois caminhos: pela tela do autcom e pela API.
Comparar os dois arquivos. Divergência de conteúdo aponta para os campos do Passo 3 da Tarefa 6 — os
posicionais trocados.

#### Executado em 01/09/2026 — Fase 3

**A cotação oficial não tem `COT_EXCLUI`** — conferido no dicionário de dados: a coluna só existe na
`COTGER_RES`. Logo não há como distinguir "não existe" de "foi descartada", e a validação é
existência pura (`TCotacaoOficialService.fExiste`). O enum de três estados que o giro usa não tem
equivalente aqui e teria mentido.

**O item 6 do Passo 3 não foi feito, e não é esquecimento:** `pExpurgarExpirados` deixou de existir
na Tarefa 5 — quem expurga as planilhas é o `TApiCleaner`, no laço principal do `.dpr`. O que
sobrou para o POST é a varredura de **tarefas** órfãs, que não tem equivalente pronto.

**`SST_SERVIC`/`SST_METHOD` também no WHERE das leituras.** O `AUTOINCREM` da `SSATSK` é global:
sem esse filtro, `GET /cotacao/exportacao/{id}` de uma tarefa de *giro* devolveria 200 com lista de
fornecedores vazia em vez de 404. É o mesmo vazamento entre tipos que a Tarefa 9 corrigiu na
varredura, agora do lado da leitura.

**A guarda de travessia é a lista de fornecedores do processamento**, lida de `SST_PARAMS` — não o
formato do nome. `fCaminhoDoArquivo` recusa nome mal formado, mas nome **bem** formado de outro
processamento passaria por ele. As três causas de recusa dão o mesmo 404 com a mesma mensagem, para
não revelar qual é o caso.

**Literal de string em Delphi tem teto de 255 caracteres** (`E2056`) — o resumo de Swagger da rota
de exportação estourou na primeira escrita. Vale para qualquer `MVCSwagSummary` longo.


---

## Fase 4 — Entrega

### Tarefa 12: Contrato e lista de casos para o analista

**Arquivos:**
- Criar: `IA/specs/455094/casos-a-cobrir.md`

Isto **é** entregável de quem implementa, não subproduto. Os casos em si são escritos por analista humano —
ver `CLAUDE.md`. O que sai daqui é o contrato e a lista.

- [x] **Passo 1: Documentar o contrato das três rotas**

Para cada rota: método, caminho, headers, corpo com todos os campos e tipos, e cada código de resposta com
o que o dispara.

- [x] **Passo 2: Transcrever os 21 critérios de aceitação como lista de casos**

Um item por critério da seção 6 da spec, dizendo o que preparar, o que executar e o que conferir. Marcar
quais precisam de roteiro manual em vez de caso automatizado — os de reinício de serviço, processo morto à
força e teto de simultâneos.

- [x] **Passo 3: Registrar o que a suíte automatizada consegue afirmar**

A suíte do projeto afirma resposta **e** estado de banco. Indicar, para os casos de 202, quais tabelas
precisam de assert — `SSATSK`, `MENREP`, `EMACOT` — e que o assert deve usar `pTesteMontarJsonTabela`, um
bloco por tabela, em vez de JSON montado à mão: o helper lista as colunas pelo `information_schema`, então
coluna nova entra no dump sozinha.

#### Executado em 01/09/2026 — e a divisão de papéis mudou por decisão do usuário

O `casos-a-cobrir.md` foi escrito como previsto. Depois disso o usuário decidiu que **nós** também
escreveríamos os casos, e não o analista. O `CLAUDE.md` diz o contrário; a instrução do usuário
prevalece, e fica registrado que foi decisão dele.

**A infraestrutura existe e o `CLAUDE.md` está desatualizado.** Ele afirma que só o Faturamento tem
projeto de teste REST. Existem `SuprimentoServicesTEST.dpr`,
`Services.Suprimento.Tests.groupproj` e suíte versionada em `Scripts/testes/`, com 29 casos, uma
procedure de assert, roteiro manual e um `validar_casos.py`.

**Doze casos escritos, ids 0037–0048**, todos aprovados pelo `validar_casos.py`:

| Códigos | Casos |
|---|---|
| 400 | sequencial vazio · fornecedores vazio · cotação inexistente · cotação de outra empresa · operador inexistente |
| 409 | exportação em andamento (lock tomado pela conexão do teste) |
| 429 | teto atingido (três tarefas fabricadas + locks) |
| 404 | andamento inexistente · andamento de outra empresa · **andamento com id de tarefa de giro** · download com id inexistente · download de fornecedor fora da lista |

Cobrem inteiros os critérios 06, 13, 14 e 18.

**Caso de teste aqui são três artefatos, não um:** o `.sql`, o `.inc` que mapeia nome→id, e o método
Delphi. Faltar qualquer um dos dois últimos deixa o caso na tabela sem ninguém o executar — sem
erro e sem aviso. Entraram quatro `.inc` e quatro métodos em `api.controller.cotacao.test.pas`.

**O que não entrou, e está escrito nos `.inc`:** o 202 e o download de 200. O 202 enfileira
exportação real — abre a cotação, escreve em disco, fala SMTP — e afirmar só "202 recebido" é o
menos interessante; o que dá valor é o assert de banco, e a exportação ainda não tem procedure de
assert como o giro tem. O download de 200 precisa de arquivo real dentro da retenção e de `accept`
binário no método. "Header ausente" também não: a tabela não tem coluna de header e o runner sempre
monta um.

**Âncoras conferidas na base da suíte** (`2_30_BELAT_TC`, 53307, que é para onde o MCP aponta):
cotação `02200000000003542022` da empresa 022 com três fornecedores; cotação `02200000000003257008`
da 008; tarefa de giro 604; `EXPMAX` ausente de `CFGSIS`, logo vale o default 3; `OP1` existe e
`ZZ9` não.


---

### Tarefa 13: Revisão e commit

- [ ] **Passo 1: Varrer as travas do pre-commit, em duas passadas**

Uma passada só engana. Nos arquivos **modificados**, valem apenas as linhas adicionadas do `svn diff` — os
legados têm `TBitBtn` e `StrToFloat` de antes, e não são nossos. Nos arquivos **novos**, vale o arquivo
inteiro, e eles não aparecem no `svn diff` porque ainda são `?`.

```bash
svn diff | grep '^+' | grep -nE 'TBitBtn|TButton|TDataSetProvider|TClientDataSet|TDBGrid|dxSkin|\.SetFocus|StrToFloat\(|StrToFloatDef\(|Application\.CreateForm\(|ActiveControl :=|FOREIGN_KEY_CHECKS'
svn status | grep '^?'
```

- [ ] **Passo 2: Conferir SQL sem concatenação e sem `Now()`**

```bash
svn diff | grep '^+' | grep -nE "SQL.*\+|NOW\(\)|Now\(\)"
```

Esperado: zero. `fNow()` é o permitido e não casa com o padrão acima por causa do `f`.

- [ ] **Passo 3: Conferir o EOL dos `.pas` alterados**

```bash
svn diff --diff-cmd diff -x "--strip-trailing-cr" | wc -l
svn diff | wc -l
```

Números muito distantes indicam EOL convertido — diff de 2000 linhas onde a mudança é de 200. Comparar com
`svn cat` antes de submeter ao DelphAI.

- [ ] **Passo 4: Executar `/review`**

Antecipa o que o DelphAI apontaria. Não substitui o gate.

- [ ] **Passo 5: Rodar o gate do DelphAI e obter o token**

O campo de análise corta em 65.535 caracteres sem avisar. Gerar versão derivada, cortando o que o revisor
já lê no diff.

- [ ] **Passo 6: Commit**

Primeira linha `Req. 455094`, token do DelphAI na mensagem. Incluir os arquivos novos com `svn add` antes.

---

## Auto-revisão do plano

**Cobertura da spec.** RF01 → Tarefas 10 e 11. RF02 → 10. RF03 → 6 e 10 (lista vazia recusada). RF04 → 7.
RF05 → 7 Passo 1. RF06 → 11 Passos 1-2. RF07 → 11 Passo 3. RF08 → 4. RF09 → 1, 2, 3. RF10 → 5 e 10 Passo 3.
RF11 → 9. RF12 → 6 Passo 2 e 8. RF13 → 8. RF14 → 7 Passo 3.
RN01 → 11 Passos 3 e 6. RN02 → 6 Passo 3. RN03 → 6 Passo 2. RN04 → 4 e 6. RN05 → 11 Passo 1. RN06 → 6 Passo 4
e 10. RN07 → herdado do `fCarregaCotacao`, sem tarefa própria. RN08 → 9. RN09 → 8 Passo 4. RN10 → 5.
RN11 → nenhuma tarefa escreve em `COTGER`/`COTITE`/`COTFOR`; conferido na varredura da Tarefa 13.
RN12 → 6 Passo 1. RN13 → 7. RN14 → 7 Passo 2.
Critérios 01-21 → Tarefa 12 Passo 2, com os manuais marcados.

**Lacuna assumida:** os critérios 10 a 15 da spec — timeout, reinício da API, processo morto, teto,
não degradar os endpoints em produção — não têm tarefa de implementação própria porque são propriedades
herdadas da infraestrutura do Req. 454895, não código novo. Eles aparecem como **verificação** na
Tarefa 12. Se algum falhar, aí sim vira tarefa.

**Consistência de nomes.** `fGerar` é o método em todas as menções (Tarefas 6, 8, 10).
`TCotacaoExportacao*` é o prefixo em todos os DTOs e serviços. A chave de tarefa é
`'TCotacaoExportacaoService.fGerar'` nas Tarefas 8 e 10 — e as duas dizem para conferir uma contra a outra,
porque divergência ali falha tarde.

---

## Tarefa 14 — alinhamento ao Req. 459763, entrada nao prevista (04/09/2026)

Nao estava no plano. Apareceu por um conflito de `svn update`: a r493119 alterou sete units,
incluindo tres que este requisito tambem altera.

**O que aquele requisito fez, e por que nos alcanca.** Padronizou o JSON de status dos endpoints
assincronos do servico — quatro status, `etapa` como objeto com o `progresso` dentro, ausencia em
`null` e nunca `""` ou `0`, resultado contavel em `qtdItensGerados`. O objetivo declarado e o
frontend ter **um parser** para os dois endpoints. A nossa rota de andamento nasceria com forma
diferente da rota irma do mesmo servico — exatamente o que aquele requisito veio eliminar.

**Por que alinhar agora.** A rota nao tinha consumidor: nao commitada, nao publicada. Alinhar
custou a edicao; alinhar depois seria mudanca incompativel em contrato vivo. Nao ha momento mais
barato, e essa foi a razao da decisao — nao a proximidade dos arquivos.

**Tres divergencias deliberadas em relacao ao giro**, todas comentadas no codigo:

| Ponto | Giro | Exportacao | Por que |
|---|---|---|---|
| `etapa.numero` / `totalEtapas` | catalogo fechado de 8 etapas | sempre `null` | o trabalho e um laco por fornecedor; o mensuravel e a POSICAO no laco, que e o `progresso`. "Etapa 1 de 1" e ruido |
| `etapa` em `CONCLUIDO` | `pEncerrar` preserva o numero, para fechar a barra em 8 de 8 | vira `null` inteira | sem sequencia publicada sobraria objeto de quatro campos nulos, que o comentario deles mesmos diz ser pior que nulo |
| identificador na `MENREP` | `COT_DESCRI` do rascunho | `COT_NUMCOT` da oficial | rascunho nao tem numero, e a descricao da oficial costuma ser texto gerado que nao identifica nada |

**Dois conflitos de merge, e o segundo era real.** Em `Services.Core.Worker.pas` a r493119 acrescentou
dois parametros ao `fColher` e o nosso bloco declara `pDefinirTarefa`/`fIdTarefa` ao lado — somar
resolveu. Em `Notificacao.pas` eles criaram `fNomeDaCotacao` **dentro da classe que este requisito
havia refatorado**: o `pGravar` tinha saido para `TMenRep` com `AstrNumDoc` generico, para a
exportacao poder passar `COT_<seq>`. A mesclagem manteve as duas intencoes.

**O que NAO precisou mudar:** o controller. O Swagger sai dos atributos do proprio DTO, e a action
so renderiza — a mudanca de forma nao a alcanca.

**O que fica pendente disto:** os casos 44, 45 e 46 afirmam apenas 404, entao seguem validos. Um
caso de 200 no andamento, quando existir, precisa afirmar `etapa` nula em `PENDENTE` e
`qtdItensGerados` em `CONCLUIDO` — e ali zero e valor valido, que e a distincao inteira do 459763.

### Pendencia aberta pelo merge do Req. 460364 (05/09/2026)

O 460364 moveu CINCO validacoes do controller do giro para um **pre-voo dentro do worker**
(`pValidarSolicitacao`): operador em CADOPE, situacao do rascunho, varredura de orfas, 409 e 429.
Eram cinco idas ao banco a partir do processo HTTP; viraram uma ida ao pool, e o que sobrou no
metodo do controller e HTTP mais a entrega a infraestrutura do worker.

**A exportacao ainda faz as cinco no controller** - `fCampoTabela` em CADOPE,
`TCotacaoOficialService.fExiste`, `pEncerrarOrfas`, `fEmAndamento` e `fTetoAtingido`.

**Nao migrei junto, e a razao e de sequenciamento, nao de merito.** No momento do merge dois casos
ja estavam vermelhos por causa da AV na geracao da planilha. Trocar a arquitetura do fluxo ali
tiraria a capacidade de dizer qual mudanca quebrou o que - e as cinco validacoes estao cobertas
pelos casos 37 a 43, que hoje passam.

O que a migracao envolve, quando for feita:

- um `TCotacaoExportacaoServiceWorker.fValidarSolicitacao` espelhando o do giro
- as tres excecoes de recusa (`EInvalidParams`, `ECotacaoExportacaoEmAndamento`,
  `ECotacaoExportacaoTetoAtingido`) na lista branca que faz elas atravessarem a fronteira do worker
- um DTO de params da validacao, como o `TCotacaoGiroValidarParams`
- o controller reduzido a ler o header e entregar

Os casos 37 a 43 continuam valendo depois da migracao: eles afirmam codigo e mensagem, que nao
mudam. O que muda e de onde a recusa sai.


---

# Fase 5 — Delegação do envio à libGatIme (14/09/2026)

> **A Tarefa 13 (revisão e commit) passa a ser a última do plano**, depois da Tarefa 22. Nada desta fase é
> commitado isoladamente.

**Por que esta fase existe.** A cotação era o único lugar do sistema que mandava e-mail sem passar pela
libGatIme. Levar isso para o serviço Linux importou junto uma pilha SMTP inteira que nunca tinha rodado
fora do Windows, e o resultado foi uma semana de investigação sem causa fechada. As RN19 a RN24 da spec
devolvem o envio à dona. Ver também a revisão da RN13.

**Ordem e por quê.** As Tarefas 15 a 17 são preparo e não mudam comportamento nenhum — dá para compilar e
seguir. A 18 abre a porta na libGatIme. A 19 é a única que altera código em produção usado por terceiros, e
por isso vem sozinha. A 20 e a 21 são os dois consumidores. A 22 são os casos.

**Compilação:** Windows e Linux são **pedidas ao usuário**. Nunca disparar `msbuild`.

---

### Tarefa 15: `TResultEnvio` sai da `.so` para `untTypesSistema`

**Arquivos:**
- Modificar: `padra_atualizado/fontes/util/untProcessaGatilhosImediatos.pas:24` (remover a declaração)
- Modificar: `padra_atualizado/fontes/genericos/untTypesSistema.pas` (acrescentar)

**Interfaces:**
- Produz: `TResultEnvio = (tpEnviadoOK, tpEnviadoErro, tpNaoEnviado, tpTentarNovamente, tpDisparoAtrasado24Hrs);` visível ao host e à `.so`.

**Por que mover.** O tipo aparece na assinatura de `fProcessarGatilho` (Tarefa 18), que o host enxerga.
Hoje ele mora dentro de uma unit que só existe dentro da `libGatIme`. `untTypesSistema` é pré-requisito de
todos os projetos, então serve aos dois lados sem criar dependência nova.

- [ ] **Passo 1: Copiar a declaração para `untTypesSistema`**

Na seção `type` da interface, junto dos demais enums:

```pascal
  { Desfecho de um envio de gatilho. Vivia em untProcessaGatilhosImediatos, dentro da libGatIme; veio
    para ca em 14/09/2026 porque passou a aparecer na assinatura publica da IGatIme. }
  TResultEnvio = (tpEnviadoOK, tpEnviadoErro, tpNaoEnviado, tpTentarNovamente, tpDisparoAtrasado24Hrs);
```

- [ ] **Passo 2: Remover a declaração antiga**

Apagar a linha 24 de `untProcessaGatilhosImediatos.pas`. A unit já usa `untTypesSistema`, então nada mais
muda ali.

- [ ] **Passo 3: Conferir que ninguém mais declarava o mesmo nome**

```sh
grep -rn "TResultEnvio *=" --include=*.pas padra_atualizado/
```

Esperado: uma ocorrência só, em `untTypesSistema.pas`. Duas seria conflito de nome silencioso — a unit que
vier por último no `uses` ganha, sem aviso.

- [ ] **Passo 4: Pedir a compilação Windows e Linux ao usuário**

Sem mudança de comportamento esperada. Se algo quebrar aqui, é ordem de `uses`, não lógica.

---

### Tarefa 16: Trava de versão da libGatIme no carregamento

**Arquivos:**
- Modificar: `padra_atualizado/fontes/genericos/GatilhosImediatos.Interfaces.pas` (constante do contrato)
- Modificar: `padra_atualizado/fontes/libGatIme/fontes/GatilhosImediatos.Classes.pas` (função exportada)
- Modificar: `padra_atualizado/Services/libGatIme/Target/Linux/GatIme.dpr` (cláusula `exports`)
- Modificar: `padra_atualizado/fontes/genericos/untDllGatIme.pas` (resolução e checagem)
- Modificar: `padra_atualizado/fontes/libGatIme/libGatIme.dproj` e `Services/libGatIme/Target/Linux/GatIme.dproj` (`PreBuildEvent`)

**Interfaces:**
- Produz: `GATIME_CONTRATO_VERSAO` (constante), `fContratoVersaoGatIme: Integer` (exportada pela `.so`/DLL) e `TDllGatime.fVersaoCompativel: Boolean`.

**CORRIGIDA EM 14/09/2026, ANTES DE EXECUTAR.** A primeira redação apoiava a trava no
`fSVN_RevisionGatIme`. **Não serve**, e a verificação mostrou por quê: ele lê
`fontes/libGatIme/rev.inc`, que diz `SVN_REVISION = '456514'` e foi commitado pela última vez em
**fevereiro de 2026** (r456839), com o repositório hoje na r494524. Existe `revision.tmpl` do SubWCRev ao
lado, mas **nenhum `PreBuildEvent`** o regenera. Seguir o plano original faria a trava recusar **sempre**,
inclusive a biblioteca correta, com o sintoma "libGatIme desatualizada" na instalação certa.

E revisão de SVN não serviria como portão nem estando fresca, por três motivos: o mínimo teria de ser a
revisão do nosso próprio commit, conhecida só **depois** de commitar; o número muda a cada build sem
significar nada sobre contrato; e revisão é fato sobre a **cópia de trabalho** no momento do build, não
sobre o código — com sete cópias do repositório e ramos distintos, uma `.so` pode ter revisão alta e não
ter a mudança.

- [ ] **Passo 1: Declarar a versão do contrato ao lado da interface**

Em `GatilhosImediatos.Interfaces.pas`, junto da `IGatIme` — é o par que tem de mudar junto:

```pascal
const
  { Versao do CONTRATO da IGatIme. SUBIR SEMPRE que a interface mudar: metodo novo, comportamento
    diferente, parametro com outro significado. Nao tem relacao com revisao de SVN nem com data de
    build - e o numero que diz qual contrato esta .so implementa.

      1 - contrato historico: fMonitorar + fGravarGatilhoImediato
      2 - Req. 455094: acrescenta fGravarGatilhoObtendoId e fProcessarGatilho }
  GATIME_CONTRATO_VERSAO = 2;
```

- [ ] **Passo 2: Expor por função na biblioteca**

Em `GatilhosImediatos.Classes.pas`, fora de `IFDEF` — as duas plataformas precisam:

```pascal
function fContratoVersaoGatIme: Integer; {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF LINUX};
begin
  Result := GATIME_CONTRATO_VERSAO;
end;
```

A convenção segue o `fCarregarDll`: `stdcall` no Windows, `cdecl` no Linux. Divergir aqui corrompe a
pilha, e o sintoma seria pior que o problema que a trava evita.

- [ ] **Passo 3: Acrescentar ao `exports` do `.dpr` da `.so`**

Em `Services/libGatIme/Target/Linux/GatIme.dpr:869`, ao lado de `fCarregarDll`. E o `external` correspondente
no `untDllGatIme` para o ramo Windows.

- [ ] **Passo 4: Resolver o ponteiro no Linux, junto do `fCarregarDll`**

```pascal
  fContratoVersaoGatImeSO := GetProcAddress(HandleDllGatilhosImediatos, PChar('fContratoVersaoGatIme'));
```

Numa `.so` antiga o símbolo não existe e o `GetProcAddress` devolve `nil` — **que é exatamente o caso que
se quer detectar**. Perguntar por símbolo ausente é seguro; chamar método ausente não é.

- [ ] **Passo 5: Conferir uma vez, no `TDllGatime`**

```pascal
function TDllGatime.fVersaoCompativel: Boolean;
var
  LintVersao: Integer;
begin
 {$IFDEF LINUX}
  if not Assigned(fContratoVersaoGatImeSO) then
    LintVersao := 1   { .so anterior a 14/09/2026 nao exporta a funcao: e o contrato 1 }
  else
    LintVersao := fContratoVersaoGatImeSO;
 {$ELSE}
  LintVersao := fContratoVersaoGatIme;
 {$ENDIF}

  Result := LintVersao >= GATIME_CONTRATO_VERSAO;

  if not Result then
    pGravarErro(True, Format('libGatIme desatualizada nesta instalacao: contrato %d, o host exige %d. ' +
                             'Os metodos sincronos nao serao chamados.',
                             [LintVersao, GATIME_CONTRATO_VERSAO]));
end;
```

No Windows a DLL é ligada por `delayed`, e a ausência do símbolo levanta exceção na primeira chamada —
envolver em `try/except` devolvendo 1, para o mesmo desfecho dos dois lados.

- [ ] **Passo 6: Guardar os dois métodos novos atrás dela**

Os encaminhamentos do `TDllGatime` (Tarefa 18) começam com a guarda que o `fMonitorarGatilhosImediatos`
já tem, acrescida da versão:

```pascal
  if (not Assigned(DllGatIme)) or (not fVersaoCompativel) then
    Exit(tpNaoEnviado);
```

- [ ] **Passo 7: Verificar com `.so` de contrato antigo**

Guardar cópia da `libGatIme.so` atual — que **não** exporta `fContratoVersaoGatIme` —, subir o host novo
contra ela e confirmar no log "libGatIme desatualizada: contrato 1, o host exige 2", **sem AV e sem
derrubar o processo**. É o critério 28 da spec.

**Achado consolidado no caminho, deliberadamente fora do escopo: a informação de versão dos binários
não é confiável neste projeto.** São dois sintomas da mesma família, os dois medidos em 14/09/2026:

- `fontes/libGatIme/rev.inc` diz `456514` e foi commitado pela última vez em **fevereiro de 2026**
  (r456839), com o repositório na r494524. Existe `revision.tmpl` do SubWCRev ao lado, mas nenhum
  `PreBuildEvent` o regenera.
- **24 dos 56** `.dproj` Linux não chamam o `svn_rev.bat`, e entre eles estão `GatilhosInformacao` e
  `GatilhosImediatos`. Como o `Services/bin/svn_rev.inc` é **um arquivo só, compartilhado**, esses 24 não
  ficam sem versão: ficam com a do último projeto compilado naquela máquina. É o mecanismo por trás do
  `buildDate` mentir em parte dos serviços.

**Chegou a ser planejado consertar o `rev.inc` aqui, e foi retirado em 14/09/2026 com o custo medido.**
Assim que a trava passou a usar `GATIME_CONTRATO_VERSAO`, nada deste requisito passou a depender do
`rev.inc`. E o conserto custa dois `.dproj` com evento por configuração, uma mudança de versionamento
(`svn delete` + `svn:ignore`), e uma **dependência de build nova**: hoje a libGatIme compila sem
`SubWCRev`, e com o evento deixa de compilar em máquina sem TortoiseSVN. Defeito de diagnóstico não
justifica esse raio numa biblioteca de seis consumidores.

**Requisito próprio**, e vale: hoje qualquer diagnóstico que comece por "qual versão está instalada"
começa errado.

### Tarefa 17: Par `GET_LOCK` / `RELEASE_LOCK` correto em `untFuncoesGenerica`

**Arquivos:**
- Modificar: `padra_atualizado/fontes/genericos/untFuncoesGenerica.pas` (junto de `fIsUsedLock`, linha 9627)

**Interfaces:**
- Produz: `fAdquireLockNomeado(const AstrNome: String; const AintEsperaSegundos: Integer = 0): Boolean` e `fLiberaLockNomeado(const AstrNome: String): Boolean`.

**Por que aqui e não reusar o que existe.** RN23. O `fGetLock` de `untFuncoesSimples.pas:50087` faz
`Result := True` sem ler o retorno do `GET_LOCK`, que devolve 0 quando estoura a espera — quem chama acha
que tem o lock e não tem. Ele é usado pelo autcom para decidir qual estação é responsável pelo robô do SFA
(`untPrincipal.pas:25515`) e três vezes na importação de CTe; corrigi-lo mudaria o comportamento desses
robôs em produção, fora do escopo. `untFuncoesGenerica` já é dona do `fIsUsedLock` e é visível às duas
builds — `Services.Core` não serve, porque a libGatIme só a enxerga sob `{$IFDEF LINUX}` e também compila
como `libGatIme.dll`.

**A unit é cp1252.** Conferir o encoding antes e depois da edição.

- [ ] **Passo 1: Declarar na interface**

```pascal
{ Advisory lock nomeado do MySQL. Escopado na CONEXAO: quem adquire tem de ser quem trabalha, e a
  queda do processo libera sozinha. Espera zero por padrao - nao pegou, nao espera. }
function fAdquireLockNomeado(const AstrNome: String; const AintEsperaSegundos: Integer = 0): Boolean;
function fLiberaLockNomeado(const AstrNome: String): Boolean;
```

- [ ] **Passo 2: Implementar**

```pascal
function fAdquireLockNomeado(const AstrNome: String; const AintEsperaSegundos: Integer = 0): Boolean;
var
  qryAux: TUniQuery;
begin
  Result := False;

  qryAux := fCriaQuery();
  try
    qryAux.SQL.Text := 'SELECT GET_LOCK(:NOME, :ESPERA) AS OBTIDO';
    qryAux.ParamByName('NOME').AsString    := AstrNome;
    qryAux.ParamByName('ESPERA').AsInteger := AintEsperaSegundos;
    qryAux.Open;

    { 1 obteve, 0 estourou a espera, NULL erro. O fGetLock de untFuncoesSimples devolve True nos tres
      casos - e por isso que este par existe aqui em vez de reusar aquele. }
    Result := (not qryAux.Fields[0].IsNull) and (qryAux.Fields[0].AsInteger = 1);
  finally
    FreeAndNil(qryAux);
  end;
end;

function fLiberaLockNomeado(const AstrNome: String): Boolean;
var
  qryAux: TUniQuery;
begin
  Result := False;

  qryAux := fCriaQuery();
  try
    qryAux.SQL.Text := 'SELECT RELEASE_LOCK(:NOME) AS LIBEROU';
    qryAux.ParamByName('NOME').AsString := AstrNome;
    qryAux.Open;

    Result := (not qryAux.Fields[0].IsNull) and (qryAux.Fields[0].AsInteger = 1);
  finally
    FreeAndNil(qryAux);
  end;
end;
```

- [ ] **Passo 3: Conferir o encoding e o tamanho do diff**

```sh
file padra_atualizado/fontes/genericos/untFuncoesGenerica.pas
svn diff padra_atualizado/fontes/genericos/untFuncoesGenerica.pas | wc -l
```

Esperado: continua `ISO-8859`, e o diff na casa das dezenas de linhas. Centenas significa conversão de
fim de linha ou de charset — desfazer e refazer.

- [ ] **Passo 4: Pedir compilação Windows e Linux**

---

### Tarefa 18: Os dois métodos novos na `IGatIme`

**Arquivos:**
- Modificar: `padra_atualizado/fontes/genericos/GatilhosImediatos.Interfaces.pas:16`
- Modificar: `padra_atualizado/fontes/libGatIme/fontes/GatilhosImediatos.Classes.pas:43-51` e `:117`
- Modificar: `padra_atualizado/fontes/util/untProcessaGatilhosImediatos.pas` (novo método público)
- Modificar: `padra_atualizado/fontes/genericos/untDllGatIme.pas` (encaminhamento no `TDllGatime`)

**Interfaces:**
- Consome: `TResultEnvio` da Tarefa 15; `fAdquireLockNomeado` / `fLiberaLockNomeado` da Tarefa 17; a guarda `fVersaoCompativel` da Tarefa 16.
- Produz: `fGravarGatilhoObtendoId(RecGatilhoImediato: TRecGatilhoImediato; out AstrIdGatilho: String): Boolean` e `fProcessarGatilho(const AstrIdGatilho: String): TResultEnvio`, nos dois níveis — `IGatIme` e `TDllGatime`.

- [ ] **Passo 1: Acrescentar à interface, ao fim, sem tocar nos dois existentes**

```pascal
  IGatIme = interface
    ['{EA66E39A-13F2-414D-875A-0EF86F97A1C8}']
    function fMonitorar(AstrFluxo: String = ''): {$IFDEF LINUX}Boolean{$ELSE}IMonitorProcedure{$ENDIF LINUX};
    function fGravarGatilhoImediato(RecGatilhoImediato: TRecGatilhoImediato): Boolean;

    { Grava e devolve o AUTOINCREM da linha em GATIME_WPPEMA, para quem vai pedir o processamento
      daquele registro. O fGravarGatilhoImediato acima ja calculava esse valor e o descartava. }
    function fGravarGatilhoObtendoId(RecGatilhoImediato: TRecGatilhoImediato;
                                     out AstrIdGatilho: String): Boolean;

    { Processa UM registro e devolve o desfecho. Nao varre a fila. Devolve tpTentarNovamente quando
      outro processo detem o lock daquele registro. }
    function fProcessarGatilho(const AstrIdGatilho: String): TResultEnvio;
  end;
```

- [ ] **Passo 2: `fGravarGatilhoImediato` vira encaminhamento**

Em `GatilhosImediatos.Classes.pas`, renomear o corpo atual (linha 117) para `fGravarGatilhoObtendoId`,
acrescentando o parâmetro `out`, e atribuir `AstrIdGatilho := strAutIncWppEma` logo antes do
`Result := True`. O método antigo passa a ser:

```pascal
function TGatIme.fGravarGatilhoImediato(RecGatilhoImediato: TRecGatilhoImediato): Boolean;
var
  LstrId: String;
begin
  Result := fGravarGatilhoObtendoId(RecGatilhoImediato, LstrId);
end;
```

Nenhum dos seis consumidores de hoje muda.

- [ ] **Passo 3: Método público de um registro só em `TGatilhosImediatosExecute`**

Espelha o corpo do laço de `pExecuteCliente` (`untProcessaGatilhosImediatos.pas:310-380`) para uma linha,
**sem** o `fLock_Unlock` do monitor, sem `LckAtcEhDoMesmoPID` e sem o `Sleep(1000)` — aquilo é maquinaria
de varredura, não de envio.

```pascal
function TGatilhosImediatosExecute.fExecutarGatilho(const AAutInc: String): TResultEnvio;
const
  SQL_LINHA =
    ' SELECT GAT_D_EWPP, GAT_D_EEMA, GAT_D_ESMS, GAT_OPEENV, GAT_INFJSN ' +
    ' FROM GATIME_WPPEMA WHERE AUTOINCREM = :AUTINC ';
var
  LQry: TUniQuery;
  LstrLock: String;
begin
  Result := tpNaoEnviado;

  LstrLock := fNomeLockGatilho(AAutInc);

  { O lock e tomado AQUI, na conexao que vai processar - GET_LOCK e escopado na conexao, e adquirido
    pelo chamador nao protegeria o que roda na conexao da .so. Espera zero: se outro processo esta
    com este registro, nao e nossa vez. }
  if not fAdquireLockNomeado(LstrLock) then
    Exit(tpTentarNovamente);

  try
    LQry := fCriaQuery;
    try
      LQry.SQL.Text := SQL_LINHA;
      LQry.ParamByName('AUTINC').AsString := AAutInc;
      LQry.Open;

      if LQry.IsEmpty then
        Exit(tpNaoEnviado);

      if LQry.FieldByName('GAT_D_EEMA').IsNull then
      begin
        Result := fExecutaClienteEmail(AAutInc);
        pMarcaEnvioEmail(AAutInc, Result);
      end;

      if LQry.FieldByName('GAT_D_ESMS').IsNull then
      begin
        Result := fExecutaClienteSms(AAutInc);
        pMarcaEnvioSms(AAutInc, Result);
      end;

      pMarcaGatImeEnviado(AAutInc);
    finally
      FreeAndNil(LQry);
    end;
  finally
    fLiberaLockNomeado(LstrLock);
  end;
end;
```

**WhatsApp entra também. Revisto em 14/09/2026, a pedido do usuário.** A primeira redação deixava o canal
de fora alegando "trabalho próprio". Ao medir, eram ~15 linhas, todas já existentes: a fila sai de
`fRetFilaEnvioWhatsAppOperador(fCfgSis('GATOPE'))` com a chave lida da `CADFIL`, e `pAjustaFilaGatOpeEnv` e
`pAjustaFilaJson` a refinam pela linha antes do despacho de três vias.

**O que decidiu foi o alvo, não o custo:** os gatilhos de informação mandam e-mail **e** WhatsApp, e é deles
que nasceu este trabalho. Com o canal de fora, a Tarefa 21 entregaria envio imediato para metade do que
motivou o requisito.

**Como o canal é verificado, decidido em 14/09/2026:** por **homologação em campo**, não por caso
automatizado. O robô de gatilhos de informação vai para um conjunto reduzido de clientes por um período, e
é ele quem exercita o WhatsApp síncrono de ponta a ponta. A suíte cobre a mecânica — linha na fila,
resultado devolvido, marcação por canal —, tudo por consulta ao banco; a mensagem chegando no aparelho não
é afirmável por ela.

**Consequência de sequenciamento, e ela favorece a entrega:** o pacote libGatIme + robô **não depende da AV
do `TLSHandshake`**. Ele pode ir para homologação enquanto o lado da cotação segue parado. O critério 30
segura o fechamento do 455094, não o ganho do robô.

**Cada canal tem a própria variável de resultado**, como no laço original: passar o desfecho acumulado para
o `pMarcaEnvio*` de outro canal gravaria estado errado na linha. A função devolve **um** valor, e a regra é
o pior dos canais tentados — sucesso num não pode esconder erro noutro, senão quem chama grava "enviado"
para mensagem que não saiu.

- [ ] **Passo 4: Nome do lock numa função só**

```pascal
{ Prefixo porque o espaco de nomes do GET_LOCK e GLOBAL na instancia do MySQL, compartilhado pelos
  Services e pelo autcom. }
function fNomeLockGatilho(const AAutInc: String): String;
begin
  Result := 'GATIME_' + VS_strCodEmp + '_' + AAutInc;
end;
```

Precisa ser visível ao `pExecuteCliente` da Tarefa 19 — mesma unit, seção `implementation` serve.

- [ ] **Passo 5: `fProcessarGatilho` na `TGatIme`**

```pascal
function TGatIme.fProcessarGatilho(const AstrIdGatilho: String): TResultEnvio;
var
  LGatIme: TGatilhosImediatosExecute;
begin
  Result := tpNaoEnviado;
  try
    LGatIme := TGatilhosImediatosExecute.Create('');
    try
      Result := LGatIme.fExecutarGatilho(AstrIdGatilho);
    finally
      FreeAndNil(LGatIme);
    end;
  except
    on e: Exception do
    begin
      pGravarErro(True, 'TGatIme.fProcessarGatilho: ' + e.Message);
      Result := tpEnviadoErro;
    end;
  end;
end;
```

**O `try/except` é o que sustenta a RN20 e o critério 30.** A AV do `TLSHandshake` sobe como exceção e é
capturada aqui: o chamador recebe `tpEnviadoErro`, a linha fica pendente, e o robô manda depois.

- [ ] **Passo 6: Encaminhar no `TDllGatime`, com a guarda da Tarefa 16**

- [ ] **Passo 7: Pedir compilação Windows e Linux**

---

### Tarefa 19: `pExecuteCliente` passa a tomar o lock por registro

**Arquivos:**
- Modificar: `padra_atualizado/fontes/util/untProcessaGatilhosImediatos.pas:310-380`

**Interfaces:**
- Consome: `fAdquireLockNomeado`, `fLiberaLockNomeado` (Tarefa 17) e `fNomeLockGatilho` (Tarefa 18).

**Esta é a única tarefa do requisito que altera código em produção usado por terceiros** — WhatsApp, SMS,
`untDisparaEmailAut` e editor de relatórios passam por este laço. Por isso ela vem sozinha, e por isso o
critério 27 existe.

**Sem ela o lock não protege nada:** o monitor continuaria mandando a mesma linha que a chamada síncrona
está mandando. O risco está descrito no próprio código, em `untGatilhosInformacao.pas:239` — *"dois
processos no mesmo cursor podem enviar a mesma mensagem duas vezes ao cliente final"*.

- [ ] **Passo 1: Pegar o lock no topo do corpo do laço**

Logo depois do `while not LQryEnvArq.Eof do begin`, antes de qualquer envio:

```pascal
      LstrLockLinha := fNomeLockGatilho(LQryEnvArq.FieldByName('AUTOINCREM').AsString);

      { Espera zero: linha que outro processo esta enviando neste instante fica para o proximo ciclo.
        Acrescimo aditivo - nenhuma linha deixa de ser enviada, algumas sao enviadas depois. }
      if not fAdquireLockNomeado(LstrLockLinha) then
      begin
        LQryEnvArq.Next;
        Continue;
      end;
```

- [ ] **Passo 2: Liberar no `try/finally` da linha**

Envolver do `if fValidaDisparo(...)` até o `pMarcaGatImeEnviado(...)` num `try` cujo `finally` chama
`fLiberaLockNomeado(LstrLockLinha)`. O `Sleep(1000)` e o `LQryEnvArq.Next` ficam **fora**, depois do
`finally` — segurar o lock durante o sleep atrasaria a chamada síncrona por um segundo por linha sem
necessidade.

- [ ] **Passo 3: Declarar `LstrLockLinha: String` nas variáveis de `pExecuteCliente`**

- [ ] **Passo 4: Conferir que o `Exit` do meio do laço não escapa do `finally`**

Há um `Exit` no ramo de `LckAtcEhDoMesmoPID` que encerra a aplicação. Ele está **antes** da aquisição, e
tem de continuar antes — sair com lock tomado deixaria a linha travada até a conexão morrer. Ler o trecho
depois de editar e confirmar a ordem.

- [ ] **Passo 5: Pedir compilação Windows e Linux**

---

### Tarefa 20: A cotação delega o envio (substitui a Tarefa 7)

**Arquivos:**
- Modificar: `padra_atualizado/Services/Core/suprimento/services/Suprimento.Services.Cotacao.Exportacao.pas`
- Modificar: `padra_atualizado/fontes/genericos/untDadosEnviaGatilhoEmail.pas` (desfazer a exportação de `fCarregaDadosConexao`)
- Modificar: `padra_atualizado/Services/Suprimento.Services.API/Target/Linux/SuprimentoServicesAPI.dpr` e o `deployproj`

**Interfaces:**
- Consome: `TDllGatime.fGravarGatilhoObtendoId` e `.fProcessarGatilho` (Tarefa 18).
- Produz: `TCotacaoExportacaoGerarResult.enviados` e `emailEnviado` por fornecedor — **sem mudança de contrato**.

- [ ] **Passo 1: Verificar o bucket antes de escrever código**

Pré-requisito da RN21, e o candidato mais provável a morder primeiro. Confirmar que o `TBucketCitel`
responde a partir da `srvPrg1`. Se não responder, **parar e reportar** — não contornar com `GAT_PATARQ`,
que é proibido pela RN21: a fila atravessa máquina e sistema operacional, e registro inserido no Linux pode
ser processado por robô no Windows.

- [ ] **Passo 2: Trocar a chamada de envio pelo gatilho**

Manter a resolução de destinatários da Tarefa 7 e a gravação em `EMACOT`. O que sai é o bloco
`TEnvioEmail.EnviarEmail(...)` com a lista de credenciais; o que entra:

```pascal
  LrecGatilho := TRecGatilhoImediato.Create(LstrAssunto,
                                            fCfgSis('MSGCOT', varString),
                                            LarrArquivos,
                                            EmptyStr,
                                            strLoginUsuarioLogado,
                                            EmptyStr,
                                            String.Join(';', LarrDestinatarios));

  if TDllGatime.fNew.fGravarGatilhoObtendoId(LrecGatilho, LstrIdGatilho) then
    AFornecedor.emailEnviado := TDllGatime.fNew.fProcessarGatilho(LstrIdGatilho) = tpEnviadoOK
  else
    AFornecedor.emailEnviado := False;
```

- [ ] **Passo 3: Carregar a `libGatIme.so` no processo da tarefa**

`pCarregaFuncoesDllGatilhoImediatos` antes do primeiro uso e `FreeLibrary` no encerramento, no mesmo molde
de `pLoadLibTintaMaquina` / `pFreeLibTintaMaquina` que o `.dpr` já tem.

- [ ] **Passo 4: Pôr a `libGatIme.so` no `deployproj` do serviço**

Hoje ela não está lá — a pasta de deploy tem só `bplNFe.so`, `bplShared.Functions.so`, `bplrtl260.so` e
`libmidas.so.2`. Sem este passo o `RetornarDllGatilhosImediatos` devolve `0` e a trava da Tarefa 16 recusa.

- [ ] **Passo 5: Desfazer o que a Tarefa 7 abriu e não é mais necessário**

`fCarregaDadosConexao` volta a ser só da `implementation` em `untDadosEnviaGatilhoEmail.pas` — a libGatIme
resolve credencial por conta própria. E os **18 marcadores `SMTP.1` a `SMTP.18`** e o log do OpenSSL saem
de `untTEnvioEmail.pas`.

```sh
grep -c "SMTP\." padra_atualizado/fontes/email/controller/untTEnvioEmail.pas
```

Esperado ao fim: `0`.

- [ ] **Passo 6: Reverter o `fRetModeSSL`**

O default voltou de `sslmUnassigned` para `sslmClient` como tentativa, e o próprio comentário registra que
o nexo causal era não comprovado. A hipótese que o motivava caiu; a mudança altera comportamento de toda
empresa sem `CFG_MODSSL` preenchido. **Reverter.**

- [ ] **Passo 7: Reverter `Services/bin/opcoes.ini`**

`FORCAR_ENVIO_EMAIL=S` e o apontamento de banco local. **Não vai para o commit em nenhuma hipótese.**

- [ ] **Passo 8: Pedir compilação Linux e rodar os casos 25, 26 e 30**

---

### Tarefa 21: `untGatilhosInformacao` deixa de drenar a fila

**Arquivos:**
- Modificar: `padra_atualizado/fontes/util/untGatilhosInformacao.pas` — remover `pProcessarGatilhosImediatos` (linhas 217 a 270) e a chamada na linha 2171; alterar `EnviarRelatorioPorEmail` (linha ~858) e `EnviarRelatorioPorWhatsApp` (linha ~909)

**Interfaces:**
- Consome: `fGravarGatilhoObtendoId` e `fProcessarGatilho` (Tarefa 18).

**RN20.** Nenhum produtor drena o que não inseriu. Os dois estragos já vistos em produção — processar
registro com `GAT_PATARQ` do Windows e reenviar lixo antigo — são consequência direta disso.

- [ ] **Passo 1: `EnviarRelatorioPorEmail` guarda o id e processa**

```pascal
  if TDllGatime.fNew.fGravarGatilhoObtendoId(TRecGatilhoImediato
                                               .Create(strDescricao,
                                                       strMensagem,
                                                       LArquivos,
                                                       LDadosEnviaGatilhoEmail.ToJsonString,
                                                       fCfgSis('GATOPE'),
                                                       EmptyStr,
                                                       strEmailDestino),
                                             LstrIdGatilho) then
    TDllGatime.fNew.fProcessarGatilho(LstrIdGatilho);
```

- [ ] **Passo 2: Mesmo tratamento em `EnviarRelatorioPorWhatsApp`**

O `fExecutarGatilho` cobre WhatsApp desde a revisão de 14/09/2026, então aqui o envio também sai na hora —
que é o ponto do requisito para este robô, já que ele manda pelos dois canais.

- [ ] **Passo 3: Apagar `pProcessarGatilhosImediatos` e a chamada**

Some com ela a heurística de lock órfão das linhas 228 a 260 — idade, `LCK_TENTAT`,
`pDestravaLockForcado` — e o `fLockTaskMonitor` do monitor operacional. Aquele bloco só existe para tomar
o lock do monitor com segurança; sem drenagem não há lock de monitor a tomar.

- [ ] **Passo 4: Aposentar o `DestravarFilas` junto**

Descoberto ao conferir quem mais citava o que foi removido. O `TEnviarGatilhos.DestravarFilas`
(`Services/GatilhosInformacao/Target/Linux/MonitorarGatilhos/untGatilhos.pas:1722`) sobe o robô **de
propósito, sem gatilho vencido**, só para que o `pExecuteAll` não ache nada e caia no
`pProcessarGatilhosImediatos`, que drenava a fila. É o conserto do caso MINAS BOMBAS — último gatilho às
18:15, nada mais vence, fila cheia até 07:30, **treze horas e quarenta medidas**.

Sem a drenagem, ele subiria o robô e nada aconteceria: proteção que parece existir e não existe, com log
dizendo que rodou.

**Sai inteiro, e a razão é que a causa dele sumiu.** O atraso existia porque o envio era adiado para o fim
do laço; com envio na inserção, a fila que ele caçava não se forma mais. O que sobra — linha que perdeu a
disputa do lock, `.so` recusada pela trava, processo morto entre gravar e processar — é resto, e varrer
resto é função do serviço `GatilhosImediatos`, não deste robô.

Fica no lugar um comentário-lápide dizendo o que havia ali, por que saiu, de quem é o que sobrou, e em que
revisão o mecanismo pode ser recuperado. Quem for procurar o conserto do MINAS BOMBAS precisa achar a
explicação, não o vazio.

- [ ] **Passo 5: Conferir que nada mais chama o que foi removido**

```sh
grep -rn "pProcessarGatilhosImediatos" --include=*.pas padra_atualizado/
```

Esperado: nenhuma ocorrência.

- [ ] **Passo 6: Pedir compilação Linux e rodar o caso 29**

---

### Tarefa 22: Casos de teste 25 a 30

**Arquivos:**
- Criar: `Services/Suprimento.Services.API/Scripts/testes/casos/0053_*.sql` a `0058_*.sql`
- Modificar: `Services/Suprimento.Services.API/Source/api/controller/api.controller.cotacao.test.pas`

**Os casos são meus** — neste projeto acumulo análise e teste, o que contraria o default do `CLAUDE.md`.
Combinado com o usuário em 14/09/2026.

Cada caso são três artefatos: o `.sql`, o `.inc` e o método Delphi. A coluna `response` é porteira —
deixá-la vazia faz o assert não rodar. Ler o `README.md` da pasta antes.

- [ ] **Passo 1: Caso 25 — uma linha em `GATIME_WPPEMA` por fornecedor**

Afirma assunto, destinatário, `GAT_ARQBCK` não vazio e `GAT_OPEENV` igual ao operador da tarefa. Tudo por
consulta ao banco, sem SMTP — é a melhora grande sobre o que vínhamos tentando.

- [ ] **Passo 2: Caso 26 — `EMACOT` só para quem teve resultado positivo**

- [ ] **Passo 3: Caso 27 — o monitor pula a linha travada**

O único que precisa de desenho cuidadoso, e o que protege contra mensagem duplicada ao fornecedor. O
`sql_before` toma o lock `GATIME_<empresa>_<autoincrem>` numa conexão própria; o caso dispara o monitor; o
assert afirma que `GAT_LIBENV` continua `'S'` e que nenhuma linha nova apareceu em `EMAENV`.

- [ ] **Passo 4: Caso 28 — `.so` desatualizada**

Exercitado manualmente com uma cópia antiga da `libGatIme.so`, conforme a Tarefa 16, Passo 5. Registrar o
resultado no `record.md` — não é automatizável pela suíte, que não controla o binário implantado.

- [ ] **Passo 5: Caso 29 — o robô envia ao inserir, e não drena o alheio**

Duas afirmações: o gatilho inserido pelo robô sai antes do fim da varredura, e uma linha inserida por
**outro** produtor, deixada pendente de propósito, continua pendente depois de o robô rodar.

- [ ] **Passo 6: Caso 30 — o e-mail chega**

Definição de pronto acordada em 14/09/2026. **Depende da causa da AV no `TLSHandshake`, que está em
aberto**, e a medição que separa máquina de binário — rodar o `GatilhosInformacao` na `srvPrg1` — ainda
não foi feita. Se a causa não fechar, este caso é o que segura a entrega, e é assim que foi combinado.

- [ ] **Passo 7: Registrar as limitações declaradas**

No `record.md`, não só no código: o WhatsApp de ponta a ponta é verificado por **homologação em campo pelo
robô de gatilhos de informação**, com a suíte cobrindo só a mecânica por banco; o `fGetLock` de
`untFuncoesSimples` continua quebrado e é achado para requisito próprio; o caso 28 é manual; e a informação
de versão dos binários continua não confiável, com os dois sintomas medidos.

---

## Auto-revisão da Fase 5

**Cobertura das regras novas.** RN19 → Tarefas 15, 18 e 20. RN20 → Tarefa 21. RN21 → Tarefa 20, Passo 1.
RN22 → Tarefa 16. RN23 → Tarefas 17, 18 e 19. RN24 → não gera tarefa de código: é significado de campo, e
está na spec para quem consome. **Sem lacuna.**

**Cobertura dos critérios novos.** 25 e 26 → Tarefa 22, Passos 1 e 2. 27 → Passo 3, e depende da Tarefa 19.
28 → Passo 4, e depende da Tarefa 16. 29 → Passo 5, e depende da Tarefa 21. 30 → Passo 6, **e depende de
uma causa em aberto** — declarado, não escondido.

**Consistência de nomes entre tarefas.** `fGravarGatilhoObtendoId`, `fProcessarGatilho`,
`fExecutarGatilho`, `fNomeLockGatilho`, `fAdquireLockNomeado`, `fLiberaLockNomeado`,
`fVersaoCompativel`, `GATIME_CONTRATO_VERSAO`, `fContratoVersaoGatIme` — cada um aparece com a mesma grafia em todas as tarefas que
o citam.

**O que este plano não resolve, e está escrito:** a AV do `TLSHandshake`; o WhatsApp no caminho síncrono;
o `fGetLock` quebrado do autcom; e a migração das cinco validações da exportação para o pré-voo do worker,
pendência aberta pelo Req. 460364 e registrada no fim deste arquivo.
