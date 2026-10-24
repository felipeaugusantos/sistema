# Especificação — Req. 462692

**Título:** Painel de Entregas — configuração de colunas visíveis na visualização de documentos
**Objetivo:** Permitir que o usuário escolha, entre cinco colunas configuráveis da grade de documentos, quais são ocultadas quando a janela do painel fica abaixo de 1370px — no lugar do par fixo que o sistema esconde hoje.
**Zona:** Legado (host `padra_atualizado/fontes/genericos/`) + package FMX `padra_atualizado/Packages/Principal/` — ver §5.1
**Data:** 2026-09-18
**Solicitante:** AUTCOM_PEPVC — Vitor / Aline

## 1. Contexto / problema atual

O Painel de Entregas (`TfmxPainelEntregas`, FireMonkey) exibe os documentos de um romaneio numa grade construída com um `TGridPanelLayout` de **13 colunas**. A grade existe duplicada em dois lugares que precisam manter exatamente a mesma definição de colunas:

- o cabeçalho, `layColunasGridDocumentos`, na própria form;
- cada linha de dado, no frame `TframeGridDocumentosLinha`.

Quando a largura da janela é **menor ou igual a 1370px**, o sistema zera a largura de duas colunas fixas — `DISTÂNCIA KM TEMPO DIST.` (índice 4) e `RECEBEDOR` (índice 6) — para que as demais caibam em tamanho legível. A regra está escrita **duas vezes**, com os valores `90` e `120` chumbados no código:

- `ConfigurarLayoutResponsivo` (`Principal.View.FMXPainelEntregas.pas:2641`) — executada **uma vez por linha de documento**;
- `FormResize` (`Principal.View.FMXPainelEntregas.pas:3976`) — executada no redimensionamento, sobre o cabeçalho.

O cliente do chamado usava a versão 150.105, que exibia a coluna `RECEBEDOR`. Na 150.100.12 entraram colunas novas, e como o monitor dele tem resolução abaixo de 1370, o painel passou a esconder `RECEBEDOR` — informação que, para ele, é essencial. Não há hoje nenhuma forma de escolher qual coluna sacrificar: a escolha é fixa no código e igual para todos.

### 1.1 Restrições técnicas levantadas na análise

Dois achados no fonte do FMX condicionam a solução e estão registrados aqui porque não são evidentes na leitura do código do painel:

**(a) O FMX reescreve as larguras percentuais.** Em `RecalcCellDimensions` (`FMX.Layouts.pas`), toda coluna com `SizeStyle = Percent` tem seu `Value` **normalizado em disco** para que o conjunto some 100 a cada realinhamento — e `TCellItem.SetValue` chama `Changed(False)`, que agenda esse realinhamento. Os valores de projeto gravados no `.fmx` (28,09 / 13,00 / 10,50…) não sobrevivem ao primeiro `Resize`, e escrever várias colunas percentuais em sequência faz cada escrita ser renormalizada contra um conjunto parcialmente atualizado, degradando as proporções de forma cumulativa.

Colunas `Absolute`, ao contrário, nunca são reescritas pelo FMX. É por isso que hoje só as duas colunas absolutas são escondidas: `90` e `120` estão no código-fonte e por isso podem ser devolvidas exatas.

**Este achado é o que determina o desenho adotado** (§1.2): ao tornar absolutas todas as colunas configuráveis, o sistema passa a escrever **apenas** em colunas absolutas. As percentuais restantes nunca são tocadas, e a renormalização delas vira idempotente — depois do primeiro passe já somam 100, e `Value/100*100` devolve o mesmo valor. O problema deixa de existir em vez de ser contornado.

**(b) O layout nunca "não cabe".** Havendo qualquer coluna percentual, o layout ocupa exatamente a largura disponível: ele espreme, não estoura. Portanto o aviso de espaço apresentado ao usuário **não pode** ser baseado em largura total. Chegou a existir na tela um aviso com essa conta, removido em 22/09/2026 por decisão do analista: o número confundia o usuário mais do que orientava. Fica o registro de por que um aviso ingênuo de "não cabe" seria errado.

