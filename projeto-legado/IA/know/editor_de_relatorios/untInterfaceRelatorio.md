# untInterfaceRelatorio

## Responsabilidade
Camada de runtime do relatório (`TInterfaceRelatorio`): monta filtros e parâmetros na tela, abre os dados (SQL → `qryDados`), resolve a pasta de saída e valida a entrada antes de chamar `TGeraFR3`.

## Caminho
`padra_atualizado/fontes/editorRelatorios/untInterfaceRelatorio.pas`

## Comportamento (escopo relevante à rotina)
- **Pasta de saída:** quando `CADREL.REL_PASSAI='S'`, cria um filtro de pasta (`FIndexPasta`, row `PASTA_REL`). O valor é lido por `fPastaSaida` e passado a `fExecutaRelatorio`.
- **Botão "..." do filtro de pasta** (`pButtonClickDirectory`): abre `SelectDirectory('', '', strLocalDir, [sdNewUI, sdShowEdit], nil)` — o "Browse For Folder" do shell (janela padrão). É a UX de seleção de pasta de referência da rotina.
- **Caption do filtro por destino** (`Case fRetDestino`): `desTXT`, `desXML` e (novo) `desArquivoSaida` recebem caption com `*` (obrigatório).
- **Validação** (`fValidaDado`): pasta é obrigatória quando `fRetDestino In [desTXT, desXML, desArquivoSaida]`; e deve existir (diretório) quando `In [desTXT, desXML, desPDF, desCSV, desArquivoSaida]`.
- **Mapeamento** `fDestinoToTipo(strDescricao): TDestinoRel` — converte o rótulo de `ArrDestino` de volta ao enum (usado com `CADREL.REL_DESTIN`).

## Métodos (relevantes)
| Método | Tipo | O que faz |
|---|---|---|
| `fPastaSaida: String` | função | Lê o valor do filtro de pasta (`FIndexPasta`) |
| `pButtonClickDirectory(Sender, AButtonIndex)` | proc | Abre o "Browse For Folder" e grava no filtro |
| `pSetaParDirectory(intIndice)` | proc | Configura a row como editor com botão "..." |
| `fValidaDado(intIndex): Boolean` | função | Valida obrigatoriedade/existência da pasta por destino |
| `fDestinoToTipo(strDescricao): TDestinoRel` | class func | Rótulo → enum |
| `fExecutaRelatorio(...)` (wrapper) | função | Chama `FGeraFr3.fExecutaRelatorio(..., fPastaSaida, fRetDestino, ...)` |

## Tabelas
Executa o `REL_DEFSQL` do relatório (resultado em `qryDados`); lê `CADREL` via `FCadRel`.

## Pontos de atenção
- Para um novo destino de arquivo, incluí-lo nos conjuntos de `fValidaDado` (obrigatoriedade + existência) e, se quiser caption próprio, no `Case fRetDestino` da montagem do filtro.
- A UX de seleção de pasta correta é a variação **`SelectDirectory(Caption, Root, var Dir, [sdNewUI, sdShowEdit], Parent)`** (shell moderno) — não a variação antiga `SelectDirectory(var Dir, [sdAllowCreate...], HelpCtx)` (janela pequena/legada).

## Alterações documentadas
| Data | Requisito/Revisão | O que mudou |
|---|---|---|
| 2026-09-10 | Req. 459921 | `desArquivoSaida` incluído na validação de pasta (`fValidaDado`), no caption do filtro e na mensagem de preparação de dados |
