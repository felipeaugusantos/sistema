# untGeraFR3

## Responsabilidade
Orquestrador de execução/geração do relatório (`TGeraFR3`). Prepara o FastReport, mantém os datasets do resultado e **despacha a geração conforme o destino** escolhido.

## Caminho
`padra_atualizado/fontes/editorRelatorios/untGeraFR3.pas`

## Comportamento (escopo relevante à rotina)
- Propriedades-chave (públicas, consumidas pelos geradores irmãos):
  - `qryDados: TArrDataSet` — resultado do(s) SELECT do relatório.
  - `arrCadRel: TArrQuery` — registro(s) de `CADREL` com a config (`REL_*`).
  - `objInterfaceGera` — referência ao `TInterfaceRelatorio` em uso.
- `fExecutaRelatorio(strIdent, strPasta, desDestino, blnApenasPrincipal, blnExibirMensagem)` é o ponto de entrada da geração:
  - Se `strPasta` vazio → `strPasta := fGetPathSaidaSQL` (variável de sessão `@PATH_SAIDA_PDF`).
  - Prepara/pré-visualiza FR3 apenas para `[desVideo, desDesignReport, desImpressora, desPDF, desEmail]`.
  - Demais destinos vão para `Case desDestino Of`, chamando o gerador específico.

## Tabelas
Indiretas: opera sobre `qryDados` (resultado) e `arrCadRel` (`CADREL`). SQL utilitário: `fGetPathSaidaSQL`/`fGetArqSaidaPDF`/`fGetVariavelBanco` leem variáveis de sessão via `SELECT @VAR`.

## Métodos (relevantes à rotina)
| Método | Tipo | O que faz | Efeito colateral |
|---|---|---|---|
| `fExecutaRelatorio(...)` | função | Despacha a geração por destino | Gera saída, grava log |
| `fExportaArquivoCSV/TXT/XML(strPasta,...)` | função | Cria o gerador respectivo e chama `fGera*` | Grava arquivo(s) |
| `fExportaArquivoSaida(strPasta, blnExibirMensagem)` | função | (novo) Destino "Arquivo Saída" | Grava arquivos |
| `fExportaArquivoPDF` | função (aninhada) | Exporta PDF; se sem pasta/arquivo usa `TSaveDialog` | Grava PDF |
| `fGetPathSaidaSQL: String` | função | Lê `@PATH_SAIDA_PDF` | — |
| `fCriaDiretorio(strPasta)` | função | Garante a existência da pasta | Cria diretório |

### fExportaArquivoSaida (novo — detalhe)
- Se `strPasta` vazio → `SelectDirectory('', '', strPasta, [sdNewUI, sdShowEdit], nil)` (mesmo "Browse For Folder" do filtro de pasta); cancelar aborta.
- `fCriaDiretorio(strPasta)`; instancia `TGeraArquivoSaida` em `try/finally`, `objGeraGR3 := Self`.
- Chama `fGeraArquivos`; ao ok exibe "N arquivo(s) gerado(s)..." (usa `intGerados`/`intPulados`) e grava `pGravaLogPaf`.
- Ver [untGeraArquivoSaida](untGeraArquivoSaida.md).

### Case desDestino (trecho)
`desCSV → fExportaArquivoCSV`; `desTXT → fExportaArquivoTXT`; `desXML → fExportaArquivoXML`; `desExcel/desGrid → fMontaGrid`; `desArquivoSaida → fExportaArquivoSaida` (novo); gráficos → `fMontaGrafico`; `desValidacao → fConfirmaExecucao`.

## Padrão frmGravando (compartilhado pelos geradores)
Os geradores (`TGeraCSV/TXT/Saida`) usam o modal `TfrmGravando` (unit genérica `untGravando`):
`pCriarFormularios(TfrmGravando, frmGravando)` → seta `lblGravando.Caption` → `fExecutarAcao := <callback>` (tipo `TFunctionFormGravando = function(pgbProgresso: TcxProgressBar): Boolean Of Object`) → `ShowModal` → lê `blnConfirma` → `pFreeAndNil`. Progresso via `frmGravando.pgbStatus` (`Properties.Max`/`Position`).

## Dependências (uses de implementação — parcial)
`untGeraCSV, untGeraTXT, untGeraXML, untGeraArquivoSaida` (novo), `FileCtrl` (novo, para `SelectDirectory`), `untInterfaceRelatorio`, `untRelatorio`, `untGravando`.

## Pontos de atenção
- Destinos de arquivo (CSV/TXT/XML/Arquivo Saída) **não** entram no ramo de PrepareReport do FR3 — usam os datasets diretamente.
- `strPasta` pode vir de: filtro de pasta (`fPastaSaida`), `@PATH_SAIDA_PDF`, ou (Arquivo Saída) do prompt `SelectDirectory`.

## Alterações documentadas
| Data | Requisito/Revisão | O que mudou |
|---|---|---|
| 2026-09-10 | Req. 459921 | Novo `fExportaArquivoSaida` + ramo `desArquivoSaida` no Case; `uses` de `untGeraArquivoSaida` e `FileCtrl`; prompt de pasta via `SelectDirectory` quando sem pasta |