### 1.2 Desenho adotado: obrigatórias percentuais, configuráveis absolutas

As 13 colunas passam a ter dois papéis:

- **Cinco colunas configuráveis** — `CIDADE - UF`, `DISTÂNCIA KM TEMPO DIST.`, `PREVISÃO ENTREGA`, `RECEBEDOR`, `MOTORISTA`. Todas com `SizeStyle = Absolute`. São as únicas que o usuário pode esconder, e as únicas em que o sistema escreve.
- **Oito colunas obrigatórias** — `ROTA`, `DOCUMENTO`, `CLIENTE`, `STATUS`, `ITENS`, `DATA INÍCIO`, `DATA BAIXA` e a célula de ícones. Sempre visíveis. As cinco percentuais entre elas (`CLIENTE`, `STATUS`, `ITENS`, `DATA INÍCIO`, `DATA BAIXA`) absorvem o espaço liberado por cada coluna escondida, mantendo o comportamento elástico que o painel já tem.

Três colunas mudam de `Percent` para `Absolute`: `CIDADE - UF` (era 13,000000), `PREVISÃO ENTREGA` (era 10,503618) e `MOTORISTA` (era 12,545222). As larguras absolutas foram definidas pelo analista em 22/09/2026, olhando a tela: **110, 90 e 100**. Por serem absolutas, valem em qualquer resolução.

**Os valores percentuais no `.fmx` não precisam ser alterados**, apenas o `SizeStyle` e o `Value` das três colunas convertidas — o FMX renormaliza o conjunto restante sozinho.

> **Correção de 22/09/2026 — a conversão NÃO é neutra.** Uma versão anterior desta seção afirmava que em 1366 o layout ficava pixel a pixel idêntico. A conta estava certa para o cenário de **13 colunas visíveis**, que é justamente o que nunca acontece abaixo de 1370: ali o padrão esconde duas colunas, e no sistema original esses 210px voltavam ao bolo percentual, alargando `CIDADE - UF`, `PREVISÃO ENTREGA` e `MOTORISTA` muito além da largura de projeto. Ao torná-las absolutas, elas ficaram congeladas no tamanho do cenário "tudo visível". O efeito real está em RN11.

### 1.3 Infraestrutura já existente que será reaproveitada

O autcom já possui persistência padronizada de configuração de colunas de grade:

- **Tabela `CFGCOL_GRD`** — registrada em `pIncluiProdCod('CFGCOL_GRD', ...)` (`untFuncoesGenerica.pas:46899`). Colunas: `AUTOINCREM`, `GRD_CHAVE_` (identificador da grade), `GRD_CODEMP`, `GRD_CODOPE` (nulo = padrão da empresa; preenchido = do operador), `GRD_COLFLD` (identificador da coluna), `GRD_COLCAP`, `GRD_COLORD`, `GRD_COLTAM`. **Semântica: linha presente = coluna visível.**
- **Classe `TConfiguracaoGrids`** (`padra_atualizado/fontes/configuracoes/untTConfiguracaoGrids.pas`) — lê e grava essa tabela.
- **Tela `TfrmConfiguracaoGrids`** (`padra_atualizado/fontes/configuracoes/untConfiguracaoGrids.pas`) — usada em Baixa a Receber, Baixa Cta. Pagar, Manutenção de Romaneio, Seleção de Documentos do Resumo de Caixa e outras.

**A tabela será reaproveitada; a tela e a classe, não.** Ambas são construídas a partir de um `TcxGrid` + `TcxGridDBTableView` reais e montam a pré-visualização criando colunas DevExpress ligadas a campos de um `TDataSet`. O Painel de Entregas não tem grid nem dataset — tem um `TGridPanelLayout` FireMonkey e uma lista de `IDocumento`. Alimentá-las exigiria fabricar um cxGrid e um dataset falsos só para isso. Decisão: reusar a tabela (o suporte continua olhando no mesmo lugar, e nenhuma tabela nova é criada) e escrever uma tela FMX enxuta no molde do `TfmxConsultaMotoristas`, que o painel já sabe abrir.

## 2. Módulos e entidades envolvidos

