# Editor de Relatórios

## Objetivo
Motor de relatórios dinâmicos do ERP (também chamado REL_DEFSQL). Permite cadastrar relatórios a partir de um SQL (`REL_DEFSQL`), configurar campos/filtros/parâmetros e **gerar a saída em vários destinos** (Vídeo, Impressora, PDF, CSV, TXT, XML, Excel, e-Mail, Grid, gráficos, dashboards e — a partir do Req. 459921 — **Arquivo Saída**). É a base de todos os relatórios "quick" e customizados do sistema.

## Zona e localização
- Zona: **Legado**
- Módulo/pasta: `padra_atualizado/fontes/editorRelatorios/`
- Compilado: DLL `libEditorRelatorios` (fonte de verdade do que compila: `libEditorRelatorios.dpr`)
- Units principais (com link):
  - [untFuncEditorRel](untFuncEditorRel.md) — tipos base do editor (enum de destinos `TDestinoRel`, `ArrDestino`)
  - [untCadRelatorios](untCadRelatorios.md) — cadastro do relatório (tela `TfrmCadRelatorios`)
  - [untInterfaceRelatorio](untInterfaceRelatorio.md) — filtros/parâmetros em runtime, pasta de saída, validações
  - [untGeraFR3](untGeraFR3.md) — orquestrador de execução/geração (`TGeraFR3`), despacho por destino
  - [untGeraArquivoSaida](untGeraArquivoSaida.md) — gerador do destino "Arquivo Saída" (novo)
  - Geradores irmãos (mesmo padrão): `untGeraCSV`, `untGeraTXT`, `untGeraXML`, `untGeraExcelRelatorio`

## Telas
| Tela (form) | Unit | Função |
|---|---|---|
| `TfrmCadRelatorios` | untCadRelatorios | Cadastro do relatório: SQL, campos, filtros, parâmetros, destinos permitidos e opções por destino |
| `TfrmPedeDestinoRel` | untPedeDestinoRel | Em runtime, pede qual destino usar (entre os permitidos em `REL_DESTIN`) |
| `TfrmGravando` | untGravando (genérica) | Modal de progresso usado pelos geradores de arquivo |

## Fluxo principal
1. No cadastro (`TfrmCadRelatorios`), o usuário define o SQL e marca os **destinos permitidos** no checklist `cklDestin`. Os marcados são gravados em `CADREL.REL_DESTIN` (texto, um rótulo por linha) por `pDestinosToCampo`.
2. Ao executar o relatório, os filtros/parâmetros são montados por `TInterfaceRelatorio`; se houver mais de um destino permitido, `TfrmPedeDestinoRel` pergunta qual usar (`pMontaDestinos` / `fGetDestinoRel`).
3. `TInterfaceRelatorio` abre os dados (SQL executado em `qryDados[]`) e chama `TGeraFR3.fExecutaRelatorio(strIdent, strPasta, desDestino, ...)`.
4. `fExecutaRelatorio` prepara o FR3 apenas para destinos de tela/impressão `[desVideo, desDesignReport, desImpressora, desPDF, desEmail]`; para os demais despacha via `Case desDestino Of` chamando o gerador específico (`fExportaArquivoCSV/TXT/XML/Saida`, `fMontaGrid`, gráficos, etc.).

## Fluxos alternativos e exceções
- **Pasta de saída:** destinos de arquivo (CSV/TXT/XML/PDF/Arquivo Saída) usam uma pasta. Se `CADREL.REL_PASSAI='S'`, é exibido um filtro de pasta na tela de filtros (obrigatório/validado por destino em `fValidaDado`). O botão "..." desse filtro abre o "Browse For Folder" via `SelectDirectory('', '', dir, [sdNewUI, sdShowEdit], nil)` (`pButtonClickDirectory`).
- Em `fExecutaRelatorio`, se `strPasta` chega vazio, tenta `fGetPathSaidaSQL` (variável de sessão `@PATH_SAIDA_PDF`).
- **Arquivo Saída** especificamente: se `REL_PASSAI='N'` e não há pasta, o gerador pede a pasta na tela (mesma chamada `SelectDirectory` do filtro) antes de gerar.
- Erros de geração exibem `pMensagemOk` e gravam log via `pGravaLogPaf`.

