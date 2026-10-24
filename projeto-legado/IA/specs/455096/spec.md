# Especificação — Req. 455096

**Título:** Importação da planilha de cotação respondida pelo fornecedor, via REST
**Objetivo:** Receber na Suprimento.Services.API o `.xlsx` que o fornecedor devolveu preenchido, gravar preços e condições na cotação oficial com os mesmos cálculos do autcom, em execução assíncrona com status consultável e notificação na `MENREP`.
**Zona:** Mista — Moderna em `padra_atualizado/Services/`, Legado em `padra_atualizado/fontes/`
**Data:** 2026-09-30
**Requisito de origem:** Wagner Neves, 07/08/2026. Envolvidos: Wagner Neves / Ronaldo

A jornada de investigação, as alternativas descartadas e as medições estão em `record.md`, nesta pasta. Esta spec é o contrato.

## 1. Contexto

O REPOR+ exporta a planilha da cotação pela API (Req. 455094), o fornecedor preenche e devolve. Hoje a volta só existe no autcom desktop, em `TCotacao.pImportaArquivos` (`untCotacao.pas:13844`), que dá `raise` no Linux e depende de COM para ler a planilha. O drawer "Importar planilha" do REPOR+ já existe e está mockado à espera deste endpoint (`quotation_import_supplier_response_modal.dart:21-26`).

**Infraestrutura herdada, não regra:** `SSATSK` + modo `task` + `GET /{idProcessamento}` no formato do Req. 459763, `MENREP` e advisory lock do Req. 454895; abertura da cotação sem tela da exportação do Req. 455094 (`Suprimento.Services.Cotacao.Exportacao.pas:70-110`). O item 2 do requisito ("verificar viabilidade" do status) é resolvido por essa infraestrutura.

**O que o REPOR+ faz com a cotação depois da resposta** decide onde gravar (levantado no fonte do REPOR+, ver `record.md`): tudo que usa preço — comparação, vencedor, geração de pedido, status "respondeu" — lê as tabelas **oficiais**. O `_RES` do REPOR+ é só o wizard de criação, apagado na promoção. E nada no REPOR+ grava preço, `COT_FORMEN` ou `COT_VLRTOT`: a linha de `COTFOR` nasce só com a chave, "o fornecedor preenche depois".

## 2. Entidades

| Tabela | Uso |
|---|---|
| `COTGER` | lida (cotação, empresa, `COT_DTAFIN`); grava `COT_VLRTOT` |
| `COTITE` | lida (`COT_QTDITE`, `COT_GERPED`, `COT_FORESC`); grava **só** `COT_FORMEN` |
| `COTFOR` | grava preços do fornecedor importado |
| `COTCFO` | lida (pertinência, `COT_UTILIZ`); grava `COT_CONPAG`, `COT_DTAENT`, `COT_IMPEXC` |
| `COTGER_RES` | lida — rascunho ativo bloqueia a importação (RN08) |
| `LCKATC` | lida, **nunca gravada** — trava de outra sessão bloqueia a importação (RN14) |
| `SSATSK` | tarefa assíncrona |
| `MENREP` | notificação — a API apenas insere |

## 3. Requisitos funcionais

