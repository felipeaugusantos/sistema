# Plano de Execução — Req. 462692

**Referência:** spec.md
**Zona:** mista — `padra_atualizado/Packages/Principal/View/` (FMX, estilo dot-notation do package) + `padra_atualizado/fontes/genericos/` (Legado)

## 1. Abordagem técnica

Quatro peças, cada uma com uma responsabilidade única:

**(1) Tabela constante das colunas** — unit nova `Principal.View.PainelEntregas.Colunas`, sem dependência de form nem de banco. Passa a ser a fonte de verdade das 13 colunas da grade de documentos: quais são configuráveis, o valor de cada uma e o padrão de fábrica. Os dois `.fmx` continuam desenhando a grade, mas quem decide largura em tempo de execução é esta unit (spec §1.2).

```pascal
type
  TColunaDocumentos = record
    Indice        : Integer;   // posição no TGridPanelLayout
    Chave         : String;    // gravado em GRD_COLFLD; estável, nunca o índice
    Rotulo        : String;    // texto na tela de seleção
    Configuravel  : Boolean;   // True => Absolute e ocultável; False => obrigatória
    Valor         : Double;    // px se Configuravel ou absoluta fixa; % se elástica
    LarguraMinima : Integer;   // px mínimos; só consultado nas elásticas obrigatórias
    OcultaPadrao  : Boolean;   // comportamento de fábrica em janela <= 1370
  end;

const
  COLUNAS_DOCUMENTOS: array[0..12] of TColunaDocumentos = ( ... );
  LARGURA_LIMITE_COLUNAS = 1370;
```

Expõe:

- `AplicarColunas(const ALayout: TGridPanelLayout; const AOcultas: TArray<String>): Boolean` — escreve **apenas as cinco células configuráveis**, dentro de `ALayout.ColumnCollection.BeginUpdate/EndUpdate` (spec RN03). Nenhuma coluna percentual é tocada. Se `ColumnCollection.Count` divergir da constante, não altera nada e devolve `False` para o chamador registrar o log (spec RN10).
- `Configuraveis: TArray<TColunaDocumentos>` e `OcultasPadrao: TArray<String>` — respectivamente o que a tela lista e o padrão de fábrica.
- `ContemChave`, `VisiveisEmOrdem` e `OcultasAPartirDeVisiveis` — apoio à persistência e à conversão entre "visíveis" (formato de `CFGCOL_GRD`) e "ocultas" (formato que `AplicarColunas` espera).

> `SobraParaElasticas` e `MinimoElasticas` existiram para alimentar o aviso de espaço da tela e foram removidas em 22/09/2026, junto com ele.

**(2) Persistência no host** — unit nova `untTConfiguracaoColunasGrid` em `fontes/genericos/`, lendo e gravando `CFGCOL_GRD` sem nenhum acoplamento a cxGrid, ao contrário de `untTConfiguracaoGrids`. Duas rotinas, ambas por `ParamByName`:

```pascal
function  fColunasVisiveisGrid(const AstrChaveGrid: String): TArray<String>;
procedure pGravarColunasVisiveisGrid(const AstrChaveGrid: String;
                                     const AarrColunas : TArray<String>;
                                     const AarrLarguras: TArray<Integer>);
```

`AarrColunas` chega **na ordem do layout**, e `GRD_COLORD` recebe a posição de cada chave nesse array — o host não precisa conhecer a tabela constante, que vive no package.

Gravar = apagar as linhas do trio `GRD_CHAVE_` + `GRD_CODEMP` + `GRD_CODOPE` e inserir as visíveis, sob `fStartTransaction` / `fCommit` / `fRollBack` (de `untFuncoesSimples` — os sufixados com `Gen` que o `CLAUDE.md` cita só existem em `autcomtinta/` e `auttin/`). `AUTOINCREM` por `fRetAutoIncrem('CFGCOL_GRD', VS_strCodEmp)`.

