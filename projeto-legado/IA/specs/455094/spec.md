# Especificação — Req. 455094

**Título:** Exportação da cotação em Excel e envio por e-mail aos fornecedores, via REST
**Objetivo:** Expor na Suprimento.Services.API a exportação da cotação oficial em planilha, um arquivo por fornecedor, com envio opcional por e-mail, em execução assíncrona.
**Zona:** Mista — Moderna em `padra_atualizado/Services/`, Legado em `padra_atualizado/fontes/`
**Data:** 2026-08-31
**Requisito de origem:** Wagner Neves, 07/08/2026. Envolvidos: Wagner Neves / Ronaldo

## 1. Contexto / problema atual

A tela de cotação do REPOR+ precisa exportar a cotação para planilha e, opcionalmente, mandar essa planilha por e-mail aos fornecedores, sem o usuário ter que baixar o arquivo e anexar à mão.

**O autcom já tem essa rotina inteira, e ela é a referência.** `untCadCotEmail.pas` é a tela, `untModuloCotExportacao.pas` o módulo de relatório, e o método que faz o trabalho é `TCotacao.fGeraArquivoExportacao` (`untCotacao.pas:13152`): gera o arquivo e, se pedido, envia por e-mail com ele anexado. O orquestrador em lote é `pExportarArquivos` (`untCotacao.pas:13683`).

Como no Req. 454895, a regra permanece onde está e passa a ser exposta via REST — o que se constrói ao redor dela é um orquestrador sem interface gráfica e um ciclo de vida assíncrono.

**Relação com o Req. 454895.** É reaproveitamento de **infraestrutura**, não de regra: a tabela de tarefa `SSATSK` com as colunas `SST_CODEMP` / `SST_CODOPE` / `SST_STATUS`, o terceiro modo de execução `task` do binário, o header `OperadorLogado`, o mecanismo de notificação na `MENREP` e a detecção de tarefa órfã por advisory lock. Nenhuma decisão de negócio daquele requisito é herdada.

**Dois fatos apurados no levantamento, que sustentam a viabilidade:**

1. ~~**O motor da planilha não usa COM.**~~ **ERRADO — corrigido em 31/08/2026, durante a implementação.** Ver a seção *Formato do arquivo* logo abaixo, e a RN01.

   A afirmação original vinha de um rastreamento incompleto: `fExportarExcelNovoPrg` (`untCotacao.pas:14724`) instancia `TGeraArquivo.Create(taHtml, ...)` e o `TEscreveHTML` de fato escreve HTML — mas o HTML é **intermediário**. Ao final de todo `fEscreve` roda `TEscreveHTML.pSaveFile`, que abre o arquivo no Excel ou no BrOffice via COM, re-salva como XLS de verdade, aplica auto-ajuste de coluna, bloqueio de células, validação e proteção. **A exportação da cotação depende de COM, sem alternativa no caminho atual.**
2. **O envio de e-mail já compila para Linux, e já existe binário Linux cujo propósito é enviar por essa unit.** `untTEnvioEmail` está no `SuprimentoServicesAPI.dpr:689`, fora de qualquer `IFDEF`, com ramo Linux próprio no `uses` (`services.core.uses.inc` + `Shared.Core`), Indy e OpenSSL, e o overload por record `EnviarEmail(ADadosEnvioEmail: TDadosEnvioEmail)` em vez dos 35 parâmetros posicionais.

   **E o envio a partir de Linux já está exercitado em produção, pelo mesmo caminho de código.** O robô de gatilhos imediatos roda em Linux, e `untProcessaGatilhosImediatos.pas` está dentro da `libGatIme.so` (`GatIme.dpr:20`). A chamada dele em `untProcessaGatilhosImediatos.pas:793` passa `AAbrirEditor = False` (linha 801) e `blnEmailAut = True` (linha 806) — exatamente a combinação que a API precisa usar, descrita na RN14. Com esses dois argumentos o fluxo é `EnviarEmailAutomatico` → `EnviarMensagem` → `TIdMessage` → Indy/SMTP, com anexo por caminho de arquivo.

   O mesmo mecanismo serve os gatilhos de informação, cujo serviço Linux também compila a unit de envio (`GatilhosInformacao.dpr:704`).

   **Consequência para o planejamento:** o envio de e-mail em Linux **não é risco aberto**, e o spike que a primeira versão desta spec exigia como bloqueante deixa de ser. Levantado em 31/08/2026, na revisão dos três pontos.

## 2. Módulos e entidades envolvidos

**Módulos:** Suprimento (API REST), Movimentação de Itens / Cotação (autcom), E-mail (autcom)

**Units e serviços:**

| Caminho | Papel |
|---|---|
| `padra_atualizado/Services/Suprimento.Services.API/` | Controller REST e projeto Linux |
| `padra_atualizado/Services/Core/suprimento/services/` | Orquestrador e DTOs |
| `padra_atualizado/Services/Core/Services.Core.Worker.pas` | Disparo de tarefa e ciclo de execução |
| `padra_atualizado/fontes/movimentacaoitens/Cotacao/untCotacao.pas` | Regra da exportação — quatro funções recebem implementação Linux |
| `padra_atualizado/fontes/genericos/untGeraExcelHtml.pas` | Gerador da planilha (`TGeraArquivo`) — recebe ramo Linux |
| ~~`padra_atualizado/fontes/email/controller/untTEnvioEmail.pas`~~ | ~~Envio de e-mail~~ — **a API não o chama mais** (RN19). Continua sendo quem envia, mas por dentro da libGatIme |
| `padra_atualizado/fontes/genericos/GatilhosImediatos.Interfaces.pas` | `IGatIme` — recebe os dois métodos novos (RN19) |
| `padra_atualizado/fontes/libGatIme/fontes/GatilhosImediatos.Classes.pas` | Implementação da `IGatIme` dentro da `.so` |
| `padra_atualizado/fontes/util/untProcessaGatilhosImediatos.pas` | Consumidor da fila — `pExecuteCliente` passa a tomar o lock por registro (RN23) |
| `padra_atualizado/fontes/genericos/untDllGatIme.pas` | Wrapper do host — recebe a trava de versão (RN22) |
| `padra_atualizado/fontes/util/untGatilhosInformacao.pas` | Perde o `pProcessarGatilhosImediatos` e a heurística de lock órfão (RN20) |
| `padra_atualizado/fontes/genericos/untFuncoesGenerica.pas` | Ganha o par `GET_LOCK` / `RELEASE_LOCK` ao lado do `fIsUsedLock` (RN23) |
| `padra_atualizado/fontes/genericos/untTypesSistema.pas` | Recebe `TResultEnvio`, que precisa ser visível ao host (RN19) |
| `padra_atualizado/fontes/movimentacaoitens/Cotacao/untCadCotEmail.pas` | Referência das opções de exportação (leitura, **não alterado**) |
| `padra_atualizado/fontes/genericos/untGeraExcel.pas`, `untExcel.pas` | Dependências atuais de `untGeraExcelHtml` — **precisam sair da cadeia do binário Linux**, não apenas ser condicionadas |

**Tabelas e entidades:**

| Tabela | Uso |
|---|---|
| `SSATSK` | Tarefa assíncrona — colunas já criadas pelo Req. 454895, sem nova DDL |
| `COTGER` / `COTITE` / `COTFOR` | Cotação oficial — **somente leitura** |
| `CADFOR` / `ITEFOR` | Fornecedores da cotação, e-mail e contato |
| `EMACOT` | Registro do e-mail enviado da cotação, gravado hoje por `fGravarEmaCot` |
| `CADOPE` | Validação do operador do header e e-mail do comprador |
| `MENREP` | Notificação do REPOR+ — a API apenas insere |
| `CFGSIS` | `MSGCOT` (corpo do e-mail da cotação), `PATLOG` (logo) |
| `GATIME_WPPEMA` | Fila de envio da libGatIme — **uma linha por fornecedor**, inserida pela exportação (RN19). Sem DDL nova |
| `GATIME_WPPEMA_ARQUIVO` | Anexos do gatilho. A exportação usa a chave do bucket, nunca `GAT_PATARQ` (RN21) |
| `EMAENV` / `CONOPE` | Registro genérico de e-mail, gravado por dentro do envio. Distinto da `EMACOT`, que é o vínculo da cotação — as duas continuam sendo gravadas |

