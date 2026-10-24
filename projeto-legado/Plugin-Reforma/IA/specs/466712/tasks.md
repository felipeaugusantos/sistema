# Tarefas — Requisito 466712

**Referência:** `spec.md` e `plan.md` desta pasta.

**Regras para todas as tarefas:**
- `.pas`, `.dfm` e `.dpr` só com edição byte-safe em cp1252, preservando o EOL e com âncora única; conferir a contagem
  de caracteres não-ASCII antes e depois.
- Toda alteração nas 5 versões (72, 74.111, 150, 150.45, 150.100); as 5 cópias do plugin idênticas.
- `svn add` dos arquivos novos. Não fazer commit (é do usuário, plugin e 5 hosts juntos).
- **Dono dos casos de teste:** analista. Quem implementa entrega o código e o `testes.md`.

## Fase 1 — Simulação com desconto PIS/COFINS e REFPRE (contrato 5)
- [x] Levantamento com o usuário (2026-10-02): REFPRE só com `CFG_REFCIS = 'N'`; com `'S'` como antes; preço de compra
      editável na aba 3 recalculando o PRECOM
- [x] Modelo e cálculo: `DescontoPisCofins`/`PrecoCompraComDesconto`, preço líquido, gatilho `grPrecoLiquido`
- [x] Repositório: `IRepositorioSimulacao`, `TRepositorioRefpre` (ler, gravar por upsert, código vazio não grava)
- [x] Simulação: campos `ITE_DPISCO`/`ITE_PRELIQ`, gate REFCIS, escolha do repositório, carga, `Persistir(CodigoItem)`
- [x] Aba 2: desconto e preço líquido no bloco Novo, validação, reempilhamento das linhas
- [x] Aba 3: preço de compra pelo preço líquido (clássica e grid)
- [x] Só os campos da REFPRE digitáveis; o resto segue o produto (aba 1 → Novo → aba 3); carga em duas etapas
      (`grCargaParametros`)
- [x] Contrato 5: `pReformaGravar(CodigoItem)`; hosts passam `ITE_CODITE` do `qryTabela`
- [x] DUnit isolado do `TCalculoFormacao`

## Fase 2 — Estrutura do banco e replicação da REFPRE (contrato 6)
- [x] `Reforma.Repositorio.Estrutura`: fonte única do DDL (IMPTRI, REFPRE 1 a 7, ITEREO, ITEREF, REFCON, REFDIV), cria e
      acrescenta o que falta, tipos do ITEGER do banco
- [x] Host: `untReformaGravacaoHost` com `TReformaBancoHost` e `pReformaPrepararBanco` depois do login
- [x] Replicação da REFPRE para grupo de preço e responsável pelo fornecedor (`Reforma.Simulacao.Replicacao`)

## Fase 3 — Convert (contrato 7)
- [x] Banco conferido (2026-10-03, `2_30_74_150_COM` e `2_30_74_XX_COM`): triggers PREPRO↔ITEGER, PROALT, PREALT,
      tipos, volume, `CFG_REFCIS` existente
- [x] Contrato: `Reforma.Contrato.Convert`, `IReformaConsulta.Proximo/Fim`, exports, assinatura RTTI
- [x] Simulação sem ITEREF com `CFG_REFCIS = 'S'` (`TRepositorioSemPersistencia`)
- [x] DLL: Estrutura, Regra, Processo, Conferencia, View, Servico, `pReformaAbrirConvert(Host)`
- [x] Hosts: `untReformaConvertHost` (cálculo e gravação por família), loader, menu em `untPrincipal`, `autcom.dpr`;
      150.x com os wrappers do `untPrecoProduto`; 72 com o `untTBatchSQL` copiado do 74.111
- [x] Decisões de 2026-10-05: rádios Origem dos Impostos e Somente Itens Ativos, procedure por item, ITEREO por bloco,
      campos de custo de F/R pela lista da versão (`CamposCustoDaLogada`), sem `ITE_PEFAVE`

## Fase 3b — Consulta da conversão no cadastro (contrato 8; origem REFTRI-03)
- [x] Contrato 8: export `fReformaAbaVisivel` (obrigatório no loader), assinatura
- [x] `Reforma.Simulacao.Modelo`: `pCriarCamposFormacao` e `fLerFormacao` extraídos sem mudar o comportamento
- [x] `Reforma.Repositorio.Conversao` (`TConsultaConversao`): última conversão aplicada (ITEREF `REF_APLICADO = 'S'`,
      maior `REF_ID`) e ITEREO da mesma chave; colunas por `information_schema`; cache; falha silenciosa; ausente/nulo = 0