- **Módulo:** Painel de Entregas (package `Principal.View`) + funções genéricas do host.
- **Units:**

| Unit | Caminho | Papel |
|------|---------|-------|
| `Principal.View.FMXPainelEntregas` | `padra_atualizado/Packages/Principal/View/source/` | Painel; cabeçalho da grade e regra dos 1370 |
| `Principal.View.Frame.FMXPainelRotasGridDocumentosLinha` | `padra_atualizado/Packages/Principal/View/frames/` | Linha da grade; mesma definição de colunas |
| `Principal.View.PainelEntregas.Colunas` | `padra_atualizado/Packages/Principal/View/source/` | **Nova** — tabela constante das colunas + rotinas de aplicação |
| `Principal.View.FMXConfiguracaoColunasDocumentos` | `padra_atualizado/Packages/Principal/View/source/` | **Nova** — tela de seleção |
| `Principal.View.Interfaces` | `padra_atualizado/Packages/Principal/View/interfaces/` | `IFuncoes` ganha dois métodos |
| `untTFuncoesFiremonkey` | `padra_atualizado/fontes/genericos/` | Implementação de `IFuncoes` no host |
| `untTConfiguracaoColunasGrid` | `padra_atualizado/fontes/genericos/` | **Nova** — leitura/gravação de `CFGCOL_GRD` desacoplada de cxGrid |
| `Principal.View.dpk` | `padra_atualizado/Packages/Principal/View/package/` | Registro das units novas |

- **Tabelas:**
  - `CFGCOL_GRD` — **já existe, sem alteração de estrutura**. Chave lógica usada: `GRD_CHAVE_ = 'PAINELENTREGAS.DOCUMENTOS'` + `GRD_CODEMP` + `GRD_CODOPE`. Chave primária física: `AUTOINCREM`.

## 3. Requisitos funcionais

- **RF01** — Na visualização de documentos do Painel de Entregas, exibir um ícone de configuração (engrenagem) na barra superior, ao lado do `imgVoltar`. O ícone só aparece quando a janela está **em 1370px ou menos** — acima disso todas as colunas cabem e a configuração é ignorada, então o botão não teria efeito. Fora dessa condição ele acompanha o `imgVoltar`: some ao sair da visualização de documentos. A comparação é a mesma de RN09; divergir criaria uma faixa em que a escolha vale mas não há como alterá-la.
- **RF02** — O clique no ícone abre a tela de seleção de colunas, modal, com a lista das **cinco colunas configuráveis** (RN01), cada uma com um marcador de exibição, na mesma ordem em que aparecem no painel. As oito colunas obrigatórias não são listadas — não há o que decidir sobre elas.
- **RF03** — A tela inicia com o estado atualmente em vigor para o operador: o que ele gravou antes ou, se nunca gravou, o padrão de fábrica (`DISTÂNCIA KM TEMPO DIST.` e `RECEBEDOR` desmarcadas, as outras três marcadas).
- **RF04** — O usuário marca e desmarca livremente, podendo inclusive esconder as cinco. Não há trava: as colunas obrigatórias garantem que a grade nunca fica vazia.
- **RF07** — Botão **Gravar**: persiste a escolha para o operador logado e a empresa corrente, fecha a tela e reconstrói a grade de documentos imediatamente, sem exigir que o usuário volte e entre de novo no romaneio. Enquanto isso o painel exibe o overlay de aguarde que já existe (`recCarregando`), com mensagem e barra de progresso, reusando `pStepStatusGravacao` — são quatro passos: gravar, reler, ajustar o cabeçalho e atualizar os documentos. O overlay é escondido em `finally`, para não ficar preso na tela se algo falhar no meio.
- **RF08** — Botão **Restaurar padrão**: descarta a configuração do operador e volta ao comportamento de fábrica.
- **RF09** — Botão **Cancelar** (e a tecla ESC): fecha sem gravar nada.
- **RF10** — Com a janela em 1370px ou menos, o painel aplica a configuração do operador. Acima de 1370px, o painel exibe **todas** as colunas, ignorando a configuração. A distribuição de largura nessa faixa muda em relação à versão atual, por consequência da conversão de três colunas para absolutas — ver RN11; não é a configuração do operador agindo.
- **RF11** — A configuração vale para o cabeçalho e para todas as linhas de documento simultaneamente; as duas definições de coluna são aplicadas a partir da mesma fonte.

