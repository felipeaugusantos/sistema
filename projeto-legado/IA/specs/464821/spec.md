# Especificação — Req. 464821

**Título:** Importação de localização física acrescenta o Local de Separação no início do LOC_CODLOC
**Objetivo:** Fazer o código (`LOC_CODLOC`) gerado pela importação de planilha seguir a configuração `CFG_LOCFIS` da empresa logada (campos e ordem), igual ao cadastro manual.
**Zona:** Legado
**Data:** 2026-09-29

## 1. Contexto / problema atual

Menu: Principal > Manutenção de Cadastros > Produtos > Localização Física > Importar planilha.

A `CFG_LOCFIS` (tabela `CFGSIS`, `SIS_CODCFG = 'CFG_LOCFIS'`, valor **por empresa**) define quais campos compõem o código da localização e em que ordem. Formato: blocos de 13 caracteres = nome do campo (10) + tipo (1: `L` alfa, `A` numérico, `0` alfanumérico) + tamanho (1) + completar com zeros (`S`/`N`).

Valores encontrados na base consultada:

| Empresa | CFG_LOCFIS | Ordem resultante |
|---|---|---|
| 001 | `LOC_R_U_A_A3S` `LOC_PREDIOA2S` `LOC_ANDAR_A3S` `LOC_APARTAA2S` | Rua-Prédio-Andar-Apto (sem CODLSE) |
| 002, 003, 004, 005, 800 | `LOC_R_U_A_A4N` `LOC_PREDIOA4N` `LOC_ANDAR_A4N` `LOC_APARTAA4N` `LOC_CODLSE04N` | Rua-Prédio-Andar-Apto-CODLSE (CODLSE no fim) |

- **Cadastro manual** (`TfrmCadLocFisica.fRetCodigoWMS`, `untCadLocFisica.pas`): percorre `objCfgLocFis` (`TCamposCfgLocFis`) na ordem configurada e junta os valores não vazios com `-`. Correto.
- **Importação** (`TfrmImportarPlanilhaLocFisica.pValidaLocais`, `untImportarPlanilhaLocFisica.pas`, ~linhas 298-333): replica a lógica com **ordem fixa** `CODLSE-RUA-PREDIO-ANDAR-APARTA` e **sempre** prefixa o CODLSE quando a máscara está ativa, sem consultar `objCfgLocFis`.

Efeito no cliente (empresa 001, sem CODLSE na config): linha da planilha com Local de Separação `002`, Rua `002`, Prédio `01`, Andar `001`, Apto `01` gera `002-002-01-001-01`; o esperado é `002-01-001-01` (o "002 a mais" reportado). Nas empresas 002 a 800 há defeito equivalente: o CODLSE vai para o início, mas a config o coloca no fim.

Planilha de teste: `\\Citel-fileserve\autdbf\CIMDISTR\230926\Cadastros Novas Localizações Sistema_IMPO - P2-P6.xlsx` (colunas: F = Local de Separação; H = Rua; I = Prédio; J = Andar; K = Apartamento).

## 2. Módulos e entidades envolvidos
- Módulo: Cadastros / Configurações (WMS, localização física).
- Units:
  - `padra_atualizado/fontes/configuracoes/untCfgLocFis.pas`
  - `padra_atualizado/fontes/cadastros/untCadLocFisica.pas`
  - `padra_atualizado/fontes/cadastros/untImportarPlanilhaLocFisica.pas`
- Tabelas: `CADLOC` (`LOC_CODEMP` + `LOC_CODLOC`; chave técnica `AUTOINCREM`; campos `LOC_CODLSE`, `LOC_R_U_A_`, `LOC_PREDIO`, `LOC_ANDAR_`, `LOC_APARTA`), `CADLSE` (`LSE_CODIGO`), `CFGSIS` (`SIS_CODEMP` + `SIS_CODCFG`).