- **RF01** — `POST /cotacao/importacao/gerar`, headers `Empresa` e `OperadorLogado`, corpo `multipart/form-data` com `arquivo`, `sequencialCotacao` (o `AUTOINCREM` oficial, mesmo id da exportação) e `codFornecedor`. Responde **202** com `idProcessamento`. Multipart é decisão do João (30/09/2026), tomada sabendo que o runner de testes só posta texto — o runner ganha método multipart. Se o spike da seção 8 reprovar multipart no binário Linux, **a decisão volta ao João**; JSON com base64 foi a alternativa discutida.
- **RF02** — O POST valida só o que é barato e responde **4xx sem criar tarefa** se falhar: cotação inexistente ou de outra empresa (404); cotação finalizada, `COT_DTAFIN` preenchido (409) — paridade, o autcom esconde a importação (`untCotacao.pas:3146-3162`); BID encerrado, `COT_LIBBID = 'E'` (409) — paridade, `untCotacao.pas:5339`; fornecedor fora da `COTCFO` da cotação (422); extensão diferente de `.xlsx` ou arquivo sem assinatura ZIP `PK` (415); corpo acima de 5 MiB (413, do próprio DMVC); rascunho ativo, RN08 (409); cotação travada por outra sessão, RN14 (409).
- **RF03** — Aprovado o POST, grava a linha na `SSATSK`, grava o arquivo em disco (RN09) e dispara o filho por `SpawnTask`. Falha ao gravar o arquivo ou ao disparar marca a tarefa como erro e responde 500 — não fica tarefa pendente sem arquivo.
- **RF04** — `GET /cotacao/importacao/{idProcessamento}` devolve status (`PENDENTE`, `PROCESSANDO`, `CONCLUIDO`, `ERRO`) e o resultado da RN12.
- **RF05** — O filho executa, nesta ordem: ler o OOXML (RN01); conferir o cabeçalho (RN02); localizar colunas (RN03); validar todas as linhas (RN04); calcular (RN05, RN06); gravar em transação (RN07); notificar (RN13).
- **RF06** — Registrar o método no worker com despacho pelo filho, conforme `IA/rules/services-workers.md`: sobrecarga tipada via `fExecuteTask` **e** `AddMethod`.

## 4. Regras de negócio

- **RN01 — Leitor OOXML próprio, e não espelho do escritor.** Unit nova em `padra_atualizado/fontes/genericos/`, ao lado de `untOOXMLWriter.pas`, com `System.Zip`, sem Excel, LibreOffice ou biblioteca externa. Entrada: stream. Saída: grade de células com texto e tipo (*número*, *texto*, *vazia*). Não conhece cotação.

  O arquivo que volta é o que o programa **do fornecedor** regravou, não o que exportamos — medido por round-trip no LibreOffice (`record.md`): 6 partes viram 10, e as 80 células `inlineStr` viram 80 referências a `xl/sharedStrings.xml`. Escopo mínimo: localizar a primeira planilha por `xl/workbook.xml` + `xl/_rels/workbook.xml.rels`, sem presumir `sheet1.xml`; `sharedStrings`, `inlineStr` e valor direto; referência `B12` → coordenada, tolerando linha e célula ausentes; data como serial; número em formato invariante. Fórmula: lê o valor em cache. Múltiplas planilhas: só a primeira. `.xls` BIFF: recusado no POST.

- **RN02 — Conferência do conteúdo contra o request.** O cabeçalho exportado traz `COTAÇÃO DE PREÇOS: <numcot>`, `CNPJ : <cnpj>` e `Fornecedor: <nome>` (`fExportarExcelNovoPrg`, `untCotacao.pas:14853-14866`). Número da cotação divergente do `COT_NUMCOT` do `sequencialCotacao`, ou CNPJ divergente da empresa da cotação: **erro do arquivo**. Nome do fornecedor divergente do `NOMFOR`: **aviso** — nome muda no cadastro depois da exportação. Rótulo ausente conta como divergente. O nome do arquivo é ignorado.

  Não é paridade: o autcom não confere nada disso. Ele **monta** o nome esperado a partir da cotação aberta e de cada fornecedor dela e procura com `FileExists` (`untCotacao.pas:13950-13964`); o equivalente disso na API é o request.

- **RN03 — Localização por célula inteira.** Comparação com a célula completa, sem espaços nas pontas, sem diferenciar caixa — e não por `Pos` na linha CSV, como o autcom (`untTValidaExcel.pas:516-580`), em que `Código` casaria dentro de `Código Fábrica`.
  - Linha de títulos: a primeira com uma célula igual a `Código`.
  - Obrigatórias: `Código`, `Preço Unit.`, `% I.P.I.`, `% Frete`, `%Subs.`; e `%Crédito ICMS` se `CRICCO` ligada.
  - Opcionais: `Divisor`, `Observação do Fornecedor`.
  - Rótulos do cabeçalho, valor na célula à direita: `CONDIÇÃO DE PAGAMENTO:`, `DATA DE ENTREGA:`. Rótulos com valor na própria célula, por prefixo: `COTAÇÃO DE PREÇOS:`, `CNPJ :`, `Fornecedor:`.

  Os textos são as constantes `TIT_*`, movidas de `untCotacao.pas` para `untCotacaoTypesAndConst.pas` na Tarefa 7 — a exportação e a importação leem a mesma constante, inclusive os rótulos `TIT_COTACAO`, `TIT_CNPJ` e `TIT_FORNECEDOR`, antes literais em `fExportarExcelNovoPrg`. A leitura das linhas para no rodapé `TIT_TOTAL_GERAL` que a exportação grava na coluna `Código`.