**(3) Ponte package → host** — `IFuncoes` ganha dois métodos, porque o package não executa SQL (spec §5.2):

```pascal
function CarregarColunasGrid(const AChaveGrid: String): TArray<String>;
procedure GravarColunasGrid(const AChaveGrid: String;
                            const AColunasVisiveis: TArray<String>;
                            const ALarguras: TArray<Integer>);
```

Implementados em `TFuncoes` (`untTFuncoesFiremonkey.pas`), delegando para (2). O package monta os dois arrays a partir da tabela constante, em ordem de layout, e o host apenas grava: `GRD_COLORD` = índice no array, `GRD_COLTAM` = largura correspondente. A tabela constante **não** atravessa a fronteira do package.

**(4) Tela de seleção** — `TfmxConfiguracaoColunasDocumentos`, FMX, molde de `TfmxConsultaMotoristas`. Lista **cinco** marcadores, não treze. Recebe do painel a lista de colunas ocultas em vigor; devolve a nova lista e os flags de confirmação e de restauração. Não fala com banco nem faz conta de largura.

O painel amarra tudo: lê uma vez no `FormShow`, guarda em `FColunasOcultas`, e as duas cópias da regra dos 1370 passam a chamar `AplicarColunas`.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `Principal.View.PainelEntregas.Colunas.pas` | `padra_atualizado/Packages/Principal/View/source/` | criar |
| `Principal.View.FMXConfiguracaoColunasDocumentos.pas` + `.fmx` | `padra_atualizado/Packages/Principal/View/source/` | criar |
| `untTConfiguracaoColunasGrid.pas` | `padra_atualizado/fontes/genericos/` | criar |
| `Principal.View.Interfaces.pas` | `padra_atualizado/Packages/Principal/View/interfaces/` | alterar — 2 métodos em `IFuncoes` |
| `untTFuncoesFiremonkey.pas` | `padra_atualizado/fontes/genericos/` | alterar — implementar os 2 métodos |
| `Principal.View.FMXPainelEntregas.pas` | `padra_atualizado/Packages/Principal/View/source/` | alterar — campo, `FormShow`, `ConfigurarLayoutResponsivo`, `FormResize`, clique da engrenagem |
| `Principal.View.FMXPainelEntregas.fmx` | `padra_atualizado/Packages/Principal/View/source/` | alterar — converter 3 colunas para `Absolute` + `imgConfigColunas` na barra |
| `Principal.View.Frame.FMXPainelRotasGridDocumentosLinha.fmx` | `padra_atualizado/Packages/Principal/View/frames/` | alterar — converter as **mesmas** 3 colunas para `Absolute` |
| `Principal.View.dpk` | `padra_atualizado/Packages/Principal/View/package/` | alterar — `contains` das units novas |
| `autcom.dpr` / `autcom.dproj` | `padra_atualizado/` | alterar — `uses` de `untTConfiguracaoColunasGrid` |

**Sem alteração de estrutura de banco.** `CFGCOL_GRD` já existe e já está registrada em `pIncluiProdCod` (`untFuncoesGenerica.pas:46899`). Nenhum script `.sql` acompanha este requisito.

## 3. Sequência de implementação

