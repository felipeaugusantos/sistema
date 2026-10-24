# Plano de Execução — Requisito 466712

**Referência:** `spec.md` desta pasta (as seções citadas abaixo são de lá).
**Zona:** plugin no padrão moderno (dot-notation, interfaces com GUID, sem Hungarian, `const` nos parâmetros); hosts na
zona Legado (Hungarian, prefixos `p`/`f`, `ParamByName`).
**Ordem de implementação usada:** 150.100 (referência), depois 74.111, 72, 150 e 150.45.

**Regras de edição (obrigatórias):**
- `.pas`, `.dfm` e `.dpr` em cp1252, só por script byte-safe (nunca Edit/Write da ferramenta): medir o EOL antes e
  replicá-lo, âncora única antes de gravar, contar os caracteres não-ASCII antes e depois. Arquivo `.pas` novo: cp1252
  com CRLF.
- Toda alteração vale para as 5 versões. O plugin é o mesmo nas 5 (external SVN `Plugin-Reforma`); as 5 cópias locais
  têm de ficar idênticas.
- `svn add` em todo arquivo novo. Nunca `svn revert` sem conferir o diff. O commit é do usuário (plugin + 5 hosts).
- Ruído de IDE (`ActivePage`, `Explicit*`, units acrescentadas sozinhas como
  `cxDataControllerConditionalFormattingRulesManagerDialog`) não vai para o commit.

---

## 1. Arquitetura

```
untCadProdutos (host)                         libReformaPrecos.dll
  abas 2, 3 e 4  ◄── janelas da DLL ───────── TSimulacaoReforma (dataset compartilhado pelas abas 2 e 3)
  pReformaGravar(CodigoItem) ───────────────► Persistir → TRepositorioRefpre (REFPRE)   [CFG_REFCIS = 'N']
                                                         TRepositorioSemPersistencia     [CFG_REFCIS = 'S']
  TReformaHostAdapter (IReformaHost, IReformaCalculoConvert)

untPrincipal (host)
  com CFG_REFCIS = 'S': fReformaAbaVisivel(3) = False; aba 2 em modo conversão ──► TConsultaConversao (ITEREO/ITEREF)
  login: pReformaPrepararBanco ─────────────► fReformaPrepararBanco → Reforma.Repositorio.Estrutura (sanitização)
  pCarregarMenusAcesso:
    mnuConvertReforma.Visible := fReformaConvertDisponivel(operador, data) And Not fPreMat
  mnuConvertReformaClick → pReformaAbrirConvert(TReformaConvertHost) ──► TConvertServico.Abrir → TfrmReformaConvert
                                                                          TProcessoConversao (fases 0, P, A, C; Reverter)
  TReformaConvertHost (IReformaConvertHost) ◄──────────────────────────── usa:
    ExecutarComProgresso (TfrmGravando)                                     IReformaTarefa.Executar(Progresso)
    IniciarCalculo / CalcularItem / FinalizarCalculo (motor nativo)         Fase P: Regra (alvos) + CalcularItem
    AplicarLote / ReverterLote (SQL de conjunto da família)                 Fase A e Reverter
    AtivarReforma / DesativarReforma (CFGSIS + cache)                       Fase C e fim do Reverter
    EmpresasPrecoDe / TrocarEmpresa                                         grupos de preço
    Gravacao (IReformaGravacao) e AbrirConsulta (IReformaConsulta)          ITEREF/ITEREO/REFCON/REFDIV, ABFRTE
```

**Princípios**
1. **A DLL decide o quê; o host decide como.** A DLL escolhe itens, preço de compra novo, despesa, federais zerados,
   alvos de preço e margem, lotes, backup, conferência e quando ativar. O host calcula e grava pelas regras nativas da
   versão. Mudar a regra de preço mexe só na DLL (`Reforma.Convert.Regra`).
2. **Regras na DLL, exe genérico.** Visibilidade do menu (`TConvertServico.Liberado`), da aba 4
   (`fReformaAbaVisivel`), regra de preço: na DLL, para trocar só a DLL quando a regra mudar.
3. **Duas portas de entrada sem estado compartilhado.** O Convert recebe o próprio host no export e nunca usa
   `GHost`/`GSimulacao` (do cadastro). Por isso o menu exige o cadastro fechado.