- **RN04 — Tudo ou nada por arquivo; linha com conteúdo estranho segue o autcom.** Tudo é lido e verificado antes de qualquer gravação. Erro — que só existe no nível do arquivo — não grava nada e a tarefa termina `ERRO`. Diverge de propósito do autcom, que importa parcial e marca `COT_IMPEXC='S'` mesmo com erro (`untCotacao.pas:14093-14096`).

  **Na linha, o efeito é o do autcom**, decidido pelo João em 30/09/2026, depois de uma primeira versão desta spec transformar quatro desses casos em erro. O que a API acrescenta é só o **aviso** no resultado, onde o autcom se cala: não bloqueia e não muda o que é gravado.

  | Situação | Efeito (paridade) | Na API |
  |---|---|---|
  | coluna obrigatória ausente | layout inválido | **erro do arquivo**, nomeando as ausentes |
  | `Código` vazio | linha ignorada | — |
  | preço, IPI, frete, ST ou crédito vazio | 0 — "não cotou" | — |
  | valor ilegível | 0 — `fStrToFloat` é `StrToFloatDef` com padrão 0 (`untFuncoesSimples.pas:6137-6140`) | aviso |
  | valor negativo | gravado como veio — não há validação de faixa | aviso |
  | código repetido na planilha | cada linha aplica por cima da anterior; vence a última | aviso |
  | código fora da cotação do fornecedor | linha ignorada (`pAtualizaUnitarioItemfornecedor` sai no `fFindItemForncedor`) | aviso |
  | data de entrega vazia ou ilegível | mantém a atual (`StrToDateDef(..., 0) > 0`, `untCotacao.pas:13927-13928`) | aviso só se ilegível |
  | condição de pagamento vazia ou inválida por `fValidaCndPag` | mantém a atual (`:13930-13931`) | aviso só se inválida |

  Leitura de número: célula numérica em formato invariante, **sem** passar por `fStrToFloat` — ele tira todo `.`, e `12.5` viraria `125`. Célula de texto em pt-BR, como o autcom: tira `.` e converte com `fStrToFloat`. O processo roda com `FormatSettings` pt-BR (seção 8). Código com menos dígitos que `fTamCodIte` é completado com zeros à esquerda (paridade, `untCotacao.pas:14044-14045`). Condição de pagamento passa por `fRemoveCaracteres(..., '().')` antes de validar (paridade).

- **RN05 — Cálculo por item: o motor da `TCotacao`, sem cópia.** Abrir a cotação como `pAbrirCotacao` da exportação (oficiais, `strSeqGerBKP` vazio) e, por linha válida, chamar `pAtualizaUnitarioItemfornecedor` com `FImportandoFornecedor = True`. Isso dá, por construção: crédito ICMS > 0 zera ST; divisor ausente mantém o atual e ≤ 0 vira 1; `DIVUNI`; `UNITOT` por `fCalculaPrecoImp` nas variantes de `FRMCUS`; `COT_IMPPLA`; observação. Não chamar `fSelecionaMenoresPrecos` (depende de `TfrmGravando` e grava `FORESC`) nem `fSalvaCotacao` (`raise` no Linux, e regrava a cotação inteira).

  O autcom grava `COT_IMPPLA` com `Now` (`untCotacao.pas:5770`). No caminho da API o valor gravado tem de vir de `fNow()`, trava do pre-commit.