## 4. Regras de negócio

- **RN01 — Identidade das colunas.** A persistência usa chave textual estável em `GRD_COLFLD`, nunca o índice numérico da coluna. Inserir uma coluna no meio do layout no futuro não pode embaralhar a configuração já gravada dos clientes. Tabela de colunas:

| Índice | `GRD_COLFLD` | Rótulo na tela | `SizeStyle` | Valor | Largura em 1366 | Papel |
|--------|--------------|----------------|-------------|-------|-----------------|-------|
| 0 | `ROTA` | ROTA | Absolute | 40 | 40 | obrigatória |
| 1 | `DOCUMENTO` | DOCUMENTO | Absolute | 115 | 115 | obrigatória |
| 2 | `CLIENTE` | CLIENTE | Percent | 28,093286 | 242 | obrigatória, elástica |
| 3 | `CIDADEUF` | CIDADE - UF | Absolute **(convertida)** | 110 | 110 | **configurável** |
| 4 | `DISTANCIA` | DISTÂNCIA KM TEMPO DIST. | Absolute | 90 | 90 | **configurável**, oculta por padrão |
| 5 | `PREVISAO` | PREVISÃO ENTREGA | Absolute **(convertida)** | 90 | 90 | **configurável** |
| 6 | `RECEBEDOR` | RECEBEDOR | Absolute | 100 | 100 | **configurável**, oculta por padrão |
| 7 | `MOTORISTA` | MOTORISTA | Absolute **(convertida)** | 100 | 100 | **configurável** |
| 8 | `STATUS` | STATUS | Percent | 7,425318 | 64 | obrigatória, elástica |
| 9 | `ITENS` | ITENS | Percent | 7,425318 | 64 | obrigatória, elástica |
| 10 | `DATAINICIO` | DATA INÍCIO | Percent | 10,503618 | 90 | obrigatória, elástica |
| 11 | `DATABAIXA` | DATA BAIXA | Percent | 10,503618 | 90 | obrigatória, elástica |
| 12 | `ICONES` | Assinaturas / Fotos / Observações | Absolute | 100 | 100 | obrigatória |

  Para as cinco **configuráveis** o número é a largura fixa, em pixels, válida em qualquer resolução. Para as cinco **percentuais obrigatórias** o número é apenas a largura de referência gravada em `GRD_COLTAM`; na tela elas ficam maiores, porque repartem o que sobra. A largura útil de referência é 1326 (janela de 1366 menos as margens de 20 de `layGridDocumentos`).

- **RN02 — Ocultar e restaurar.** Ocultar é atribuir `0` ao `Value` da célula; restaurar é atribuir o valor absoluto da tabela acima. **O sistema só escreve nas cinco colunas configuráveis**, todas absolutas. Nenhuma coluna percentual é jamais escrita pelo código: elas se reacomodam sozinhas, porque o FMX renormaliza o conjunto restante a cada realinhamento.

- **RN03 — Aplicação em lote.** A aplicação ocorre entre `ColumnCollection.BeginUpdate` e `EndUpdate`, para que as cinco atribuições produzam um único realinhamento em vez de cinco. Com o desenho de §1.2 isto é otimização, não correção — escrever apenas colunas absolutas já é seguro, e a renormalização das percentuais é idempotente. Mantido porque `ConfigurarLayoutResponsivo` roda uma vez por linha de documento.

- **RN04 — A grade nunca fica vazia.** Garantido pelo desenho: as oito colunas obrigatórias não são configuráveis. Não há trava na tela, e esconder as cinco configuráveis é uma escolha válida.

- **RN06 — Escopo da persistência.** Uma linha em `CFGCOL_GRD` por coluna **visível**, com `GRD_CHAVE_ = 'PAINELENTREGAS.DOCUMENTOS'`, `GRD_CODEMP` = empresa logada, `GRD_CODOPE` = operador logado (sempre preenchido). Gravar é substituir o conjunto: apagar as linhas do trio chave/empresa/operador e inserir as marcadas, dentro de uma transação.

