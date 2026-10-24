# Especificação — Req. 459921

**Título:** Novo tipo de saída de relatório "Arquivo Saída"
**Objetivo:** Criar um tipo de saída no editor de relatórios que, a partir de um SELECT com colunas de nome e conteúdo, grave um arquivo por registro do resultado.
**Zona:** Legado
**Data:** 2026-09-09

## 1. Contexto / problema atual

O editor de relatórios dinâmicos (REL_DEFSQL, `padra_atualizado/fontes/editorRelatorios/`) oferece hoje os tipos de saída CSV, TXT, PDF, XML, Excel, e-Mail, Vídeo, Impressora, Grid, gráficos e dashboards (enum `TDestinoRel` em `untFuncEditorRel.pas`). Todos esses tipos aplicam pré-processamento/formatação sobre o resultado.

Falta uma saída simples e genérica que apenas **materialize cada linha do resultado como um arquivo em disco** — o nome do arquivo em uma coluna, o conteúdo em outra. O caso motivador (solicitante Nogueira/Compras, ticket Zendesk 1638535) é exportar em lote os XML de NF-e emitidas (tabela `XMLNFE`), mas a necessidade é genérica: qualquer conteúdo textual gravável em arquivo.

## 2. Módulos e entidades envolvidos

- Módulo: editor de relatórios (`editorRelatorios` / DLL `libEditorRelatorios`).
- Units/serviços:
  - `padra_atualizado/fontes/editorRelatorios/untFuncEditorRel.pas` — enum `TDestinoRel` + `ArrDestino`
  - `padra_atualizado/fontes/editorRelatorios/untGeraArquivoSaida.pas` — **nova** unit geradora
  - `padra_atualizado/fontes/editorRelatorios/untGeraFR3.pas` — despacho de destino / execução
  - `padra_atualizado/fontes/editorRelatorios/untInterfaceRelatorio.pas` — validação de pasta de saída
  - `padra_atualizado/fontes/editorRelatorios/untCadRelatorios.pas` / `.dfm` — cadastro do relatório
  - `padra_atualizado/fontes/editorRelatorios/libEditorRelatorios.dpr` — cláusula `uses`
- Tabelas/entidades:
  - `CADREL` (cadastro de relatórios) — chave primária `REL_CODREL`. Recebe **duas colunas novas**: `REL_ENCARQ` (encoding do arquivo) e `REL_SANARQ` (flag sanitizar nome). Campo existente `REL_DESTIN` armazena, por nome, os destinos habilitados.
  - Resultado do SELECT do relatório — deve expor as colunas `ARQUIVO_NOME` e `ARQUIVO_CONTEUDO`.

## 3. Requisitos funcionais

- **RF01** — Disponibilizar o novo destino "Arquivo Saída" no cadastro de relatórios (checklist `cklDestin`), gravado em `REL_DESTIN` como os demais destinos.
- **RF02** — Na execução, quando o destino escolhido for "Arquivo Saída", iterar o resultado do relatório e gravar **um arquivo por registro**: nome = coluna `ARQUIVO_NOME`, conteúdo = coluna `ARQUIVO_CONTEUDO`.
- **RF03** — A ausência de qualquer das colunas obrigatórias (`ARQUIVO_NOME`, `ARQUIVO_CONTEUDO`) no resultado deve interromper a geração com mensagem clara. Demais colunas do SELECT são ignoradas.
- **RF04** — O encoding de gravação é configurável por relatório via nova coluna `REL_ENCARQ`, escolhido em combobox no cadastro. Opções: UTF-8 (padrão), UTF-8 com BOM, ANSI (Windows-1252), UTF-16 LE.
- **RF05** — Flag `REL_SANARQ` no cadastro (checkbox): quando ligada, sanitiza o nome do arquivo removendo caracteres inválidos para o sistema de arquivos.
- **RF06** — Definição da pasta de destino:
  - Se `REL_PASSAI='S'` (flag "Pedir pasta de saída"), usa o caminho informado no filtro, como já ocorre para CSV/TXT/XML.
  - Se `REL_PASSAI='N'`, o sistema solicita a pasta na tela **antes de gerar** (espelhando o comportamento da saída PDF).
- **RF07** — Progresso arquivo-a-arquivo no `frmGravando`: a barra avança a cada arquivo (1 registro = 1 arquivo) e o rótulo exibe o nome do arquivo sendo gravado.
- **RF08** — Ao término, exibir mensagem com a contagem: "N arquivo(s) gerado(s) com sucesso"; linhas puladas (nome vazio) reportadas.
- **RF09** — Se o SELECT não retornar registros, exibir aviso e não gerar nada.

