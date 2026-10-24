# Especificação — Req. 432942

**Título:** Cálculo de preço de tinta AUTOMOTIVA via Faturamento.Services.API
**Objetivo:** Habilitar consulta de preço tintométrico automotivo por endpoint REST dedicado, replicando o comportamento da tela `frmAbstractDigTintaAutomotiva` do autcom, com escopo incremental limitado a Lazzumix (LAZ), Duxone Global (DUX), Anjo Automotiva (AJT), Maza Automotiva (MZA) e Maza Industrial (MZD).
**Zona:** Híbrida (API em Zona Moderna, código de tinta em Zona Legado)
**Data:** 2026-07-30
**Solicitantes:** Paula (originadora do requisito), Ronaldo (gerente), Carol (analista)

## 1. Contexto / problema atual

O endpoint `POST /tintas/carregar/dados` da Faturamento.Services.API hoje calcula preço apenas para tintas IMOBILIÁRIAS. Ao receber `idPro` de tinta automotiva, bloqueia explicitamente com `raise Exception.Create('Consulta de preço de tinta automotiva ainda não está disponível.')` em `Services.ConsultarPreco.Tinta.pas:987-988` — trava histórica adicionada por segurança, sem cliente ativo até o momento.

A cliente Tintas Gonçalves passou a demandar cálculo de preço para tintas automotivas via Webservice/SALES PRO. A infraestrutura Linux das libTintas automotivas já está compilada e mapeada (`TLibTintaDllRelacao` registra LAZ, DUX, DU2 como `ttAutomotiva`; os `.so` correspondentes existem em `padra_atualizado/Services/Lib/LibTintas/`), mas a cadeia de propagação de parâmetros específicos da automotiva (formato de embalagem, volume solicitado) está incompleta no path Linux.

Complementarmente, o requisito prevê nova configuração no AUTCOM para parametrizar embalagens padrão de tinta automotiva — item tratado fora desta implementação (pendente definição de UI com Paula).

## 2. Módulos e entidades envolvidos

**Módulos:**
- `padra_atualizado/Services/Faturamento.Services.API/` — controller REST
- `padra_atualizado/Services/Core/faturamento/services/` — service + worker
- `padra_atualizado/Services/Consulta.Preco.Tinta/` — repositório
- `padra_atualizado/autcomtinta/` — hub e função exportada `fRetornaPrecoTintaSemTela`
- `LibTintas/libTintasComum/` — infraestrutura polimórfica (calculador, digitação, tipos)
- `LibTintas/libTintaLazzumix/`, `libTintaDuxone/`, `libTintaDuxone2/` — implementações concretas por marca

**Entidades / tabelas:**
- `TINPRE_REQ` (chave: `TPR_REQ_ID`) — request de cálculo
- `TINPRE_RES` (chave: `TPR_RES_ID`) — resultado (133 campos, incluindo `TPR_EMBPRO`, `TPR_MODVEN`, `TPR_TIPEMB`, `TPR_VOLPRO`, `TPR_TINAUT`, `TPR_PREVE1..7`, `TPR_SALDIS`)
- `<MARCA>_CADMIX` (ex: LAZ_CADMIX, DUX_CADMIX) — fórmulas por marca; campos usados: `MIX_VOLCON`, `MIX_VOLDIL`, `MIX_VOLMIC`, `MIX_VOLMID`, `MIX_REFERE`
- `<MARCA>_CADBAS` — bases por marca
- `CADITE` — cadastro de itens (embalagem via `ITE_PROEMB='S'`)

## 3. Requisitos funcionais

- **RF01** — Nova rota REST `POST /tintas/automotivas/precos` que aceita request com identificação (cliente, empresa, marca, hashes de cor) e parâmetros específicos de automotiva (modo venda, item embalagem, formato embalagem, volume solicitado)
- **RF02** — Nova rota REST `POST /tintas/imobiliarias/precos` com contrato idêntico ao atual `POST /tintas/carregar/dados`
- **RF03** — Rota antiga `POST /tintas/carregar/dados` marcada como deprecated, permanecendo funcional via delegação interna para a rota imobiliária nova
- **RF04** — Resposta idêntica para as duas rotas: array de itens com `hashMd5`, `codigoProduto`, `idGerado`, `estoqueDisponivel`, `preco1..preco7`, `mensagemErro` (reuso do `TTintasCarregarDadosResult` existente)
- **RF05** — Validação de compatibilidade rota/tipo: rejeitar `idPro` imobiliário em rota automotiva e vice-versa
- **RF06** — Whitelist de marcas automotivas homologadas: aceitar apenas `LAZ` (Lazzumix), `DUX` (Duxone Global), `AJT` (Anjo Automotiva), `MZA` (Maza Automotiva) e `MZD` (Maza Industrial) na v1; demais marcas retornam mensagem "em desenvolvimento". `MZD` é classificada como `ttIndustrial` no `TLibTintaDllRelacao`, mas é aceita porque essa classificação é apenas de catálogo — a lib implementa o pipeline automotivo (`TFormulaIndustrialMazaIndustrial` herda de `TAbstractFormulaAutomotiva`, usa `TBaseAutomotiva` e `untDigDadosTintometricosAutomotiva`) e a validação de tipo rejeita apenas `ttImobiliaria`
  - **A whitelist é um gate de liberação gradual, não uma restrição técnica.** Marcas ficam fora apenas enquanto não houver cliente demandando e cenário de teste montado para proteger a liberação. Habilitar uma marca nova é inclusão na constante `MARCAS_AUTOMOTIVAS_HOMOLOGADAS` + testes, sem mudança de código
  - Casos já identificados como tecnicamente aptos mas fora da v1 por esse gate: `DU2` (Duxone Global 2), `KIN` (Killing Industrial) e `MIF` (Up Tintas) — as duas últimas também herdam de `TAbstractFormulaAutomotiva`
