# Análise de Requisito — Req. 462019

**Título:** Divergência de espécie de documento na importação de NF de uso e consumo (modelos 62/66/75)
**Data:** 15/09/2026
**Área:** Movimentação de Itens > Importação de Nota Fiscal de Uso e Consumo

## 1. Contexto de negócio

A rotina de "Importação de Nota Fiscal de Uso e Consumo" (`TEntImpConsumo`, unit `untEntImpConsumo.pas`)
permite importar arquivos XML de notas fiscais eletrônicas de consumo (água, energia elétrica e
telecomunicações) recebidas de concessionárias/operadoras, e a partir delas gerar automaticamente o
lançamento fiscal (`CADFIS`) e o movimento de estoque/financeiro (`MOVGER`/`MOVDET`/`MOVTRI`).

Historicamente essa rotina só tratava um tipo de documento fiscal genérico (espécie `'NF'`). Em
03/09/2026, o Req. 458421 (revisão SVN 492989 nesta cópia) estendeu a rotina para reconhecer três
novos modelos de documento fiscal eletrônico específicos de concessionárias:

- **Modelo 62 — NFCom** (Nota Fiscal de Telecomunicações)
- **Modelo 66 — NF3e** (Nota Fiscal de Energia Elétrica)
- **Modelo 75 — NFAg** (Nota Fiscal de Água/Esgoto — documento novo da Reforma Tributária)

Para isso, o Req. 458421 passou a classificar o documento, durante a leitura do XML, em uma "espécie
de documento" própria por modelo: `'CO'` (comunicação) para modelo 62, `'EL'` (energia) para modelo 66
e `'AG'` (água) para modelo 75 — em analogia à espécie `'CT'`, já usada no sistema para conhecimentos de
transporte (CT-e).

## 2. O problema (Req. 462019)

O ticket Zendesk #1672711 (cliente Miguel e Torso Comércio de Tintas) reportou que uma NF de uso e
consumo modelo 75 (NFAg, concessionária DAE Jundiaí — água e esgoto) não era importada. O XML de
simulação fornecido foi `xmlDfe-35260903582243000173750010001466551008598968.xml`.

### 2.1 Causa raiz

A extensão feita pelo Req. 458421 ficou incompleta: a espécie de documento calculada durante a leitura
do XML (`'CO'`/`'EL'`/`'AG'`/`'NF'`, gravada no campo `ESPECIE_DOCUMENTO` do dataset de importação) não
era a mesma espécie gravada no cadastro fiscal (`CADFIS.FIS_ESPDOC`) na etapa seguinte:

- `TEntImpConsumo.fCarregarArquivosDiretorio` calculava a espécie corretamente por modelo.
- `TEntImpConsumo.pGravarCadFis` (chamada logo depois, em `fConfirmarImportacaoConsumo`) gravava
  `CADFIS.FIS_ESPDOC` com o literal fixo `'NF'`, **ignorando** o valor calculado.
- `TEntImpConsumo.pCriaMovGerMovDet` (chamada na sequência) usa a espécie calculada (não o que foi
  gravado) para localizar, via `SELECT`, o `CADFIS` recém-criado e a partir dele gerar `MOVGER`/
  `MOVDET`/`MOVTRI` (lógica em `untXMLConsumoItem.pas`, chave de busca `FIS_NUMDOC` + `FIS_ESPDOC` +
  `FIS_CODEMP` + `FIS_FORCLI` + `FIS_SERIE_`).

Como o `CADFIS.FIS_ESPDOC` gravado (`'NF'`) nunca batia com a espécie buscada (`'EL'`/`'AG'` para os
modelos 66/75), o `INSERT ... SELECT` que gera o movimento executava com sucesso porém **sem
encontrar nenhuma linha** — o CADFIS era criado, mas o movimento de estoque/financeiro correspondente
nunca era gerado, sem nenhuma exceção ou mensagem de erro visível ao usuário. Foi exatamente esse o
cenário relatado: a nota "não importa", sem indicação clara do motivo.

Adicionalmente, para o modelo 62 a espécie `'CO'` era atribuída de forma incondicional, mesmo quando o
CFOP do item não correspondia a uma operação de comunicação — sem nenhuma validação equivalente à já
existente em `TfrmCadLivroFiscal.fValidaClaFisCT` (tela de cadastro do livro fiscal), que só permite a
espécie `'CO'` quando o CFOP está dentro da faixa de comunicação (constante `CFOP_COMUNICACAO`,
`genericos\untConstantes.pas`).

### 2.2 Investigação — origem da regra em outras cópias

Via `svn log`/`svn diff` do Req. 458421, identificou-se que a revisão 492990 (autor caio.barbosa,
mesmo dia) — commitada na working copy `379.48.2.30.74.150.100` — já corrigia exatamente esse ponto
(`pGravarCadFis` gravando a espécie dinâmica em vez do literal `'NF'`) e adicionava, em
`untCadLivroFiscal.pas`, um tratamento especial para a espécie `'AG'` na exclusão de CADFIS.