## Tabelas envolvidas
| Tabela | Uso (L/G) | Papel na rotina |
|---|---|---|
| `CADREL` | L/G | Cadastro do relatório (SQL, destinos, opções). Campos `REL_*`. Novos: `REL_ENCARQ`, `REL_SANARQ` |
| `AJUREL` | L | Ajuda do editor (variáveis/campos/fórmulas exibidos ao usuário). Novos códigos 000090/000091 documentam `ARQUIVO_NOME`/`ARQUIVO_CONTEUDO` |
| (dinâmico) | L | O resultado do `REL_DEFSQL` de cada relatório vira `qryDados[]` em runtime |

## Configurações (CFGSIS)
| Código | Valores | Efeito na rotina |
|---|---|---|
| `ZOOINI` | inteiro | Zoom inicial do preview FR3 |
| `EDTPDE` | S/N | Embutir fontes no PDF exportado |
| A confirmar | — | Outras `fCfgSis` usadas em `untGeraFR3` não foram mapeadas neste requisito |

> Observação: opções por relatório (não CFGSIS) ficam em `CADREL.REL_*` — ver por-unit.

## Campos de CADREL relevantes (parcial)
| Campo | Efeito |
|---|---|
| `REL_DESTIN` | Lista de destinos permitidos (texto, por rótulo de `ArrDestino`) |
| `REL_PASSAI` | 'S' exibe o filtro "Pedir pasta de saída" na tela de filtros |
| `REL_ENCARQ` | (novo) Codificação/modo do destino Arquivo Saída: `UTF-8` / `UTF-8 BOM` / `ANSI` / `UTF-16` / `Base64` |
| `REL_SANARQ` | (novo) 'S'/'N' — sanitizar o nome do arquivo (destino Arquivo Saída) |

## Integrações e dependências
- `untGravando` (genérica) — modal de progresso `TfrmGravando`.
- FastReport (`frxClass`) para os destinos de tela/impressão/PDF.
- `Vcl.FileCtrl.SelectDirectory` para seleção de pasta.
- `System.NetEncoding` para Base64 (destino Arquivo Saída).

## Regras de negócio conhecidas
1. Destinos são persistidos por **rótulo** (`ArrDestino`) em `REL_DESTIN`, não por ordinal — a ordem do enum pode mudar sem quebrar dados.
2. Destino **Arquivo Saída** grava **1 arquivo por registro** do resultado; exige as colunas `ARQUIVO_NOME` e `ARQUIVO_CONTEUDO` no SELECT.
3. `Base64`: o conteúdo é texto base64 decodificado para binário na rotina — **não** usar `FROM_BASE64` no SQL (retorna binário que é corrompido na leitura como texto).

## Pontos de atenção
- Extensão do enum `TDestinoRel` afeta o limite do array `ArrDestino` (mesmo limite superior) — ver [untFuncEditorRel](untFuncEditorRel.md).
- Componentes publicados adicionados à mão no `.dfm` exigem declarar os campos na classe do form no `.pas` (o IDE sincroniza ao abrir; em edição fora da IDE é manual).
- Fontes em latin1/Windows-1252 (CRLF); `.md`/`.sql` do editor em UTF-8.

## Histórico de alterações documentadas
| Data | Requisito/Revisão | Resumo |
|---|---|---|
| 2026-09-10 | Req. 459921 (alterações locais) | Novo destino "Arquivo Saída" (1 arquivo por registro), campos `REL_ENCARQ`/`REL_SANARQ`, suporte a Base64, prompt de pasta padrão, ajuda AJUREL |