- **RN06 — Menor preço sem tocar no vencedor escolhido.** Rotina nova. Para cada item com linha do fornecedor importado, `GERPED = 'N'` e quantidade > 0: `FORMEN` = fornecedor com `COT_UTILIZ = 'S'` e `PRECOM_FOR > 0` de menor `UNITOT` — o mesmo critério de `fSelecionaMenoresPrecosPrg` (`untCotacao.pas:6390`).
  - **Empate:** mantém o `FORMEN` atual se estiver entre os empatados; senão o menor código de fornecedor. *(regra nova — no autcom o desempate é a ordem do índice em memória)*
  - **`COT_FORESC` nunca é gravado.** Preenchido significa escolha do comprador; nulo **ou vazio** significa "segue o menor preço" — o legado grava `''` (ver RN07). É a semântica que o REPOR+ já usa: vencedor efetivo = `FORESC ?? FORMEN` na comparação (`CotacaoComparacaoServiceImpl.java:114-116`) e no pedido (`CotacaoPedidoGeradorServiceImpl.java:130-132`). O banco não distingue escolha manual de automática — `SELMAN` é calculado em memória (`untCotacao.pas:4094`) —, então gravar `FORESC` congelaria o vencedor no primeiro fornecedor importado.
  - **Item com pedido gerado (`GERPED = 'S'`):** o preço do fornecedor é atualizado (paridade — `pAtualizaUnitarioItemfornecedor` não olha `GERPED`), `FORMEN` fica, e o resultado leva aviso.
  - **Fornecedor importado com `COT_UTILIZ = 'N'`:** preços gravados, não concorre ao menor preço, aviso. **Diverge do autcom**, que filtra o fornecedor desativado do dataset (`OCULTAR`) e ignora todas as linhas sem avisar — constatado na Tarefa 10.

- **RN07 — Gravação: uma transação, só o necessário.** `fStartTransaction` / `fCommit` / `fRollBack`, SQL com `ParamByName`, sob `GET_LOCK` por cotação — duas importações da mesma cotação, do mesmo fornecedor ou não, recalculam `FORMEN` e `VLRTOT` dos mesmos itens. A segunda **espera** até 600 s (o comprador importa fornecedores em sequência); esgotado o prazo, a tarefa termina `ERRO` com mensagem de conflito. Não há 409 de "em andamento" no POST.
  1. Reconferir a RN08 e a RN14. Rascunho ativo ou trava de outra sessão → rollback, tarefa `ERRO`.
  2. `UPDATE COTFOR` só nas linhas do fornecedor presentes na planilha: `COT_VALUNI`, `COT_IPIENT`, `COT_FREENT`, `COT_SUBSTI`, `COT_CREICM`, `COT_DIVISO`, `COT_UNITOT`, `COT_OBSITE`, `COT_IMPPLA`. Mapeamento dataset → coluna em `untCotacao.pas:4359-4384`. Linhas ausentes da planilha ficam intocadas (paridade).
  3. `UPDATE COTITE SET COT_FORMEN` nos itens da RN06.
  4. `UPDATE COTCFO` do fornecedor: `COT_CONPAG` e `COT_DTAENT` se preenchidos, `COT_IMPEXC = 'S'`.
  5. `UPDATE COTGER SET COT_VLRTOT` com a fórmula de `fSQLUpdateVlrTot` (`untCotacao.pas:8080-8160`: variantes de `FRMCUS`, crédito ICMS, `blnMulCot`), trocando o join `F.COT_CODFOR = I.COT_FORESC` por `F.COT_CODFOR = COALESCE(NULLIF(I.COT_FORESC, ''), I.COT_FORMEN)`. O `NULLIF` é obrigatório: o legado grava `COT_FORESC` como **string vazia**, não NULL (`fSqlUpdateItem`, `untCotacao.pas`; base de dev em 30/09/2026: 8.828 linhas `''` contra 52 NULL) — sem ele o `COALESCE` não troca de coluna. Achado na revisão da Tarefa 4. Sem a troca, com `FORESC` nulo pela RN06, o total somaria só itens escolhidos à mão. Ao salvar no autcom, ele preenche `FORESC` com o mesmo menor preço e recalcula pela fórmula dele — o valor coincide.