1. **Conversão nos dois `.fmx`** — em `layColunasGridDocumentos` (cabeçalho) e no `TGridPanelLayout` do frame de linha, trocar `SizeStyle` de `Percent` para `Absolute` e o `Value` nas colunas 3 (`CIDADE - UF` → 110), 5 (`PREVISÃO ENTREGA` → 90) e 7 (`MOTORISTA` → 100); e ajustar a 6 (`RECEBEDOR` → 100). **Os dois arquivos, sempre.** Conferir CA02 aqui, contra a tabela de RN11 — o layout em 1366 **muda** em relação ao anterior.
2. **`Principal.View.PainelEntregas.Colunas.pas`** — a tabela constante com os 13 registros e as quatro rotinas, espelhando exatamente o que ficou nos `.fmx` (spec RN01).
3. **`untTConfiguracaoColunasGrid.pas`** — leitura e gravação de `CFGCOL_GRD`. Degradar para lista vazia se a tabela não existir (spec R03).
4. **`IFuncoes` + `TFuncoes`** — os dois métodos e a delegação. Compilar o package e o host neste ponto, antes de mexer na tela.
5. **Painel — aplicação.** Campo `FColunasOcultas: TArray<String>`, carregado no `FormShow`. Substituir os dois blocos de 1370 por chamadas a `AplicarColunas`; os literais `90`, `120` e `1370` saem do `.pas`. Validar CA01, CA02 e CA04 **antes** de haver qualquer tela.
6. **Tela de seleção** — `.pas` + `.fmx`, com os cinco marcadores e o texto de orientação. Sem aviso calculado e sem trava no Gravar (spec RN04).
7. **Painel — acionamento.** `imgConfigColunas` no `.fmx`; visibilidade concentrada em `ExibirBarraDocumentos`, que exige também janela em 1370px ou menos (spec RF01) e é reavaliada no `FormResize`. Clique abre por `ShowModal` ou `pAbrirFmx` conforme TSPlus; ao confirmar, reaplica o cabeçalho e chama `AtualizaDocumentos(layGridDocumentos.Tag)`.
8. **Registros de projeto** — `contains` do `.dpk` e `uses` do `autcom.dpr`.
9. **Roteiro de validação manual** (§5) percorrido ponta a ponta.

Os passos 1 e 5 são deliberadamente anteriores à tela: o primeiro muda o layout sem tocar em código, e o quinto reescreve o mecanismo sem mudar comportamento em 1366. Cada um isola uma classe de regressão e a torna fácil de atribuir.

## 4. Conformidade com padrões do projeto

**Zona do package (`Packages/Principal/View/`)** — dot-notation nas units novas; parâmetro com `A`, local com `L`, campo com `F`; sem prefixo de tipo, acompanhando o padrão mais recente das units `Principal.View.*` (spec §5.1). Não é zona Legado.

**Zona Legado (`fontes/genericos/`)** — `untTConfiguracaoColunasGrid.pas` segue o legado: Hungarian (`strChaveGrid`, `arrColunas`, `qryConfig`), prefixos `p`/`f` nos métodos, `fCriaQuery`, `try/finally` no `FreeAndNil`.

**Pre-commit — o que esta entrega toca:**

- SQL exclusivamente por `ParamByName()`; nada de concatenação. `TConfiguracaoGrids.GravarDados` já é o bom exemplo, e `TTintadeMaquina.fAtuallizarConfiguracaoCFGCON` é o contraexemplo a não copiar.
- `fMensagem()` para qualquer aviso ao usuário no host; nada de `ShowMessage`/`MessageDlg`.
- `fStrToFloat` / `fStrToFloatDef` se houver conversão numérica a partir de texto.
- Nenhum `Now`/`NOW()` — a entrega não grava data.
- `TBitBtnLocked` caso surja botão VCL; na tela FMX o vocabulário é o do FireMonkey, como nas demais telas do painel.
- Sem `TDBGrid`, `TClientDataSet`, `TDataSetProvider`, `dxSkin*`.
- Sem `FillType = ftBrush` e sem `Outline =` no `.fmx`.
- Nenhum script SQL, portanto nenhum risco de `FOREIGN_KEY_CHECKS`.

**Encoding** — `.pas` e `.fmx` em Windows-1252. Os rótulos acentuados de `COLUNAS_DOCUMENTOS` (`DISTÂNCIA KM TEMPO DIST.`, `PREVISÃO ENTREGA`, `CIDADE - UF`) são o ponto exato onde um editor em UTF-8 corrompe o arquivo. Conferir antes e depois de gravar.

**Edição de projeto** — units novas entram no `contains` do `.dpk` e no `uses` do `.dpr`; o `.dproj` é sincronizado pela IDE, não à mão.

## 5. Estratégia de testes

