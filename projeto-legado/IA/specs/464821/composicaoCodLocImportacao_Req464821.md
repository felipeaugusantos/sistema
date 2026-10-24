# Req. 464821 — Importação de localização física: composição do LOC_CODLOC conforme CFG_LOCFIS

**Sistema:** AUTCOM (desktop VCL) — Principal > Manutenção de Cadastros > Produtos > Localização Física
**Solicitante/contato:** Gabriel (cliente CIMDISTR) | **Análise inicial:** Osvaldo Lucas Machado (25/09/2026) | **Validação:** Leandro Conti (28/09/2026)
**Zona:** Legado | **Working copy:** 379.48.2.30.74.150.45 (revisão base SVN 497456)

## 1. Contexto de negócio

Quando a empresa usa WMS com **máscara de código** de localização, o campo `CADLOC.LOC_CODLOC` não é digitado: é
composto automaticamente a partir dos campos de endereço da localização. Quem define **quais campos** entram e **em
que ordem** é a configuração `CFG_LOCFIS`, gravada em `CFGSIS` (`SIS_CODCFG = 'CFG_LOCFIS'`) **por empresa**
(`SIS_CODEMP`), e editada na tela `TfrmCfgLocFis` (`untCfgLocFis.pas`).

Campos elegíveis (`arrNomCam` em `untCfgLocFis.pas`): `LOC_CODLSE` (Local de Separação), `LOC_R_U_A_` (Rua), `LOC_PREDIO`
(Prédio), `LOC_ANDAR_` (Andar), `LOC_APARTA` (Apartamento).

Formato do valor: blocos de 13 caracteres por campo = nome (10) + tipo (1) + tamanho (1) + completar com zeros (1).

| Posição | Significado |
|---|---|
| tipo | `L` = alfa, `A` = numérico, `0` = alfanumérico (gravado como zero) |
| tamanho | 1 dígito (1 a 9) |
| zeros | `S` = completa com zeros à esquerda (só habilitado para tipo numérico); `N` = não completa |

Valores encontrados na base consultada (leitura):

| Empresa | CFG_LOCFIS | Código resultante |
|---|---|---|
| 001 | `LOC_R_U_A_A3S LOC_PREDIOA2S LOC_ANDAR_A3S LOC_APARTAA2S` | Rua-Prédio-Andar-Apto (sem CODLSE) |
| 002, 003, 004, 005, 800 | `LOC_R_U_A_A4N LOC_PREDIOA4N LOC_ANDAR_A4N LOC_APARTAA4N LOC_CODLSE04N` | Rua-Prédio-Andar-Apto-CODLSE (CODLSE no fim) |

(espaços acrescentados acima só para leitura; no banco o valor é contínuo.)

## 2. O problema e a causa raiz

Sintoma reportado: ao importar planilha de novas localizações, o sistema "acrescenta 002 no início do código".

**Causa raiz:** `TfrmImportarPlanilhaLocFisica.pValidaLocais` (`untImportarPlanilhaLocFisica.pas`) replicava à mão a montagem
do código do cadastro manual, mas com **ordem fixa** `CODLSE-RUA-PREDIO-ANDAR-APARTA` e **sempre** prefixando o CODLSE quando a
máscara estava ativa (`blnUsaMascaraCodigo`, que só indica `CFG_LOCFIS` não vazia). Nunca consultava a lista de campos da
configuração.

O cadastro manual (`TfrmCadLocFisica.fRetCodigoWMS`, `untCadLocFisica.pas`) sempre esteve correto: percorria
`objCfgLocFis` (`TCamposCfgLocFis`) na ordem configurada.

Exemplo real (planilha de teste, empresa 001): colunas F = Local de Separação `002`, H = Rua `002`, I = Prédio `01`,
J = Andar `001`, K = Apto `01`.

- Importação (antes): `002-002-01-001-01` (CODLSE fixo na frente).
- Esperado pela config da 001 (sem CODLSE): `002-01-001-01` — o mesmo que o cadastro manual gera.

Defeito equivalente, não reportado, nas empresas 002 a 800: a config põe o CODLSE **no fim**, e a importação o colocava
**no início**.

## 3. Jornada de investigação

1. O relato do cliente e a análise inicial (Osvaldo, via DelphAI) atribuíam o comportamento à "regra de negócio" de o CODLSE
   compor o código. Leandro Conti respondeu que o comportamento estava correto segundo a `CFG_LOCFIS`. A divergência estava
   em que o cadastro manual respeitava a config e a importação não.