4. **Preparar antes de gravar.** O cálculo inteiro sai na Fase P (só leitura no produto); a Fase A só copia ITEREF para
   o produto por conjunto; a Fase C confere antes de ligar a `CFG_REFCIS`.
5. **Fronteira exe/DLL.** Nenhuma exceção atravessa: tudo volta como `TResultadoGravacao`. O host chama a DLL dentro de
   `Try/Except` e nunca a descarrega de dentro do `Except`.
6. **Determinismo para a LOGREP.** Toda escrita pela porta do host; chave GUID; data/hora do `fNow` do host como
   parâmetro; nada de `NOW()`/`AUTO_INCREMENT` como referência.

---

## 2. Contrato exe/DLL (versão 12)

`Reforma.Contrato.Exportacao.VERSAO_CONTRATO = 12`, mais a assinatura RTTI das interfaces
(`Reforma.Contrato.Assinatura`). O loader recusa versão ou assinatura diferente. Exports que não entram na RTTI exigem
bump manual.

### 2.1 Interfaces (`Contrato\Reforma.Contrato.Convert.pas`)
- `IReformaProgresso`: `Definir(Texto, Maximo)`, `Avancar(Quantidade)`.
- `IReformaTarefa`: `Executar(Progresso): TResultadoGravacao` (implementada pela DLL, executada pelo host no
  `TfrmGravando`).
- `IReformaConvertHost` (herda `IReformaBancoHost`: `AbrirConsulta`, `Gravacao`):
  - contexto: `CodigoEmpresa`, `Operador`, `DataHora`, `DecimaisUnitarios`, `TabelasAtivas`, `EmpresasPrecoMatriz`,
    `UsaPrePro`, `ConfiguracaoTexto`, `EstiloVisual`, `JanelaPrincipal`;
  - interface: `Mensagem`, `MostrarLista` (tela de log), `Confirmar`, `ExecutarComProgresso`;
  - gravação: `ExecutarLote` (vários comandos num `ExecSQL`, transação aberta);
  - cálculo: `IniciarCalculo(Opcao)`, `CalcularItem(Entrada, out Valores)`, `FinalizarCalculo`,
    `CamposCustoDaLogada(Origem)`;
  - aplicação: `AplicarLote(Chave, Lote)`, `AtivarReforma(Empresa)`;
  - reversão: `ReverterLote(Chave, Lote, PrimeiroLote)`, `DesativarReforma(Empresa)`;
  - grupos: `EmpresasPrecoDe(Empresa)`, `TrocarEmpresa(Empresa)`.
- `IReformaCalculoConvert` (implementada pelo adapter do cadastro, obtida por `Supports`): `Operador`,
  `DecimaisUnitarios`, `CalcularItemBase(Opcao, Entrada, Base, out Valores)`.
- Tipos: `TOpcaoConversao` (Recalcular Preço de Venda / Margem), `TModoTabelaConversao` (`mtcMantemPreco`,
  `mtcMantemMargem`), `TAlvosConversao`, `TEntradaConversao` (item, preço de compra, despesa, alvos, comissões),
  `TValoresConversao` (uma linha da ITEREF: empresa, origem L/F/R, custo, federais, despesa, ICMS saída, outros valores,
  preço/margem/comissão por tabela), `TComandoSql` (SQL + parâmetros).

### 2.2 Exports da DLL
- Cadastro: `pReformaInicializar`, `fReformaCriarAba2`, `fReformaCriarAba3`, `fReformaCriarAba3Grid`,
  `fReformaCriarAba4`, `fReformaCriarAba4Grid`, `fReformaAbaVisivel`, `pReformaCarregar`, `pReformaEntrarAba`,
  `pReformaAtualizarAtual`, `pReformaConfirmarEdicao`, `fReformaPendente`, `pReformaGravar(CodigoItem, out Mensagem)`,
  `pReformaDescartar`, `pReformaFinalizar`.
- Convert e banco: `pReformaAbrirConvert(Host)`, `fReformaConvertDisponivel(Operador, Data)`,
  `fReformaPrepararBanco(Banco, out Mensagem)`.
- Handshake: `fReformaAssinaturaContrato`.

Todos são obrigatórios no loader do host.