## 3. Requisitos funcionais

- **RF01** — Criar o recurso REST `/cotacao/exportacao` na Suprimento.Services.API, com três rotas: `POST /cotacao/exportacao/gerar`, `GET /cotacao/exportacao/{idProcessamento}` e `GET /cotacao/exportacao/{idProcessamento}/arquivo/{codFornecedor}`. O POST exige os headers `Empresa` e `OperadorLogado`.
- **RF02** — O POST valida, grava a linha da tarefa com empresa e operador em suas colunas, dispara o processo separado no modo `task` e responde HTTP 202 com o identificador, em tempo de milissegundos.
- **RF03** — A geração produz **um arquivo por fornecedor**. A lista de fornecedores vem no DTO; ela é o equivalente do `MARCADO = 'S'` que `pExportarArquivos` usa no dataset da tela. Lista vazia é recusada — a API não assume "todos". Nome do arquivo igual ao do autcom: `COT<numCotacao>_<codEmpresa>_<codFornecedor>.xls`.
- **RF04** — O envio de e-mail é decidido **no próprio POST**, por campo do DTO, e ocorre na mesma tarefa que gerou os arquivos — espelhando `fGeraArquivoExportacao(blnEnviaEmail)`. *Decisão de 31/08/2026: a alternativa de decidir depois, com um `POST /{id}/enviar` sobre arquivos já gerados, foi descartada por YAGNI — a tela do autcom nunca precisou dela. Se o REPOR+ pedir, é requisito próprio.*
- **RF05** — Os destinatários vêm do request **ou** dos fornecedores da cotação, conforme o DTO. O caminho pelos fornecedores usa a regra que já existe em `fSQLFornecedorEmail` e `pMontaClientFornecedorEmail`.
- **RF06** — O GET de status informa status geral, etapa, progresso, datas, mensagem e **detalhe por fornecedor**, com arquivo gerado e resultado do envio.

  **A forma do corpo é a do Req. 459763, e não a que este requisito desenhou.** Aquele requisito, entregue em 03/09/2026 na r493119, padronizou o JSON de status dos endpoints assíncronos deste serviço — quatro status, `etapa` como objeto com o `progresso` dentro, campos ausentes em `null` e nunca `""` ou `0`, e o resultado contável em `qtdItensGerados`. O objetivo declarado é o frontend ter **um parser** para os dois endpoints.

  Alinhamos em 04/09/2026, durante a implementação. A razão de ter sido agora e não depois é de oportunidade: a rota não tinha consumidor — não estava commitada nem publicada —, então alinhar custou a edição. Alinhar depois seria mudança incompatível em contrato vivo. O contrato campo a campo, com as três divergências deliberadas em relação ao giro, está em `casos-a-cobrir.md` seção 1.2.

  O mesmo requisito também fez a notificação do giro nomear a cotação, porque duas gerações rendiam avisos indistinguíveis. O mesmo defeito existia aqui e foi corrigido junto.
- **RF07** — O GET de download devolve o arquivo `.xls` de um fornecedor daquele processamento.
- **RF08** — O DTO de opções espelha a tela `frmCadCotEmail` do autcom, não a tela do REPOR+ — são treze opções hoje lidas direto de checkboxes em `fGeraArquivoExportacao`.
- **RF09** — Dar implementação Linux a `untGeraExcelHtml` e a **uma** função de `untCotacao`: `fExportarExcelNovoPrg`, que é o gerador da planilha. *Escopo reduzido em 31/08/2026, durante o planejamento.*

  A redação anterior pedia as quatro funções hoje com `raise`. As outras três — `pExportarArquivos`, `fGeraArquivoExportacao`, `fPedeDadosExportacao` — **permanecem Windows-only**: elas são laço de tela e leitura de checkbox, e quem as substitui é o orquestrador da API, mesma divisão que o Req. 454895 usou. `fExportarExcelNovoPrg` é a única que carrega regra de formação da planilha, e já recebe seus parâmetros por um record de campo (`recExportaPreco`), não por componente — o que a torna a de menor atrito para portar.

  Portar as três seria trabalho sem consumidor: nenhuma delas seria chamada pelo caminho da API.
- **RF10** — Expurgar os arquivos gerados após a retenção definida, na mesma varredura que detecta tarefa órfã.
- **RF11** — Controlar concorrência: uma exportação em andamento por cotação, teto de processos simultâneos compartilhado com as demais tarefas da API, e detecção de tarefas órfãs.
- **RF12** — Propagar exceção para o estado da tarefa, sem falha silenciosa.
- **RF13** — Gravar notificação de conclusão na `MENREP`, sucesso ou erro, reusando o mecanismo do Req. 454895. **`MEN_TIPO__` recebe o mesmo token textual `'COTACAO'` já usado pelo giro** — decidido em 31/08/2026. Se o REPOR+ precisar diferenciar exportação de giro pelo tipo, é requisito da equipe deles.

  Isso não deixa o app sem saber a qual ação a notificação se refere: o `MEN_WORKID` é o identificador que o próprio REPOR+ recebeu no 202 e guardou, então ele já tem o vínculo. Do lado do servidor a distinção também existe, em `SST_SERVIC` e `SST_METHOD` da `SSATSK` — o que não existe é distinção **na notificação**, e ela não é necessária.
- **RF14** — Registrar o e-mail enviado na `EMACOT`, mantendo a paridade com `fGravarEmaCot` do autcom.

## 4. Regras de negócio

- **RN01 — O caminho do autcom depende de COM, e por isso o Linux ganha um renderizador próprio.** *Reescrita em 31/08/2026, durante a implementação. A redação anterior afirmava que a planilha era HTML sem COM, e estava errada.*

  **O que o autcom faz hoje.** `TEscreveHTML` escreve uma tabela HTML, mas isso é etapa intermediária. Ao final de todo `fEscreve` roda `TEscreveHTML.pSaveFile` (`untGeraExcelHtml.pas:1162`), que cria `TExcel`, abre o arquivo no Excel ou no BrOffice, re-salva como XLS de verdade, aplica `AutoAjuste` de largura, bloqueio de células, validação de faixa e proteção de estrutura. Não há flag que pule essa etapa.

  **O que o Linux faz.** Acrescentar `taXLSX` ao enum `TTipoArquivoHTML` e implementar `TEscreveXLSX`, que grava **OOXML** — o `.xlsx` de verdade — montando as partes XML e empacotando com `System.Zip`, sem COM. *Reescrito em 31/08/2026, 21h: esta alínea dizia `taXLS` sobre o `XLSWriter`, em SpreadsheetML. O spike da RN18 derrubou essa rota — o LibreOffice descarta a proteção de planilha e a validação do SpreadsheetML, e o resultado é planilha editável.*

  **Isto é extensão prevista, não gambiarra.** `TEscreve` é base abstrata com sete métodos virtuais puros, `TEscreveHTML` e `TEscreveCSV` são duas implementações, e o construtor de `TGeraArquivo` já despacha por `Case ATipoArquivo`. O `pSaveFile` — onde mora o COM — é um desses sete. Um renderizador novo nasce sem COM por construção.

  **O layout não muda de dono.** A declaração do layout vive em `TGeraArquivo`, nas listas `FListaTitulos` e `FListaCampos`, com fonte, alinhamento, formato, mínimo, máximo, `FBloquear` e letra de coluna — tudo agnóstico de formato. `fExportarExcelNovoPrg` continua sendo a única fonte da verdade do layout, e não é alterado: só a escolha do tipo muda, `taHtml` no Windows e `taXLSX` no Linux.

  **O que diverge, e é aceito:** apenas a largura de coluna, porque o `AutoAjuste` é COM e no Linux a largura é estimada (RN15). *Correção de 31/08/2026, 21h: a redação anterior listava também a senha como divergência aceita. Não é — o spike provou que `<sheetProtection password="...">` com o hash legado de 16 bits do Excel 97 funciona sem COM. A senha vai igual à do Windows.* Conteúdo, ordem, colunas, fontes, travamento de célula, validação de faixa e senha são os mesmos.

  **O que precisa ser implementado além dos sete métodos:** o renderizador monta seis partes XML — `[Content_Types].xml`, `_rels/.rels`, `xl/workbook.xml`, `xl/_rels/workbook.xml.rels`, `xl/styles.xml` e `xl/worksheets/sheet1.xml` — e as compacta com `System.Zip`. O spike mediu isso em ~80 linhas de template. A declaração já carrega mínimo e máximo em `FValidaValor` e `FBloquear` por campo; o trabalho é traduzi-los para `<dataValidation>` e para o `<protection locked="0|1">` do `cellXfs`.

  **Nota histórica que continua valendo:** `untCadCotFornecedor.pas:804` tem a versão antiga da exportação, em COM direto, acionada pelo mesmo `frmCadCotEmail.rdgOrdenacao` (linha 605). Daí o sufixo em `pExportarExcelNovo`. A motivação da troca não está documentada; não afirmar sem ir ao `svn log`.