Não há suite automatizada aplicável: o package `Principal` não tem infraestrutura de teste, e pelo `CLAUDE.md` os casos de teste são escritos por analista humano. A validação desta entrega é **manual, com roteiro**, e a lista de casos a cobrir são os critérios de aceitação da spec §6.

**Roteiro de validação manual:**

1. **Neutralidade da conversão, logo após o passo 1 da sequência** — abrir o painel em 1366, entrar na visualização de documentos de um romaneio com várias linhas e conferir que as larguras são as mesmas de antes: 40 / 115 / 242 / 112 / 90 / 108 / 64 / 64 / 90 / 90 / 100 com as duas colunas de fábrica escondidas. Em seguida abrir em 1920 e registrar as larguras novas, conferindo contra a tabela de RN11. Cobre CA01 e CA02.
2. **Estabilidade sob redimensionamento** — arrastar a janela entre 1920 e 1200 cinco vezes, observando as larguras. Qualquer deriva reprova. Cobre CA04.
3. **Configuração e efeito** — em 1366, desmarcar `CIDADE - UF` e `DISTÂNCIA KM TEMPO DIST.`, marcar `RECEBEDOR`, gravar. Conferir cabeçalho **e** linhas. É o cenário do chamado. Cobre CA03 e CA11.
4. **Isolamento** — repetir a leitura com outro operador e com outra empresa. Cobre CA06.
5. **Bordas da tela** — desmarcar as cinco (CA08); marcar as cinco em 1200 (CA09); conferir que a engrenagem some acima de 1370 e volta ao reduzir (CA10); Restaurar padrão (CA07).
6. **Carga** — abrir dez romaneios em sequência e confirmar, por log de SQL, uma única leitura de `CFGCOL_GRD`. Cobre CA05.
7. **TSPlus** — repetir os itens 3 e 5 em sessão TSPlus. Cobre CA12.
8. **Leitura de código** — confirmar que `90`, `120` e `1370` existem num único lugar no `.pas`. Cobre CA13.
9. **Diff dos dois `.fmx`** — comparar a `ColumnCollection` do cabeçalho com a do frame de linha, item a item. Devem ser idênticas nas 13 colunas. Cobre CA14 e é a checagem que pega o risco R04.

## 6. Riscos e mitigação

| Risco | Mitigação |
|-------|-----------|
| **Conversão aplicada num `.fmx` e esquecida no outro** — modo de falha mais provável: não gera erro de compilação, só desalinha título e dado | Passo 1 da sequência trata os dois arquivos como uma coisa só; item 9 do roteiro compara as duas `ColumnCollection`; CA14 (spec R04) |
| Renormalização percentual do FMX | Neutralizada pelo desenho: o código só escreve em colunas absolutas (spec R02). `BeginUpdate`/`EndUpdate` mantido por performance (spec RN03); CA04 como rede de segurança |
| `MOTORISTA` truncando em monitor largo, por perder 70px | Conhecido e aceito (spec RN11). Se incomodar em campo, elevar o valor absoluto na tabela constante — um número, um arquivo |
| Consulta a banco dentro do laço de montagem das linhas — `ConfigurarLayoutResponsivo` roda por linha | Leitura única no `FormShow`, guardada em campo; caso CA05 |
| Cabeçalho e frame divergirem em quantidade de colunas | Verificação de `ColumnCollection.Count` com log (spec RN10) |
| ~~Ícone de engrenagem indisponível~~ | Resolvido: ícone fornecido e versionado em `IA/specs/462692/settings-20px.png` (spec D01) |
| Mínimos das elásticas subestimados, tornando o aviso inócuo (spec P01) | Ajuste do analista em cinco números; ponto único de edição na tabela constante, sem retrabalho de código |
| `CFGCOL_GRD` ausente em base antiga | Leitura degrada para padrão de fábrica em vez de estourar (spec R03) |
| Usuário de monitor largo configura e não vê efeito | A engrenagem não aparece acima do limite (spec RF01) |