- **RN07 — Ausência de configuração.** Zero linhas para o operador significa "nunca configurou" e ativa o padrão de fábrica de RN01, que reproduz exatamente o comportamento atual do sistema. Restaurar padrão (RF08) grava esse mesmo estado apagando as linhas do operador.

- **RN08 — Ordem e largura gravadas.** As colunas visíveis são enviadas ao host **na ordem do layout**. `GRD_COLORD` recebe a posição da coluna nessa sequência e `GRD_COLTAM` recebe a largura derivada de RN01, para que as linhas fiquem coerentes com as demais grades que usam `CFGCOL_GRD`. Nenhum dos dois é lido de volta nesta entrega — reordenar e redimensionar coluna está fora de escopo (§7).

- **RN09 — Limiar de 1370.** O limiar permanece 1370 e continua chumbado, mas passa a existir **num único ponto**, consumido tanto pelo cabeçalho quanto pelas linhas.

- **RN10 — Consistência da tabela de colunas.** Se a quantidade de colunas do `TGridPanelLayout` divergir da tabela constante (alguém inseriu coluna no designer sem atualizar o código), a aplicação não altera nada e registra o erro via `IFuncoes.GravarLogErro`. Falha silenciosa aqui produziria um layout embaralhado sem pista de causa.

- **RN11 — Mudança assumida de largura, em qualquer resolução.** Coluna absoluta não cresce. Como `CIDADE - UF`, `PREVISÃO ENTREGA` e `MOTORISTA` deixam de ser percentuais, elas passam a ter largura fixa e o espaço que ocupariam a mais vai para `CLIENTE`, `DATA INÍCIO`, `DATA BAIXA`, `STATUS` e `ITENS`. **Isto vale também em 1366**, onde o padrão esconde duas colunas e o original repartia os 210px liberados entre as percentuais. No padrão de fábrica a 1366, com as larguras aprovadas (110 / 90 / 100):

| Coluna | Original | Depois | Δ |
|--------|---------:|-------:|--:|
| CIDADE - UF | 139 | 110 | −29 |
| PREVISÃO ENTREGA | 112 | 90 | −22 |
| MOTORISTA | 134 | 100 | −34 |
| CLIENTE | 301 | 339 | +38 |
| DATA INÍCIO | 112 | 127 | +15 |
| DATA BAIXA | 112 | 127 | +15 |
| STATUS | 80 | 90 | +10 |
| ITENS | 80 | 90 | +10 |

  E numa janela de 1920 (útil 1880), com as 13 visíveis:

| Coluna | Hoje | Depois | Δ |
|--------|-----:|-------:|--:|
| CIDADE - UF | 184 | 112 | −72 |
| PREVISÃO ENTREGA | 149 | 90 | −59 |
| MOTORISTA | 178 | 108 | −70 |
| CLIENTE | 398 | 485 | +87 |
| DATA INÍCIO | 149 | 181 | +32 |
| DATA BAIXA | 149 | 181 | +32 |
| STATUS | 105 | 128 | +23 |
| ITENS | 105 | 128 | +23 |

  Decisão tomada com o trade-off à vista: nome de cidade e horário de previsão não ficam mais longos conforme o monitor cresce, então o espaço é mais bem empregado em `CLIENTE`. O ponto de atenção é `MOTORISTA`, que em tela grande perde 70px e pode truncar nomes longos — se isso incomodar em campo, o remédio é elevar o valor absoluto dela na tabela de RN01, ao custo de apertar as elásticas em 1366. Em 1366 e abaixo nada muda.

## 5. Requisitos técnicos / não-funcionais

### 5.1 Zona

O `CLAUDE.md` não mapeia `padra_atualizado/Packages/`. A entrega vive em duas zonas distintas e cada uma segue a sua:

- **`padra_atualizado/Packages/Principal/View/`** — código FireMonkey recente, units em dot-notation. O estilo local é misto: convive `LMotorista`/`LCodMot` com resquícios de Hungarian (`strURL`, `recUltimoFiltro`, `lstDocs`). **Nas units novas seguir o padrão predominante e mais recente do package** — `A` em parâmetro, `L` em local, `F` em campo, sem prefixo de tipo. Não é zona Legado: não introduzir Hungarian em código novo aqui.
- **`padra_atualizado/fontes/genericos/`** — **Legado**. Hungarian obrigatório, prefixos `p`/`f` em métodos, `fCriaQuery`, SQL embutido com `ParamByName()`.

### 5.2 Acesso a dados

O package `Principal.View` **não executa SQL** — verificado: nenhuma ocorrência de `TUniQuery`, `fCriaQuery` ou `SQL.Text` em `Principal.View.FMXPainelEntregas.pas`. Todo acesso a banco passa pelo host através de `IFuncoes` / `IDashboard`. A persistência desta entrega segue a mesma regra: dois métodos novos em `IFuncoes`, implementados no host.

### 5.3 Performance

`ConfigurarLayoutResponsivo` roda **uma vez por linha de documento**. A lista de colunas ocultas é lida do banco **uma única vez**, no `FormShow` do painel, e mantida em campo da form. Nenhuma consulta pode ser disparada dentro do laço de montagem das linhas.

### 5.4 Transação

A gravação em `CFGCOL_GRD` (apagar + inserir) ocorre dentro de `fStartTransaction` / `fCommit`, com `fRollBack` no `except` e `raise` sem parâmetros, seguindo `TConfiguracaoGrids.GravarDados`.

  > Correção apurada na implementação: o `CLAUDE.md` lista `fStartTransactionGen` / `fCommitGen` / `fRollBackGen` como os helpers de transação do projeto, e esta spec repetiu isso. Esses três **não existem em `padra_atualizado/`** — vivem apenas em `autcomtinta/untFuncoesGen.pas` e `auttin/Funcoes/untFuncoesGen.pas`. Na zona deste requisito a API é `fStartTransaction` / `fCommit` / `fRollBack`, de `untFuncoesSimples`.

### 5.5 TSPlus

A tela nova precisa do mesmo tratamento das demais telas FMX do painel: quando `objFuncoes.RunningInTSPlus`, abrir por `objFuncoes.pAbrirFmx`; caso contrário, `ShowModal`. Molde: `TfmxPainelEntregas.ConsultaMotorista`.

### 5.6 Encoding

`.pas` e `.fmx` do package em Windows-1252, conforme o `.editorconfig`. Os rótulos com acento (`DISTÂNCIA`, `PREVISÃO`, `CIDADE - UF`) estão na tabela constante em Pascal — atenção ao gravar o arquivo, ver aviso do `CLAUDE.md` sobre editores que salvam em UTF-8.

### 5.7 Permissão e auditoria

Preferência pessoal de visualização, sem impacto em dado de negócio: **sem** controle de acesso por `fVerificaAcessoSistema` e **sem** registro em auditoria.

## 6. Critérios de aceitação

Estes critérios são a entrega de quem implementa. A escrita dos casos de teste é do analista (§8).