- **RF07** — Validação de volume mínimo por fórmula/modo (via `MIX_VOLMIC` / `MIX_VOLMID`)
- **RF08** — Validação polimórfica de modo venda por marca via `fHabilitaRdgModoVenda` (respeita regras específicas de cada `TFormulaAutomotiva<Marca>`)
- **RF09** — Validação de código de item embalagem em `CADITE` com `ITE_PROEMB='S'`

## 4. Regras de negócio

- **RN01** — Cálculo de preço automotivo consome `TAbstractCalculadorPrecoTinta.fRetornaPreco` no path Linux (`blnSemTela=True` forçado em `{$IFDEF LINUX}`), delegando polimorficamente à classe `TFormulaAutomotiva<Marca>` via `TLibTintaFactory.GetITintadeMaquina(idPro)`
- **RN02** — `formatoEmbalagem` aceita siglas `LT` (Litro), `GL` (Galão), `CP` (Copo), `LA` (Lata), `SP` (Spray), `BD` (Balde), `TB` (Tambor), conforme mapeamento em `untDigDadosTintometricosAutomotiva.pas:293-331`
- **RN03** — `modoVenda` aceita `C` (Concentrado) ou `D` (Diluído)
- **RN04** — Se `volumeSolicitado < MIX_VOLMIC` (modo C) ou `< MIX_VOLMID` (modo D) para a fórmula/cor, retornar `mensagemErro` no item e `preco*=0`; demais itens do array continuam processando
- **RN05** — Se `TFormulaAutomotiva<Marca>.fHabilitaRdgModoVenda` rejeitar o modo (ex: Lazzumix trava `MIX_REFERE='LAZZUDUR'`), retornar `mensagemErro` no item
- **RN06** — Se `itemEmbalagem` não existir em `CADITE` ou não tiver `ITE_PROEMB='S'`, retornar `mensagemErro` no item
- **RN07** — Erros por item não travam a request: cada hash é processado isoladamente
- **RN08** — Campos não expostos no contrato v1 (`linhaFabricante`, `codigoDiluente`, `comCatalisador`, `considerarEmbalagem`, `usarResina325`, `percentualAgentePerformance`, `percentualDiluenteAdicional`) usam defaults server-side equivalentes ao comportamento da tela do autcom (primeiro item da lista disponível, false, true, false, 0, 0)
- **RN09** — Cache de `TINPRE_RES` (linhas 828-832 de `Services.ConsultarPreco.Tinta.pas`) filtra por `TPR_EMBPRO + TPR_MODVEN` quando `TINAUT=1` — chave já preparada, sem colisão entre embalagens/modos diferentes da mesma cor
- **RN10** — Campo `TPR_TINAUT` é inferido internamente via `fTipoTinta(idPro)`, não vem do request

## 5. Requisitos técnicos / não-funcionais

- **RT01** — Compatibilidade retroativa: consumidores atuais do `POST /tintas/carregar/dados` não devem quebrar; delegação interna para a rota imobiliária nova mantém contrato
- **RT02** — Separação arquitetural imob/auto: construtores/factory methods dedicados em `TConsultarPrecoTinta` (`NewImobiliaria` / `NewAutomotiva`); DTOs separados; rotas separadas
- **RT03** — Cadeia Linux estendida com parâmetros opcionais no final das assinaturas (`strFormatoEmb: String = ''; fltVolumeSolic: Double = 0`), preservando compatibilidade com chamadas existentes
- **RT04** — Encoding dos fontes Delphi em `latin1` (Windows-1252), CRLF (conforme `.editorconfig`)
- **RT05** — Zona Moderna: Controller → Service → Worker → Repository; `ParamByName` em SQL; exceções tipadas
- **RT06** — Zona Legado: manter estilo existente (Hungarian, prefixos `p`/`f`, herança de bases customizadas); novos parâmetros opcionais no final
- **RT07** — Gate pre-commit: sem `Now()`, `StrToFloat`, `.SetFocus`, `ActiveControl :=`, `Application.CreateForm`, `FOREIGN_KEY_CHECKS`, `TBitBtn`, `TClientDataSet`, `TDBGrid`, `dxSkin*`, `frxSmartMemo`
- **RT08** — Gate DelphAI: token na mensagem de commit; primeira linha `Req. 432942 <resumo>`