- **RN17 — O formato tem de sobreviver à volta, e isso restringe a escolha.** *Levantado em 31/08/2026, a pedido do usuário. A importação não faz parte deste requisito, mas condiciona o formato.*

  A planilha enviada ao fornecedor **retorna** e é importada por `untImportCotacaoItens.pas`, cujo filtro aceita `*.xls`, `*.xlsx` e `*.csv`. Quem lê é `untTValidaExcel.pas`, e a estratégia é indireta: abre no Excel (`untTValidaExcel.pas:1731` e `:1938`) ou no BrOffice (`:1842`) via COM, **salva como CSV** (`:1901`, `:1957`) e lê o CSV com `TStringList`. Não existe parser de planilha próprio — o COM é o parser.

  **Consequência para a escolha de formato:** basta que o arquivo seja abrível por Excel ou BrOffice.

  *Correção de 31/08/2026, 21h — esta alínea afirmava duas coisas que o spike da RN18 desmentiu.* Dizia que "SpreadsheetML atende": não atende, porque o LibreOffice descarta a proteção de planilha e a validação desse formato. E dizia que "a divergência entre extensão e conteúdo já existe hoje, com HTML gravado como `.xls`": não existe — o HTML é intermediário, e o COM re-salva em `.xls` binário de verdade antes de o arquivo sair. O formato escolhido é `.xlsx`, e nele extensão e conteúdo coincidem.

  **A leitura em Linux é o próximo requisito** — informado pelo usuário em 31/08/2026. Isso deixa de ser hipótese e passa a condicionar a escolha agora. `untTValidaExcel.pas` já tem `{$IFDEF LINUX}` no `uses`, mas não está em nenhum `.dpr` de Services: é intenção registrada, não fato.

  **E derruba um argumento que esta spec chegou a registrar.** A versão anterior dizia que SpreadsheetML "barateia pagar a dívida da leitura". Vale menos do que parecia: o que volta é o que o Excel **do fornecedor** salvou, e se ele usar *Salvar como* volta `.xlsx`. Nenhuma biblioteca de leitura de OOXML lê SpreadsheetML — são formatos diferentes. Mandar `.xlsx` e receber `.xlsx` é o caminho de menor surpresa no round-trip.

- **RN18 — O formato de saída é OOXML (`.xlsx`), escrito em Delphi com `System.Zip`.** *Aberta em 31/08/2026 ao fim da sessão; **fechada em 31/08/2026, 21h, por spike executado**.*

  **Decisão: rota C.** As rotas A e B foram descartadas por evidência, não por preferência.

  **Por que a A morreu.** SpreadsheetML não sobrevive ao LibreOffice. Gerado um arquivo de amostra com trava por célula, `ss:Protected="1"` na planilha, `<Password>` em `<WorksheetOptions>` e dois blocos `<DataValidation>`, e convertido por `soffice --headless --convert-to xlsx`, o XML resultante mostra:

  | Elemento | SpreadsheetML | OOXML `.xlsx` |
  |---|---|---|
  | `locked` por célula | importado | importado |
  | `sheetProtection` | **descartado** | preservado |
  | `dataValidation` | **descartado** | preservado |

  O filtro Excel-2003-XML do LibreOffice é parcial. E como `locked` **só age com a planilha protegida**, o efeito prático é planilha inteiramente editável — confirmado pelo usuário abrindo o arquivo. A trava sozinha é inerte.

  **E o ponto de comparação estava errado nesta spec.** O que o fornecedor recebe hoje **não é HTML**: o `pSaveFile` manda o Excel re-salvar com `FileFormat 56` = `xlExcel8` (`untExcelOfc.pas:312`), `.xls` binário genuíno, e o BrOffice usa `FilterName = 'MS Excel 97'` (`untExcelBRO.pas:471`). Proteção e validação chegam íntegras ao fornecedor hoje. SpreadsheetML seria **regressão**, não paridade — a frase "não estamos criando classe nova de problema", da RN17, não se aplica à proteção.

  **Por que a C passou na frente da B.** O spike montou um `.xlsx` com proteção de planilha, senha, trava por célula e validação de faixa usando **somente a stdlib do Python** (`zipfile`), sem `XlsxWriter`: **6 partes, 80 linhas de XML, 2.845 bytes**. Passou pelo round-trip do LibreOffice com `sheetProtection`, ambos os `dataValidation` e os `locked` preservados.

  Isso mede o trabalho real: nunca foi a biblioteca, era saber qual XML escrever — e agora está escrito. Com a extensão medida, a B passa a pagar uma dependência de runtime no container para evitar ~80 linhas de template. Não se justifica. `System.Zip` é RTL, e já roda em Linux nesta base (`untTEnvioEmail.pas` o usa e compila no `libGatIme.so`).

  **Detalhe de fidelidade que o spike expôs.** A primeira amostra usava `selectLockedCells="1"` e o usuário não conseguia nem clicar na descrição. O autcom chama `Protect(Password := Senha)` com os demais parâmetros no default (`untExcelOfc.pas:518`), e o default do Excel **permite selecionar** célula travada. O renderizador deve **omitir** `selectLockedCells` e `selectUnlockedCells` do `<sheetProtection>` — o default do schema é seleção liberada, que é o comportamento de produção.

  **Senha:** o hash legado de 16 bits do Excel 97 (`<sheetProtection password="XXXX">`) é aceito por Excel e LibreOffice e tem ~8 linhas de implementação. Não é preciso o `algorithmName`/`hashValue`/`saltValue`/`spinCount` do OOXML moderno.

  **O que o spike não cobriu, e continua em aberto:** não há Excel instalado na máquina de desenvolvimento — a validação foi só no LibreOffice. `.xlsx` é o formato nativo do Excel, então o risco é baixo, mas **abrir no Excel é caso de teste para o analista**, não presunção. Ver o critério de aceitação 22.

  **Artefatos do spike** (descartáveis, fora do controle de versão): `c:\tmp\spike_455094.xls` (SpreadsheetML, o que falhou), `c:\tmp\spike_455094_v2.xlsx` (OOXML, o que passou) e o gerador em Python no scratchpad da sessão. O Python foi andaime de investigação — **não** entra no produto.

  **O download responde `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` com `Content-Disposition: attachment`.** *Atualizado em 31/08/2026, 21h — a redação anterior dizia `application/vnd.ms-excel`, que é o MIME do `.xls` e ficou errado com a decisão pela rota C.* A armadilha do `;charset=utf-8` que o `BuildContentType` do DMVCFramework anexa a qualquer `application/*` **já tem solução provada no próprio serviço**, em `api.controller.pedidocompra.pas:144-155`: atribuir `Response.ContentType` **antes** do `SendFile`, porque o `SendFile` propaga o ContentType corrente e o setter grava direto, sem reaplicar o `BuildContentType`. Seguir esse padrão, não inventar outro. Aqui o risco é maior do que era com texto: `.xlsx` é ZIP, e MIME contaminado com charset em conteúdo binário é exatamente o defeito já registrado na memória do projeto para PDF.

  **A questão de encoding do arquivo desapareceu com a rota C**, e isso é ganho colateral. As partes de um `.xlsx` são XML declarado UTF-8 por definição do formato — não há escolha a fazer nem divergência possível entre declarado e gravado. A dúvida registrada aqui antes ("o HTML do autcom é latin1, e se a resposta declarar utf-8 o acento corrompe") era real para HTML e é **inaplicável** ao OOXML. O que sobra é gravar as partes em UTF-8 e escapar `&`, `<` e `>` no texto — descrição de produto com `&` quebra o XML se não for escapada.

