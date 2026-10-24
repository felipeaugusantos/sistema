# Plano de Execução — Req. 432942

**Referência:** specs.md
**Zona:** Híbrida (API em Moderna, código de tinta em Legado)
**Estratégia:** Entrega incremental — primeira release cobre LAZ, DUX, AJT, MZA, MZD; arquitetura fica genérica para escalar

## 1. Abordagem técnica

### 1.1 Rotas REST

| Rota | Estado | Contrato |
|---|---|---|
| `POST /tintas/imobiliarias/precos` | Nova | Idêntico ao `/tintas/carregar/dados` atual |
| `POST /tintas/automotivas/precos` | Nova | Dedicado (ver Seção 1.2) |
| `POST /tintas/carregar/dados` | DEPRECATED | Delega internamente para a rota imobiliária nova |

### 1.2 Contrato do request `POST /tintas/automotivas/precos`

Todos os campos são obrigatórios:

- `codigoCliente` — string
- `codigoEmpresa` — string
- `idPro` — string(3), whitelist v1: `LAZ`, `DUX`, `AJT`, `MZA`, `MZD`
- `hashesMd5` — array de strings (hashes de cores/fórmulas)
- `modoVenda` — string(1): `C` (Concentrado) ou `D` (Diluído)
- `itemEmbalagem` — string, código de produto em `CADITE` com `ITE_PROEMB='S'`
- `formatoEmbalagem` — string(2): `LT` | `GL` | `CP` | `LA` | `SP` | `BD` | `TB`
- `volumeSolicitado` — Double (litros)

### 1.3 Contrato do request `POST /tintas/imobiliarias/precos`

Idêntico ao `TTintasCarregarDadosParams` atual:
- `codigoCliente`, `codigoEmpresa`, `idPro`, `hashesMd5`, `codigoProduto` (opcional)

### 1.4 Contrato do response (comum às duas rotas)

Reuso do `TTintasCarregarDadosResult` existente — array de items:
- `hashMd5`, `codigoProduto`, `idGerado`, `estoqueDisponivel`, `preco1..preco7`, `mensagemErro`

### 1.5 Separação de responsabilidade

- Factory methods dedicados: `TConsultarPrecoTinta.NewImobiliaria(...)` e `NewAutomotiva(...)`
- Construtor atual → `protected` + marker deprecated
- DTOs separados: `TTintasImobiliariasCarregarDadosParams` e `TTintasAutomotivasCarregarDadosParams`
- Service com métodos dedicados: `fCarregarDadosImobiliarias` e `fCarregarDadosAutomotivas`
- Idem em `TTintometricoServiceWorker`

### 1.6 Propagação Linux (crítico)

Cadeia atual encerra em `TDigDadosTintometricosAutomotiva.fDigDadosTintometricos`, que no path Linux (linhas 165-167 de `untDigDadosTintometricosAutomotiva.pas`) só recebe `strEmbPro` e `strModoVenda`. Formato de embalagem (`Formula.tpeTipEmb`) e volume solicitado (`Formula.VolumePro`) hoje só são setados via componentes VCL (`rdbLitro.Click`, `edtVolume.Text`), inexistentes em Linux.

Solução: adicionar dois parâmetros opcionais no final das assinaturas da cadeia (`strFormatoEmb: String = ''; fltVolumeSolic: Double = 0`) e, no path Linux de `fDigDadosTintometricos`, aplicá-los em `Formula.tpeTipEmb` (via conversor de sigla) e `Formula.VolumePro` antes do `pOnShow()`.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|---|---|---|
| `Services.ConsultarPreco.Tinta.pas` | `padra_atualizado/Services/Consulta.Preco.Tinta/Source/` | Alterar: factory methods, campos FTipEmb/FVolPro, remover raise (linha 987-988), whitelist automotiva, validações |
| `api.controller.tintometrico.pas` | `padra_atualizado/Services/Faturamento.Services.API/Source/api/controller/` | Alterar: 3 actions (imob nova, auto nova, deprecated), validação tipo/rota |
| `Faturamento.Services.Tintometrico.pas` | `padra_atualizado/Services/Core/faturamento/services/` | Alterar: dois métodos (`fCarregarDadosImobiliarias`, `fCarregarDadosAutomotivas`) |
| `Faturamento.Services.Workers.pas` | `padra_atualizado/Services/Core/faturamento/services/` | Alterar: dois workers |
| `TTintasImobiliariasCarregarDadosParams` (DTO) | Novo arquivo em `padra_atualizado/Services/Faturamento.Services.API/Source/api/controller/` | Criar |
| `TTintasAutomotivasCarregarDadosParams` (DTO) | Novo arquivo em `padra_atualizado/Services/Faturamento.Services.API/Source/api/controller/` | Criar |
| `untTintaMaquina.pas` | `padra_atualizado/autcomtinta/` | Alterar: `fRetornaPrecoTintaSemTela` (+2 params opcionais) |
| `AutcomTinta.dpr` | `padra_atualizado/Services/Lib/autcomtinta/Linux/` | Atualizar cláusula `exports` com nova assinatura |
| `untAbstractLibTintaAutomotiva.pas` | `LibTintas/libTintasComum/Genericos/` | Alterar: `RetornaPreco` (+2 params opcionais) |
| `untAbstractCalculadorPrecoTinta.pas` | `LibTintas/libTintasComum/Genericos/` | Alterar: `fRetornaPreco` (+2 params opcionais) |
| `untDigDadosTintometricosAutomotiva.pas` | `LibTintas/libTintasComum/Genericos/` | Alterar: `fDigDadosTintometricos` (+2 params) + bloco `{$IFDEF LINUX}` aplicando `Formula.tpeTipEmb` e `Formula.VolumePro` |
| `untTipoEmbalagem.pas` | `LibTintas/libTintasComum/Tipos/` | Adicionar `fConverterSiglaTipoEmbalagem(strSigla): TTipoEmbalagem` |

