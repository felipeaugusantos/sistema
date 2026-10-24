# Req. 455096 — retrospectiva

Documento único do requisito, consolidado entre sessões. O contrato vai para `spec.md` quando existir;
aqui fica a jornada.

**Requisito de origem:** Wagner Neves, 07/08/2026. Envolvidos: Wagner Neves / Ronaldo.
Importar, pela Suprimento.Services.API, o template de cotação preenchido pelo fornecedor, aplicando os
mesmos cálculos do autcom; status consultável por identificador (viabilidade a verificar); notificação
na `MENREP` ao terminar.

---

## 30/09/2026 — ponto de partida

- **Classificado como arquitetural** (brainstorming do superpowers): endpoint novo, leitor de planilha
  novo em Linux e escrita em tabela de cotação. Caminho: spec escrita → plano.
- **Base:** Req. 455094 (exportação — é o caminho de ida desta mesma planilha) e Req. 454895 (giro
  assíncrono, `SSATSK`, `MENREP`, advisory lock). O item 2 do requisito ("verificar viabilidade" da tabela
  de status) **já está resolvido pela infraestrutura desses dois**: `SSATSK` + `GET /{idProcessamento}` no
  formato do Req. 459763.
- Levantamento interrompido para ser retomado na cópia `379.48.2.30.74.150`. Nenhuma pergunta foi feita
  ao usuário ainda — a próxima sessão começa pelo *entendimento escrito* do brainstorming.

## Mapeamento da importação do autcom