- [ ] **CA01** — Em janela maior que 1370px, o painel exibe as 13 colunas, independentemente do que estiver gravado para o operador. As larguras seguem RN11: `CIDADE - UF`, `PREVISÃO ENTREGA` e `MOTORISTA` fixas em 112, 90 e 108, e a folga em `CLIENTE`, nas datas, em `STATUS` e `ITENS`. **Não é idêntico à versão anterior** — é a mudança assumida.
- [ ] **CA02** — Em janela de 1366px, com o operador sem nenhuma configuração gravada, o painel esconde `DISTÂNCIA KM TEMPO DIST.` e `RECEBEDOR`, e as demais colunas medem 40 / 115 / 339 / 110 / 90 / 100 / 90 / 90 / 127 / 127 / 100. **Não é idêntico ao comportamento anterior** — ver a tabela de RN11 para o antes e depois.
- [ ] **CA03** — Desmarcando `CIDADE - UF` e `DISTÂNCIA KM TEMPO DIST.` e marcando `RECEBEDOR`, em janela de 1366px, o painel passa a exibir `RECEBEDOR` e a esconder as outras duas, no cabeçalho **e** em todas as linhas. É o cenário exato do chamado que originou o requisito: 202px liberados contra os 210 que o corte fixo liberava hoje.
- [ ] **CA04** — Redimensionar a janela de 1920px para 1200px e de volta para 1920px, cinco vezes seguidas, não altera a largura das colunas configuráveis nem a proporção das elásticas. (Valida RN02: como o código só escreve em colunas absolutas, a renormalização do FMX não tem o que corromper.)
- [ ] **CA05** — Abrir e fechar a visualização de documentos de dez romaneios não dispara nenhuma consulta adicional a `CFGCOL_GRD` além da leitura única do `FormShow`.
- [ ] **CA06** — A configuração gravada por um operador não aparece para outro operador na mesma empresa, nem para o mesmo operador em outra empresa.
- [ ] **CA07** — "Restaurar padrão" devolve o comportamento de CA02 e remove as linhas do operador em `CFGCOL_GRD`.
- [ ] **CA08** — Com as cinco configuráveis desmarcadas, o Gravar permanece disponível e o painel exibe apenas as oito obrigatórias, que se redistribuem pelos 520px liberados.
- [ ] **CA09** — Marcando as cinco configuráveis em janela de 1200px, o Gravar permanece disponível e o painel passa a exibir as 13 colunas espremidas. Não há aviso nem bloqueio.
- [ ] **CA10** — Com a janela acima de 1370px, a engrenagem **não aparece** na barra. Redimensionar para 1366px sem sair da visualização de documentos faz ela aparecer; voltar para 1920px faz sumir.
- [ ] **CA11** — Ao confirmar, a grade é reconstruída na hora, sem sair e voltar ao romaneio, **e o cabeçalho acompanha as linhas**. Conferir alinhamento entre título e dado coluna a coluna, não só que as linhas mudaram.

  > Defeito real, corrigido em 22/09/2026: `AtualizaDocumentos` reconstrói as linhas, e cada uma passa por `ConfigurarLayoutResponsivo`, mas o cabeçalho é um layout à parte na form e ninguém o tocava — só o `FormResize` fazia isso. Gravar não dispara resize, então o título ficava com as larguras antigas e descasado do dado. O mesmo valia na primeira abertura da visualização de documentos, que dependia de o `OnResize` ocorrer depois do `OnShow`. Hoje `AplicarColunasDocumentos(layColunasGridDocumentos)` é chamado explicitamente nos três pontos: `FormResize`, `AbrirTelaDocumentos` e o clique da engrenagem.
- [ ] **CA12** — O painel abre e opera normalmente em sessão TSPlus, e a tela de configuração abre por `pAbrirFmx`.
- [ ] **CA13** — Os números `90`, `120` e `1370` não aparecem mais duplicados no `.pas`: existe uma única definição consumida pelo cabeçalho e pelas linhas.
- [ ] **CA14** — O cabeçalho e o frame de linha declaram o mesmo `SizeStyle` nas 13 colunas e o mesmo `Value` nas **absolutas**. Nas percentuais a comparação é por **proporção entre elas**, não pelo número escrito: o designer renormaliza o conjunto para somar 100 ao salvar, então os dois arquivos divergem no texto sem divergir no layout. Divergência real entre os dois `.fmx` é o modo de falha mais provável desta entrega, já que a conversão precisa ser feita duas vezes.

## 7. Fora de escopo

- **Reordenar colunas.** `GRD_COLORD` é gravado mas não lido. Trocar a ordem exigiria remanejar controles entre células no cabeçalho e no frame.
- **Redimensionar colunas.** `GRD_COLTAM` é gravado mas não lido.
- **Configuração no nível da empresa.** `CFGCOL_GRD` suporta `GRD_CODOPE` nulo como padrão da empresa, e outras telas usam isso. Nesta entrega a leitura considera **apenas** as linhas do operador: um segundo nível de configuração sem tela para administrá-lo seria uma armadilha de suporte. A tabela continua permitindo adicionar isso depois.
- **Demais grades do Painel de Entregas.** A configuração vale só para a grade de documentos. A grade de romaneios (`layColunasGridRomaneio`), pendências e itens a liberar ficam como estão.
- **Reaproveitar `TfrmConfiguracaoGrids`.** Decisão registrada e justificada em §1.3.
- **Rever o limiar de 1370px.** Permanece como está.
- **Casos de teste automatizados.** Ver §8.