## 3. Sequência de implementação

1. **F1 — Factory methods em `TConsultarPrecoTinta`** — adicionar `NewImobiliaria` e `NewAutomotiva`, mover construtor para `protected`, remover `raise` da linha 987-988, adicionar campos privados `FTipEmb` e `FVolPro`
2. **F2 — DTOs novos** — criar `TTintasImobiliariasCarregarDadosParams` (clone semântico) e `TTintasAutomotivasCarregarDadosParams` (8 campos)
3. **F3 — Rotas REST** — criar as duas actions novas em `api.controller.tintometrico.pas`, marcar rota antiga como deprecated (delegação interna)
4. **F4 — Service + Worker** — criar `fCarregarDadosImobiliarias` (clone) e `fCarregarDadosAutomotivas` (grava `TPR_EMBPRO`, `TPR_MODVEN`, `TPR_TIPEMB`, `TPR_VOLPRO` em `TINPRE_REQ`)
5. **F5 — Propagação Linux (cadeia legada)**
   - F5.1: adicionar `fConverterSiglaTipoEmbalagem` em `untTipoEmbalagem.pas`
   - F5.2: adicionar `strFormatoEmb` e `fltVolumeSolic` (opcionais no final) nas 5 assinaturas: `Services.ConsultarPreco.Tinta.pas:1059`, `untTintaMaquina.pas:2402`, `AutcomTinta.dpr` exports, `untAbstractLibTintaAutomotiva.pas:767`, `untAbstractCalculadorPrecoTinta.pas:40`, `untDigDadosTintometricosAutomotiva.pas:51`
   - F5.3: aplicar em Linux dentro de `untDigDadosTintometricosAutomotiva.pas` bloco `{$IFDEF LINUX}` (junto ao 165-167): setar `Formula.tpeTipEmb` e `Formula.VolumePro` quando parâmetros vierem preenchidos
6. **F6 — Validações (Services.ConsultarPreco.Tinta.pas + controller)**
   - Rota auto: `fTipoTinta(idPro) = ttImobiliaria` → mensagemErro (aceita `ttAutomotiva` e `ttIndustrial`, este último por causa de `MZD`)
   - Rota imob: `fTipoTinta(idPro) <> ttImobiliaria` → mensagemErro
   - Whitelist auto v1: `idPro in ['LAZ','DUX','AJT','MZA','MZD']` — caso contrário mensagemErro "em desenvolvimento"
   - Volume < `MIX_VOLMIC`/`MIX_VOLMID` → mensagemErro no item
   - Delegar `TFormulaAutomotiva<Marca>.fHabilitaRdgModoVenda`
   - `itemEmbalagem` inválido (sem `ITE_PROEMB='S'`) → mensagemErro
7. **Build Linux** — compilar `libTintaLazzumix.so`, `libTintaDuxone.so`, `libTintaAnjoAutomotiva.so`, `libTintaMazaAutomotiva.so` e `libTintaMazaIndustrial.so` via PAServer local; validar `libAutcomTinta.so` também
8. **Validação de paridade** — comparar `preco1..preco7` do endpoint vs tela `frmAbstractDigTintaAutomotiva` do autcom para uma cor real de cada marca homologada em modos C e D

## 4. Conformidade com padrões do projeto

**Zona Moderna** (controller, service, worker, DTOs, `TConsultarPrecoTinta`):
- Arquitetura em camadas: Controller → Service → Worker → Repository
- Interfaces com GUID quando criar contratos novos
- `ParamByName()` em SQL, sem concatenação
- Tratamento de exceções tipadas com re-raise após rollback quando aplicável
- Sem Hungarian style em código novo