2. Leitura do código: `fRetCodigoWMS` (manual, dinâmico) contra `pValidaLocais` (importação, ordem fixa). Confirmada a
   duplicação de lógica com comportamento divergente.
3. Leitura de `TCamposCfgLocFis.Create`: a lista é montada por `fCfgSis('LOCFIS', varString)` em blocos de 13 caracteres.
4. Planilha de teste lida (`\\Citel-fileserve\autdbf\CIMDISTR\230926\Cadastros Novas Localizações Sistema_IMPO - P2-P6.xlsx`),
   confirmando o "002 a mais" no código esperado/gerado.
5. Consulta somente leitura ao banco (conta `atendimentoII`, `SELECT` com `LIMIT`): inicialmente consultei `LOCFIS` sem o
   prefixo `CFG_` e concluí, errado, que a base não tinha a config. O correto é `SIS_CODCFG = 'CFG_LOCFIS'`. Com isso apareceu
   a config por empresa (seção 1), que revelou também o defeito das empresas 002 a 800.
6. Confirmado que a empresa considerada é a logada: `fCfgSis` → `fCfgSisL` usa `VS_strCodEmp` quando `strCodEmp` vem vazio
   (existe desvio `VS_EmpCfgSisDes`/`VS_ArrCfgSisDes` só para configs listadas; não há indício de que a `LOCFIS` esteja nele).

## 4. Abordagens avaliadas e descartadas

- **Ajuste mínimo só na importação** (percorrer `objCfgLocFis` dentro de `pValidaLocais`): funcionaria, mas manteria a
  lógica de montagem duplicada em duas units, que foi a origem do defeito. Descartado em favor da função compartilhada
  (decisão do solicitante).
- **Completar zeros e validar tipo/tamanho na importação** (como o `OnExit` do manual): descartado por decisão do
  solicitante — a planilha deve vir com os valores corretos, como já era o comportamento. Registro do comportamento do manual
  (útil para quem for retomar o tema): `pOnExit1..4` só existem para tamanho 1 a 4, só rodam em modo de edição e chamam
  `fPadL(valor, N, '0')` sem validar letras; o bloqueio de letras no manual vem só do `TipoTexto` numérico do edit.
- **Reusar `fPadL` na função nova:** descartado — há duas implementações com truncamento diferente (seção 7).

## 5. Solução aplicada

Nova função em `TCamposCfgLocFis` (`untCfgLocFis.pas`):

```pascal
function fMontaCodigo(Const AstrCodLse, AstrRua, AstrPredio, AstrAndar, AstrAparta : String) : String;
```

- Percorre a lista na ordem da configuração; para cada campo, escolhe o valor pelo `strNomCam` (`IndexText` em
  `arrNomCam`); ignora valores vazios; une com `-`. Sem zeros, sem validação, sem truncamento.
- Comportamento idêntico ao do antigo `fRetCodigoWMS`.

Alterações:

| Unit | Alteração |
|---|---|
| `untCfgLocFis.pas` | Declaração e implementação de `TCamposCfgLocFis.fMontaCodigo` |
| `untCadLocFisica.pas` | `fRetCodigoWMS` passa a chamar `objCfgLocFis.fMontaCodigo` com `LOC_CODLSE`, `LOC_R_U_A_`, `LOC_PREDIO`, `LOC_ANDAR_`, `LOC_APARTA` de `qryTabela` |
| `untImportarPlanilhaLocFisica.pas` | `untCfgLocFis` no `uses` da implementação; `pValidaLocais` cria `TCamposCfgLocFis` dentro do `Try` (inicializado com `Nil`) e libera no `Finally`; a concatenação manual do `strCodLoc` foi substituída por `fMontaCodigo(strCodLse, R_U_A_, PREDIO, ANDAR_, APARTA)` |

Mantido na importação: montagem de `strEnder_` (texto do endereço), `fVerificaChavePrimaria`, validação por
`fExisteLocalSeparacao`, padronização do CODLSE com `fPadL(..., fTamCodLse, '0')`, gravação em `CODLSE`, crítica de duplicidade
por `lstCodigos`. `fTamCodLse` lê o tamanho da coluna `CADLSE.LSE_CODIGO` (`DESC CADLSE`), não o `04N` da config — não há
divergência a tratar.

Comportamento resultante: o Local de Separação só compõe o código se `LOC_CODLSE` estiver na `CFG_LOCFIS`, na posição
configurada; fora da máscara, continua sendo gravado em `LOC_CODLSE` e validado, sem entrar no código. Com `LOCFIS` vazia, o
`CODLOC` continua sendo o digitado na planilha.