## 3. Requisitos funcionais
- RF01 — A importação deve montar o `LOC_CODLOC` percorrendo a `CFG_LOCFIS` da empresa logada, na ordem e com os campos configurados.
- RF02 — O cadastro manual e a importação devem usar a **mesma função** de montagem (`TCamposCfgLocFis`), eliminando a duplicação de lógica.
- RF03 — O Local de Separação só compõe o código se `LOC_CODLSE` constar na `CFG_LOCFIS`, na posição configurada.
- RF04 — Fora da máscara, o Local de Separação continua sendo gravado em `LOC_CODLSE` e validado por `fExisteLocalSeparacao`, sem entrar no código.

## 4. Regras de negócio
- RN01 — Montagem: percorrer a lista na ordem da config; para cada campo, pegar o valor correspondente; ignorar valores vazios; unir com `-`.
- RN02 — A montagem **não completa zeros, não valida tipo/tamanho e não trunca**. A planilha deve vir com os valores corretos (igual ao comportamento atual da importação).
- RN03 — O CODLSE informado na planilha continua sendo padronizado com `fPadL(..., fTamCodLse, '0')` antes de ser usado (na máscara ou fora dela).
- RN04 — A empresa considerada é a logada (`fCfgSis` sem `strCodEmp` usa `VS_strCodEmp`).
- RN05 — `LOCFIS` vazia (sem máscara): comportamento atual mantido (CODLOC digitado livremente na planilha).
- RN06 — Detecção de duplicidade (`fVerificaChavePrimaria` e dicionário `lstCodigos`) continua usando o código montado.
- RN07 — Deve continuar exigindo ao menos um entre Rua, Prédio, Andar e Apartamento (regra atual).

## 5. Requisitos técnicos / não-funcionais
- Nomes sem número do requisito; seguir o padrão da unit (Hungarian, `A` em parâmetros, prefixos `p`/`f`).
- `TCamposCfgLocFis` criado na importação com `try/finally`.
- Arquivos `.pas` em cp1252/CRLF: edição apenas via Python com encoding explícito; conferir ausência de `\xef\xbf\xbd` e diff limpo.
- Sem alteração em `.dpr`/`.dproj`.
- Sem impacto fiscal/financeiro; sem mudança de banco.

## 6. Critérios de aceitação
- [ ] Empresa 001: linha 1 da planilha de teste gera `LOC_CODLOC = 002-01-001-01`.
- [ ] Empresas 002 a 800: com CODLSE na config (no fim), o código sai `Rua-Prédio-Andar-Apto-CODLSE`.
- [ ] O mesmo conjunto de valores gera o mesmo código no cadastro manual e na importação.
- [ ] Config com `LOC_CODLSE` na primeira posição: o CODLSE sai no início.
- [ ] Config sem `LOC_CODLSE`: o Local de Separação é gravado em `LOC_CODLSE` e validado, sem aparecer no código.
- [ ] Crítica de duplicidade continua funcionando (código repetido na planilha e já existente na base).
- [ ] `LOCFIS` vazia: importação continua usando o `CODLOC` da planilha.
- [ ] Cadastro manual continua gerando os mesmos códigos de antes.

## 7. Fora de escopo
- Montagem de `ENDER_`.
- Completar zeros, validar tipo ou tamanho na importação.
- Tipo Alfanumérico gravado como `'0'` (zero) em `pSalva`, comparado com `'O'` (letra) em `pSetaConfiguracoes`.
- Demais formulários que instanciam `TCamposCfgLocFis` (`untCadLocFisSelecao`, `untInativarLotesSemSaldo`, `untBalancoEstoqueDigColetivo`, `untImpEtiLoteDoProduto`, `untFiltroEtiItens`).
- Duas versões de `fPadL` com truncamento diferente.

## 8. Dependências e riscos
- `fTamCodLse` pode divergir do tamanho `04N` do CODLSE na config das empresas 002 a 800 → conferir o valor real antes de implementar.
- A função compartilhada fica em `untCfgLocFis`, usada por várias units; a alteração é apenas aditiva (novo método), sem mudar os existentes.
- O `TCamposCfgLocFis` deve ser criado após o login/troca de empresa (criado dentro de `pValidaLocais`, atende).
- A base consultada (somente leitura) tem a `CFG_LOCFIS` da empresa 001 igual à do cliente, mas não reproduz a importação; a validação é manual com a planilha.