## 8. Testes

O package `Principal` não possui infraestrutura de teste automatizado, e pelo `CLAUDE.md` os casos de teste da zona moderna são escritos por analista humano. Portanto:

- A entrega de quem implementa é **o contrato e a lista de casos a cobrir** — os critérios de aceitação de §6 — mais o roteiro de validação manual descrito no `plan.md`.
- Nenhuma tarefa de "escrever testes" é atribuída a quem implementa.

## 9. Dependências, riscos e pendências

- **P01 — Larguras mínimas das elásticas (encerrada em 22/09/2026).** A pendência existia para calibrar o aviso de espaço. O aviso foi removido a pedido do analista, por confundir mais do que ajudar, e com ele o único consumidor de `MinimoElasticas`. O campo `LarguraMinima` continua na tabela apenas para alimentar `GRD_COLTAM`, que não é lido de volta — portanto nenhum ajuste é necessário.

  Os valores absolutos das cinco configuráveis (112 / 90 / 90 / 120 / 108) são um segundo conjunto de números ajustáveis, mas com efeito diferente: cada um governa a largura daquela coluna em **todas** as resoluções, e elevá-lo aperta as elásticas em 1366. Ver RN11.
- **D01 — Ícone de engrenagem (resolvida).** O ícone foi fornecido e está versionado junto deste requisito, em `IA/specs/462692/settings-20px.png` — PNG 20×20 RGBA, 930 bytes, sha1 `b02d63b66367d8a58cb35e7ca688eccc7435e689`. Mesmo formato dos demais ícones do painel, que vivem embutidos como `MultiResBitmap` de 20×20 dentro do `.fmx` (`left.png`, `note.png`, `place.png`, `photo-camera.png`…).

  Observação para a implementação: a pasta `imagens/Icons/20px/`, apontada pelos `FileName` de todos os ícones do `.fmx`, **não está versionada nesta cópia** — os caminhos gravados lá são de outra máquina (`...\74.Des\...`) e não resolvem. O que vale é o blob embutido; o `FileName` é apenas o rastro de quem arrastou a imagem no designer. Portanto o ícone é embutido no `.fmx` a partir do arquivo acima, e não há dependência de pasta externa. O plano B de rótulo textual fica descartado.
- **R01 — Divergência entre as duas definições de coluna.** Cabeçalho e frame são hoje dois `TGridPanelLayout` independentes com valores repetidos à mão. A tabela constante os unifica em código, mas nada impede alguém de mexer só num `.fmx`. Mitigação: RN10 (verificação de contagem com log).
- **R02 — Renormalização do FMX (neutralizado pelo desenho).** Descrito em §1.1-a. O desenho de §1.2 faz o código escrever exclusivamente em colunas absolutas, que o FMX nunca reescreve, e a renormalização das percentuais restantes é idempotente. Deixa de exigir cuidado no código; CA04 permanece como rede de segurança, não como mitigação obrigatória.
- **R04 — Conversão feita num `.fmx` e esquecida no outro.** As três colunas que mudam de `Percent` para `Absolute` precisam ser convertidas **duas vezes** no designer: em `layColunasGridDocumentos` (cabeçalho) e no `TGridPanelLayout` do frame de linha. Convertida só no cabeçalho, o desalinhamento entre título e dado só aparece visualmente, sem erro de compilação. É o modo de falha mais provável desta entrega. Mitigação: CA14.
- **R03 — `CFGCOL_GRD` inexistente em base antiga.** `TLibCartoesConfiguracaoGrids` testa a existência da tabela com `SHOW TABLES LIKE` antes de usá-la, o que indica que já houve base sem ela. A tabela está registrada em `pIncluiProdCod`, portanto o atualizador a cria; ainda assim, a leitura deve degradar para o padrão de fábrica em vez de estourar exceção se a tabela não existir.