- **RN02 — Um arquivo por fornecedor, com os preços daquele fornecedor.** O conteúdo é filtrado por `COT_CODFOR` (`untCotacao.pas:13166`). Não existe "planilha da cotação inteira" nesta rotina; a exportação de arquivo único é outra rotina (`fExportaExcelAnalise`), fora de escopo.

- **RN03 — Falha em um fornecedor não derruba os outros.** O autcom marca `STATUS` por fornecedor com `'Enviado'` ou `'Não enviado'` e segue. A tarefa só termina em erro se a falha for da exportação como um todo; falha de envio a um fornecedor é resultado parcial, registrado no detalhe por fornecedor do `SST_STATUS`. Uma tarefa com N-1 envios bons não pode aparecer como erro.

- **RN04 — Modo sem preço é opção do usuário, não derivação.** `FExportarSemPreco` zera valor unitário e total na planilha (`untModuloCotExportacao.pas:234`), que é o caso de mandar a planilha em branco para o fornecedor preencher. Vem no DTO.

- **RN05 — Status derivado.** A `SSATSK` não tem coluna de status; ele é derivado de `SST_DTAINI`, `SST_DTAFIN`, `SST_SUCESS` e `SST_TYPERR`. A condição de erro **precisa** considerar `SST_TYPERR`: quando o disparo falha, o tratamento existente grava `SST_RESULT` e `SST_TYPERR` sem gravar `SST_SUCESS`, e um status derivado apenas de `SST_SUCESS` deixaria esse caso eternamente como processando. Herdado do Req. 454895.

- **RN06 — Operador logado atravessa o request, a linha da tarefa e o processo.** Header `OperadorLogado`, gravado em `SST_CODOPE`, reaplicado no processo da tarefa por `pDefinirUsuario`. Sem isso, o e-mail sai atribuído ao operador default e a notificação vai para o `MEN_CODOPE` errado. `MEN_CODOPE` é `CHAR(3)` com FK para `CADOPE.OPE_CODOPE`, então o POST valida contra `CADOPE` e responde 400 — código inválido não pode falhar só no insert da notificação, ao final de um processamento que já rodou. Herdado do Req. 454895 (RN11 e RN13 de lá).

- **RN07 — Comprador vem da capa, não do DTO.** O cabeçalho da planilha traz nome e e-mail do comprador lidos de `COT_CODCMP` (`untCotacao.pas:14748`). O consumidor não envia.

- **RN08 — Prova de vida por advisory lock.** "Está executando" é `IS_USED_LOCK` retornando algo, não a simples existência de linha em aberto — senão tarefa morta travaria a cotação para sempre. Linha com início preenchido, fim nulo e sem lock ativo está provadamente órfã. Herdado do Req. 454895.

- **RN09 — Notificação isolada.** Gravada em transação própria, depois do fim do processamento. Falha ao notificar **não** marca como erro uma exportação que concluiu — registrar em log e seguir. O estado da tarefa é a fonte de verdade; a notificação é aviso. Tarefa órfã detectada pela varredura também notifica, pois nunca chega ao final da execução. Herdado do Req. 454895.

- **RN10 — Retenção do arquivo é finita e declarada.** Os arquivos vivem no filesystem do serviço, em diretório por `idProcessamento`. Passada a retenção, o diretório é apagado e o download passa a responder 404 com mensagem clara — não erro genérico. **Retenção: 48 horas, confirmado em 31/08/2026.**

- **RN11 — Nenhuma escrita nas tabelas da cotação.** `COTGER`, `COTITE` e `COTFOR` são lidas. As únicas escritas do requisito são `SSATSK`, `EMACOT` e `MENREP`.

- **RN12 — Ler as tabelas oficiais direto, com `strSeqGerBKP` vazio. A API não imita o mecanismo da tela aqui.** *Levantado em 31/08/2026, e é a correção mais importante desta revisão.*

  A tela do autcom exporta a partir do **rascunho `_RES`**, não das oficiais: `pExportaPrecosFornecedores` (`untCotacao.pas:20238`) chama `fIncluir_CopiaSeguranca` antes de exportar, o que cria uma cópia `_RES` e devolve a sequência nova em `strSeqGerBKP`; depois passa essa sequência com a flag `strSeqGerBKP <> ''` para `fAbreCdsPrecosItemFornecedor`, e com ela em `True` o SQL troca `COTGER`/`COTITE`/`COTFOR` pelas versões `_RES`. O dado exportado é o oficial, só que através de uma cópia recém-feita.

  **A API faz o contrário: `strSeqGerBKP = ''` e a flag em `False`,** caminho que o mesmo `fAbreCdsPrecosItemFornecedor` suporta revertendo o SQL para as tabelas oficiais (`untCotacao.pas:4602`). `fCarregaCotacao` já trata o caso, porque o `LEFT JOIN COTITE_RES` cai em `COT_SEQGER = 0` e não traz linha (`untCotacao.pas:4209`).

  Duas razões, e a primeira é de correção, não de elegância:

  1. Se um comprador estiver com a cotação aberta no autcom, **já existe um `_RES` daquela cotação**, e ele pode descartá-lo a qualquer momento. A API criando outro colide com a sessão de edição dele.
  2. Exportar é leitura. Criar `_RES` a partir do servidor é escrita, e nenhuma escrita em tabela de cotação está no escopo (RN11).

  **Armadilha a evitar:** o orquestrador do Req. 454895 preenche `strSeqGerBKP` de propósito, porque o giro grava no rascunho. Copiar aquela precondição para cá troca a fonte de dados sem erro de compilação e sem mensagem — é falha calada.

- **RN13 — O envio é direto, e não pela fila de gatilhos.** *Confirmado em 31/08/2026, em duas leituras independentes.* A cotação chama `TEnvioEmail.EnviarEmail` (`untCotacao.pas:13343`) e registra em `EMACOT` via `fGravarEmaCot` (`untCotacao.pas:13382`). Não há chamada a `fGravarGatilhoImediato` em nenhum ponto de `movimentacaoitens`, nem gatilho de cotação em `untDisparaEmailAut.pas`. A API espelha esse caminho.

  **Por que não enfileirar, embora seja tecnicamente viável.** O `TRecGatilhoImediato` (`untTypesSistema.pas:65`) carrega assunto, mensagem, anexos por caminho, destinatário e operador — daria para gravar um gatilho por fornecedor, e ganharíamos retentativa de graça (`fRetMaxAttempsGatilhosImediatos`). O que decide contra é a **semântica do item 4 do requisito**: ele pede aviso de que *o envio foi concluído*. Com fila, a tarefa termina antes do envio, o aviso só poderia dizer "enfileirado", e o status por fornecedor sairia do `SST_STATUS` para as tabelas de gatilho — o GET passaria a consultar duas fontes para responder uma pergunta.

  **A fila fica registrada como plano B**, e é o caminho melhor em dois cenários: se o SMTP a partir do binário Linux não se sustentar, ou se a equipe REPOR+ aceitar a semântica de "enfileirado" em troca da retentativa.

  ---

  **REVISADA EM 14/09/2026 — a conclusão se inverte, e o gatilho do plano B foi acionado.** Tudo que a
  RN13 descreve continua verdadeiro como **descrição da tela do autcom**: ela realmente envia direto. O
  que cai é a frase final, *"a API espelha esse caminho"*. Espelhar a tela era o princípio certo para
  layout, colunas e opções; para o envio, copiou junto um furo de arquitetura — a cotação é o único lugar
  do sistema que manda e-mail sem passar pela libGatIme, que é a dona do envio de e-mail e WhatsApp.

  O primeiro dos dois cenários previstos aqui ocorreu: **o SMTP a partir do binário Linux não se
  sustentou.** Uma semana de investigação terminou com AV dentro do `TLSHandshake`, causa em aberto, sete
  hipóteses derrubadas. E a objeção que esta RN levantava contra a fila — *"a tarefa termina antes do
  envio, o aviso só poderia dizer enfileirado"* — **deixa de valer**, porque a libGatIme passa a oferecer
  processamento síncrono por registro (RN19). O status continua saindo do `SST_STATUS`, e o GET continua
  consultando uma fonte só.

  A decisão passa a ser a das RN19 a RN24. Esta RN fica no texto, inteira, porque o raciocínio que ela
  registra é o que explica por que o requisito seguiu por outro caminho durante duas semanas.

