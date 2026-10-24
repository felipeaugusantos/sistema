# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuração do ambiente de desenvolvimento

O repositório inclui um `.editorconfig` que configura automaticamente charset `latin1` (Windows-1252), CRLF e indentação para arquivos Delphi. Para que tenha efeito, é necessário instalar a extensão **EditorConfig** na IDE ou editor utilizado:

- **VS Code**: [EditorConfig for VS Code](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
- **Delphi / RAD Studio**: sem suporte nativo — o encoding é controlado pelo hook `.claude/hooks/delphi-encoding.ps1`

Sem a extensão instalada, o `.editorconfig` é ignorado silenciosamente e o editor pode salvar arquivos em UTF-8, corrompendo caracteres especiais nos fontes.

## Visão Geral

ERP para varejo/setor de tintas desenvolvido em **Delphi Seattle** (Object Pascal). Composto por uma aplicação desktop VCL principal, serviços Linux (daemons REST) e módulos independentes. Banco de dados: **MySQL**. Controle de versão: **SVN**.

## Specs, Plans e Tasks

Quando for informado um número de requisito, procurar a pasta `<raiz>/IA/<número do requisito>` e ler os arquivos `Specs.md`, `Plans.md` e `Tasks.md`. Se não encontrar, perguntar ao usuário se quer executar a skill `IAArquitectDesenv`.

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
| `padra_atualizado/Services/Services.groupproj` | Todos os ~24 serviços Linux |
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

- `padra_atualizado/TestesUnitarios/` — suite DUnit principal (`AutcomTestes.groupproj`); subpastas: `Contabilidade/`, `Faturamento/`, `padra_atualizado/`
- `padra_atualizado/TestCase/` — suite DUnit de cálculos (`AutcomTestCase.groupproj`); cobre impostos, preços, margens e CFOPs
- `padra_atualizado/testes unitarios/` — suite complementar (`Testes.groupproj`); cobre Configuracoes e Custo
- `padra_atualizado/Services/Faturamento.Services.API/Target/Linux/Test_Cases/` — testes de integração da API REST (`.inc` incluídos no `.dpr` de teste)

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
- `fStartTransactionGen` / `fCommitGen` / `fRollBackGen` — controle de transação global

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