## 4. Regras de negócio

- **RN01** — Colunas obrigatórias do resultado: `ARQUIVO_NOME` e `ARQUIVO_CONTEUDO`. Se faltar qualquer uma → erro, nenhuma geração.
- **RN02** — Modo de gravação definido por `REL_ENCARQ`:
  - `UTF-8` (padrão) — texto, sem BOM
  - `UTF-8 BOM` — texto com BOM
  - `ANSI` — texto Windows-1252
  - `UTF-16 LE` — texto com BOM
  - `Base64` — o conteúdo de `ARQUIVO_CONTEUDO` é **texto base64** que a rotina **decodifica para binário** e grava cru (ignora encoding/BOM). Usar para arquivos binários (ex.: PDF armazenado em base64). O SELECT deve devolver o base64 como texto — **não** aplicar `FROM_BASE64` no SQL (isso devolve binário que é corrompido na leitura).
- **RN03** — Sanitização (`REL_SANARQ='S'`): remover do nome os caracteres inválidos (`\ / : * ? " < > |` e controles). Com `REL_SANARQ='N'`, o nome é usado como veio (erro do SO caso inválido).
- **RN04** — Arquivo existente é **sempre sobrescrito**.
- **RN05** — Registro com `ARQUIVO_NOME` vazio (após trim/sanitização) é **pulado** e contabilizado para o relatório final; não interrompe o lote.
- **RN06** — Pasta de destino: com `REL_PASSAI='S'`, é obrigatória e validada (diretório deve existir), como para TXT/XML; com `REL_PASSAI='N'`, é solicitada na tela — cancelar o seletor aborta a operação sem erro.
- **RN07** — O diretório de destino é criado se não existir (padrão `fCriaDiretorio`, como nas demais saídas de arquivo).

## 5. Requisitos técnicos / não-funcionais

- Encoding de gravação correto e independente do encoding dos fontes Delphi (latin1) — usar `TEncoding` apropriado.
- Conteúdo potencialmente grande (campos LONGTEXT/BLOB, ex.: XML de NF-e) — garantir leitura completa do campo.
- Sem impacto fiscal/financeiro direto (é geração de arquivos a partir de dados já existentes); sem gravação em banco.
- Aderência às travas de pre-commit e ao gate DelphAI (Zona Legado).
- Colunas novas em `CADREL` dependem do processo de atualização de banco da Citel (schema não versionado neste repositório).

## 6. Critérios de aceitação

- [ ] "Arquivo Saída" aparece no checklist de destinos do cadastro e é persistido em `REL_DESTIN`.
- [ ] Com um SELECT contendo `ARQUIVO_NOME`/`ARQUIVO_CONTEUDO`, a execução gera exatamente um arquivo por registro na pasta de destino.
- [ ] Falta de coluna obrigatória interrompe com mensagem clara e não gera arquivos.
- [ ] O encoding gravado corresponde ao escolhido em `REL_ENCARQ` (validável pelos bytes iniciais / BOM).
- [ ] Com `REL_SANARQ='S'`, nomes com caracteres inválidos são gravados sanitizados; com `='N'`, usados como vieram.
- [ ] Arquivo já existente é sobrescrito.
- [ ] Com `REL_PASSAI='N'`, o sistema pede a pasta na tela antes de gerar; cancelar aborta sem erro.
- [ ] `frmGravando` avança por arquivo exibindo o nome; ao fim, mensagem com contagem.
- [ ] SELECT sem registros exibe aviso e não gera nada.

## 7. Fora de escopo

- Cadastro do relatório específico de exportação de XML de NF-e (será cadastrado depois via editor, como dado).
- Conteúdo binário puro (BLOB não-textual): o recurso trata conteúdo como texto com encoding selecionável.
- Compactação (zip) dos arquivos gerados.
- Envio dos arquivos por e-mail/WhatsApp ou a outros destinos.

## 8. Dependências e riscos

- **Dependência:** criação das colunas `REL_ENCARQ` e `REL_SANARQ` em `CADREL` pelo processo de atualização de banco (fora do repositório) antes do uso em produção.
- **Risco:** extensão do enum `TDestinoRel` altera `High(TDestinoRel)` — apenas `ArrDestino` depende do limite (será ajustado); demais conjuntos (`SET_GRAFICO`, `SET_GRAFICO_DASH`) usam membros explícitos.
- **Risco:** divergência entre o encoding escolhido e o encoding real do dado no banco — responsabilidade do cadastrador do relatório.
- **Risco:** leitura de conteúdo muito grande — validar que não há truncamento.