## 6. Decisões de escopo

Incluído: montagem do código conforme config, em todas as empresas; unificação da lógica manual/importação.

Fora de escopo (por decisão do solicitante): `strEnder_`; completar zeros/validar tipo e tamanho na importação; tipo
alfanumérico (item 7); demais formulários que instanciam `TCamposCfgLocFis` (`untCadLocFisSelecao`, `untInativarLotesSemSaldo`,
`untBalancoEstoqueDigColetivo`, `untImpEtiLoteDoProduto`, `untFiltroEtiItens`) — não foram alterados.

## 7. Achados colaterais (não corrigidos)

1. **Tipo alfanumérico nunca é aplicado no cadastro manual.** `pSalva` grava `'0'` (zero) para "Alfanumerico", mas
   `pSetaConfiguracoes` compara com `'O'` (letra) e nunca casa; o edit fica sem `TipoTexto`.
2. **Duas versões de `fPadL` com truncamento diferente** quando o texto excede o tamanho: `untFuncoesSimples.pas` mantém o fim
   do texto; `libFuncoes/untFuncoesGen.pas` mantém o começo. Ambas cortam em silêncio.
3. **`pOnExit` do manual só cobre tamanho 1 a 4**; acima disso "Completar com Zeros" marcado não completa nada.
4. **A `Case` que despacha por `strTipDad`/`intTamCam` no manual não valida letras em campo numérico** — depende só do
   `TipoTexto` do edit.

## 8. Validação

Implementação concluída e conferida por diff. **Importação validada pelo solicitante (2026-09-30): resultado ok.** Replicada em
74.150 e 74.150.100 (mesmo código, diff e encoding conferidos). Roteiro usado com a planilha de teste:

- Empresa 001: linha 1 gera `002-01-001-01`.
- Empresa com CODLSE no fim da config (002 a 800): código sai `Rua-Prédio-Andar-Apto-CODLSE`.
- Config com CODLSE em primeiro: CODLSE no início.
- Config sem CODLSE: `LOC_CODLSE` gravado e validado, fora do código.
- Mesmo dado no manual e na importação: mesmo código.
- Duplicidade (planilha e base): crítica mantida. `LOCFIS` vazia: `CODLOC` livre da planilha.
- Cadastro manual: códigos iguais aos de antes.

## 9. Ressalvas e lições de processo

- Consulta à base: a chave em `CFGSIS` é `SIS_CODCFG = 'CFG_<nome>'` (com o prefixo `CFG_`), e a tabela é `CFGSIS`.
- A conta de banco usada tem `SELECT` global e escrita em `DIROPE`; só foram executadas leituras pontuais.
- A base consultada tem a `CFG_LOCFIS` igual à do cliente na empresa 001, mas não reproduz a importação; a prova do defeito
  está no código e na planilha.
- Edição dos `.pas` feita via Python em cp1252/CRLF; validado: decodifica sem erro, sem `\xef\xbf\xbd`, sem LF solto.
- Nenhum comentário no fonte exigiu "Nota N": os dois comentários curtos apenas citam o Req. 464821.

## 10. Ajustes pós-revisão

- `pValidaLocais`: se `fMontaCodigo` devolver vazio (nenhum campo informado na planilha consta na `CFG_LOCFIS`), a linha é marcada
  como inconsistente (`'C'`) com o motivo "Nenhum dos campos configurados em CFG_LOCFIS foi informado", sem chamar
  `fVerificaChavePrimaria`. Antes da alteração a montagem fixa sempre gerava ao menos um segmento.
- `TCamposCfgLocFis.Create`: `IndexText` retornando -1 (bloco desconhecido/malformado na config) não indexa mais `arrNomCam`; o bloco é
  ignorado. Evita range error/AV agora que o construtor também roda na importação.
- Aplicado nas três cópias (74.150.45, 74.150, 74.150.100); encoding e EOL conferidos.
- Validação do solicitante (seção 8) ocorreu antes destes dois ajustes; compilação e teste funcional deles ficam pendentes (planilha com campos fora da config → linha 'C'; config com bloco inválido → sem erro).

## 11. Tamanho dos campos na importação (ajustes pós-revisão)