- **RN14 — Dois argumentos do envio são obrigatórios em Linux, e ambos falham diferente se errados.** A implementação de referência **não é a tela**, é `untProcessaGatilhosImediatos.pas:793` — o robô de gatilhos, que já roda em Linux e passa esta mesma combinação. Copiar dali, não de `untCotacao.pas:13343`. Em `EnviarEmail`:
  - **`AAbrirEditor = False`.** O ramo do editor é `EnviarEmailEditor`, que tem `{$IFDEF LINUX}` com `raise` (`untTEnvioEmail.pas:4328`). Na tela esse argumento recebe `FExibeTelaEmail`, que é `True` quando há um só fornecedor — copiar isso para a API derruba justamente o caso de fornecedor único.
  - **`blnEmailAut = True`.** Só esse ramo chama `EnviarMensagem` direto (`untTEnvioEmail.pas:4289`); o outro passa por `TfrmGravando.fExecutarModal` e por `fMensagem` (`untTEnvioEmail.pas:4295`). A tela manda `False`, porque tem interface para exibir. A API não tem.

  **NÃO SE APLICA MAIS À API, desde 14/09/2026.** Com a RN19 a exportação não chama `EnviarEmail`: ela
  grava um gatilho e pede o processamento. Quem chama passa a ser a libGatIme, em
  `untProcessaGatilhosImediatos.pas:799` — que é exatamente a implementação de referência que esta RN
  mandava copiar, e que já passa esses dois argumentos. A regra continua correta e continua sendo
  cumprida; muda só quem a cumpre. Fica registrada porque explica por que a referência era o robô e não a
  tela, e porque volta a valer se algum dia a API precisar enviar por fora da fila.

- **RN15 — A largura de coluna é estimada em Linux, e essa é a única divergência aceita na planilha.** *Levantado em 31/08/2026, durante a Tarefa 1.*

  O gerador calcula largura de coluna medindo o texto em pixels, com `TControlCanvas` amarrado a
  `Application.MainForm` (`untGeraExcelHtml.pas:669`). Serviço Linux não tem form principal — nem com FMX,
  porque serviço não tem interface. No ramo Linux a largura passa a ser estimada por comprimento do texto
  vezes fator do tamanho da fonte.

  **O ramo Windows não muda:** o autcom continua medindo com Canvas, e a planilha que os usuários já
  recebem sai exatamente como hoje. Uniformizar as duas plataformas na estimativa foi considerado e
  descartado — alteraria o comportamento de uma rotina em produção que ninguém pediu para mudar.

  Medir de verdade com FMX (`TBitmap` + `Canvas.MeasureText`) também foi descartado: as métricas do FMX não
  batem com as do GDI, então o resultado continuaria divergente, com precisão falsa, e acrescentaria
  dependência FMX ao gerador.

  Consequência declarada: largura é atributo cosmético. Conteúdo, ordem, valores, colunas e cabeçalho
  são idênticos — é o que o critério 04 afere.

  **Peso reavaliado em 31/08/2026, depois da RN01:** a estimativa passou a importar **mais**, não menos.
  O `GetVirtualWidth` é chamado pelo `AddCampo` do `TGeraArquivo`, que é compartilhado, então a largura
  estimada alimenta a coluna no XML do renderizador Linux. E não há `AutoAjuste` depois para corrigi-la,
  porque o auto-ajuste é COM. No Windows a estimativa nunca entra em cena; no Linux ela é a largura final.

- **RN16 — O substituto de `TFont` é classe, não record, e o vazamento existente é preservado.**
  O gerador usa `nil` como sentinela em quatro parâmetros default, com `Assigned()` decidindo se cria a
  fonte (`untGeraExcelHtml.pas:337` e `:393`). Record não aceita `nil`, então o substituto sem VCL é uma
  classe própria.

  Os `TFont.Create` das linhas 301, 339 e 395 **não têm `Free` em nenhum lugar** — há vazamento hoje. A
  classe própria o preserva; record o consertaria de graça. Preservar é deliberado: consertar é mudança de
  comportamento fora do escopo deste requisito, e a zona legado não se refatora proativamente. Fica
  registrado como achado para requisito próprio.

- **RN19 — A libGatIme é a dona do envio, e a cotação delega.** *Decidido em 14/09/2026, substituindo a conclusão da RN13.*

  O envio de e-mail e WhatsApp pertence à libGatIme. Os demais módulos são **consumidores**, e a cotação
  passa a ser um deles: em vez de chamar `TEnvioEmail.EnviarEmail`, grava um gatilho por fornecedor e pede
  o processamento daquele gatilho.

  Para isso a `IGatIme` (`GatilhosImediatos.Interfaces.pas`) ganha dois métodos, **acrescentados à
  interface existente**, que continua com os dois de hoje intactos:

  - gravar o gatilho devolvendo o identificador da linha em `GATIME_WPPEMA` — o `fGravarGatilhoImediato`
    de hoje já calcula esse identificador e o descarta, devolvendo só `Boolean`;
  - processar **um** identificador e devolver o `TResultEnvio` — o processamento por linha já existe e já
    devolve esse tipo: `fExecutaClienteEmail(const AAutInc: String): TResultEnvio`
    (`untProcessaGatilhosImediatos.pas:97`), e o mesmo vale para WhatsApp e SMS. O método novo é **porta
    para código existente**, não implementação nova.

  `TResultEnvio` sai de `untProcessaGatilhosImediatos.pas:24`, que vive dentro da `.so`, para
  `untTypesSistema` — o host precisa enxergar o tipo que aparece na assinatura.

  **O que isso preserva:** a tarefa termina sabendo o desfecho de cada fornecedor, então o contrato do
  endpoint não muda e o consumidor não recompila.

- **RN20 — Quem insere processa o que inseriu; a fila inteira é do robô.** *Decidido em 14/09/2026.*

  Nenhum produtor drena a `GATIME_WPPEMA` além do que ele próprio gravou. A varredura da fila é função do
  serviço `GatilhosImediatos`, que existe para isso, e o que sobra é dele — inclusive linha cuja tentativa
  síncrona falhou, que fica pendente e sai depois. **Isso não é defeito nosso e não vira pendência
  nossa.** Não importa em qual servidor ou sistema operacional o robô rode.

  A regra não é estética. Produtor que drena linha alheia produz dois estragos já observados em produção:
  processa registro com `GAT_PATARQ` gravado no Windows, que não existe no Linux, e reenvia lixo antigo
  parado na fila.

  Por isso o `pProcessarGatilhosImediatos` de `untGatilhosInformacao.pas:218` — `{$IFDEF LINUX}`, que toma
  o lock do monitor operacional e chama `fMonitorar` para drenar tudo — **deixa de existir**. Some com ele
  a heurística de lock órfão das linhas 228 a 260: idade, `LCK_TENTAT`, `pDestravaLockForcado` e a
  ocorrência de 26 horas no DONATO em 08/09/2026. Aquele bloco só existe para tomar o lock do monitor com
  segurança, e sem a drenagem não há lock de monitor a tomar.

  **Ganho colateral, medido no código:** hoje o `pExecuteAll` percorre os gatilhos pendentes com
  `Sleep(1000)` por item e só drena **depois do laço inteiro** — o gatilho da primeira volta espera todas
  as outras. Com processamento por identificador, cada um sai na hora. É exatamente o comportamento que a
  gambi tentava obter e não obtinha.

- **RN21 — Anexo trafega pelo bucket. `GAT_PATARQ` é compatibilidade com o passado e não se usa.** *Decidido em 14/09/2026.*

  O XLSX vai para o `TBucketCitel` no momento de gravar o gatilho, como o `fGravarGatilhoImediato` já faz
  com qualquer anexo, e o consumidor o baixa na hora de enviar.

  A coluna `GAT_PATARQ` guarda caminho de arquivo local e o consumidor **ainda sabe lê-la**
  (`untProcessaGatilhosImediatos.pas:974`), o que torna tentador usá-la para evitar a ida e volta ao
  bucket — o arquivo já está no disco de quem vai enviar. **Não usar.** A fila é compartilhada entre
  máquinas e entre sistemas operacionais: nada que dependa do sistema de arquivos local pode entrar nela.
  Registro inserido no Linux pode ser processado por robô no Windows, e o caminho não significa nada lá.