- **RN08 — Rascunho ativo bloqueia.** Existindo `COTGER_RES` com `COT_CODEMP` e `COT_NUMCOT` da cotação e `IFNULL(COT_EXCLUI,'N') <> 'S'`, a importação é recusada, com mensagem que nomeia o rascunho e pede para salvar ou descartar no autcom. Motivo: o salvar do autcom faz `UPDATE COTFOR` com o valor **em memória** de cada item × fornecedor (`fSqlUpdateItemFornecedor`, `untCotacao.pas:9150-9171`) e regrava `FORMEN`/`FORESC` (`:9121-9122`) — apagaria a importação sem aviso. Rascunho ativo não prova tela aberta agora (pode ser "salvar para restaurar"), e o custo aceito é o comprador limpar rascunho esquecido. Base de dev em 30/09/2026: 47 rascunhos ativos ligados a cotação oficial.

- **RN14 — Trava da `LCKATC`: ler, nunca pegar.** A chave `COTACAO_<COT_NUMCOT>_<COT_CODEMP>` é usada pelos **dois** clientes: o autcom a grava ao abrir a cotação para alterar (`fLock_Unlock`, `untCotacao.pas:3345-3367`, solta em `:3673`) e o REPOR+ a grava ao entrar no detalhe da cotação não finalizada, com `LCK_ORIGEM = 'REPORMAIS'` e `LCK_CODOPE` = operador, soltando no `dispose` da página ou após 60 s sem heartbeat (`CotacaoLockServiceImpl.java:22,142`; `quotation_list_page.dart:125-135`; `quotation_detail_page.dart:84-90`). O drawer de importação vive nessa tela, então **o pedido chega com a trava presa pelo próprio solicitante** — exigir trava livre recusaria toda importação vinda do REPOR+.

  - Sem trava: importa.
  - Trava com `LCK_ORIGEM = 'REPORMAIS'` e `LCK_CODOPE` igual ao header `OperadorLogado`: importa. A trava do solicitante ainda impede o autcom de abrir a cotação durante a importação.
  - Qualquer outra trava — autcom, ou REPOR+ de outro operador: recusa, nomeando o detentor pelo mesmo texto do autcom (`GetHostLock`).

  **A chave gravada leva o nome da base na frente**: `LCK_CHAACE = '<base>.COTACAO_<numcot>_<codemp>'` — o autcom prefixa em `untFuncoesGenerica.pas:6977-6981` e o REPOR+ em `LockAutcomServiceImpl.java:57,148`. A consulta usa `LCK_CHAACE = CONCAT(DATABASE(), '.', :CHAVE)`; procurar só `COTACAO_...` não acha nenhuma trava.

  Conferida no POST e de novo dentro da transação (RN07). A API não grava na `LCKATC`: a serialização entre importações continua no `GET_LOCK` da RN07.

- **RN09 — Arquivo trafega por disco.** `<binário>/CotacaoImportacao/<idProcessamento>/arquivo.xlsx`, caminho composto por **uma** função que valida o id como numérico — espelho de `TCotacaoExportacaoArquivos.fDiretorioDoProcessamento`. Nunca compor caminho com o nome enviado pelo cliente. `SST_PARAMS` leva só metadados: `sequencialCotacao`, `codigoFornecedor` (o campo multipart se chama `codFornecedor`), nome original (só para mensagem), tamanho, hash. Pai e filho são sempre o mesmo host (`SpawnTask`, `Services.Core.Worker.pas:185-201`). Base64 em `SST_PARAMS` descartado: a `SSATSK` não tem expurgo e `max_allowed_packet` varia por cliente.

- **RN10 — Retenção de 48 h**, registrando o diretório no `TApiCleaner`, como a exportação. Serve para investigar importação contestada.

- **RN11 — Um fornecedor por POST.** O drawer do REPOR+ é aberto por fornecedor.