## 6. Critérios de aceitação

- [ ] `POST /tintas/automotivas/precos` responde HTTP 200 com preços calculados para cor válida de LAZ, DUX, AJT, MZA e MZD em modos C e D
- [ ] Paridade validada: mesma cor+parâmetros na tela `frmAbstractDigTintaAutomotiva` do autcom e no endpoint retornam `preco1..preco7` iguais
- [ ] `POST /tintas/automotivas/precos` com `idPro` imobiliário (ex: SRV) retorna `mensagemErro` no item
- [ ] `POST /tintas/imobiliarias/precos` com `idPro` automotivo (ex: LAZ) retorna `mensagemErro` no item
- [ ] `POST /tintas/automotivas/precos` com marca fora da whitelist (ex: DU2 Duxone Global 2, STA Starmix, DUP Axalta) retorna `mensagemErro` "em desenvolvimento"
- [ ] `volumeSolicitado` abaixo do mínimo da fórmula retorna `mensagemErro` no item, sem travar demais
- [ ] `itemEmbalagem` inválido (sem `ITE_PROEMB='S'`) retorna `mensagemErro` no item
- [ ] Modo `C` em cor Lazzumix com `MIX_REFERE='LAZZUDUR'` retorna `mensagemErro` (regra polimórfica)
- [ ] `POST /tintas/imobiliarias/precos` para SRV retorna resultado idêntico ao `POST /tintas/carregar/dados` atual
- [ ] `POST /tintas/carregar/dados` (deprecated) continua funcional com o mesmo comportamento anterior
- [ ] Compilação Linux dos `.so` de LAZ, DUX, AJT, MZA e MZD permanece funcional após alteração das assinaturas na cadeia (F5)
- [ ] Cache `TINPRE_RES` não colide entre requests da mesma cor com formatos/modos diferentes
- [ ] Swagger publica as 3 rotas com contratos corretos; rota deprecated sinalizada

## 7. Fora de escopo

- Suporte a outras marcas automotivas além de LAZ, DUX, AJT, MZA, MZD — inclusive `DU2` (Duxone Global 2), que estava na whitelist e foi retirada por decisão da analista. Exclusão por gate de liberação gradual (demanda de cliente + cenário de teste), não por impedimento técnico; habilitação futura via inclusão na whitelist
- Campo `codigoDiluente` no contrato (marcas homologadas retornam `fGetDiluentes = Nil`; server aplica default se marca futura exigir)
- Campo `linhaFabricante` no contrato (server aplica `stlDesEmb[0]` como default)
- Campos polimórficos avançados: catalisador, resina 325, percentual de agente performance, diluente adicional, considerar embalagem
- Formatos de embalagem além dos 7 padrão: Spray Sintético, Spray Poliéster, Spray Duco
- Item 2 do requisito original (nova config CFGTIN `EMBAUT` no AUTCOM) — pendente definição de UI com Paula, será tratado em requisito complementar
- Habilitar novas marcas automotivas em produção — cada marca requer teste de paridade dedicado

## 8. Dependências e riscos

**Dependências:**
- Projetos `TintaLazzumix.dproj`, `TintaDuxone.dproj`, `TintaDuxone2.dproj` em `padra_atualizado/Services/Lib/LibTintas/` compiláveis para Linux64 (validado — todos com Platform Linux64 default)
- `TLibTintaDllRelacao` já mapeia LAZ, DUX, DU2 como `ttAutomotiva` (validado)
- `libAutcomTinta.so` carregado no startup do daemon Faturamento.Services.API

**Riscos:**
- **R1** — Paridade autcom vs endpoint pode divergir devido a defaults server-side (linhaFabricante, comCatalisador, considerarEmbalagem, etc.) — validar cedo com cor real de cada marca homologada (LAZ/DUX/AJT/MZA/MZD)
- **R2** — Suporte a `deprecated: true` no Swagger via MVCFramework pode não existir; fallback é sinalizar via `[MVCSwagSummary]` textual
- **R3** — F5 altera assinaturas em código legado profundo (cadeia de 5 arquivos) — mesmo marcas fora do escopo precisam continuar compilando limpo
- **R4** — Setters `Formula.tpeTipEmb` e `Formula.VolumePro` podem ter side-effects (recalcular volume mínimo, disparar eventos) — validar comportamento em teste de paridade
- **R5** — Primeiro build Linux após F5 pode revelar dependências não previstas (unit não referenciada, encoding, `{$IFDEF LINUX}` mal balanceado) — mitigar com build local via PAServer cedo