- **RN22 — O host confere a versão da libGatIme ao carregar, antes de qualquer chamada.** *Decidido em 14/09/2026.*

  Acrescentar método a uma interface publicada cria um modo de falha ruim: host novo chamando `.so` antiga
  salta para um slot além do fim da vtable — não levanta exceção, produz AV ou corrupção silenciosa. E o
  desencontro é plausível, porque a `libGatIme` passa a existir em **três** lugares atualizados por
  processos de deploy diferentes: junto do autcom no Windows, na pasta do robô Linux, e agora na do
  Suprimento. Em 14/09/2026 a `.so` do robô era de 08/09 e o binário do Suprimento de 14/09.

  A proteção é uma **trava de versão**, não uma interface nova por mudança: a `fSVN_RevisionGatIme`, hoje
  exportada só no Windows (`untDllGatIme.pas:26`), passa a ser exportada também no Linux, e o `TDllGatime`
  a consulta **uma vez**, logo após carregar. Ausente ou abaixo do mínimo exigido, registra *"libGatIme
  desatualizada — tem X, precisa Y"* e degrada ali.

  Genérica de propósito: cobre método que não existe, método que passou a se comportar diferente e
  parâmetro que mudou de significado, e protege os seis consumidores, não só a chamada nova. O
  `TDllGatime` já é o lugar dessa guarda — tem hoje uma checagem de `Assigned` cujo comentário conta o
  estrago de quando faltou (`untDllGatIme.pas:148`: a fila parou de andar e a central parou de receber).

  **Custo aceito e declarado:** a trava só vale se o número mínimo for elevado quando o contrato mudar. É
  um número, num lugar, com o motivo escrito ao lado.

- **RN23 — Lock por registro com `GET_LOCK`, tomado pelos dois lados, dentro de quem processa.** *Decidido em 14/09/2026.*

  Nome `GATIME_<empresa>_<autoincrem>`. O prefixo existe porque o espaço de nomes do `GET_LOCK` é global
  na instância do MySQL, compartilhado pelos serviços e pelo autcom — mesma razão já documentada em
  `Suprimento.Services.Cotacao.Concorrencia.pas`.

  **Tomado dentro do processamento, na conexão que processa.** `GET_LOCK` é escopado na conexão; adquirido
  pelo chamador, não protegeria o que a libGatIme faz na conexão dela — e a libGatIme tem
  `pIniciarConexaoThreadGatIme` própria.

  **Os dois lados tomam.** O `pExecuteCliente`, que hoje varre a fila com `SELECT` simples e **sem
  proteção nenhuma** por linha, passa a pegar o mesmo lock antes de enviar e a pular a linha ocupada. Sem
  isso o lock não protege nada: o monitor mandaria a mesma mensagem que a chamada síncrona está mandando.
  O risco não é teórico — está descrito no próprio código, em `untGatilhosInformacao.pas:239`: *"dois
  processos no mesmo cursor podem enviar a mesma mensagem duas vezes ao cliente final"*.

  Espera zero nos dois lados: quem não pegou devolve `tpTentarNovamente` no caminho síncrono, e pula no
  monitor.

  **Sem coluna de reivindicação.** Chegou a ser proposta e foi descartada: hoje não existe proteção alguma
  por linha, então o lock sozinho já é estritamente melhor, e a única falha que ele não cobre — cair
  depois de enviar e antes de marcar — **já acontece hoje, igual**. Estado novo na tabela traria linha
  presa precisando da própria recuperação.

  **Onde o código mora:** `untFuncoesGenerica`, que já é dona de `fIsUsedLock` (linha 9627) e é visível
  tanto para a build Windows quanto para a Linux. `Services.Core` está fora porque a libGatIme só a
  enxerga sob `{$IFDEF LINUX}` e também compila como `libGatIme.dll` para o autcom. As funções novas usam
  `ParamByName()`; as existentes montam o nome do lock por concatenação.

  **Defeito encontrado no caminho, e deliberadamente não corrigido:** o `fGetLock` de
  `untFuncoesSimples.pas:50087` faz `Result := True` sem ler o retorno do `GET_LOCK`, que devolve 0 quando
  estoura o tempo — quem chama acha que tem o lock e não tem. É usado pelo autcom em
  `untPrincipal.pas:25515`, onde decide qual estação é responsável pelo robô do SFA, e três vezes na
  importação de CTe. Corrigi-lo mudaria o comportamento desses robôs em produção, fora do escopo deste
  requisito. **Fica registrado como achado para requisito próprio**, e é a razão de as funções novas
  nascerem em `untFuncoesGenerica` em vez de reusar essa.

- **RN24 — `emailEnviado` significa "não saiu na minha tentativa", e não "não será enviado".** *Decidido em 14/09/2026, decorrência da RN20.*

  Falhando a tentativa síncrona, a linha fica pendente na `GATIME_WPPEMA` e o robô a envia depois. O
  fornecedor recebe a mensagem, e o campo do detalhe por fornecedor continua dizendo que não foi enviada,
  porque descreve **aquela tentativa**.

  Consequência para quem consome: interface que exiba ali um indicador definitivo de falha vai mentir. O
  campo pede rótulo de tentativa, não de desfecho. **A eventual troca do nome do campo é decisão da equipe
  REPOR+ com a análise**, não deste documento — mas o significado fica fixado aqui.

- **RN25 — O anexo é XLSX e o nome que chega ao fornecedor tem de dizer isso.** *Levantada em 14/09/2026, por defeito observado no primeiro e-mail que saiu de verdade.*

  O fornecedor recebeu `COT00014902228001426.xlsx.pdf`. Duas causas somadas, e as duas precisavam de
  correção — consertar só uma produziria `nome.pdf`, que é pior, porque o nome passaria a mentir sem
  parecer estranho.

  **A exportação passava o título já com extensão.** O `fGravarGatilhoImediato` monta `GAT_NOMARQ`
  como título mais a extensão derivada do tipo do arquivo. O título vai sem extensão.

  **E o sistema não conhecia `.xlsx`.** O `fGetTipoArquivo` casa contra uma lista fechada
  — `.pdf`, `.jpeg`, `.jpg`, `.png`, `.xls`, `.xml`, `.doc`, `.bmp` — e o que não casa vira `tpaPDF`.
  Mapear `.xlsx` para o `tpaExcel` existente **não serve**: a extensão dele é `.xls`, e extensão que
  não corresponde ao conteúdo é exatamente o que a RN18 evitou ao escolher OOXML.

  Por isso o `TTipoArquivo` ganhou **`tpaExcelX`**, acrescentado **no fim do enum**: inserir no meio
  deslocaria o ordinal de `tpaXml` em diante, e o tipo é gravado em coluna em outros pontos do
  sistema.

  **Acrescentar valor a enum não quebra compilação**, então os `case` sobre `TTipoArquivo` foram
  varridos à mão. O de `untThreadEnviaSMS` alcança o valor novo, porque o tipo dele vem do
  `fGetTipoArquivo`, e foi coberto com o MIME e a extensão corretos. Os demais recebem o tipo de
  escolha da própria tela e não alcançam.

  *Este defeito passou por três leituras do mesmo trecho e só apareceu quando alguém abriu a caixa de
  entrada. É o argumento de por que o critério 30 exige a mensagem chegando.*