Ao comparar com as demais cópias de working copy do sistema, verificou-se que:

- Na cópia `72.352_AMARELINHA` (onde o ticket foi aberto), o combinado de revisões 492989+492990 foi
  aplicado como um único commit (r492989 local), mas **sem** a correção do `pGravarCadFis` — ou seja,
  essa cópia especificamente tinha o bug.
- Nas outras 5 cópias (`379.48.2.30.72`, `74.111`, `74.150`, `74.150.45`, `74.150.100`),
  `pGravarCadFis` **já** gravava a espécie dinâmica corretamente (equivalente à correção de r492990) —
  ou seja, o defeito de divergência CADFIS × MOVGER já não existia nelas. O que faltava, em todas, era
  a regra de negócio: `'CO'` sem validação de CFOP, e as espécies `'EL'`/`'AG'` sem nenhuma utilidade
  real no restante do sistema (ver seção 3).

## 3. Decisão de escopo — por que remover `'EL'`/`'AG'` em vez de dar suporte completo a elas

Foi avaliado, e descartado, dar suporte completo às espécies `'EL'` (energia) e `'AG'` (água) como
categorias fiscais próprias (equivalente ao que já existe para `'CT'`, transporte). Motivo: essas
siglas não têm nenhuma regra de negócio validada em nenhum outro ponto do sistema — ao contrário de
`'CO'` (que é exigida pela validação de CFOP de comunicação em `fValidaClaFisCT`) ou `'CT'` (usada em
todo o módulo de conhecimento de transporte). A única referência a `'AG'` fora da própria importação
era um tratamento especial isolado em `untCadLivroFiscal.pas` (exclusão de CADFIS), introduzido pelo
mesmo Req. 458421 sem uma regra de negócio mais ampla por trás.

Como a importação de modelo 75 **sempre falhava** (pelo bug da seção 2.1) até esta correção, confirmou-se
com o solicitante que não existe, em nenhuma base de produção, documento gravado com `CADFIS.FIS_ESPDOC
= 'AG'` — tornando segura a remoção do tratamento especial em `untCadLivroFiscal.pas` sem risco de
afetar dados históricos.

Decisão final: os modelos 66 (NF3e) e 75 (NFAg) passam a ser classificados como nota fiscal padrão
(`'NF'`) — mesma espécie de qualquer NF de uso e consumo sem uma regra fiscal diferenciada — enquanto o
modelo 62 (NFCom) mantém a espécie `'CO'`, mas agora condicionada à mesma validação de CFOP de
comunicação usada no restante do sistema.

## 4. Solução aplicada

### 4.1 `untEntImpConsumo.pas` — `TEntImpConsumo.fCarregarArquivosDiretorio`

O cálculo do CFOP do item (função `fCFOPConsumo`) foi antecipado para ocorrer antes da definição da
espécie de documento (antes ele ocorria depois). A definição da espécie passou a ser:

- **Modelo 62:** espécie `'CO'` somente se o CFOP do item estiver contido na faixa de CFOP de
  comunicação (constante `CFOP_COMUNICACAO`); caso contrário, `'NF'`.
- **Modelos 66 e 75:** removidos da classificação especial — passam a cair no mesmo tratamento padrão
  (`'NF'`), igual a qualquer outro modelo não mapeado.
- **Demais modelos:** inalterado, `'NF'`.

### 4.2 `untEntImpConsumo.pas` — `TEntImpConsumo.pGravarCadFis` (somente na cópia `72.352_AMARELINHA`)

A gravação de `CADFIS.FIS_ESPDOC` passou a usar a mesma espécie apurada na leitura do XML, em vez do
literal fixo `'NF'` — eliminando a divergência que causava a falha silenciosa descrita na seção 2.1.
Nas outras 5 cópias esse ponto já estava correto (ver seção 2.2) e não foi alterado.

### 4.3 `untCadLivroFiscal.pas` — exclusão de CADFIS

Revertido, nas 6 cópias, o tratamento especial que isentava documentos de espécie `'AG'` da checagem
padrão de "não permitir excluir notas com produtos vinculados" e que os equiparava a nota de serviço
para fins de exclusão do movimento associado. Sem esse tratamento, um CADFIS gerado por essa
importação (agora sempre espécie `'NF'`) segue a mesma regra de exclusão de qualquer outra nota fiscal
padrão do sistema.

### 4.4 Cópias impactadas

A correção foi aplicada nas 6 working copies do sistema que possuem essa rotina:

| Working copy | `pGravarCadFis` já usava espécie dinâmica? | Alteração aplicada |
|---|---|---|
| `72.352_AMARELINHA` | Não (bug) | Itens 4.1, 4.2 e 4.3 |
| `379.48.2.30.72` | Sim | Itens 4.1 e 4.3 |
| `379.48.2.30.74.111` | Sim | Itens 4.1 e 4.3 |
| `379.48.2.30.74.150` | Sim | Itens 4.1 e 4.3 |
| `379.48.2.30.74.150.45` | Sim | Itens 4.1 e 4.3 |
| `379.48.2.30.74.150.100` | Sim (origem da correção original, r492990) | Itens 4.1 e 4.3 |