**Zona Legado** (cadeia `untTintaMaquina`, `untAbstractLibTintaAutomotiva`, `untAbstractCalculadorPrecoTinta`, `untDigDadosTintometricosAutomotiva`, `untTipoEmbalagem`):
- Manter estilo Hungarian existente
- Prefixo `f` para funções, `p` para procedures
- Novos parâmetros como opcionais no final da assinatura (não quebra chamadas)
- Encoding `latin1` (Windows-1252), CRLF

**Componentes / chamadas proibidos (pre-commit):**
- Sem `Now()`/`NOW()` em código novo — usar `fNow()`
- Sem `StrToFloat`/`StrToFloatDef` — usar `fStrToFloat`/`fStrToFloatDef`
- Sem `.SetFocus` direto — usar `pSetFocus`
- Sem `Application.CreateForm` — usar `pCriarForm` / `pCriarFormularios`
- Sem `ActiveControl :=` (exceto `:= nil`)
- Sem `FOREIGN_KEY_CHECKS` / `SET_FOREIGN_CHECKS` em SQL
- Sem componentes proibidos: `TBitBtn`, `TButton`, `TClientDataSet`, `TDBGrid`, `dxSkin*`, `frxSmartMemo` (não aplicável nesta implementação — não há UI)

**Gate DelphAI:**
- Rodar antes do commit
- Primeira linha do commit: `Req. 432942 <resumo curto>`
- Token DelphAI presente na mensagem

## 5. Estratégia de testes

Testes automatizados não fazem parte do escopo desta entrega (decisão explícita).

**Validação manual obrigatória:**
- Cor real de LAZ modo C: comparar preços da tela do autcom vs endpoint `POST /tintas/automotivas/precos`
- Cor real de LAZ modo D: idem
- Cor real de DUX modo C: idem
- Cor real de DUX modo D: idem
- Cor real de AJT modos C e D: idem
- Cor real de MZA modos C e D: idem
- Cor real de MZD modos C e D: idem
- Cor Lazzumix com `MIX_REFERE='LAZZUDUR'`: verificar rejeição polimórfica no endpoint
- Cor com volume abaixo do mínimo: verificar `mensagemErro` no item, demais itens processando
- `POST /tintas/automotivas/precos` com `idPro='SRV'` (imob): verificar `mensagemErro`
- `POST /tintas/imobiliarias/precos` com `idPro='LAZ'` (auto): verificar `mensagemErro`
- `POST /tintas/automotivas/precos` com marca não homologada (ex `STA`, `DUP`, `ANJ`): verificar `mensagemErro` "em desenvolvimento"
- `itemEmbalagem` inexistente ou sem `ITE_PROEMB='S'`: verificar `mensagemErro`
- Regressão imobiliária: `POST /tintas/imobiliarias/precos` com `SRV` deve retornar mesmo resultado que `POST /tintas/carregar/dados` atual
- Regressão da rota deprecated: `POST /tintas/carregar/dados` deve continuar funcional após F3

## 6. Riscos e mitigação

- **R1 — Paridade autcom vs endpoint pode divergir** por causa de defaults server-side (linhaFabricante, comCatalisador, considerarEmbalagem, etc.) → Mitigação: validar cedo com uma cor real; se divergência aparecer, identificar qual default está errado e ajustar
- **R2 — MVCFramework pode não suportar `deprecated: true` no Swagger** → Mitigação: fallback via texto explícito em `[MVCSwagSummary]` sinalizando deprecação
- **R3 — Consumidores atuais de `/tintas/carregar/dados` podem quebrar** → Mitigação: manter rota funcional com delegação transparente para a imob nova; nenhuma mudança de contrato de request ou response
- **R4 — Compilação Linux após F5 pode revelar problemas em outras marcas** (fora do escopo LAZ/DUX/DU2) devido a alteração de assinaturas em código compartilhado → Mitigação: usar parâmetros opcionais no final; compilar todos os `.dproj` de `padra_atualizado/Services/Lib/LibTintas/` para detectar quebras cedo
- **R5 — Setters `Formula.tpeTipEmb` e `Formula.VolumePro` podem ter side-effects** (recalcular volume mínimo, disparar eventos VCL) → Mitigação: validar em teste de paridade; se side-effect atrapalhar em Linux, envolver `{$IFDEF LINUX}` na aplicação
- **R6 — Cache `TINPRE_RES` pode colidir** entre requests da mesma cor com formatos/modos diferentes → Mitigação: já validado em specs — as linhas 828-832 filtram por `TPR_EMBPRO + TPR_MODVEN` quando `TINAUT=1`