### 2.3 Histórico do contrato
5: código do item na gravação (REFPRE). 6: estrutura do banco na subida e replicação da REFPRE. 7: Convert. 8: aba
visível decidida pela DLL (consulta da conversão). 9: `MostrarLista`. 10: grupos de preço. 11: aba 4 e Reverter. 12: regra do
menu com operador e data.

---

## 3. Plugin — simulação (spec §3)

| Unit | Responsabilidade |
|---|---|
| `Calculo\Reforma.Calculo.Modelo` | `TFormacaoCusto` com `DescontoPisCofins`, `PrecoCompraComDesconto` e as bases do preço líquido |
| `Calculo\Reforma.Calculo.Formacao` | `TCalculoFormacao`: preço com desconto antes de chamar o host (a fórmula de custo do host não muda); gatilhos `grPrecoLiquido` (preço de compra digitado na aba 3, conta inversa) e `grPrecoCliente` (preço com impostos digitado) |
| `Simulacao\Reforma.Simulacao.Modelo` | `TSimulacaoReforma`: dataset das abas 2 e 3 (`ITE_DPISCO`, `ITE_PRELIQ`, `ITE_PRECLn`...); gate `CFG_REFCIS` lido uma vez; escolha do repositório; `CampoEditavel` (com `'N'`, só colunas da REFPRE e `ITE_PRECLn`); `Pendente`/`Persistir(CodigoItem)`; `CriarSomenteLeitura`/`MostrarConvert` (aba 4); `MargemNaRefpre(Tabela)` |
| `Repositorio\Reforma.Repositorio.Refpre` | `TRepositorioRefpre`: `Ler` (tabela lida por tabela), `Gravar` (`ogSubstituir`, upsert pela chave única; código vazio não grava) |
| `Repositorio\Reforma.Repositorio.Banco` | `IRepositorioSimulacao` e `TRepositorioSemPersistencia` (`CFG_REFCIS = 'S'`; a antiga gravação na ITEREF saiu) |
| `Simulacao\Reforma.Simulacao.Replicacao` | Replicação da linha da REFPRE para o grupo de preço e o responsável pelo fornecedor, como o cadastro faz com os preços |
| `View\Reforma.View.Comparativo` | Aba 2: desconto e preço líquido no bloco Novo, validação 0 ≤ x < 100, reempilhamento das linhas pelo gate (posição calculada uma vez) |
| `View\Reforma.View.Futura` / `FuturaGrid` | Aba 3 (clássica no 72/74.111, grid vertical no 150.x): preço de compra ligado ao `ITE_PRELIQ`; campos travados pelo `CampoEditavel` |
| `View\Reforma.View.Validacao` | Validação e recálculo ao sair dos campos (`TValidadorPrecos`), travamento dos campos que seguem o produto |

Carga com REFPRE: desconto, despesa e comissões antes do `grInicial`; preço e margem das tabelas lidas repostos depois
(`grCargaParametros`). Sem linha: tudo do produto (`grInicial`).

---

## 4. Plugin — Convert (spec §4)