- **RN26 — Canal sem destino não é executado, mas é marcado.** *Levantada em 15/09/2026, por regressão que o caso 53 pegou.*

  Num gatilho de cotação, que é só de e-mail, as colunas de WhatsApp e SMS são nulas **por natureza** —
  nunca haverá envio por esses canais. Executar os ramos deles é trabalho à toa e, pior, expõe o
  processamento a falhas de um caminho que não interessa: em 14/09 o ramo de WhatsApp abortou o
  processamento **antes do e-mail** ao tropeçar numa coluna ausente.

  Mas **pular o ramo inteiro quebra o encerramento da linha.** O `pMarcaGatImeEnviado` só põe
  `GAT_LIBENV = 'N'` quando os **três** canais têm data:

  ```sql
  WHERE GAT_D_EWPP IS NOT NULL AND GAT_D_EEMA IS NOT NULL AND GAT_D_ESMS IS NOT NULL
  ```

  Sem marcação, um gatilho só de e-mail fica em `'S'` para sempre, e a fila acumula linha que ninguém
  vai fechar.

  A regra que concilia as duas coisas: **canal sem destino é marcado como não previsto, sem executar
  nada.** É o mesmo desfecho que o laço do `pExecuteCliente` obtém por outro caminho — ele entra nos
  três ramos e cada função marca ao sair cedo.

  *O laço original não foi alterado nisso. A regra existe porque o processamento por registro, que é
  novo, precisava reproduzir um efeito que no laço era subproduto.*

## 5. Requisitos técnicos / não-funcionais

- **Assincronismo real.** O caminho síncrono de tarefa da API tem dois bloqueios de 120 segundos — o laço de polling e o `ReadLn` do despacho. Nenhum dos dois se aplica ao caminho novo.
- **Isolamento.** O processo separado é reparentado para o init: reiniciar a API não interrompe exportação em andamento.
- **Não degradar o que está em produção.** `/pedido-compra/calcular-impostos`, `/pedido-compra/pdf` e `/cotacao/giro/*` compartilham a mesma API e a mesma tabela de tarefas. Nada do protocolo do pool nem do comportamento síncrono pode mudar.
- **Segurança.** Validar que o identificador é numérico antes de concatenar em comando de shell. Validar `codFornecedor` antes de compor caminho de arquivo — o download não pode virar travessia de diretório. Todo SQL novo com `fCriaQuery` e `ParamByName()`.
- **A cadeia OLE não pode entrar no binário.** `untGeraExcelHtml` usa hoje `ComObj` e `untGeraExcel` → `untExcel`, que é automação COM. Condicionar o `uses` não basta se algum tipo usado no corpo vier de lá: os tipos de formatação (`TFont`, `TColor`) precisam de substituto Linux.
- **Auditoria e data.** Timestamps persistidos via `fNow()`.
- **Encoding.** Fontes Delphi em latin1 conforme `.editorconfig`; estes artefatos de análise em UTF-8.
- **Impacto fiscal/financeiro:** nenhum. Não toca cálculo de imposto, título ou documento fiscal.

## 6. Critérios de aceitação

- [ ] 01 — POST com cotação válida responde 202 em milissegundos e a chamada não permanece aberta durante a geração.
- [ ] 02 — GET imediatamente após o POST retorna pendente ou processando; após a conclusão retorna concluído, com um item de detalhe por fornecedor solicitado.
- [ ] 03 — Para N fornecedores selecionados são gerados N arquivos, com os nomes no padrão do autcom, e cada um contém somente os itens e preços do seu fornecedor.
- [ ] 04 — A planilha gerada pela API, para os mesmos filtros e o mesmo fornecedor, é equivalente à que a tela do autcom produz. **Equivalente significa: mesmos itens, mesma ordem, mesmos valores, mesmas colunas e mesmo cabeçalho.** A **largura** das colunas pode divergir — ver RN15 — e divergência só de largura **não reprova** o caso.
- [ ] 05 — GET de download devolve o arquivo do fornecedor pedido, abrível no Excel e no LibreOffice.
- [ ] 06 — Download de fornecedor que não faz parte do processamento, ou de identificador inexistente, responde 404 com mensagem clara.
- [ ] 07 — Com envio de e-mail pedido no POST, cada fornecedor recebe a mensagem com sua planilha anexada, e o detalhe por fornecedor no GET reflete enviado ou não enviado.
- [ ] 08 — Falha de envio a um fornecedor não impede os demais, e a tarefa não termina em erro por causa dela: o GET mostra os bons como enviados e o ruim como não enviado.
- [ ] 09 — Com destinatários informados no request, o e-mail vai para eles e não para os fornecedores; sem eles, vai para os fornecedores da cotação.
- [ ] 10 — Exportação que ultrapassa 120 segundos conclui normalmente, sem timeout.
- [ ] 11 — Reiniciar o serviço da API com uma exportação em andamento não a interrompe.
- [ ] 12 — Matar o processo à força faz a tarefa ser detectada como órfã, passar a responder erro no GET, gerar notificação de erro e liberar a cotação para nova exportação sem intervenção manual.
- [ ] 13 — Segundo POST para a mesma cotação, com o primeiro em andamento, responde 409.
- [ ] 14 — Ultrapassar o teto de processos simultâneos responde 429 sem disparar processo.
- [ ] 15 — Durante uma exportação em execução, `/pedido-compra/calcular-impostos`, `/pedido-compra/pdf` e `/cotacao/giro/*` respondem dentro do tempo normal.
- [ ] 16 — Falha forçada no meio da geração faz o GET responder erro com a mensagem da exceção, e não concluído com zero arquivos.
- [ ] 17 — Conclusão gera linha em `MENREP` com `MEN_CODOPE` igual ao header `OperadorLogado`, `MEN_WORKID` igual ao identificador do processamento e `MEN_MENSAG` citando a cotação e a quantidade de arquivos. `MEN_LIDA__` fica `'N'` e `MEN_DTALEI` nulo.
- [ ] 18 — Header `OperadorLogado` ausente, ou com código inexistente em `CADOPE`, responde 400 no POST, antes de disparar o processo.
- [ ] 19 — Envio por e-mail grava `EMACOT` do mesmo jeito que o autcom, e o e-mail aparece na consulta de mensagens do autcom.
- [ ] 20 — Passada a retenção, o diretório do processamento não existe mais e o download responde 404 com mensagem clara, sem erro genérico.
- [ ] 21 — O Swagger declara que o arquivo é XLSX (OOXML), com o MIME `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`. *Reescrito em 31/08/2026, 21h: a redação anterior dizia "HTML com extensão `.xls`, e não XLSX", que era verdade para a rota descartada e virou o oposto do correto com a RN18.*
- [ ] 22 — **A planilha abre no Microsoft Excel** sem aviso de formato ou de arquivo corrompido; código e descrição recusam edição; preço e IPI aceitam; valor fora da faixa é recusado com a mensagem declarada; desproteger pede a senha; e célula travada continua **selecionável e copiável**. *Este caso é obrigatório e não foi coberto pelo spike — não há Excel na máquina de desenvolvimento, e a verificação foi feita só no LibreOffice. Ver RN18.*
- [ ] 23 — A mesma verificação do critério 22, no LibreOffice Calc. *Coberta pelo spike em 31/08/2026 com um arquivo de amostra; repetir sobre a planilha real gerada pela API, que tem colunas, larguras e volume de linhas que a amostra não tinha.*
- [ ] 24 — Item cuja descrição contenha `&`, `<` ou `>` é exportado e a planilha abre normalmente, com o caractere visível na célula. *Escape de XML — falha aqui produz arquivo corrompido, não célula errada.*

- [ ] 25 — Com envio pedido no POST, existe **uma linha em `GATIME_WPPEMA` por fornecedor**, com assunto, destinatário e a chave do anexo no bucket preenchidos, e o operador da tarefa em `GAT_OPEENV`. O `GAT_NOMARQ` termina em **`.xlsx`** e não contém `.pdf` — ver RN25. E `GAT_LIBENV` fica `'N'`, com os três canais datados, provando que a linha encerrou — ver RN26. *Afirmável por consulta ao banco, sem depender de SMTP.*
- [ ] 26 — O detalhe por fornecedor reflete o `TResultEnvio` devolvido pela libGatIme, e `EMACOT` é gravada para os fornecedores cujo resultado foi positivo — e só para eles.
- [ ] 27 — Enquanto a chamada síncrona detém o lock de um registro, o monitor **pula** aquela linha e não a envia. *É o caso que protege contra mensagem duplicada ao fornecedor; não pode ficar sem cobertura.*
- [ ] 28 — Com a `libGatIme` mais antiga que o mínimo exigido, o serviço **não chama** os métodos novos: registra "libGatIme desatualizada" e a exportação conclui com o e-mail não enviado, sem AV e sem derrubar o processo.
- [ ] 29 — O `GatilhosInformacaoEnviar` envia cada gatilho **assim que o insere**, e não mais ao fim da varredura; e nenhuma linha da `GATIME_WPPEMA` que ele não tenha inserido é processada por ele.
- [ ] 30 — **O e-mail chega de fato ao destinatário**, a partir do `Suprimento.Services.API` em Linux. *Definição de pronto acordada em 14/09/2026: o requisito não entrega sem este caso verde. A causa da AV no `TLSHandshake` está em aberto e é pré-requisito deste critério.*