- **RN12 — Resultado.** Em `SST_RESULT`: `itensAtualizados`, `avisos` e `erros`, cada um `{linha, codigoItem, tipo, mensagem}`; `linha` e `codigoItem` nulos em erro de arquivo (coluna ausente, RN02, arquivo inválido). **Conflito não é erro de arquivo:** rascunho ativo (RN08), trava (RN14) e timeout do lock (RN07), quando detectados dentro da tarefa, terminam `ERRO` com o motivo só em `mensagem` e `erros` vazio — para rascunho e trava, o mesmo texto que o 409 do POST dá (Ruling S, revisão final). Tipos de aviso: `ITEM_FORA_DA_COTACAO`, `ITEM_COM_PEDIDO_GERADO`, `FORNECEDOR_NAO_UTILIZADO`, `NOME_FORNECEDOR_DIVERGENTE`, `VALOR_ILEGIVEL`, `VALOR_NEGATIVO`, `CODIGO_REPETIDO`, `DATA_ENTREGA_ILEGIVEL`, `CONDICAO_PAGAMENTO_INVALIDA`. `erros` só com status `ERRO`, e nesse caso nada foi gravado.

- **RN13 — Notificação.** `MENREP` por `pNotifyFinish`, `MEN_TIPO__ = 'COTACAO'`, `MEN_WORKID` = `idProcessamento`, `MEN_CODOPE` = header `OperadorLogado`, mensagem citando cotação, fornecedor e desfecho ("58 itens importados, 4 avisos" / "Importação recusada: 3 erros").

## 5. Requisitos técnicos

- Units novas na zona Moderna com dot-notation; o leitor OOXML em `fontes/genericos/` segue o estilo do `untOOXMLWriter.pas` vizinho.
- Suprimento.Services.API compilada para Linux; a nova unit do leitor e a de serviço entram pelo `.dpr`.
- Toda query com `fCriaQuery` / `ParamByName`. `fNow()` em todo valor gravado.
- Validar `idProcessamento` como numérico antes de compor caminho ou comando (`IsValidTaskId`).

## 6. Critérios de aceitação

Os casos de teste REST saem desta lista e são escritos por quem implementa (CLAUDE.md, seção Testes). Casos marcados **[manual]** não têm como rodar no runner.

1. Arquivo exportado pela API, preenchido e **salvo no LibreOffice**, importa: preço, IPI, frete, ST, divisor, observação, condição de pagamento e data de entrega gravados; `COT_IMPPLA` preenchido; `COT_IMPEXC = 'S'`.
2. **[manual, bloqueia o fechamento]** O mesmo, com o arquivo **salvo no Excel real** — executado pelo João. Não há Excel na máquina de desenvolvimento; só o LibreOffice foi medido.
3. `COT_UNITOT` igual ao que o autcom grava para a mesma entrada, nas variantes de `FRMCUS` e com `CRICCO` ligada e desligada; crédito ICMS > 0 zera ST.
4. `COT_FORMEN` recalculado pelo menor `UNITOT`; `COT_FORESC` intocado em todos os itens; item com escolha manual continua com ela.
5. `COT_VLRTOT` pelo vencedor efetivo, com item sem `FORESC` entrando pelo `FORMEN`.
6. Empate de `UNITOT`: mantém `FORMEN` atual; sem ele entre os empatados, menor código.
7. Coluna obrigatória ausente recusa o arquivo inteiro, nomeando as colunas, **sem nenhuma alteração** em `COTFOR`, `COTITE`, `COTCFO` e `COTGER`.
7a. Valor ilegível grava 0, valor negativo grava como veio, código repetido fica com a última linha, data ilegível e condição de pagamento inválida mantêm o valor atual — todos concluem a importação, cada um com seu aviso e a linha no resultado.
8. Item fora da cotação do fornecedor, item com `GERPED = 'S'` e fornecedor com `COT_UTILIZ = 'N'` geram o aviso correspondente e a importação conclui.
9. Número da cotação ou CNPJ divergente recusa; nome do fornecedor divergente só avisa.
10a. Trava da `LCKATC` do autcom, ou do REPOR+ de outro operador: 409 no POST nomeando o detentor. Trava do REPOR+ do mesmo `OperadorLogado`: importa.
10. Rascunho ativo: 409 no POST. **[manual]** Rascunho criado entre o POST e a execução: tarefa `ERRO`, nada gravado.
11. Cotação inexistente ou de outra empresa (404), finalizada (409), BID encerrado (409), fornecedor fora da cotação (422), `.xls` e arquivo não-ZIP (415), sem criar linha na `SSATSK`.
12. Colunas reordenadas pelo fornecedor ainda importam; célula numérica e célula de texto `12,50` leem o mesmo valor.
13. `GET` de id inexistente responde 404; conclusão gera `MENREP` com `MEN_WORKID` e `MEN_CODOPE` corretos.
14. Duas importações simultâneas da mesma cotação serializam, e o `FORMEN` final reflete as duas.