| Unit | Responsabilidade |
|---|---|
| `Convert\Reforma.Convert.Servico` | `TConvertServico.Abrir(Host)` (estilo visual, tela modal) e `Liberado(Operador, Data)`: 998 ou data ≥ 26/12/2026 |
| `Convert\Reforma.Convert.Estrutura` | Só leitura: confere tabelas e colunas de controle (`CONTROLE_REFCON`, `CONTROLE_REFDIV`...) e monta a lista de colunas `ITE_*` presentes no ITEGER e na ITEREF. Faltando algo, a conversão não começa |
| `Convert\Reforma.Convert.Regra` | `TRegraPrecoRefpre`: `Alvos` (rádio Margem: preço do ITEGER sem CBS/IBS/IS por `fPrecoSemImpostosReforma`; rádio Venda: margem da REFPRE ou do ITEGER) e `Comissoes` (REFPRE ou ITEGER); `fJsonItemAliquota` (payload da procedure) |
| `Convert\Reforma.Convert.Grupos` | Grupos de preço a partir de `EmpresasPrecoDe` de cada empresa do CADEMP: conjunto repetido uma vez, contido some, cruzado bloqueia, empresa fora do servidor |
| `Convert\Reforma.Convert.Processo` | `TProcessoConversao`: `Situacao`, `Executar` (trava `GET_LOCK`, fase 0 `fAtualizarAbreviacoes`, P, A, C, retomada, volta ao início), `Conferir`, `Reverter`; filtro de itens por parâmetro (`fSqlFiltroItens`/`fParametrosFiltroItens`) |
| `Convert\Reforma.Convert.Conferencia` | `TConferenciaConvert`: uma consulta por empresa (ITEREF × ITEGER × ITEREO, com o grupo), comparação na DLL, gravação da REFDIV |
| `View\Reforma.View.Convert` (.pas/.dfm) | Tela: rádios, grid de grupos com checkbox e detalhe, Observação, botões Confirma/Conferir/Reverter/Cancela, memo de itens do 998, foco no grupo da logada |
| `Simulacao\Reforma.Simulacao.Convert` | Aba 4: `fAba4Disponivel` (998 e `CFG_REFCIS = 'N'`), `fCalcularConvertProduto` (alíquotas, regra, base da aba 3, `CalcularItemBase`) |
| `View\Reforma.View.CalculoConvert` | `TpnlCalculoConvert`: rádios + frame da aba 3 (clássico ou grid) sobre a simulação somente leitura; recalcula quando a aba 3 muda |
| `Repositorio\Reforma.Repositorio.Estrutura` | Sanitização (fonte única do DDL): cria e ajusta IMPTRI, REFPRE, ITEREO, ITEREF, REFCON, REFDIV e `CADEMP.EMP_REFCON`; `fSincronizarReforma` liga/desliga a `CFG_REFCIS` pelo `EMP_REFCON` |
| `Plugin\Reforma.Plugin.pas` / `libReformaPrecos.dpr` | Exports; estado das abas do cadastro em variáveis da unit (a DLL exporta funções soltas, sem objeto do host) |

### 4.1 Fases (`TProcessoConversao`)
1. **Trava:** `GET_LOCK('REFTRI_CONVERT_<empresa>', 0)`; `RELEASE_LOCK` no `finally`.
2. **Situação:** pela REFCON de L. Nova: GUID, REFCON (L + F) em `'P'` com opções e filtro. Em andamento: mesma
   chave e opções gravadas.
3. **Fase 0:** `fAtualizarAbreviacoes` — lê a 1ª linha da IMPTRI e faz `UPDATE ABFRTE SET RTE_CBSALQ = :CBS` e
   `RTE_IBSUFA = :IBS` (só as linhas diferentes), se a tabela e as colunas existirem.
4. **Fase P:** pré-checagens (estrutura, `CFG_REFCIS` de L e F, PREPRO nas tabelas ativas no 150.x, alíquotas por
   abreviação para todos os itens); leitura dos itens pendentes de uma vez; `IniciarCalculo`; por item
   `Regra.Alvos`/`Comissoes` + `CalcularItem`; buffer gravado em `INSERT` de 250 linhas da ITEREF e, na mesma
   transação, `INSERT ITEREO ... SELECT` só dessas linhas; ao fim, cópia do item de maior código para os itens do mesmo
   grupo de preços; `FinalizarCalculo`. Lotes de 100 itens.
5. **Fase A:** por lote: checagem de alterados (ITEGER/PREPRO × ITEREO), `AplicarLote`, `REF_APLICADO = 'S'` na
   ITEREF/ITEREO, contagem na REFCON, commit. Alterado: `ALTERADO` na REFDIV, lotes não aplicados apagados, REFCON `'P'`.
6. **Fase C:** limpeza de itens excluídos (`EXCLUIDO`), conferência, REFDIV; sem bloqueante, numa transação:
   `AtivarReforma` (CFG_REFCIS = 'S' + cache) e `EMP_REFCON = 'S'` em L e F, REFCON `'C'`; com bloqueante, `'D'`.
7. **Falha em P ou A sem lote aplicado:** `DELETE` da chave em ITEREF, ITEREO, REFDIV e REFCON (volta ao início).

### 4.2 Reverter (`TProcessoConversao.Reverter`)
`fConfirmarAlterados` (lista e pergunta; Não marca `'X'` na ITEREO por um UPDATE) → `fReverter`: por lote, numa
transação, `ReverterLote` + `DELETE` das linhas do lote na ITEREF e na ITEREO; no fim, numa transação,
`DesativarReforma` por empresa, `DELETE` da chave nas 4 tabelas e `EMP_REFCON = 'R'`.