Motivação: o `pCriaDataSet` tinha `CODLSE` fixo em 3 e `R_U_A_`/`PREDIO`/`ANDAR_`/`APARTA` fixos em 4, sem relação com o cadastro
manual. Consulta (leitura) na base de testes `2_30_74_150_COM`: `CADLOC` Rua/Prédio/Andar/Apto = `varchar(4)`, `LOC_CODLOC` = `varchar(30)`,
`LOC_CODLSE` e `CADLSE.LSE_CODIGO` = `varchar(6)`; `CFG_LOCFIS` da empresa 003 = Rua/Prédio/Andar/Apto todos `A1N` (tamanho 1, sem CODLSE).

- **CODLSE:** `Size := fTamCodLse` (antes 3). Com a coluna em 6, o valor padronizado por `fPadL(..., fTamCodLse, '0')` era cortado pelo dataset.
- **Rua/Prédio/Andar/Apto:** `Size` segue o tamanho da `CFG_LOCFIS`, como o cadastro manual (`pSetaCamposWms` → `MaxLength := intTamCam`).
  Novo método `TCamposCfgLocFis.fTamCampo(AstrNomCam, AintPadrao)` (`untCfgLocFis.pas`): devolve `intTamCam` do campo na config, ou o padrão
  quando o campo não consta nela ou o tamanho é inválido (<= 0). O padrão é 4, igual à coluna da `CADLOC`, que é o que o cadastro usa sem config.
  `pCriaDataSet` cria a lista, lê os quatro tamanhos, guarda os nomes configurados em `strCamposCfgLocFis` (campo privado do form) e a libera.

**Risco tratado:** com tamanho 1 (empresa 003), uma planilha com Rua `002` seria cortada em silêncio para `0`, gerando código errado ou duplicado.
No cadastro manual o usuário não consegue digitar além do `MaxLength`; na importação não havia essa barreira.

**Validação na leitura:** em `pInsereLocaisCDS`, a função local `RetornaTextoCelula` compara o tamanho do valor da planilha com o `Size` do
campo no dataset antes da atribuição. Se exceder, marca `strImport := 'C'` e acrescenta ao motivo:
` "Rua" excede o tamanho permitido [ORIGEM] (N): valor;`. A origem citada é `CFG_LOCFIS` (campo consta na config), `CADLOC` (campo fora da
config; limite = coluna) ou `CADLSE` (Local de Separação). Aplicada a `CODLSE`, `R_U_A_`, `PREDIO`, `ANDAR_` e `APARTA`. Linhas com `'C'` já são
puladas em `pValidaLocais`, então o motivo não é sobrescrito.

Observações: nenhuma alteração em `.dpr`/`.dproj`. Replicado em 74.150.45, 74.150 e 74.150.100 (encoding e EOL conferidos). Compilação e
teste funcional destes ajustes (e dos da seção 10) pendentes: planilha com valor acima do tamanho → linha `C` com a origem; empresa 003
com Rua de 1 caractere; CODLSE de 6 posições padronizado sem corte.

## 12. Validação do Local de Separação na importação (esclarecimento pós-revisão)

Dúvida levantada com a planilha de teste (CODLSE `004` nas linhas 1-2 e `000` nas linhas 3-4): por que a primeira linha
não acusou "Local de Separação não cadastrado".

- A coluna F da planilha é o CODLSE. Em `pValidaLocais`, o valor recebe zeros à esquerda até `fTamCodLse` (`fPadL`) e é
  pesquisado em `CADLSE.LSE_CODIGO` por `fExisteLocalSeparacao`. A checagem roda em todas as linhas, independe da
  `CFG_LOCFIS` e não foi alterada por este requisito.
- Consulta (somente leitura) na base de testes `2_30_74_150_COM`: `CADLSE.LSE_CODIGO` é `varchar(6)` com 8 registros
  (`000001` a `000008`). `004` vira `000004` (existe, sem crítica); `000` vira `000000` (não existe, crítica esperada).
  Conclusão: o comportamento da linha 1 está correto para aquela base; em outra base depende dos locais cadastrados.
- Preocupação de erro de insert com o preenchimento de zeros: não procede, pois `fTamCodLse` lê o tamanho da própria
  coluna `LSE_CODIGO` (`DESC CADLSE`, cache em `VS_intTamCadLse`), o dataset usa esse mesmo tamanho (`Size := fTamCodLse`)
  e `CADLOC.LOC_CODLSE` tem o mesmo tamanho (`varchar(6)` na base de testes). O cadastro manual (`pSetaCodLse`,
  `CompZeros := True`) grava no mesmo formato. Só haveria erro se `LOC_CODLSE` fosse menor que `LSE_CODIGO` em alguma base.
- Nenhuma alteração de código nesta seção.