## 7. Fora de escopo

**Senha de abertura do arquivo. Decidido em 15/09/2026 com o Ronaldo: a planilha da API sai SEM
senha de abertura.**

A tela do autcom aplica duas proteções distintas, e só uma delas veio para a API:

| Proteção | Tela | API |
|---|---|---|
| Células travadas contra edição (`sheetProtection`) | sim | **sim** |
| Senha para abrir o arquivo | conforme `CFG_COPLPR` | **não** |

A `CFG_COPLPR` — *"Na exportação do arquivo para o fornecedor proteger a planilha com senha?"* —
tem default `'S'` (`untCfgRepositorio.pas:18733`), e no `prg` está ligada em **69 de 100 empresas**.
Ou seja, a API diverge do comportamento padrão, não da exceção.

**Por que ficou de fora.** Senha de abertura em `.xlsx` não é atributo do XML: exige cifrar o pacote
inteiro e embrulhá-lo num contêiner **CFB**, a mesma estrutura binária dos `.doc` e `.xls` antigos.
O projeto tem as primitivas de criptografia (`synacrypt`, `libeay32`), mas **não sabe escrever CFB** —
não há `IStorage` nem `StgCreateDocfile` em lugar nenhum. É trabalho de porte comparável ao próprio
gerador de OOXML deste requisito, com o agravante de que arquivo recusado pelo Excel não diz por quê
e não há Excel na máquina de desenvolvimento.

**O que isso NÃO significa.** A planilha continua protegida contra edição — código e descrição
recusam alteração, e desproteger pede a senha. O que muda é que o fornecedor abre o arquivo direto,
sem digitar nada.

*Ficou registrado, na mesma conversa, que o mecanismo atual merece revisão própria antes de
qualquer investimento em preservá-lo: a senha é constante compilada (`SEN_ADM = 'CITEL13347'`,
`untConstantes.pas:463`), igual em todos os clientes, e transmitida ao fornecedor por fora. Vazou
uma vez, vale para todos.*


1. **PDF.** `fGeraArquivoExportacao` gera PDF pelo mesmo caminho, via FastReport com `.fr3`. O requisito pede Excel, e o PDF traz o problema de portabilidade do FastReport-FMX.
2. Exportação de arquivo único da cotação (`fExportaExcelAnalise`) e a do comparativo.
3. Exportação a partir do rascunho `_RES`. Decidido em 31/08/2026: a fonte é a cotação oficial.
4. Rota para enviar e-mail sobre arquivos já gerados (`POST /{id}/enviar`) — ver RF04.
5. Conversão da planilha para XLSX real.
6. Importação da planilha respondida pelo fornecedor (`untImportCotacaoItens.pas`, pasta `COTACOES\IMPORTAR`).
7. Tela do REPOR+ e backend Java.
8. Controle de leitura e exclusão da notificação — `MEN_LIDA__`, `MEN_DTALEI`, `MEN_EXCLUI`. São da aplicação.
9. Alterar o protocolo do pool de workers ou o comportamento síncrono do despacho.

## 8. Dependências e riscos

**Dependências externas**

| Dependência | Responsável | Bloqueia |
|---|---|---|
| ~~Token de `MEN_TIPO__` para exportação~~ | ~~Equipe REPOR+~~ | **Resolvido em 31/08/2026** — mantém `'COTACAO'`, o mesmo do giro. Ver RF13 |
| ~~Retenção do arquivo em horas~~ | ~~Análise / Suprimento~~ | **Resolvido em 31/08/2026** — 48 horas. Ver RN10 |
| Conta de e-mail e provedor configurados no ambiente do serviço | Infra / cliente | Uso em produção do envio |
| Adequação da tela do REPOR+ às opções do contrato | Equipe REPOR+ | Nada do lado API |

**Riscos**

| Risco | Mitigação |
|---|---|
| **Envio de e-mail a partir do Linux — reaberto em 14/09/2026; o encerramento anterior estava errado** | Fora encerrado em 31/08 com o argumento de que "o robô roda em Linux e envia por esse mesmo caminho". O fato é verdadeiro e a inferência é falsa: prova que a **cópia compilada dentro da `libGatIme.so`** envia, não que o nosso binário envia. Mesmo fonte, binários diferentes — e, pior, **máquinas diferentes**, `srvPrg1` contra `srvwebservicesbr9`, com `libcurl` puxando linhas distintas de OpenSSL. A comparação nunca controlou a variável. Custou uma semana e sete hipóteses derrubadas. **Mitigação:** a causa é pré-requisito do critério 30, e a medição que separa máquina de binário — rodar o `GatilhosInformacao` na `srvPrg1` — ainda não foi feita |
| Descartado por medição, para não ser reaberto sem fato novo: **não é OpenSSL 1.1** | O `ldd` mostra que quem falha carrega o par 1.0 limpo (`libssl.so.10` + `libcrypto.so.10`) e quem funciona está misturado (`libcrypto.so.10` + o par 1.1). Também descartados: porta, TLS implícito contra explícito, symlink `libcrypto.so.10` (inerte — o binário não pede esse nome), `IdOpenSSLSetLibPath`, default `sslmClient`, versão de TLS e divergência de units entre os `.dpr`. E `IdSSLOpenSSLHeaders.Load` devolveu `True` com falhas vazias **e mesmo assim houve AV**: o retorno do `Load` não prova compatibilidade |
| `TBucketCitel` nunca exercitado a partir do `Suprimento.Services.API` | É o candidato mais provável a morder primeiro, e falha no enfileiramento, antes de qualquer e-mail. **Verificar cedo**, como pré-requisito, que o bucket responde a partir da `srvPrg1` — é um sim ou não que não exige código escrito |
| Mudança no `pExecuteCliente`, que roda em produção para todos os produtores da fila | O acréscimo é aditivo — linha com lock tomado fica para o ciclo seguinte —, mas é o único ponto deste requisito que altera código em uso por WhatsApp, SMS, `untDisparaEmailAut` e editor de relatórios. O critério 27 é o que o cobre |
| Envio direto não tem retentativa | Falha de SMTP é definitiva para aquele fornecedor na rodada, registrada como `'Não enviado'` no detalhe por fornecedor (RN03). O usuário reexporta. Se isso incomodar em produção, o plano B da RN13 resolve — e é o argumento mais forte a favor dele |
| Cadeia OLE de `untGeraExcelHtml` maior do que parece | Compilar a unit para Linux antes de escrever o orquestrador, e medir a cadeia real. Substituto para `TFont`/`TColor` decidido nesse momento, não antes |
| `fCarregaCotacao` com episódio de 14 minutos sem causa fechada, registrado no Req. 454895 | O assincronismo protege a requisição; o teto de processos simultâneos precisa contar estas tarefas junto com as de giro |
| Planilha divergente da do autcom (critério 04) | Exportar o mesmo fornecedor nos dois lados e comparar, com o autcom como referência |
| E-mail enviado ao fornecedor errado por defeito no mapeamento de destinatários | Critério 09 cobre os dois caminhos; o caminho pelos fornecedores reusa `fSQLFornecedorEmail` em vez de reimplementar |
| Travessia de diretório no download | Validar `idProcessamento` numérico e `codFornecedor` contra a lista do processamento, nunca compor caminho com valor cru |
| `;charset=utf-8` do DMVCFramework corrompendo acento na planilha | Ver RN01. O mesmo defeito já foi observado nos PDFs e boletos do Faturamento e está registrado no `tasks.md` do Req. 454895 como achado para outro requisito — aqui ele volta como risco de primeira ordem, porque o conteúdo é texto acentuado |