Particularidade técnica: em `379.48.2.30.74.150.100`, a função `fCFOPConsumo` tem assinatura própria
(sem parâmetro, sem ler `LobjXML.Product(0).CFOP` — calcula o CFOP apenas a partir do modelo do
documento e do tipo de empresa). O patch foi adaptado a essa variante, preservando o mesmo resultado
funcional (CFOP calculado antes da definição da espécie).

## 5. Abordagens consideradas e descartadas

- **Dar suporte pleno às espécies `'EL'`/`'AG'`** (nova categoria fiscal, como `'CT'`): descartado por
  falta de regra de negócio que as sustente em qualquer outro ponto do sistema (ver seção 3).
- **Manter `'CO'` incondicional para modelo 62**: descartado porque cria o mesmo tipo de risco de
  divergência que causou o bug original — nada garante que o CFOP do item realmente corresponda a uma
  operação de comunicação; a validação de CFOP alinha o comportamento com a regra já usada em
  `TfrmCadLivroFiscal.fValidaClaFisCT`.
- **Corrigir apenas `pGravarCadFis` sem tocar no `case` de modelo**: descartado porque não resolveria a
  causa de fundo — as espécies `'EL'`/`'AG'` continuariam sendo gravadas de forma consistente entre
  CADFIS e MOVGER, mas sem nenhuma regra de negócio no restante do sistema que as valide ou utilize
  (ver seção 3), criando uma categoria fiscal "fantasma".

## 6. Achados colaterais (não corrigidos nesta sessão)

- Nenhum achado colateral relevante identificado fora do escopo desta correção.

## 7. Ressalvas / lições de processo

- Ao investigar uma revisão SVN referenciada pelo usuário, ela pode ter sido commitada em uma working
  copy diferente da que está sendo analisada — sempre confirmar com `svn log` na cópia local antes de
  assumir que o código já reflete aquela revisão.
- Arquivos `.pas` desta base usam encoding `cp1252`/Latin-1; todas as edições desta sessão foram feitas
  via Python (`io.open(..., encoding='cp1252', newline='')`), nunca via ferramenta de edição de texto
  genérica, para não corromper caracteres acentuados do restante do arquivo.
- Dois dos seis arquivos (`379.48.2.30.74.150` e `379.48.2.30.74.150.45`) tinham quebras de linha
  mistas (CRLF/LF) pré-existentes exatamente na região do `case` de modelo, não relacionadas a esta
  alteração; o patch foi escrito de forma tolerante a isso (regex aceitando `\r?\n`) para não introduzir
  nem "corrigir" ruído de EOL fora do escopo deste requisito.

## Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit:** `padra_atualizado/fontes/movimentacaoitens/untEntImpConsumo.pas`
**Função/Procedure:** `TEntImpConsumo.fCarregarArquivosDiretorio` (bloco `case LobjXML.Modelo of`)

Explicação completa: a espécie de documento (`ESPECIE_DOCUMENTO`) calculada aqui é usada, mais adiante
em `pCriaMovGerMovDet`/`untXMLConsumoItem.pas`, para localizar via `SELECT` o registro de `CADFIS` que
acabou de ser gravado por `pGravarCadFis`, e a partir dele gerar `MOVGER`/`MOVDET`/`MOVTRI`. Antes desta
correção, `pGravarCadFis` gravava `CADFIS.FIS_ESPDOC` sempre como `'NF'` fixo, enquanto essa espécie
podia ser `'CO'`/`'EL'`/`'AG'` — o `SELECT` não encontrava o CADFIS e o movimento simplesmente não era
criado, sem nenhuma exceção (falha silenciosa). Por isso a espécie `'CO'` só pode ser atribuída quando o
CFOP realmente corresponde a uma operação de comunicação (mesma faixa `CFOP_COMUNICACAO` usada em
`TfrmCadLivroFiscal.fValidaClaFisCT`) — atribuir `'CO'` sem essa checagem reproduziria o mesmo tipo de
inconsistência que causou o bug original, mesmo com `pGravarCadFis` já corrigido, porque nada mais no
sistema validaria se aquele CFOP realmente é de comunicação. Pelo mesmo motivo, os modelos 66 (NF3e) e
75 (NFAg) não recebem mais uma espécie própria (`'EL'`/`'AG'`): essas siglas nunca tiveram nenhuma regra
de negócio validada em outro ponto do sistema (diferente de `'CO'` e `'CT'`), e mantê-las apenas como
resultado de um `case` sem uso posterior criaria uma categoria fiscal sem sustentação, com o mesmo risco
de alguém assumir (incorretamente) que existe uma regra por trás dela. Se uma revisão futura "limpar"
essa checagem de CFOP achando-a redundante com o `case` de modelo, ou reintroduzir `'EL'`/`'AG'` sem
antes garantir que exista uma regra de negócio consistente as validando em todo o sistema, o bug
original (falha silenciosa na geração de MOVGER/MOVDET) pode se repetir, ainda que de forma diferente.
