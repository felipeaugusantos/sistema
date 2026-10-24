# Plano de Execução — Req. 464821

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Criar uma função única de montagem do código em `TCamposCfgLocFis` (unit `untCfgLocFis`), que recebe os valores dos cinco campos e concatena na ordem da configuração:

- Parâmetros (na ordem de `arrNomCam`): `AstrCodLse`, `AstrRua`, `AstrPredio`, `AstrAndar`, `AstrAparta`.
- Percorre `Self` (lista de `TCfgLocFis`); pelo `strNomCam` (`LOC_CODLSE`, `LOC_R_U_A_`, `LOC_PREDIO`, `LOC_ANDAR_`, `LOC_APARTA`) escolhe o valor, ignora vazios e une com `-`.
- Sem zeros, sem validação e sem truncamento (equivale ao `fRetCodigoWMS` atual).

O cadastro manual (`fRetCodigoWMS`) passa a delegar para essa função lendo os campos de `qryTabela`. A importação substitui o bloco de concatenação manual por uma chamada à mesma função. O nome exato do método segue o padrão da unit (`f` + verbo), sem número de requisito.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untCfgLocFis | padra_atualizado/fontes/configuracoes/untCfgLocFis.pas | alterar (novo método em `TCamposCfgLocFis`) |
| untCadLocFisica | padra_atualizado/fontes/cadastros/untCadLocFisica.pas | alterar (`fRetCodigoWMS` delega) |
| untImportarPlanilhaLocFisica | padra_atualizado/fontes/cadastros/untImportarPlanilhaLocFisica.pas | alterar (`pValidaLocais`, `uses`) |

Sem alteração em `.dpr`/`.dproj`. Antes de editar, confirmar em `autcom.groupproj` que as três units são compiladas no `autcom.exe` ou na DLL correspondente.

## 3. Sequência de implementação
1. Conferir o valor efetivo de `fTamCodLse` contra o `04N` do CODLSE na config das empresas 002 a 800.
2. Incluir o método de montagem na declaração e na implementação de `TCamposCfgLocFis` (`untCfgLocFis.pas`).
3. Em `untCadLocFisica.pas`, reescrever `fRetCodigoWMS` para chamar o método novo com `LOC_CODLSE`, `LOC_R_U_A_`, `LOC_PREDIO`, `LOC_ANDAR_` e `LOC_APARTA` de `qryTabela`, mantendo o resultado idêntico.
4. Em `untImportarPlanilhaLocFisica.pas`:
   - garantir `untCfgLocFis` no `uses`;
   - em `pValidaLocais`, criar o `TCamposCfgLocFis` e liberar no `Finally` existente;
   - substituir a montagem de `strCodLoc` (linhas ~298-333) por `strCodLoc := objCfgLocFis.<método>(strCodLse, R_U_A_, PREDIO, ANDAR_, APARTA)` quando `blnUsaMascaraCodigo`;
   - manter a montagem de `strEnder_`, `fVerificaChavePrimaria`, `fExisteLocalSeparacao` e a gravação em `CODLSE`.
5. Editar os três arquivos via Python (cp1252, `newline=''`), preservando CRLF.
6. Validar: decodificação em cp1252 sem erro, ausência de `\xef\xbf\xbd`, `svn diff` só com as mudanças pretendidas.

## 4. Conformidade com padrões do projeto
- Zona Legado: Hungarian, `A` em parâmetros, prefixos `p`/`f`; não refatorar além do escopo.
- Sem componentes ou chamadas proibidas; sem `Now`; sem SQL novo.
- Objeto criado manualmente com `try/finally`.
- Nomes de identificadores sem o número do requisito; o número fica só nos comentários curtos, com "Verificar Nota N" quando houver explicação não óbvia (ex.: motivo de o CODLSE só entrar se estiver na config).
- Pre-commit: nada de `.dfm` alterado.

## 5. Estratégia de testes
- Não há suite automatizada para esta tela; validação manual com a planilha de teste (`\\Citel-fileserve\autdbf\CIMDISTR\230926\Cadastros Novas Localizações Sistema_IMPO - P2-P6.xlsx`).
- Casos:
  1. Empresa 001: linha 1 gera `002-01-001-01`.
  2. Empresa com CODLSE no fim da config: código sai com o CODLSE no final.
  3. Config com CODLSE em primeiro: sai no início.
  4. Config sem CODLSE: grava `LOC_CODLSE`, valida existência, não entra no código.
  5. Mesmo dado no cadastro manual e na importação: códigos iguais.
  6. Duplicidade (na planilha e na base): crítica mantida.
  7. `LOCFIS` vazia: `CODLOC` livre da planilha.
  8. Cadastro manual: mesmos códigos de antes da alteração.

## 6. Riscos e mitigação
- `fTamCodLse` diferente do tamanho da config → conferir na etapa 1; se divergir, alinhar com o solicitante antes de seguir.
- Alteração em unit compartilhada (`untCfgLocFis`) → apenas método novo, sem tocar nos existentes.
- Comportamento do manual mudar sem querer → `fRetCodigoWMS` delegando com a mesma regra (vazios ignorados, `-` entre valores) e teste 8.
- Duas versões de `fPadL` com truncamento diferente → a função nova não usa `fPadL`.
- Tipo Alfanumérico `'0'` contra `'O'` → fora de escopo; a função nova não depende do tipo.
