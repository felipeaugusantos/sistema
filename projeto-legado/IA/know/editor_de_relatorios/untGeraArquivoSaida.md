# untGeraArquivoSaida

## Responsabilidade
Gerar a saída do destino **"Arquivo Saída"**: grava um arquivo por registro do resultado do relatório, usando `ARQUIVO_NOME` como nome e `ARQUIVO_CONTEUDO` como conteúdo.

## Caminho
`padra_atualizado/fontes/editorRelatorios/untGeraArquivoSaida.pas` (unit nova — Req. 459921)

## Comportamento
- Instanciada por `TGeraFR3.fExportaArquivoSaida` (ver [untGeraFR3](untGeraFR3.md)) recebendo `objGeraGR3 := Self`.
- Usa os datasets já abertos do `TGeraFR3`: `qryDados[0]` (resultado do SELECT principal) e `arrCadRel[0]` (config do relatório em `CADREL`).
- Roda o laço dentro do modal de progresso `TfrmGravando` (padrão `fExecutarAcao`), atualizando a barra e o rótulo **arquivo a arquivo**.
- Não abre transação de banco (apenas lê datasets e grava arquivos em disco).

## Configurações que impactam esta unit
| Campo CADREL | Efeito |
|---|---|
| `REL_ENCARQ` | Modo de gravação: `UTF-8` (padrão, sem BOM), `UTF-8 BOM`, `ANSI` (Windows-1252), `UTF-16` (LE, com BOM) ou `Base64` (decodifica base64 → binário cru, ignora encoding/BOM) |
| `REL_SANARQ` | 'S' remove do nome os caracteres inválidos de arquivo |

## Tabelas
Nenhuma leitura/gravação SQL direta. Lê `qryDados[0]` (resultado) e `arrCadRel[0]` (config), ambos já providos por `TGeraFR3`.

## Métodos
| Método | Tipo | O que faz | Efeito colateral |
|---|---|---|---|
| `fGeraArquivos(strPasta): Boolean` | público | Shell: normaliza pasta, zera contadores, cria `TfrmGravando`, seta `fExecutarAcao := fGeraArquivo`, `ShowModal`, retorna `blnConfirma` | Cria/exibe modal |
| `fGeraArquivo(Progress): Boolean` | privado (callback) | Valida colunas obrigatórias, itera `qryDados[0]`, grava cada registro | Grava arquivos, atualiza progresso |
| `fSanitizaNome(AstrNome): String` | privado | Remove `\ / : * ? " < > \|` e caracteres < #32; aplica `Trim` | — |
| `fRetEncoding: TEncoding` | privado | Mapeia `REL_ENCARQ` → `TEncoding` (ANSI→`TEncoding.ANSI`, UTF-16→`Unicode`, senão `UTF8`) | — |
| `fGravaBOM: Boolean` | privado | Verdadeiro para `UTF-8 BOM` e `UTF-16` | — |
| `fEhBase64: Boolean` | privado | Verdadeiro quando `REL_ENCARQ='Base64'` | — |
| `pGravaArquivo(AstrCaminho, AstrConteudo)` | privado | Grava o arquivo (sobrescreve) | Grava disco |
| `intGerados` / `intPulados` / `intFalhas` | prop. leitura | Contadores para a mensagem final (lidos por `fExportaArquivoSaida`) | — |
| `fResumoErros: String` | função | Lista `nome: mensagem` das falhas por arquivo | — |

### fGeraArquivo (detalhe)
1. Se `Length(qryDados)=0` → mensagem "Relatório não carregado" e sai.
2. Se faltar `ARQUIVO_NOME` **ou** `ARQUIVO_CONTEUDO` (via `FindField`) → mensagem e sai (nenhum arquivo).
3. Se `qryDados[0].IsEmpty` → aviso "Nenhum registro..." e sai.
4. Usa o parâmetro **`Progress`** (= `frmGravando.pgbStatus`, garantido não-nil): `Max := RecordCount`; itera do primeiro ao último.
5. Por registro: lê nome (Trim) e conteúdo; sanitiza se `REL_SANARQ='S'`; se nome vazio → `Inc(intPulados)`; senão atualiza o rótulo via `pInformacao(..., Progress)`, grava e `Inc(intGerados)`; avança a barra.
6. **Resiliência por item:** a gravação de cada arquivo roda em `try/except`; uma falha (arquivo travado, nome inválido, base64 ruim) faz `Inc(intFalhas)` e registra `nome: mensagem` em `FstlErros`, **sem abortar o lote**. Só erros fora do laço (iteração) caem no `except` externo.

### pGravaArquivo (detalhe)
- Se `fEhBase64`: `arrBytes := TNetEncoding.Base64.DecodeStringToBytes(conteúdo)` (binário cru).
- Senão: `encAtual := fRetEncoding; arrBytes := encAtual.GetBytes(conteúdo)`.
- `TFileStream.Create(caminho, fmCreate)` (sobrescreve) em `try/finally`; se `Assigned(encAtual) And fGravaBOM`, escreve o preâmbulo (BOM) antes dos bytes.

## Tela associada (.dfm)
Não tem. As opções (`REL_ENCARQ`/`REL_SANARQ`) ficam na tela de cadastro — ver [untCadRelatorios](untCadRelatorios.md).

## Pontos de atenção
- **Base64:** o SELECT deve devolver o base64 como **texto** (sem `FROM_BASE64`); a decodificação para binário é feita aqui. `FROM_BASE64` no SQL retorna binário que é corrompido na leitura `AsString`.
- Encoding independente do encoding dos fontes: usa `TEncoding`/`TFileStream` explicitamente.
- Só usa o resultado **principal** (`qryDados[0]`), não trata relatórios complementares/childs.
- `uses` inclui `System.NetEncoding` (Base64) e `Vcl.Forms` (Application.ProcessMessages).

## Pontos de atenção (fixes de code review)
- `fGeraArquivos` cria/libera `frmGravando` em `try/finally` (não vaza o form global em caso de exceção).
- `fGeraArquivo` usa o parâmetro `Progress` e `pInformacao(...)` (desacoplado do global `frmGravando`).
- Falha por arquivo é **não-fatal** (contabilizada em `intFalhas`/`fResumoErros`) — o lote continua; `fExportaArquivoSaida` loga `'N'` e informa as falhas quando `intFalhas > 0` (não loga sucesso falso).
- `fSanitizaNome` também trata **nomes reservados do Windows** (CON, PRN, NUL, COM1-9, LPT1-9 → prefixo `_`) e limita o nome a 200 chars (reduz risco de MAX_PATH).

## Alterações documentadas
| Data | Requisito/Revisão | O que mudou |
|---|---|---|
| 2026-09-10 | Req. 459921 | Criação da unit; suporte a UTF-8/BOM/ANSI/UTF-16, sanitização, progresso arquivo-a-arquivo e modo Base64 (binário) |
| 2026-09-10 | Req. 459921 (code review) | try/finally do form; resiliência por item (`intFalhas`/`fResumoErros`); uso do parâmetro `Progress`; nomes reservados/limite de tamanho no `fSanitizaNome` |