**Fonte:** leitura feita por subagente na cópia `379.48.2.30.74.150_DESENV` (IA em r496420, fontes da
mesma cópia). Conferido em 30/09 que `pImportaArquivos` (13844) e `pImportarItens` (14543) estão na
mesma linha na `74.150`. **Ainda assim é relato de leitura, não verificação — reabrir o código antes de decidir em cima de qualquer item.** Caminhos relativos a
`padra_atualizado\`; `untCotacao` = `fontes\movimentacaoitens\Cotacao\untCotacao.pas`.

**Entrada.** `TCotacao.pImportaArquivos` (`untCotacao:13844-14152`), botão `btnImpArq` de
`frmCadCotacaoGeralCX`. No Linux, `raise` de "ainda não possui implementação linux". Há uma cópia antiga
em `untCadCotFornecedor.pas:707` (COM direto, só código/preço/IPI/ST). **Não confundir** com
`pImportarItens` / `untImportCotacaoItens.pas`: aquilo importa lista de itens para a cotação, não o
retorno do fornecedor — e a RN17 do 455094 apontou para ele por engano.

**Leitura.** `TValidadorExcel` (`fontes\genericos\untTValidaExcel.pas`) converte `.xls`/`.xlsx` em CSV
via COM — Excel (`Workbooks.Open` + `SaveAs xlCSV`) ou LibreOffice UNO — dentro de `TfrmGravando`, e lê o
CSV por `;`. O COM é o parser. Só a tokenização do CSV (`fGetValueCSV`, `fLocalizaColuna`,
`fLocalizaKeyValue`) é RTL pura. **Não existe leitor de OOXML no projeto**; existe o escritor
(`untOOXMLWriter.pas`, `untGeraExcelXlsx.pas`) do 455094.

**Identificação.** Cotação e fornecedor vêm **só do nome do arquivo**
(`COTACOES\IMPORTAR\COT<numcot>_<codemp>_<codfor>.xls`, pasta ao lado do exe). Nada dentro da planilha é
conferido. Colunas localizadas por **texto do cabeçalho**, não por posição (constantes em
`untCotacao:1213-1224`):
- obrigatórias `Código`, `Preço Unit.`, `% I.P.I.`, `% Frete`, `%Subs.`; mais `%Crédito ICMS` se `CRICCO`;
- opcionais `Divisor`, `Observação do Fornecedor`;
- do bloco de cabeçalho, célula à direita do rótulo: `CONDIÇÃO DE PAGAMENTO:` e `DATA DE ENTREGA:`.

Números em pt-BR (tira `.`, `fStrToFloat`). Crédito ICMS > 0 zera ST. Quantidade, desconto e prazo por
item **não** são lidos.

**Cálculo.** Por item, `pAtualizaUnitarioItemfornecedor` (`:5743`) no `cdsPrecosItemfornecedor` — item
fora da cotação do fornecedor é ignorado calado; `DIVUNI`, `UNITOT` por `fCalculaPrecoImp` /
`pCalculaImpostos` (variante por `FRMCUS`), `DIFCOM`. O `BeforePost` (`:6223`) recalcula totais. Ao fim,
`COT_IMPEXC='S'` no fornecedor e `fSelecionaMenoresPrecos` → `fSelecionaMenoresPrecosPrg` (`:6390`)
escolhe menor preço por item, preenche `FORESC`/`PREESC`/…, recalcula preço de venda por margem e trata
multiloja. Este último roda dentro de `TfrmGravando` modal — mesma armadilha do giro (ver memória
"TfrmGravando é mecanismo de invocação").

**Onde grava — o ponto que mais pesa no desenho.** Durante a importação, **só o rascunho**:
`UPDATE COTFOR_RES` por item (`fIncluiItensFornec_CopiaSeguranca`, `:5801`), sem transação, e **pulado
se `strSeqGerBKP` vazio**. As oficiais (`COTFOR`, `COTCFO` com `COT_CONPAG`/`COT_DTAENT`/`COT_IMPEXC`)
só no salvar do usuário, `fSalvaCotacao` → `fSalvaCotacaoPrg` (`:7382`, `:8183`), em transação — **e os
dois também têm `raise` no Linux**. Não foi achada escrita de cabeçalho em `COTCFO_RES`.

Consequência: "alimentar a tabela de cotação" do requisito precisa ser decidido entre **rascunho**
(como o giro do 454895, que grava `_RES`) ou **oficial** (portar o salvar). O 455094 RN12 registra por
que a API evitou criar `_RES` na exportação — colisão com sessão aberta no autcom. Aqui a escrita é
inevitável, então a pergunta volta com peso maior.

**Erro.** Importação parcial é o comportamento normal, sem rollback. Layout errado ou erro no meio ainda
marcam `COT_IMPEXC='S'` e movem o arquivo para `IMPORTADOS` (`:14093-14096`, fora do try). Não há
validação de faixa (0–100 existe só como validação na planilha exportada).

**Dependência de tela.** Seleção de arquivo modal, barra de progresso do form, `fMensagem`, `TfrmGravando`
em dois pontos, filtros de `cdsDigMultLoja`, caminhos por `Application.ExeName`. Sem UI no corpo, e
portanto candidatos a reuso: `pAtualizaUnitarioItemfornecedor`, `pBeforePostPrecosItemfornecedor`,
`fCalculaPrecoImp`, `pCalculaImpostos`. O jeito de abrir a cotação sem tela já existe em
`Suprimento.Services.Cotacao.Exportacao.pas:70-110`.

**No Services hoje.** Nada de importação. Existe o padrão a copiar: `api.controller.cotacao.pas`
(`/giro/*`, `/exportacao/*`), `Suprimento.Services.Workers.pas` (`LoadMethods`, `pNotifyFinish`),
constantes em `Suprimento.Services.Cotacao.Types.pas:1116-1131`. `untCotacao.pas` já compila no
`SuprimentoServicesAPI.dpr`.

## Achados a confirmar (possíveis defeitos no autcom, fora do escopo)

- O desktop **não importa o arquivo que a API exporta**: a API grava `.xlsx`, o desktop procura `.xls`.
- `untCotacao:14069` lê `Observação do Fornecedor` mesmo quando a coluna não foi achada (índice -1) e
  pode sobrescrever `COT_OBSITE`. Não conferido o que `fGetLetraAlfa(-1)` devolve.
- Progresso refrescado pelo índice do arquivo e não da linha (`:14075`).
- Com `COPLPR` ligado, a exportação Windows parece gravar senha de **abertura** (`SEN_ADM` no terceiro
  argumento do `SaveAs`, `untExcelOfc.pas:337-347`) e a importação não passa senha. Não verificado em
  execução. A API do 455094 sai sem senha de abertura (seção 7 da spec de lá), então não afeta o caminho
  novo.

## Perguntas em aberto para o brainstorming

1. Como o arquivo chega à API: upload pelo REPOR+ (multipart), e quem identifica cotação/fornecedor —
   nome do arquivo, como o autcom, ou campos do request?
2. Grava no rascunho `_RES` ou na oficial? (ver acima)
3. Aceitar só `.xlsx` (o que a API exporta) ou também `.xls` binário que volte do Excel do fornecedor?
   `.xls` BIFF não se lê com `System.Zip` — é outro parser.
4. Roda `fSelecionaMenoresPrecos` (escolha do vencedor + preço de venda) ou só grava preços?
5. Paridade no erro: manter a importação parcial do autcom, ou tudo-ou-nada por arquivo?

## 30/09/2026 — brainstorming, decisões da manhã

- **Entrada:** upload pelo REPOR+, `numCotacao` e `codFornecedor` como campos do request; nome do arquivo
  ignorado. O autcom não "valida" o nome — ele **monta** o nome esperado a partir da cotação aberta e de
  cada fornecedor dela e procura com `FileExists` (`untCotacao:13950-13964`, `:13999-14002`). Arquivo com
  outro nome fica invisível, sem erro. O equivalente do nome, na API, é o contexto da tela — por isso o request.
- **Conferência do conteúdo (A1):** o cabeçalho exportado traz `COTAÇÃO DE PREÇOS: <numcot>`, `CNPJ : <cnpj>`
  e `Fornecedor: <NOMFOR>` (só nome, sem código) — `fExportarExcelNovoPrg`, `untCotacao:14853-14866`.
  Número da cotação e CNPJ divergentes **recusam**; nome do fornecedor divergente e itens fora da cotação
  do fornecedor viram **aviso** no resultado. As células só ficam travadas com `COPLPR` (`:14843`).
  Descartado por ora: identificador em `docProps/custom.xml` gravado pela exportação — mexeria no 455094
  e não foi provado que sobrevive ao round-trip.
- **Formato:** só `.xlsx`. `.xls` BIFF recusado com mensagem.
- **O leitor não é espelho do escritor — medido.** Round-trip de `c:\tmp\espelho_cotacao.xlsx` pelo
  `soffice --convert-to xlsx`: de 6 partes para 10; 80 células `inlineStr` viraram 80 `t="s"` com
  `xl/sharedStrings.xml`; entram `theme1.xml` e `docProps/*`. Escopo mínimo do leitor: localizar a planilha
  por `workbook.xml` + rels, `sharedStrings` + `inlineStr` + valor direto, referência `B12` → coordenada
  com linhas/células ausentes, data serial e número invariante. Fora: fórmula (lê o valor em cache),
  múltiplas planilhas.
- **PENDENTE — TESTE OBRIGATÓRIO NO EXCEL.** Não há Excel na máquina de desenvolvimento; o round-trip só
  foi medido no LibreOffice. O João vai editar um arquivo exportado pelo Excel real e devolver para
  importar. **Não fechar o requisito sem esse caso** — vai para os critérios de aceitação da spec.
- **Onde grava (rascunho `_RES` × oficial): em aberto.** Decisão adiada até levantar como o REPOR+ usa a
  cotação depois da importação (fonte em `C:\Users\joao.catarino\Documents\AUTPAS\ReporMais`).

## 30/09/2026 — como o REPOR+ usa a cotação (levantamento para decidir `_RES` × oficial)

Fonte `C:\Users\joao.catarino\Documents\AUTPAS\ReporMais\citel`, módulo `cotacao`. Leitura por subagente;
os pontos abaixo marcados (✔) foram reabertos no fonte nesta sessão.

- **Rascunho `_RES` no REPOR+ é só o wizard de criação**, antes de existir `COTGER`. Na promoção, apagado
  fisicamente (✔ `CotacaoCadastroServiceImpl.java:506-510`). A listagem faz `UNION ALL` com
  `QTD_RESPOSTAS = 0` fixo no ramo rascunho — nenhuma resposta de fornecedor vive no `_RES`.
- **Tudo o que usa preço lê a oficial** (✔ DTOs de comparação, valor do item, distribuição): `COTFOR`
  (`COT_VALUNI`, `COT_IPIENT`, `COT_SUBSTI`, `COT_FREENT`, `COT_CREICM`, `COT_DIVISO`, `COT_UNITOT`),
  `COTITE.COT_FORMEN` / `COT_FORESC`, `COTGER.COT_VLRTOT`. Status "respondeu" = `COT_VALUNI > 0`.
- **O REPOR+ cria a `COTFOR` só com a chave** — `INSERT INTO COTFOR (COT_SEQGER, COT_CODFOR, COT_CODITE)`,
  "o fornecedor preenche depois" (✔ `:596-604`, `:772`). **Nada no Java grava preço, `COT_FORMEN` nem
  `COT_VLRTOT`** (✔ grep de atribuição vazio). Quem preencher é esta API.
- **Front:** o drawer "Importar planilha" existe e é mock (✔ `quotation_import_supplier_response_modal.dart:21-26`);
  o id passado é o `AUTOINCREM` oficial, apesar do nome `numeroCotacao`.
- **Risco anotado:** `PUT /api/cotacao/{id}` apaga e recria `COTFOR` sem preço (✔ `:125-137`) — apagaria
  preço importado. Não achada chamada no Flutter. Fora do nosso escopo; avisar a equipe REPOR+.
- **Não mapeados no REPOR+:** `COT_IMPEXC`, observação por item, `PCDCOT` (multiloja).
- MENREP: o front faz polling de 60s e mostra toast genérico, sem reação por tipo.

**Recomendação (aguarda confirmação do João): gravar nas oficiais.** O `_RES` do REPOR+ não é sessão de edição de
cotação já enviada; gravar lá deixaria o preço invisível. Colisão com cotação aberta no autcom continua
risco (memória `autpas-cotacao-res-rascunho`) — a tratar no desenho.

**O autcom sobrescreve o vencedor manual na importação** — `fSelecionaMenoresPrecos(..., blnManterEscolhido
= False)` (`untCotacao:14104`); com isso, em `:6511`, todo item com preço tem `FORESC`/`PREESC` trocado pelo
menor preço e `SELMAN := 'N'`, e o preço de venda por margem é recalculado. Pergunta levada ao usuário.
- **Vencedor: opção B escolhida** (preservar escolha manual; recalcular `FORMEN`/`VLRTOT`). Ao detalhar,
  apareceu que o banco **não distingue** escolha manual de automática: `SELMAN` é campo calculado em memória
  (`CAST("N" AS CHAR(1)) AS SELMAN`, `untCotacao:4094`), e o autcom grava `FORESC` = menor preço sozinho.
  No REPOR+, `FORESC` só é gravado pelo `PATCH .../vencedor` (clicar de novo no mesmo zera para `null`,
  `CotacaoVencedorServiceImpl.java:45-48`), e o vencedor efetivo é `FORESC ?? FORMEN` na comparação
  (`CotacaoComparacaoServiceImpl.java:114-116`) e no pedido (`CotacaoPedidoGeradorServiceImpl.java:130-132`).
  Exceção: a tela "Valor do item" usa só `FORESC` (`CotacaoCadastroServiceImpl.java:389-392`).
  Refinamento levado ao usuário.
- **Decidido B1:** a API **nunca grava `COTITE.COT_FORESC`**; recalcula `FORMEN`, menor preço e totais.
  `FORESC` preenchido = escolha do comprador; `null` = segue o menor preço (semântica que o REPOR+ já usa).
  Descartados: B2 (heurística "FORESC = FORMEN anterior" erra quando o comprador escolheu o menor) e B3
  (coluna nova — desproporcional). **Pendência para a equipe REPOR+:** tela "Valor do item" lê só `FORESC`
  e fica vazia para item sem escolha manual. Efeito colateral preexistente: abrir no autcom preenche
  `FORESC` sozinho, e o REPOR+ passa a ler como manual.
- **Decidido A (erro): tudo-ou-nada por arquivo.** Validação completa antes de gravar (cabeçalho A1,
  colunas obrigatórias, números legíveis); reprovou, não grava nada e devolve erros por linha. Item fora da
  cotação do fornecedor não reprova — pulado e listado como aviso. Gravação numa transação. Diverge de
  propósito do autcom, que importa parcial e marca `COT_IMPEXC='S'` mesmo com erro (`untCotacao:14093-14096`).
- **Decidido A (concorrência): recusar** quando existir `COTGER_RES` ativo (`COT_EXCLUI <> 'S'`) com o mesmo
  `COT_CODEMP` + `COT_NUMCOT`; a mensagem nomeia o rascunho. Motivo, verificado: o salvar do autcom faz
  `UPDATE COTFOR` com o valor em memória de cada item × fornecedor (`fSqlUpdateItemFornecedor`,
  `untCotacao:9150-9171`) e `COT_FORMEN`/`COT_FORESC` no item (`:9121-9122`) — apagaria a importação calado.
  Na base de dev (`2_30_BELAT_TC`, 30/09): 2.295 rascunhos, 2.241 excluídos, **47 ativos ligados a oficial**
  (maioria com `COT_DTACAD` 2023/24 — campo pode ser a data da cotação copiada, não do rascunho).
  Rascunho ativo não prova tela aberta agora; pode ser "salvar para restaurar". Custo aceito: comprador
  limpa rascunho esquecido.
- **Decidido A (total): `COT_VLRTOT` pelo vencedor efetivo.** A fórmula do autcom (`fSQLUpdateVlrTot`,
  `untCotacao:8080-8160`, 4 variantes por `cfgfrmCus` + crédito ICMS) faz `INNER JOIN COTFOR ... ON
  F.COT_CODFOR = I.COT_FORESC` — com B1 somaria só itens escolhidos à mão. Mantém a fórmula, troca o join
  por `COALESCE(I.COT_FORESC, I.COT_FORMEN)`, mesma regra do REPOR+. Ao salvar no autcom, ele preenche
  `FORESC` com o mesmo menor preço e recalcula — o valor coincide.
- Menor preço no autcom (`fSelecionaMenoresPrecosPrg`, `:6390`): menor `UNITOT` entre fornecedores ativos
  com `PRECOM_FOR > 0`, itens `GERPED='N'` e `QTDTOT > 0`. **Não lido ainda:** o efeito exato das listas
  `FListaFornecedorDesconsiderar`/`Remarcando` quando o menor não é o fornecedor importado — conferir antes
  da spec.
- **Decidido abordagem 1:** motor da `TCotacao` aberto sem tela como na exportação
  (`Suprimento.Services.Cotacao.Exportacao.pas:70-110`), `pAtualizaUnitarioItemfornecedor` por linha
  (paridade de `DIVUNI`/`UNITOT`/`IMPPLA`/obs/divisor por construção); menor preço por rotina nova que não
  grava `FORESC`; gravação por SQL próprio em transação (só o fornecedor importado + `FORMEN` + `COTCFO` +
  `VLRTOT`). Descartadas: 2 (extrair cálculo para unit pura — mexe em `untCotacao` e as funções leem estado
  da instância) e 3 (fórmula em SQL — terceira cópia).
- **Seção 1 do desenho aprovada** (contrato `POST /cotacao/importacao/gerar` multipart + `GET /{id}`;
  validações baratas no POST com 4xx imediato; worker lê → confere A1 → valida tudo → calcula → reconfere
  rascunho dentro da transação → grava → MENREP). **Risco a provar por spike:** multipart no binário Linux
  (sem precedente nos Services; DMVC repassa `TWebRequest.Files`, `MVCFramework.pas:1676`). Plano B: JSON
  com base64.
- **Transporte do arquivo ao filho: disco**, `<binário>/CotacaoImportacao/<id>/arquivo.xlsx`, caminho por
  função única que valida o id (espelho de `TCotacaoExportacaoArquivos.fDiretorioDoProcessamento`).
  `SST_PARAMS` só com metadados. Retenção 48h no `TApiCleaner`. Base64 em `SST_PARAMS` descartado: SSATSK
  sem expurgo e `max_allowed_packet` por cliente. Pai e filho são sempre o mesmo host (`SpawnTask`,
  `Services.Core.Worker.pas:185-201`).
- **Seção 2 aprovada**, com as quatro regras novas como **erro**: código repetido, data de entrega
  ilegível, condição de pagamento inválida, valor negativo. Localização por célula inteira (trim,
  sem caixa), não por `Pos` na linha.
- **Seção 3 aprovada:** `pAtualizaUnitarioItemfornecedor` com `FImportandoFornecedor=True`; `FORMEN` por
  rotina nova (menor `UNITOT` entre ativos com `PRECOM_FOR>0`, itens `GERPED='N'` e qtd>0); **empate** mantém
  o `FORMEN` atual se empatado, senão menor código de fornecedor; **`GERPED='S'`** atualiza preço, não mexe
  em `FORMEN`, aviso. Transação: reconfere rascunho → `COTFOR` só linhas da planilha → `COTITE.COT_FORMEN`
  → `COTCFO` (`CONPAG`/`DTAENT` se preenchidos, `IMPEXC='S'`) → `COTGER.COT_VLRTOT` com `COALESCE`.
  `GET_LOCK` por cotação serializa importações. **A conferir antes da spec:** mapeamento campo do dataset →
  coluna, e origem de `FFornecedoresAtivos`.
- **Seção 4 aprovada**, com ajuste: casos de teste de endpoint passam a ser escritos por quem implementa
  (programador + Claude Code), sem teste-primeiro — decisão do João em 30/09/2026, registrada no `CLAUDE.md`
  (seção Testes, cópia 74.150). `Contabilidade/` continua com o analista.
- Conferido antes da spec: dataset → coluna (`PRECOM_FOR`=`COT_VALUNI`, `IPI_FOR`, `ST_FOR`, `FRETE_FOR`,
  `CREICM_FOR`; `UNITOT` do dataset é calculado no SELECT, `untCotacao:4359-4384`); `FFornecedoresAtivos` =
  `COT_UTILIZ='S'`, montado em `fCarregaCotacaoPrg` (`:5636-5666`). `spec.md` escrita em 30/09/2026.
- **Revisão da spec pelo João (30/09/2026): RN04 volta à paridade.** As regras novas (negativo, código
  repetido, data ilegível, condição de pagamento inválida) e também "valor ilegível" deixam de ser erro e
  seguem o efeito do autcom — ilegível = 0 porque `fStrToFloat` é `StrToFloatDef(..., 0)`
  (`untFuncoesSimples.pas:6137-6140`). A API só acrescenta aviso no resultado. Erro fica restrito ao arquivo
  (coluna ausente, RN02, RN08). Achado no caminho: `fStrToFloat` e `StrToDateDef` dependem de
  `FormatSettings`, não conferido no Linux — risco na seção 8.
- **Trava `LCKATC` — decidido A (ler, nunca pegar), 30/09/2026.** Achado: o autcom trava `COTACAO_<numcot>_<codemp>`
  na `LCKATC` ao abrir cotação para alterar (`fLock_Unlock`, `untCotacao:3345-3367`, solta `:3673`), e o REPOR+
  usa **a mesma chave** com `LCK_ORIGEM='REPORMAIS'` durante toda a tela de detalhe (`CotacaoLockServiceImpl.java`).
  O subagente havia relatado que a trava do REPOR+ era só em memória — errado. Preocupação do João: a API pegar a
  trava bateria na do próprio REPOR+ que pediu a importação. Regra: livre ou REPOR+ do mesmo `OperadorLogado`
  importa; qualquer outra recusa. RN14 na spec.
- **BID encerrado recusa (409), paridade** — `COT_LIBBID='E'` esconde o botão no autcom (`untCotacao:5339`). Decidido 30/09/2026.
- **Contrato multipart confirmado pelo João (30/09/2026)**, mesmo sabendo que o runner só posta string
  (`api.core.test.utils.pas:529-551`). Consequências para o plano: spike de multipart no binário Linux e
  método novo de POST multipart no runner (Core, compartilhado). Se o spike reprovar, **voltar ao João** —
  a contingência base64 não é mais automática.
- **Arquivos de teste versionados** em `Suprimento.Services.API/Scripts/testes/arquivos/`: um salvo pelo
  LibreOffice (gerado por mim), um salvo pelo Excel real (fornecido pelo João) — o critério 2 vira caso
  automático. Entrega ao binário de teste no Linux: resource embutido (a provar), senão caminho ao lado do
  binário.

## 30/09/2026 — T1: spike de multipart no binário Linux — PASSOU

Rota temporária `POST /cotacao/importacao/spike` na instância subida pelo João via PAServer
(`10.0.0.205:8099`), compilada na r497765. Revertida depois (`svn revert` do controller).

- **Multipart funciona sem mudança de infraestrutura.** `Web.ReqMulti` **já está** no `uses` do
  `SuprimentoServicesAPI.dpr:14` (e dos outros dois `.dpr` de API) — o parser já é registrado.
  `Context.Request.Files` entrega o arquivo; `Context.Request.ContentParam('x')` lê campo de formulário
  multipart. O plano mandava pôr `Web.ReqMulti` no controller: desnecessário.
- **Integridade:** `espelho_cotacao.xlsx` (4.157 bytes) chegou com o mesmo tamanho, `PK` no início e último
  byte igual. Binário aleatório de 4 MB, com bytes > 127 e `0xFE` no fim, idem — nada converte o corpo
  para texto.
- **Teto de 5 MiB, do DMVC, para a API inteira:** acima disso 413 "Request size exceeded the max allowed
  size [5120 KiB]", antes do controller (`api.core.webmodule.pas:68-69`, `DEFAULT_MAX_REQUEST_SIZE`).
  Medido com 5 MB e 12 MB. O limite de 10 MB da spec era impossível; fica o do DMVC.
- **Tamanho real esperado:** planilha sintética de 30 mil itens no formato do nosso escritor = 348 KB;
  depois do round-trip do LibreOffice = 414 KB. Margem de ~12× sobre o teto. As exportações reais no
  share têm 22 linhas e 4 KB.
- No caminho: a cópia estava na r497444 e não compilava — `untPrecoProduto.pas` (r497252, Req. 463837)
  passou a usar `untCalculadoraPrecoCliente`, incluída nos `.dpr` só na r497515. `svn update` para a
  r497765 autorizado pelo João.
- **T2 (prova do resource no Linux) pulada por decisão do João, 30/09/2026.** A prova fica para a primeira
  rodada da suíte; `.rc` e `{$R}` vão na T15. Risco aceito: se o resource não for lido no Linux, a T14
  precisa trocar a origem do arquivo.
- **Revisão da T4 (30/09/2026): `COT_FORESC` é `''`, não NULL, no dado real** — base dev: 8.828 `''`, 52 NULL,
  10.578 preenchidas; o legado monta `COT_FORESC = "' + AFORESC + '"`. O `COALESCE` da RN07 não trocava de
  coluna; virou `COALESCE(NULLIF(I.COT_FORESC,''), I.COT_FORMEN)`. **O REPOR+ tem o mesmo defeito**: testa só
  `!= null` (`CotacaoComparacaoServiceImpl.java:114`, `CotacaoPedidoGeradorServiceImpl.java:130`,
  `CotacaoPedidoServiceImpl.java:176`) e elege fornecedor vazio — pendência para a equipe, spec §7.1.
- **Débito técnico aceito (T9, 30/09/2026):** `Suprimento.Services.Cotacao.Concorrencia.pas` tem agora três classes
  quase idênticas (giro, exportação, importação) — varredura de órfãs, `fEmAndamento`, lock. Mantido pelo
  estilo do arquivo e para não mexer em giro/exportação sem a suíte rodando; candidato a helper parametrizado.

## 30/09/2026 (noite) — execução do plano (subagente por tarefa)

T1 a T17 executadas; cada tarefa passou por revisão própria e houve revisão final do conjunto. Nada foi
commitado nem executado contra a base ou o Linux além do spike da T1. Compila: SuprimentoServicesAPI e os três
projetos de teste.

**Defeitos que as revisões pegaram antes de virar código entregue** — os que valem lembrar:
- `COT_FORESC` é `''`, não NULL (ver acima) — o `NULLIF` no `VLRTOT`.
- Leitor OOXML: amplificação de memória por coluna alta e ZIP bomb pelo bit 3 do cabeçalho local — leitura em
  blocos com teto real (64 MiB/parte, 1 milhão de células).
- Filtro `OCULTAR = 0` deixado pelo `pLimpaMasterPrecos` escondia o fornecedor `COT_UTILIZ='N'`.
- Pré-voo dava 409 "em andamento" contra a spec (critério 14) — passou a serializar com `GET_LOCK` de 600 s.
- Tarefa descartada (falha ao gravar o arquivo) ficava PENDENTE para sempre — o descarte estampa `SST_DTAINI`.
- Limpeza pós-tarefa dos casos não rodava quando o código HTTP divergia — `try/finally` no método de teste.

**Decisões tomadas durante a execução** (as que mudam comportamento ou contrato):
- Fornecedor `COT_UTILIZ='N'`: preços gravados com aviso — **diverge do autcom**, que esconde e ignora calado.
- Leitura para no rodapé `TOTAL GERAL`.
- Conflito (rascunho, trava, timeout do lock) chega só em `mensagem`; constantes de erro mortas removidas (RN12).
- Campo da ocorrência é `codigoItem`.
- Arquivos de teste montados sobre o layout de uma exportação real, mirando a cotação aberta 003426 — não são
  exportação byte a byte da API.
- `VLRTOT` asserido com uma casa: o `SUM` do autcom roda em DOUBLE e oscila 1 centavo com a ordem das linhas.
- Débito aceito: três classes quase idênticas em `Concorrencia.pas`.

**Pendente, e bloqueia o fechamento do requisito:**
1. Compilar o autcom desktop (Seattle) com `untCotacao.pas`, `untCotacaoTypesAndConst.pas`, `untTypesSistema.pas`.
2. Aplicar `004_INFRA_PROCEDURE_IMPORTACAO.sql` (Workbench) e os casos 0060, 0062–0091 (`autcom_db.py`,
   perfil `teste_api`), implantar e rodar a suíte. Primeira prova de que o resource `.xlsx` é lido no Linux.
3. `0002_excel_ok.xlsx` salvo no Excel real (critério 2) → então aplicar o caso 0061 e descomentar o `TestCase`.
4. Possível diferença de 0,01 no `UNITOT` entre Linux e Win32 no meio centavo — derivada à mão, não medida.
5. Avisar a equipe REPOR+ (spec §7.1): `FORESC=''` tratado como escolha; tela "Valor do item"; `PUT` que apaga preço.

**Fora do commit:** `version.inc`, `Services/bin/svn_rev.inc` (carimbo de build), `SuprimentoServicesAPI.deployproj`
e `Services/bin/opcoes.ini` (efeito do PAServer/IDE), `ArquivosTeste.res` e demais `.res`.
- **30/09/2026 22h:** autcom desktop compilado pelo João no Seattle com as mudanças de `untCotacao`/`untCotacaoTypesAndConst`/`untTypesSistema` — pendência 1 fechada.
- **30/09/2026 22h15:** procedure `004` aplicada pelo João (Workbench); casos 0060 e 0062–0091 injetados por mim via `autcom_db.py --master` (perfil `teste_api`, preview + confirmação do João). Conferido pelo MCP: 31 linhas, `test_last_revision` nulo, 0061 ausente. Falta implantar e rodar a suíte.
- **30/09/2026 22h26 — 1ª rodada da suíte (pacote publicado por mim com `deploy.py --pacote SuprimentoServicesTEST.zip --mesmo-com-falha`, autorizado pelo João): os 31 casos de importação PASSARAM (31/31).** Prova também que o resource `.xlsx` é lido no Linux (pendência da T2). Na mesma rodada, 36 casos de giro/exportação/pedido deram erro de conexão no login (`localhost:31417 … ::1 Cannot assign requested address`) e 1 falhou em cadeia (download depende do caso 50) — caminho não tocado por esta entrega; conferindo numa 2ª rodada.
- **30/09/2026 22h40 — rodada do João: 88/88 casos passaram** (suíte Suprimento inteira, inclusive os 31 de importação e os 37 de giro/exportação/pedido). Os erros de conexão da 1ª rodada foram de ambiente (API ainda subindo). Pendência 2 fechada; restam o 0002 do Excel (critério 2) e o aviso à equipe REPOR+.
- **01/10/2026 10h20 — rodada com os arquivos do Excel para a Web** (`0002_excel_ok`, `0014_excel_alterado`, produtor Microsoft Excel Online 16.0300): **89/90**. Casos 0061 (Excel sem alteração), 0092 (preço alterado + fórmula lida pelo cache) e 0078 (renomeado: `test_case` é varchar(50) e truncava calado) passaram. O único erro é `TEST_GIRO_GERAR_ACEITO_EMP_022_01`, o primeiro caso da suíte, com o mesmo erro de conexão da rodada de 30/09 — a API ainda subindo; o João teve 88/88 rodando de novo. Critério 2 fechado para Excel web; Excel desktop não medido.
- **01/10/2026 10h28 — rodada do João: 90/90.** Suíte Suprimento inteira verde, com os 33 casos de importação (0060–0092).

## 01/10/2026 — decisão de produto: o vencedor é escolhido no REPOR+

Definido pelo João com Ronaldo e Wagner: a escolha do vencedor (`COT_FORESC`) é implementada no REPOR+, com regras de desempate próprias que o autcom não tem. Compatível com a RN06 (a API nunca grava `FORESC`). Para a equipe REPOR+: o `COT_FORMEN` gravado pela API é referência (desempate da spec RN06), não a escolha; e ao gravar `FORESC` o REPOR+ precisa recalcular `COT_VLRTOT`, senão fica desatualizado até a próxima importação.