---

## 5. Consulta da conversão (spec §5)

O plugin entra em **modo conversão** quando `CFG_REFCIS = 'S'` (lida uma vez em `pReformaInicializar`).

| Unit | Responsabilidade |
|---|---|
| `Plugin\Reforma.Plugin.pas` | `fReformaAbaVisivel(Aba)`: aba 3 = `not REFCIS`, aba 4 = `GAba4Visivel`, demais True; `GConsulta: TConsultaConversao` criado na inicialização com `'S'` e liberado no fim; sem `SincronizarProduto` em modo conversão |
| `Repositorio\Reforma.Repositorio.Conversao` | `TConsultaConversao`: colunas existentes descobertas uma vez (`information_schema`); `Carregar(CodigoItem)` lê a ITEREF da última conversão aplicada (`REF_APLICADO = 'S'`, maior `REF_ID`) e a ITEREO do mesmo `REF_CHAVE`, com `:CODEMP`/`:CODITE`; cache pelo último item; `Invalidar`; falha silenciosa (datasets vazios); coluna ausente ou nula = 0 |
| `Simulacao\Reforma.Simulacao.Modelo` | `pCriarCamposFormacao(Dataset)` e `fLerFormacao(...)` extraídos para uso comum (mesma estrutura de campos nos datasets Antes/Após) |
| `View\Reforma.View.Comparativo` | Modo conversão: títulos "Antes da Conversão"/"Após Conversão"; lado Atual ligado ao dataset da ITEREO e lado Novo ao da ITEREF; sem eventos de validação nem ouvinte da simulação; todos os campos `ReadOnly`/`Enabled = False`; Margem Ideal com `DataSource := nil` e oculta; `Entrar` carrega a consulta e os calculados (Antes pelo cálculo do host com a ITEREO no lugar do produto; Após por `grCarga`); `AtualizarAtual` sem efeito |

**Host (×5):**
- loader: `FfAbaVisivel` obrigatório e `fAbaVisivel(Aba)` (falha registrada, devolve True);
- `untCadProdutos`: 72/74.111 em `pCriaPgcPrecos` e 150.x em `pCriaPgcPrecos` + `pReformaMontarAbas` — a aba 3 só é
  montada se visível e `tbsCustoFuturo.TabVisible := fAbaVisivel(3)`;
- `pReformaAtalhoAba`: Ctrl+1..4 ignora aba oculta; Ctrl+PgUp/PgDn pulam as ocultas (laço limitado a `PageCount`).

**Pontos conferidos:** `grCarga` não reescreve `PRECUS`/`PREVE`/`MARBR`/`COMTB` gravados (conferido no código e no
teste local `TesteReftri03`), então não foi preciso o plano B (só `RecalcularCustoReal` + `RecalcularPrecosCliente`). No
ProtoHost com `-refcis -conversao`: 53 campos visíveis, nenhum editável.

---

## 6. Hosts (×5)

| Arquivo | Alteração |
|---|---|
| `cadastros\untReformaGravacaoHost.pas` (novo) | `TReformaGravacao`, `TReformaTransacao`, `TReformaConsulta`, `TReformaBancoHost`, `pRollBackSemExcecao` (extraídos do adapter sem mudar comportamento); `ExecutarSql` só com transação aberta e parâmetros |
| `cadastros\untReformaConvertHost.pas` (novo) | `TReformaConvertHost` (todo o `IReformaConvertHost`), `TReformaProgresso`/`TReformaExecucaoGravando` (TfrmGravando), cálculo e gravação por família, `fReformaConvertDisponivel`, `pReformaAbrirConvert`, `fReformaCalcularItemBase`/`fReformaDecimaisConvert` (aba 4) |
| `cadastros\untReformaHostAdapter.pas` | Usa o `untReformaGravacaoHost`; implementa `IReformaCalculoConvert` |
| `cadastros\untReformaPrecosLoader.pas` | Exports do contrato 12 (obrigatórios), `fConvertDisponivel(Operador, Data)`, `pAbrirConvert`, `fCriarAba4` |
| `cadastros\untCadProdutos.pas` | `pReformaGravar` passa o código do item; aba 3 oculta com `'S'` (seção 5); aba `tbsCalculoConvert`; atalhos Ctrl+1..4 e PgUp/PgDn pulando abas ocultas; falha ao montar as abas deixa o cadastro como sem o plugin |
| `untPrincipal.pas/.dfm` | Menu `mnuConvertReforma`, visibilidade em `pCarregarMenusAcesso`, `mnuConvertReformaClick` (acesso, `fPreMat`, servidor), `pReformaPrepararBanco` depois do login |
| `autcom.dpr` | `Reforma.Contrato.Convert`, `untReformaGravacaoHost`, `untReformaConvertHost` |
| `cadastros\untPrecoProduto.pas` (só 150.x) | Wrappers de classe `fCalculaPelaConfiguracaoDaEmpresa` e `fSQLLinhasConfiguracaoDaEmpresa` para métodos privados; nenhum corpo existente muda |
| `genericos\BatchSQL\untTBatchSQL.pas` (só 72) | Copiado do 74.111 para o `ExecutarLote` |