- [x] `Reforma.View.Comparativo` em modo conversão: títulos, fontes ITEREO/ITEREF, tudo somente leitura, Margem Ideal
      oculta, calculados do Antes (host) e do Após (`grCarga`, conferido que não reescreve valores gravados)
- [x] `Reforma.Plugin`: `fReformaAbaVisivel`, `GConsulta`, sem `SincronizarProduto` em modo conversão
- [x] Hosts (5): loader `fAbaVisivel`; aba 3 oculta (`pCriaPgcPrecos`, e `pReformaMontarAbas` no 150.x); atalhos
      pulando abas ocultas
- [x] Testes locais: `TesteReftri03` e ProtoHost `-refcis` (aba 3 ausente, títulos, nada editável, atalhos)

## Fase 4 — Lista no log e grupos de preço (contratos 9 e 10)
- [x] `MostrarLista` (tela de log do host) para listas de itens/empresas
- [x] `Reforma.Convert.Grupos`; grid por grupo com checkbox e detalhe; troca de empresa e volta
- [x] `CADEMP.EMP_REFCON` e sincronização da `CFG_REFCIS` nas lojas
- [x] Alerta `SEM_PREPRO`/`SEM_LINHA` para item de F sem linha na conversão

## Fase 5 — Desempenho e mensagens (2026-10-06)
- [x] Fase A sem cascata de triggers (150.x e 72/74.111)
- [x] Lote de 100 itens; ITEREF em INSERT de 250 linhas
- [x] Mensagem final curta ("Conversão concluída.")
- [x] Foco do grid no grupo da empresa logada

## Fase 6 — Aba 4, Reverter e filtro do 998 (contrato 11)
- [x] `IReformaCalculoConvert`, exports da aba 4, `CriarSomenteLeitura`/`MostrarConvert`, Ctrl+4
- [x] Hosts: `CalcularItemBase` (150.x e 72/74.111), adapter, loader, `tbsCalculoConvert`
- [x] Correção: painel da aba 4 com o pai definido antes dos rádios ("Control '' has no parent window")
- [x] Correção: falha ao montar as abas deixa o cadastro como sem o plugin (150.x)
- [x] Reverter: `fGravarLote` com origem ITEREF/ITEREO, `ReverterLote`, `DesativarReforma`, pergunta dos alterados,
      histórico da reversão, `EMP_REFCON = 'R'`, `DELETE` das 4 tabelas da chave
- [x] Filtro de itens do 998 (`CON_FILITE`, Fase P, pré-checagem, contagem)

## Fase 7 — Regras de 2026-10-06/07 (contrato 12)
- [x] Preço de venda com impostos editável nas abas 2 e 3 com `CFG_REFCIS = 'N'`
- [x] Margem da REFPRE no rádio Recalcular Preço de Venda (Convert e aba 4: `MargemNaRefpre`)
- [x] Menu só para o 998 ou a partir de 26/12/2026 (`TConvertServico.Liberado`, `fReformaConvertDisponivel(Operador,
      Data)`)
- [x] ABFRTE com CBS e IBS UF da IMPTRI antes da Fase P

## Fase 8 — Auditoria (2026-10-07)
- [x] Filtro de itens, `fGravarLote` e lista de empresas da consulta de preços com parâmetros
- [x] `try`/`finally` com um objeto antes do `try` (adapter, Processo, Grupos, host 150.x)
- [x] Sem "NOW()" em comentários; medição de tempo (`REFTRI_CONVERT_TEMPO`) desligada
- [x] Unit acrescentada pela IDE removida da tela do Convert; ruído de DFM descartado
- [x] DLL compila nas 5 cópias; cópias idênticas

## Fase 9 — Validação e entrega
- [ ] Compilar os 5 `autcom.exe` no IDE (contrato 12) e distribuir junto com a DLL
- [ ] Rodar o `testes.md` (ou o `Roteiro_Teste_466712.txt`) nas 5 versões e registrar os resultados
- [ ] Revisar o `testes.md` com o analista
- [ ] Levar o DUnit do cálculo para a suíte do projeto e cobrir a regra de preço do Convert
- [ ] Medir o lote de 100 no 150.100 e a gravação sem cascata nas bases do 72/74.111 (`2_30_72_COM`,
      `2_30_74_XX_COM`)
- [ ] `/citel-aprovaRequisito` (justificar: variáveis de unit do `Reforma.Plugin`; lista de empresas para a rotina
      nativa; `pAjustarFundoTema` é do RF11 do REFTRI)
- [ ] Gate DelphAI e commit pelo usuário: primeira linha `Req. 466712` + token; sem `opcoes.ini`, `rev.inc`,
      `*.dproj.local`, linha `Debugger_HostApplication` do `libReformaPrecos.dproj`, `review.diff`, `.delphAI`
