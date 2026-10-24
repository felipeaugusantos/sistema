# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuração do ambiente de desenvolvimento

O repositório inclui um `.editorconfig` que configura automaticamente charset `latin1` (Windows-1252), CRLF e indentação para arquivos Delphi. Para que tenha efeito, é necessário instalar a extensão **EditorConfig** na IDE ou editor utilizado:

- **VS Code**: [EditorConfig for VS Code](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
- **Delphi / RAD Studio**: sem suporte nativo — o encoding é controlado pelo hook `.claude/hooks/delphi-encoding.ps1`

Sem a extensão instalada, o `.editorconfig` é ignorado silenciosamente e o editor pode salvar arquivos em UTF-8, corrompendo caracteres especiais nos fontes.

**Onde a proteção alcança — e onde não:**

| | `.pas` `.dfm` `.dpr` `.dpk` `.dproj` `.lpr` | `.inc` | `.sql` |
|---|---|---|---|
| `.editorconfig` | cobre | **não** | **não** |
| hook `delphi-encoding.ps1` | cobre | cobre | **não** |

**`.sql` está fora dos dois.** Editor que salve em UTF-8 corrompe acento em script, e nada avisa — o arquivo só denuncia quando alguém lê o resultado no banco. Ao alterar `.sql` com acento, conferir o encoding antes e depois; para troca cirúrgica, editar em bytes.

O encoding também **varia por arquivo**, e não por extensão: há `.pas` em cp1252 e `.pas` em UTF-8 com BOM na mesma pasta. Conferir o arquivo, não presumir pela pasta.

## Visão Geral

ERP para varejo/setor de tintas desenvolvido em **Delphi Seattle** (Object Pascal). Composto por uma aplicação desktop VCL principal, serviços Linux (daemons REST) e módulos independentes. Banco de dados: **MySQL**. Controle de versão: **SVN**.

## Pasta `IA\` — specs, regras e conhecimento

Três pastas, cada uma com um gênero. Não misturar.

| Pasta | O que vive nela |
|-------|-----------------|
| `IA\specs\<chave>\` | Um diretório por requisito — ver os cinco arquivos na seção abaixo |
| `IA\rules\<tema>.md` | Regra de um subsistema, carregada sob demanda — ver *Índice de rules* abaixo |
| `IA\know\<tema>.md` | Como o **sistema** funciona: documento por tema, para a equipe |

### `IA\specs\<chave>\`

A chave é o **número do requisito** (`454895`). Trabalho sem número recebe **slug** em kebab-case (`pdf-pedido-compra`) — acontece de verdade e não é exceção; quando o número sair, renomear a pasta.

Cinco arquivos, com leitores diferentes:

| Arquivo | O quê | Quem lê |
|---------|-------|---------|
| `spec.md` | Contrato: requisitos, regras, critérios de aceitação | eu, nas sessões seguintes |
| `plan.md` | Plano técnico: units impactadas, sequência | eu |
| `tasks.md` | Checklist de execução por fase | eu, durante a implementação |
| `analysis.md` | Texto de entrega do DelphAI, CAIXA ALTA | revisor humano |
| `record.md` | Retrospectiva da sessão: jornada de investigação, hipóteses descartadas, decisões que não aparecem no texto curto | quem retomar o assunto meses depois |

O `record.md` é gravado pelo `/resumoAnaliseRequisito`, é **único por requisito** e consolidado entre sessões — nunca sobrescrito em silêncio.

**O `tasks.md` é checklist, não diário.** Se ele passar de ~10 KB, virou registro no lugar errado: o que é narrativa pertence ao `record.md`.

Quando for passado um número de requisito, procurar `IA\specs\<numero>\` e ler o que existir lá. Se não encontrar nada, **perguntar ao usuário como ele quer conduzir o levantamento** antes de começar — há mais de um caminho, e a escolha é dele. Em qualquer caso os artefatos são gravados ali.

Se encontrar um documento de levantamento já feito, tratá-lo como fonte de verdade e **não reconduzir a entrevista**.

**Nome dos arquivos — singular ao escrever, plural aceito ao ler.** O padrão é `spec.md` / `plan.md`. Requisito antigo pode ter `specs.md` / `plans.md`: ler os dois, escrever sempre no singular, e **não** renomear arquivo alheio "para padronizar" — pode haver sessão em andamento nele.

### `IA\rules\` — só vale se estiver indexada

Regra que não é carregada não é obedecida. Toda regra em `rules\` precisa de uma linha neste `CLAUDE.md`, na seção abaixo — mesmo mecanismo que o `MEMORY.md` usa com a pasta `memory\`. Sem a linha, o arquivo é invisível.

O escopo de `rules\` é o **autcom** — mesma abrangência das travas do pre-commit.

**Índice de rules:**

| Regra | Quando carregar |
|-------|------------------|
| `IA\rules\tef-dvc.md` | Ao mexer no transporte DVC/pipe, no roteador da estação ou em `TTefCitelDvc` (Req. 456190) — nunca impor timeout artificial sobre o tempo do pinpad/transação TEF |

### `IA\know\` — e a fronteira com a memória

`know\` é conhecimento **do sistema**, versionado, escrito para a equipe ler. A memória do Claude Code (`memory\*.md` + `MEMORY.md`) é recall de sessão, local por máquina, um fato por arquivo.

Conteúdo que serve aos dois vive em `know\`, e a memória guarda só o **ponteiro**. Nunca duplicar o texto — as duas cópias divergem e aí nenhuma é confiável.


## Arquitetura


### Camada 1 — Aplicação Desktop (`padra_atualizado/`)

Aplicação VCL Windows principal. Código-fonte em `padra_atualizado/fontes/`, organizado por domínio de negócio:

| Pasta | Domínio |
|-------|---------|
| `faturamento/` | Faturamento e vendas (maior módulo) |
| `cadastros/` | Cadastros mestres (clientes, produtos, fornecedores) |
| `movimentacaoitens/` | Movimentação de estoque |
| `financeiro/` | Contas a pagar/receber, cobrança |
| `fiscal/` | Obrigações fiscais e tributárias |
| `relatorios/` + `relatorios_dll/` | Motor de relatórios (DLLs por domínio) |
| `genericos/` | Utilitários compartilhados por todos os módulos |
| `util/` | Helpers gerais |

### Camada 2 — Serviços Linux (`padra_atualizado/Services/`)

Daemons REST compilados para Linux usando **DMVCFramework**. Cada serviço segue o padrão:
```
Services/<Nome.Servico>/
  Source/     → lógica de negócio (.pas)
  Target/Linux/ → projeto Delphi (.dpr/.dproj) + deployproj
```

O serviço central é `Faturamento.Services.API/` — expõe controladores REST para pedido, faturamento, PIX, tintométrico, etiqueta e SFA Mobile. Framework compartilhado em `Services/Core/` (REST client, DMVCFramework, JWT).

### Módulos Independentes

| Pasta | Compilado ativo | Função |
|-------|----------------|--------|
| `autban/` | `libAutban.dll` | Integração bancária (85+ bancos, formatos 240p/400p) |
| `auttin/` | `libAuttin.dll` | UI tintométrica — `AutTin.exe` na pasta está **obsoleto e ignorado**; apenas a DLL é compilada |
| `autcomtinta/` | `AutcomTinta.dll` | Hub central tintométrico — carrega DLLs de marca via `LoadLibrary` (código legado, estilo VCL) |
| `PainelNfe/` | Pacotes VCL | Painel de gestão de NF-e |
| `LibTintas/` | 1 DLL por marca | Plugin de fórmulas — cada marca é uma DLL independente carregada pelo AutcomTinta |

> **Atenção:** a presença de um `.dpr` em uma pasta **não garante** que ele seja compilado ativamente. Sempre verificar `autcom.groupproj` ou `Services.groupproj` como fonte de verdade.

### Bibliotecas Compartilhadas (prefixo `lib`)

| Pasta | Função |
|-------|--------|
| `libCartoes/` | Processamento de cartões (20 adquirentes: Cielo, Stone, GetNet…) |
| `libIntegracaoCartoes/` | Gateways de cartão (conciliação, confirmação, Koncilia) |
| `libIntegracaoContasBancarias/` | Open banking / extrato bancário |
| `libIntegracaoPixCitel/` | PIX (integração Citel) |
| `libTefMultiplus/` | TEF/PinPad |
| `libApiREST/` | Infraestrutura REST reutilizável |
| `Contabilidade/` | Módulo contábil com arquitetura limpa (Classes / Interfaces / Services / Repositories / Factories / Model / View) |

## Build

- IDE: **Delphi Seattle** (RAD Studio)
- Serviços Linux compilados via PAServer (cross-compiler Delphi para Linux)

**Arquivos de build — fonte de verdade:**

| Arquivo | Compila |
|---------|---------|
| `padra_atualizado/autcom.groupproj` | ERP desktop completo: `autcom.exe` + todas as DLLs Windows + LibTintas + Monitors |
| `padra_atualizado/autcom.bpg` | **Ignorar** — formato legado BPG, substituído pelo `autcom.groupproj` |
| `padra_atualizado/Services/Services.groupproj` | Todos os 38 serviços Linux |
| `libCartoes/libCartoesProjetos.groupproj` | 20 DLLs de adquirentes de cartão |

**Monitors** (`padra_atualizado/Monitors/`): aplicações Windows de monitoramento incluídas no `autcom.groupproj` — ConsultaPagamentosPixMonitor, MonitorContabil, StatusPedidoMonitor, ReservaItemPedidoMonitor e outros.

**Regra — edição de projetos:** para adicionar ou remover units, edite apenas o `.dpr` (cláusula `uses`) — a IDE sincroniza o `.dproj` ao abrir ou compilar. Edição manual do `.dproj` só é justificável para alterar opções de compilador, configurações de deploy/PAServer ou recursos embarcados que não residem no `.dpr`; nunca para mexer no conjunto de units.

## CI/CD e Gate de Qualidade

### Travas do pre-commit SVN

O hook SVN rejeita commits que contenham os padrões abaixo. **Nunca gerar código com esses padrões** — o commit será bloqueado automaticamente.

**Componentes proibidos — usar substitutos:**

| Proibido | Usar em vez |
|----------|------------|
| `TBitBtn`, `TButton` | `TBitBtnLocked` |
| `TDataSetProvider`, `TClientDataSet`, `TProvider` | `TUniQuery`, `TUniClientDataSet` (UniDAC) |
| `TDBGrid` | `TcxGridCitel` (wrapper do projeto, unit `cxGridCitel`) ou `TcxGrid` (DevExpress direto) — prefixo `cxg` nos componentes; view: `TcxGridDBTableView`; colunas: `TcxGridDBColumn` |
| `dxSkin*` em qualquer uso | Proibido em código novo — aumenta significativamente o tamanho do executável |
| `frxSmartMemo`, `frCoreClasses` | Componentes retirados do projeto |

**Chamadas proibidas — usar substitutos:**

| Proibido | Motivo / Usar em vez |
|----------|---------------------|
| `.SetFocus` direto | Usar `pSetFocus(componente)` (procedure do projeto) |
| `StrToFloat(`, `StrToFloatDef(` | Usar `fStrToFloat(` / `fStrToFloatDef(` (funções do projeto) |
| `ActiveControl :=` (exceto `:= nil`) | Não atribuir ActiveControl diretamente |
| `Application.CreateForm(` | Usar `pCriarForm` ou `pCriarFormularios` de `padra_atualizado/fontes/genericos/untFuncoesSimples.pas` |
| `NOW()`, `Now()`, `Now` em SQL/código | Usar `fNow()` (função do projeto). **Motivo:** estações com relógio errado gravariam pedidos/vendas com data incorreta. **Exceção estabelecida — TTL de cache em memória** (expiração de entrada, cleanup interval, sem gravação em banco): usar `System.SysUtils.Now` qualificado — convenção adotada em todos os caches do projeto. Um eventual NTP step backwards apenas atrasa a expiração da entrada, sem corromper dados. `TStopwatch`/`GetTickCount64` são alternativa válida para medição de duração de operações, mas não são mandatórios. Não se aplica a: logs persistidos, timestamps de auditoria, qualquer valor gravado em banco/arquivo/REST response. |

**SQL proibido:**

| Proibido | Motivo |
|----------|--------|
| `FOREIGN_KEY_CHECKS`, `SET_FOREIGN_CHECKS` | Não desabilitar FKs em nenhum script |

**Propriedades de formulário proibidas (Fast4):**
- `FillType = ftBrush`
- `Outline =`

---

### DelphAI — Gate de commit (ferramenta interna)

Ferramenta obrigatória executada antes de commitar no SVN. Gera um token que deve estar presente na mensagem de commit.

**Regras de commit:**
- Primeira linha: `Req. ####` (número do requisito)
- Token do DelphAI obrigatório na mensagem

**Arquivos locais** (não modificar): `.delphAI/`, `review.diff`

**Papel do Claude Code:** auxílio durante o desenvolvimento. O `/review` antecipa problemas antes da submissão ao DelphAI, não o substitui.

## Testes

- `padra_atualizado/TestesAutomatizadosFulfillment/` — suite de testes automatizados para o módulo Fulfillment (integração com Mercado Livre/MGL)
- `padra_atualizado/Services/Faturamento.Services.API/Target/Linux/Test_Cases/` — testes de integração da API REST (`.inc` incluídos no `.dpr` de teste)
- `padra_atualizado/Services/Services.Tests.groupproj` — projetos de teste. Hoje só o Faturamento tem projeto de teste REST (`FaturamentoServicesTEST.dpr`)

**Quem escreve teste — não presumir:**

| Zona | Situação |
|------|----------|
| Legado (`fontes/`, `libCartoes/`, `autban/`…) | **Não há infraestrutura de teste.** Não propor TDD nem teste-primeiro. Validação é manual, com roteiro descrito |
| Moderna (`Services/`, `Contabilidade/`) | Existe infraestrutura, mas **os casos de teste são escritos por analista humano**, não por quem implementa |

Consequências para plano e tarefas:

- **Nunca escrever "escrever os testes" como tarefa de quem implementa.** Marcar o dono da tarefa quando ela for do analista.
- A entrega de quem implementa é o **contrato e a lista de casos a cobrir** — tipicamente os critérios de aceitação da spec. Isso é entregável explícito, não subproduto.
- Criar ou registrar **projeto** de teste (`.dpr`, `Services.Tests.groupproj`, compilar para Linux) é trabalho de projeto Delphi, portanto de quem implementa. Escrever **caso** de teste é do analista.
- Teste-primeiro não se aplica em nenhuma das duas zonas — na legada por falta de infraestrutura, na moderna por divisão de papel.

## Uso de Skills e Subagentes (plugin delphi-dev)

As skills do plugin `delphi-dev` (`/delphi-laudo`, `/delphi-write`, `/delphi-testes`, `/delphi-spec`, `/delphi-standards`) carregam um style guide genérico de Delphi que **conflita com os padrões da Zona Legado** deste projeto. Ao invocar qualquer skill em arquivos da zona legado, aplicar as regras a seguir.

### Regras para subagentes e skills

**Zona Legado — NÃO são violações neste projeto:**
- Hungarian style em variáveis (`strNome`, `blnAtivo`, `fltValor`, `qryCliente`) — obrigatório nesta base
- Prefixo `unt` em units (`untFaturamento.pas`) — padrão legado válido
- Prefixos `p` / `f` em métodos (`pCarregarDados`, `fCalcularTotal`) — convenção estabelecida
- SQL embutido via `.SQL.Text :=` com `ParamByName()` — sem ORM é intencional
- Ausência de interfaces em classes de negócio — não exigido na zona legado
- Herança de `TfrmPai` / `TfrmPaiSimples` em vez de `TForm` — bases customizadas obrigatórias
- Prefixo `F` em campos privados combinado com prefixo de tipo (`FstrNome`, `FblnAtivo`)

**Zona Legado — SÃO violações reais (reportar sempre):**
- SQL com concatenação de string em vez de `ParamByName()` — risco de SQL injection
- `try/finally` ausente em objetos alocados manualmente
- Acesso direto a componentes de outro form sem passar por método/propriedade
- Lógica de negócio dentro de eventos de form (`OnClick`, `OnChange`) sem delegar
- Uso de variáveis globais de unit para estado mutável compartilhado

**Zona Moderna — aplicar style guide completo:**
- Dot-notation obrigatório em units
- Interfaces com GUID em todas as dependências injetadas
- Arquitetura Controller → Service → Repository sem desvios
- Sem Hungarian style — nomes descritivos sem prefixo de tipo

### Identificação de zona por caminho

| Caminho contém | Zona |
|----------------|------|
| `padra_atualizado/fontes/` | Legado |
| `libCartoes/`, `autban/`, `auttin/`, `autcomtinta/` | Legado |
| `Contabilidade/` | Moderna |
| `padra_atualizado/Services/` | Moderna |
| `padra_atualizado/Monitors/` | Legado |
| `LibTintas/`, `PainelNfe/` | Legado |

---

## Padrões de Código

O projeto possui dois perfis de código que coexistem. Ao revisar ou escrever código, identifique em qual zona você está antes de aplicar critérios.

### Parâmetros — vale para as duas zonas

**`const` em parâmetro que o método não altera.** Em `String`, em record e em interface evita cópia; em qualquer tipo, declara a intenção na assinatura — quem chama sabe que o valor não volta modificado.

`var` e `out` só quando o método realmente devolve por ali. `out` diz também que o valor de entrada é ignorado, e é o que se quer em parâmetro de saída — ver `fListar(...; out ATruncado: Boolean)`.

### Comentários — vale para as duas zonas

Comentar ajuda. Comentar **tudo** atrapalha, e a poluição é pior na declaração do que na implementação.

| Onde | O que cabe |
|------|-----------|
| **Declaração de método** (seção da classe, `interface`) | Só o que a assinatura **não consegue dizer**: posse do objeto devolvido, semântica do `nil`, significado de parâmetro `out`, formato ou unidade. Uma ou duas linhas. Se o nome mais os parâmetros já dizem, **não comentar** |
| **Implementação** | O porquê, a alternativa descartada, a armadilha, o que foi medido |

A declaração é onde se lê a **forma** da classe — o que ela oferece, de relance. Comentário ali quebra exatamente a leitura que aquela seção existe para permitir.

**Nunca repetir o que o código diz.** `{ Monta um andamento a partir da linha }` sobre `fMontarAndamento(AQuery: IQuery): TCotacaoGiroAndamento` não é comentário denso — é ruído com aparência de cuidado.

Ao remover comentário, conferir se o porquê removido sobrevive na implementação: se era a decisão de arquitetura — a que impede alguém de desfazer a escolha —, mover para lá em vez de apagar.

#### O comentário que envelhece mal

O tamanho não é o que faz um comentário virar armadilha. É **onde ele afirma a regra**.

| Tipo | Envelhece |
|------|-----------|
| Descreve o contrato do que está logo abaixo — posse, `nil`, formato | **bem**: muda junto com a assinatura, na mesma edição |
| Afirma regra que é **executada em outro arquivo** | **mal**: o outro arquivo muda e ninguém vem corrigir aqui |

Regra enunciada onde não é aplicada **vai** divergir — não é questão de disciplina, é questão de quantas cópias existem. Enuncie uma vez, no ponto que a aplica, e nos outros lugares **aponte** para lá em vez de repetir.

**Se a regra importa a ponto de merecer um parágrafo, ela merece um caso de teste.** O parágrafo mente em silêncio; o caso reprova alto.

> Caso real, corrigido em 05/09/2026: `ConsultarAndamentoTest.inc` afirmava que o status `ERRO` "vale mesmo com `SST_SUCESS = 'S'`". A cascata avalia `CONCLUIDO` **antes**, então a afirmação era falsa — e o caso que supostamente a guardava montava `SST_SUCESS = 'N'`, sem exercitar nada. Sobreviveu porque ninguém confrontou o texto com o código.

**Isto vale em dobro para agente de código.** Um humano lê o comentário, lê o código, vê que discordam e confia no código. Um LLM tem viés para o texto — ainda mais quando lê só a declaração e não o corpo, que é justamente o que comentário em declaração convida a fazer. Comentário divergente não é ruído: é instrução errada com autoridade de documentação.

**Ao encontrar comentário que contradiz o código: corrija o comentário na hora e diga que corrigiu.** Não o silencie e não o obedeça.

---

### Zona Legado — `padra_atualizado/fontes/`, `libCartoes/`, `autban/`, `auttin/`, `autcomtinta/`

Código VCL com 15+ anos de evolução incremental. **Não refatorar proativamente** — manter consistência com o estilo existente ao fazer manutenção.

**Nomenclatura de units:**
- Prefixo `unt` para units legadas: `untFaturamento.pas`, `untAcertoConta.pas`
- Dot-notation para código mais recente no mesmo módulo: `AcordoDeObjetivos.Classes.pas`
- Ambos os estilos coexistem — respeitar o que já existe na pasta

**Classes e tipos:**
- Prefixo `T` em todas as classes e tipos
- Forms: `Tfrm` + PascalCase, herdando de `TfrmPai` ou `TfrmPaiSimples` (bases customizadas — nunca herdar direto de `TForm`)
- DTOs como records: prefixo `Tdto` com campos prefixados por tipo
- Classes de negócio: `T` + descrição funcional

**Variáveis — Hungarian style obrigatório:**

| Prefixo | Tipo | Exemplo |
|---------|------|---------|
| `str` | String | `strCodCli`, `FstrNome` |
| `bln` | Boolean | `blnAtivo`, `FblnCancelado` |
| `int` | Integer | `intCodGpo`, `intQtdItem` |
| `flt` | Double/Float | `fltValorTotal` |
| `dta` | TDateTime/TDate | `dtaNascimento` |
| `cur` | Currency | `curSaldo` |
| `obj` | Objeto de negócio/serviço | `objServico`, `objCep` |
| `lst` | TList / TStringList | `lstEmpresas`, `lstCampos` |
| `arr` | Array / TArray | `arrCampoChave`, `arrLinhas` |
| `frm` | TForm (referência) | `frmGravando`, `frmMsgTbl` |
| `qry` | TUniQuery | `qryCliente` |
| `cds` | TUniClientDataSet | `cdsItens` |
| `dts` | TDataSource | `dtsCadGrupos` |
| `cxg` | TcxGrid / TcxGridCitel | `cxgClientes` |
| `pnl` | TPanel | `pnlRodape` |
| `pgc` | TPageControl / TcxPageControl | `pgcOpcao` |
| `tab` | TTabSheet | `tabDados` |
| `edt` | TEditFocus | `edtNome` |
| `msk` | TMaskEditFocus | `mskCpf` |
| `cmb` | TComboBox / TComboBoxFocus | `cmbTipo` |
| `chk` | TCheckBox | `chkAtivo` |
| `rdg` | TRadioGroup | `rdgTipo` |
| `btn` | TBitBtnLocked | `btnConfirmar` |
| `lbl` | TLabel | `lblTotal` |
| `grb` | TGroupBox | `grbDados` |
| `tmr` | TTimer | `tmrClose` |

**Prefixos de escopo:**
- `F` — campos privados: `FstrNome`, `FblnAtivo`
- `A` — parâmetros: `AstrCodigo`, `AblnAtivo`
- `p` — procedures: `pCarregarDados`
- `f` — functions: `fCalcularTotal`, `fCriaQuery`

**Acesso a dados:**
- UniDAC: `TUniQuery`, `TUniClientDataSet`, `TUniDataSetProvider`
- SQL embutido via `.SQL.Text :=` com `ParamByName()` — sem ORM
- Factory `fCriaQuery(nil)` para criar queries
- Operações em lote: usar `TBatchSQL` (fluent API) em vez de múltiplos executes avulsos

**Helpers centrais de `libFuncoes` — não reimplementar:**
- `fConsulta(...)` — dialog universal de busca/seleção em grid
- `fMensagem(...)` — caixa de mensagem centralizada (substitui `ShowMessage`, `MessageDlg`)
- `fRetAutoIncrem(strTabela, strCodEmp)` — próximo ID autoincremento por empresa
- `fStartTransaction` / `fCommit` / `fRollBack` — controle de transação, de `untFuncoesSimples`. Todos aceitam `TUniConnection` opcional; sem argumento usam a conexão global

> **Os sufixados com `Gen` não existem em `padra_atualizado/`.** `fStartTransactionGen` / `fCommitGen` / `fRollBackGen` vivem apenas em `autcomtinta/untFuncoesGen.pas` e `auttin/Funcoes/untFuncoesGen.pas` — são do tintométrico. Usá-los em código do ERP desktop não compila. Corrigido em 18/09/2026, durante o Req. 462692, depois de a forma errada ter entrado numa spec.

**Componentes customizados do projeto — units obrigatórias no `uses`:**

| Componente | Unit | Substitui |
|------------|------|-----------|
| `TBitBtnLocked` | `BitBtnLockedIncrem` | `TBitBtn`, `TButton` |
| `TEditFocus` | `EditFocus` | `TEdit` |
| `TMaskEditFocus` | `MaskEditFocus` | `TMaskEdit` |
| `TfrmPai` / `TfrmPaiSimples` | `untPai` (`padra_atualizado/fontes/genericos/`) | `TForm` |
| `TcxGridCitel` | `cxGridCitel` | `TDBGrid`, `TcxGrid` |

**Hierarquia de forms — escolher a base correta:**

| Base | Unit | Usar quando |
|------|------|-------------|
| `TfrmPai` | `untPai` | Form genérico sem CRUD |
| `TfrmPaiSimples` | `untPai` | Exibição somente leitura |
| `TfrmPaiCad` | `untPaiCad` | CRUD completo (Incluir/Alterar/Gravar/Excluir) |
| `TfrmPaiOrdena` | `untPaiOrdena` | Lista com grid `TDBGridCitel` + busca/ordenação |
| `TfrmPaiOrdenaCxGrid` | `untPaiOrdenaCxGrid` | Igual ao anterior com `TcxGridCitel` — **preferido em código novo** |

`TfrmPaiCad` gerencia automaticamente: transação, auditoria (`pAuditoria`), flags de estado (`blnGravou`, `blnAlterou`, `blnExcluiu`) e chaves primárias (`arrCamposChave`).

**Herança e interfaces:**
- Classes de negócio herdam de `TObject` (implícito), `TComponent` ou `TInterfacedObject`
- Interfaces não são obrigatórias no código legado — presença indica refatoração em andamento

---

### Zona Moderna — `Contabilidade/`, `padra_atualizado/Services/`

Código com arquitetura limpa em migração progressiva. Aplicar boas práticas aqui.

**Nomenclatura de units:** `Dominio.Camada.NomeClasse.pas`
- Ex: `Contabilidade.Classes.TGeradorContabil.pas`
- Ex: `api.controller.pix.pas`

**Arquitetura em camadas:**
```
Controller → Service → Repository
```
- Controller: delega para service, trata HTTP/exceções
- Service: regras de negócio, coordena transações
- Repository: acesso a dados, SQL

**Interfaces com GUID obrigatório:**
```pascal
IVinculoPlanoContabilRepo<T, T2: class> = interface
  ['{40B5E8E0-B92A-4BE9-85F2-523686938DD2}']
  ...
end;
```

**Injeção de dependência via construtor:**
```pascal
constructor TXxxService.Create(ARepository: IXxxRepo);
begin
  FRepository := ARepository;
end;
```

**Tratamento de erros:**
- Transações: `fStartTransaction` / `fCommit` / `fRollBack` em bloco `try/except`
- Re-raise após rollback: `raise` (sem parâmetros)
- Controllers: capturar exceções tipadas e retornar HTTP adequado

**REST (DMVCFramework):**
- Atributos `[MVCPath]`, `[MVCHTTPMethod]`, `[MVCSwagSummary]` em cada action
- Registrar controller em `initialization`: `TControllersRegister.Instance.RegisterController(...)`

**Generics:** usar `<T, T2: class>` para repositories e services reutilizáveis

---

### DLLs de módulo — regras obrigatórias

- `ShareMem` **deve ser a primeira unit** na cláusula `uses` do `.dpr` — obrigatório para passar strings entre DLL e host
- Toda DLL expõe `pIniciaDllFuncoes` como entry point de inicialização — recebe conexão, usuário, empresa e ponteiros para variáveis globais (`VS_*`)
- Variáveis globais `VS_*` (ex: `VS_objConexao`, `VS_strUsuario`, `VS_strEmpresa`) são inicializadas pelo host via `pIniciaDllFuncoes` e usadas em toda a DLL — nunca inicializar manualmente

---

### Prefixos de units de biblioteca (ambas as zonas)

- Bibliotecas de integração: prefixo `lib` — `libFuncoes`, `libCadastros`
- Serviços Linux: `Dominio.SubDominio` — `Faturamento.Services.API`
- Controladores REST: `api.controller.<recurso>.pas`