## 7. Fora de escopo

1. **REPOR+** (avisar a equipe): o vencedor efetivo é `FORESC != null ? FORESC : FORMEN` (`CotacaoComparacaoServiceImpl.java:114`, `CotacaoPedidoGeradorServiceImpl.java:130`, `CotacaoPedidoServiceImpl.java:176`), mas o autcom grava `COT_FORESC = ''` — em item assim o REPOR+ elege o fornecedor vazio, sem `NULLIF`/`isEmpty`; tela "Valor do item" lê só `FORESC` e fica vazia para item sem escolha manual (`CotacaoCadastroServiceImpl.java:389-392`); `PUT /api/cotacao/{id}` apaga e recria `COTFOR` sem preço e apagaria a importação (`:125-137`); o drawer mockado; exibição do resultado da RN12.
2. **Defeitos do autcom** listados em `record.md` — entre eles, a importação desktop procura `.xls` e não acha o `.xlsx` que a API exporta.
3. Vários fornecedores num POST.
4. Identificador próprio embutido na exportação (`docProps/custom.xml`) — mexeria no 455094, e não se provou que sobrevive ao round-trip.
5. Preço de venda por margem (`pRecalculaPrecoDeVendaMargem`) — no autcom só roda quando `FORESC` muda, e aqui ele não muda.
6. Multiloja (`PCDCOT`) — o REPOR+ não faz cotação multiloja (memória `autpas-repormais-fonte-e-limites`).

## 8. Dependências e riscos

| Risco | Tratamento |
|---|---|
| ~~Multipart no binário Linux sem precedente~~ | **Resolvido pelo spike de 30/09/2026** (`record.md`): `Web.ReqMulti` já está no `.dpr`, arquivo binário de 4 MB chega íntegro. Teto de corpo de **5 MiB** do DMVC para a API inteira (`api.core.webmodule.pas:68-69`), com 413 antes do controller; uma cotação de 30 mil itens dá ~0,4 MB |
| Excel real regrava diferente do LibreOffice | Critério 2, manual, bloqueante |
| `TCotacao` carrega a cotação inteira em memória — segundos para 30 mil itens | Aceito: a tarefa é assíncrona |
| Tela aberta no autcom antes de existir `COTGER_RES` | Coberto pela RN14: o autcom trava a `LCKATC` ao abrir para alterar, antes de carregar |
| Usuário fecha a aba do REPOR+ com a importação em andamento: a trava dele cai (`SseEmitter.onCompletion`) e o autcom passa a conseguir abrir | Reconferência da RN14 dentro da transação reduz a janela; não a elimina. Aceito |
| Abrir a cotação no autcom preenche `FORESC` com o menor preço, e o REPOR+ passa a lê-lo como escolha manual | Preexistente, independe deste requisito |
| Travessia de diretório | RN09: caminho só a partir do id validado |
| ~~`fStrToFloat` e `StrToDateDef` dependem de `FormatSettings` no Linux~~ | **Resolvido em 30/09/2026:** `FormatSettings_ptBR` (`Services.Core.Settings.pas:2361`) é chamado no `.dpr` antes do despacho por `ParamStr(1)` (`SuprimentoServicesAPI.dpr:1013`), então o modo `task` roda em pt-BR |