### 5.1 Cálculo (motor nativo, só memória)
- **150.x:** `TPrecoProduto` reaproveitado para todos os itens (sem `fSalvaDados`); linhas da PREPRO lidas por faixa
  de itens com a configuração de cada empresa (`fSQLLinhasConfiguracaoDaEmpresa`); F e R pela configuração própria
  (`fCalculaPelaConfiguracaoDaEmpresa`); tabelas inativas pelo alvo do rádio; fator de preço por `TFatorPreco`.
- **72/74.111:** record `TReformaLinhaCalculo` que reproduz `fRetPrecoCusto`, `fRetPrecoVenda`,
  `pRecalculaPrecosFator` e `pRecalculaItensResponsavelFornecedor` do `untCadProdutos` da versão, com uma consulta das
  empresas do item.
- **Aba 4:** `CalcularItemBase` usa o mesmo caminho com os campos da tela no lugar dos gravados, só a logada
  (150.x: `pAplicarBase` nas linhas da PREPRO; 72/74.111: na linha do ITEGER).

### 5.2 Gravação de lote (`fGravarLote`, usado por `AplicarLote` e `ReverterLote`)
- Origem `ITEREF` (`REF_APLICADO = 'N'`) na aplicação; `ITEREO` (`'S'`) na reversão, com ALQFED/ALQENT de antes e o
  local "REFORMA TRIBUTARIA - REVERSAO" com agrupador próprio.
- **150.x:** histórico `pGravaMestreProAlt` (um REGPRO por execução; nos lotes seguintes só as variáveis de sessão); um
  `ExecSQL`: `SET @_PREPRO_ATUALIZA_ITEGER = 'NAO'`; `UPDATE PREPRO JOIN origem` (custo, preço/margem/comissão por
  `CASE PRO_NROTAB`, `PRO_REGPRO`, `PRO_CUSTAR` por `fCalculaPrecodeCustoTARE` com as 4 CFGSIS da empresa da linha);
  `UPDATE ITEGER JOIN origem JOIN CADITE` (campos que o trigger copiava, ALQFED/ALQENT, `ITE_DTAALT/HULALT/CODOPE`);
  `SET ... = NULL`. Parâmetros com sufixo por comando (`CHAVE_P`, `CHAVE_G`) para nenhum nome se repetir no texto.
- **72/74.111:** `pPreAltDefineVariaveisAltPre` (trigger PREALT) ou `fGravaPreAlt` por item; `UPDATE ITEGER JOIN origem
  JOIN CADITE`; na base com trigger ITEGER→PREPRO, `SET 'NAO'` + `UPDATE PREPRO JOIN ITEGER` (`fSqlPreProDoIteger`,
  parâmetros `CHAVE_P`/`LOTE_P`/`APLICADO_P`) + `SET NULL`.
- A LOGREP aceita parâmetros: o gancho do UniDAC (`ParseSQLCitel` em `untModuloReplicacao`) põe os valores no texto
  antes de gravar.

### 5.3 Outros pontos do host
- `AtivarReforma`/`DesativarReforma`: `UPDATE CFGSIS` da `CFG_REFCIS` (zero linhas = erro) e
  `dicConfiguracoes.Remove('REFCIS' + empresa)`.
- `TrocarEmpresa`: `pSetaEmpresaLogada` (72: `VS_strCodEmp`), `fAjustaDataSistema`, timezone, `pAtuVarGlobais`,
  `pMontaArrConfiguracoes` — o mesmo da rotina automática do autcom, sem `fLogoff`.
- `fReformaConvertDisponivel` passa `strLoginUsuarioLogado` e `fNow`; o clique do menu só confere a carga da DLL (a
  tela confere a regra).

---

## 7. Sequência de implementação (como foi feita)

1. REFTRI-01: modelo e cálculo do desconto → repositório REFPRE → simulação → abas 2 e 3 → contrato 5 → hosts.
2. Contrato 6: sanitização na subida do autcom e replicação da REFPRE.
3. Contrato 7: Convert (contrato, Estrutura, Regra, Processo, Conferencia, View, Servico) e hosts (150.100 → 74.111 →
   72 → 150 → 150.45).
4. Contrato 8 (consulta da conversão): extração dos campos da formação, `TConsultaConversao`, modo conversão da aba 2,
   `fReformaAbaVisivel`, aba 3 oculta e atalhos nos hosts.
5. Contratos 9 a 12: lista no log, grupos de preço, aba 4, Reverter, filtro do 998, menu liberado por data,
   abreviações; gravação sem cascata; ajustes da auditoria (SQL por parâmetro, `try`/`finally`).
6. A cada passo: DLL compilada nas 5 cópias (`dcc32`, saída por versão) e copiada para `<versão>\padra_atualizado`
   quando o autcom está fechado; o exe é compilado pelo usuário no IDE (não compila por linha de comando).

---

## 8. Conformidade com os padrões do projeto

- **Componentes:** `TBitBtnLocked`, `TcxGrid`, `TUniClientDataSet`, `TDBEditFocus`; sem `TButton`/`TBitBtn`,
  `TDBGrid`, `TClientDataSet`, `dxSkin*`.
- **Chamadas:** `TextoParaNumero`/`fStrToFloat`; `fNow` pelo host; `pCriarFormularios` no host; na DLL, foco por
  `FocarControle` ou pela API do Windows com apelido (`fFocarJanela`), nunca `.SetFocus`.
- **SQL:** sempre com parâmetros (inclusive o filtro de itens e as listas de empresas da consulta de preços). Única
  exceção: a lista de empresas passada pronta para a rotina nativa `fSQLRecalculaItensResponsavelFornecedor` (códigos
  do CADEMP, nunca digitados). DDL idempotente, latin1, sem FK e sem `FOREIGN_KEY_CHECKS`.
- **Objetos:** só o primeiro objeto é criado antes do `try`; os demais dentro, liberados no `finally`.
- **Mensagens:** curtas; detalhes e listas na tela de log (`MostrarLista`).

---

## 9. Estratégia de testes

- **DUnit isolado** do `TCalculoFormacao` (host fake): preço líquido, desconto 0 e 99,99, arredondamento, conta
  inversa, desconto desligado. Falta levar para a suíte do projeto.
- **Protótipos locais** (`Plugin-Reforma\Prototipo`, fora do SVN): `ProtoHost` (abas em desktop separado, sem
  entrada real na tela do usuário, com `-refcis` para o modo conversão), `TesteReftri03` (consulta da conversão:
  aba visível, leitura com e sem linha, cache, falha, calculados do Após) e `TesteConvert` (tela do Convert com host
  simulado, cenários de rádio e de item sem alíquota).
- **Roteiro manual** por versão: `testes.md` desta pasta.

---

## 10. Riscos e mitigação

| Risco | Mitigação |
|---|---|
| Exe e DLL de contratos diferentes | Loader recusa sem erro; distribuir juntos |
| Gravação por conjunto divergir da rotina nativa | Conferência bloqueia a ativação; aba 4 para conferir item a item; comparação com a efetivação no roteiro |
| Cascata de triggers lenta (291 s de 334 s na Fase A do 150.100) | Gravação com `@_PREPRO_ATUALIZA_ITEGER = 'NAO'` e os campos copiados no próprio comando |
| Volume da LOGREP | Comandos em bloco (250 linhas por INSERT, um comando por lote) |
| Cache da `CFG_REFCIS` em estações abertas | Aviso para sair e entrar; a tela do Convert limpa o próprio cache |
| DDL dentro de transação | Sanitização fora de transação de dados, na subida do autcom |
