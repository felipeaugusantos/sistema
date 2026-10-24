# Especificação — Req. 462247

**Título:** Parâmetros de Contabilização — bloquear troca de Tipo de Lançamento no "Alterar" e corrigir a gravação da LOGAJC na `qryParCon`
**Objetivo:** preservar a rastreabilidade do parâmetro contábil quando o usuário troca o Tipo de Lançamento, e fazer a auditoria (LOGAJC) voltar a registrar as alterações feitas em queries com JOIN.
**Zona:** `Contabilidade/` — classificada como Moderna no CLAUDE.md, mas a camada `View/` deste módulo é VCL legado com Hungarian style do início ao fim (ver seção 5).
**Data:** 20/09/2026
**Origem:** análise entregue pelo DelphAI (`problema_contabilidade.md`), verificada contra o código antes da implementação.

## 1. Contexto / problema atual

Dois defeitos independentes na tela **Parâmetros de Contabilização**, que se manifestam juntos na mesma operação de alteração.

### Defeito 1 — troca de tipo destrói a rastreabilidade

Em `TfrmParametrosContabilizacao.btnConfirmarClick`, quando o usuário carrega um parâmetro existente, troca o Tipo de Lançamento (ex.: `SAI` → `ENT`) e confirma, o sistema oferece o diálogo "Alterar / Incluir Novo / Cancelar". Escolhendo **Alterar** (`intAltera = 1`), o fluxo executa `qryParCon.Edit`, **reatribui o mesmo `CON_SEQPAR`** e sobrescreve `CON_TIPLAN` sem qualquer validação de que o tipo mudou.

O resultado é um registro cujo conjunto inteiro de dados foi substituído mantendo o código original: não existe mais nenhum vestígio do parâmetro anterior, e o `CON_SEQPAR` referenciado por lançamentos já contabilizados passa a apontar para uma regra diferente da que os gerou.

O caminho "Incluir Novo" (`intAltera = 2`) já faz o certo: gera `CON_SEQPAR` novo via `fAtualizaProCod` e roda `fValidaDuplicidade(True)`, `fValidaSAI_ENT` e `fValidaCPC`.

### Defeito 2 — LOGAJC não registra as alterações da `qryParCon`

`qryParCon` é criada por `fCriaQueryContabilidade('PARCON', ...)` — portanto é uma `TUniQueryAuditoria`, que deveria gravar LOGAJC automaticamente. Nenhum registro `ALT` aparecia.

A `qryParCon` é montada em `pCarregaParCon` sobre `SELECT PARCON.* ... LEFT JOIN PLANCO ... LEFT JOIN NATCFO ... LEFT JOIN HISPAD`, com colunas derivadas (`CLAFIS`, `DESCRE`, `DESDEB`, `HISCRE`, `STATUS`, `ORIGEM`, `NAT_DESCRI`).

Cadeia do defeito, verificada ponta a ponta:

1. `TUniQueryAuditoria.DoBeforePost` chamava `pCapturarSnapshot(True)` **durante** o Post — nesse instante os fields já carregam os valores NOVOS.
2. `fValorParaSnapshot` lia `ACampo.OldValue` sob `try/except`; em query com JOIN o `OldValue` não devolve o valor anterior e o `except` cai em `Lvalor := ACampo.Value`, ou seja, o valor NOVO.
3. Em `DoAfterPost` (ramo `dsEdit`), `LvalorAnt = LvalorAtu` para todos os campos → nenhum item entra na lista.
4. `TLogAjc.pGravarLote` sai no `if AItens.Count = 0 then Exit` (`Contabilidade.Classes.LogAjc.pas:184`) sem inserir nada.

O defeito é genérico da classe de auditoria: alcança qualquer form que use `fCriaQueryContabilidade` sobre query com JOIN ou coluna calculada.

### Defeito 3 — limites de truncamento divergentes em duas colunas

Encontrado ao auditar o caminho de gravação depois de corrigir o defeito 2. Duas colunas da LOGAJC tinham a regra de tamanho escrita em mais de um lugar, e em ambas as cópias já tinham divergido.

**`LOG_VALANT` / `LOG_VALATU`** — largura real no banco: **512**. A regra estava em quatro pontos, com dois valores:

| Onde | Valor |
|---|---|
| `TUniQueryAuditoria.fNormalizarValor` — recorta o snapshot e o valor atual antes de comparar | 512 |
| `TLogAjc.fLimitarTexto250` — recorta na gravação (usado em `VALANT` e `VALATU`) | 250 |
| `TGravacaoEmLote`, gravação em lote — `Copy(..., 1, 250)` inline, duas vezes | 250 |

**`LOG_INCDOC`** — largura real no banco: **128**. A regra estava em dois pontos, com dois valores:

| Onde | Valor |
|---|---|
| `TLogAjc.pAtribuirParametrosInsert` — constante `CTamMaxIncDoc` | 128 |
| `TGravacaoEmLote:1136` — `Copy(..., 1, 20)` inline | 20 |

O caso do `INCDOC` é mais grave que o do valor: 20 caracteres recortam a **chave** do registro auditado. Na gravação em lote, qualquer chave composta ou `AUTOINCREM` longo produzia linha de LOGAJC apontando para um identificador truncado — que não casa com registro nenhum na consulta. O defeito não alcança a tela de Parâmetros (que usa o gravador unitário), e sim os fluxos de geração contábil em lote.

Os dois modos de falha do truncamento de valor:

- alteração que ocorre **só depois do caractere 512** → a comparação não detecta → **nenhuma linha gravada**;
- alteração **entre 251 e 512** → linha gravada, mas `VALANT` e `VALATU` saem com os mesmos 250 primeiros caracteres → uma linha de LOGAJC que aparenta não registrar mudança nenhuma.

Nesta tela não é hipotético: `CON_CLAFIS` recebe `lstCfoSel.Items.CommaText`, a lista de CFOPs selecionados. Cada CFOP ocupa ~5 caracteres com a vírgula — por volta de 50 CFOPs passa de 250, por volta de 102 passa de 512.

O defeito só se torna alcançável **depois** da correção do defeito 2: enquanto a lista de diferenças saía sempre vazia, o truncamento assimétrico nunca era exercitado.

### Defeito 4 — sondagem da LOGAJC na conexão errada, sem cache, com negativa permanente

`FblnLogAjc := fTabelaExiste('LOGAJC')` era avaliado **no construtor** de `TUniQueryAuditoria`. Três problemas encadeados:

1. **Conexão errada.** `fCriaQueryContabilidade` só atribui `Result.Connection` **depois** do `Create`. No construtor a `Connection` ainda é `nil`, então `fTabelaExiste` caía em `fGetCurrentConnection` — a conexão corrente do sistema, que não é necessariamente a que vai gravar o log. O log é gravado em `TLogAjc.pGravarLote(..., Self.Connection)`: a pergunta "a LOGAJC existe?" precisa ser feita no mesmo banco onde a resposta vai ser usada.
2. **Sem cache.** Chamado sem `blnUsarCache`, era um `SELECT ... WHERE FALSE` por query criada. Só esta tela faz sete `fCriaQueryContabilidade`; o módulo inteiro faz vinte e seis.
3. **Negativa permanente e silenciosa** — o defeito relatado. `fTabelaExisteFat` tem `except Result := False`, então `False` é ambíguo: "não existe" ou "a sondagem falhou". Avaliado uma vez e guardado num campo, uma falha transitória na abertura da tela desligava a auditoria daquela query pelo resto da vida do form, sem mensagem.

O cache que o próprio `fTabelaExiste` oferece (`blnUsarCache := True`) **não** resolve: é chaveado só pelo nome da tabela, ignorando a conexão, e grava a negativa no dicionário mesmo quando ela veio do `except` — o que promoveria a falha transitória de "permanente para uma query" a "permanente para o processo inteiro".

Há ainda um problema de acoplamento acima de todos esses: **a Contabilidade é compilada como external** e `fTabelaExiste` mora no autcom (`untFuncoesSimples` → `TDBUtils` → `fTabelaExisteFat`, no Core de Faturamento). Mudança de comportamento dessa função entre versões do autcom atinge a auditoria contábil sem que nada na Contabilidade mude — e ela já colapsa qualquer falha em "não existe", que é a raiz do item 3. O módulo precisa da própria sonda.

**O mesmo defeito, pior, no gravador em lote.** `TGravacaoEmLote:109` fazia `fTabelaExiste('LOGAJC')` **sem conexão**, caindo na conexão UniDAC corrente — mas a classe grava a LOGAJC por **FireDAC**, em `FDDatabase`. Perguntava num banco e gravava em outro, além de sofrer os mesmos problemas 2 e 3. Como a `FDDatabase` já está conectada nesse ponto (`pConfiguraConexao` roda antes), a correção é apenas sondar a conexão certa — o que exige sobrecarga da sonda para `TFDConnection`.

### Defeito 5 — gravação atrasada: a query fica em `dsEdit` depois de uma falha

Levantado a partir de evidência de campo: um `CON_SEQPAR` cujos dados mudaram sem que `CON_DTAHRA` acompanhasse e sem nenhuma linha na LOGAJC — assinatura de gravação que não passou pelo `btnConfirmarClick`.

Em `btnConfirmarClick`, `qryParCon.Edit` (linha 832) ou `Append` (805) abre a edição, seguem ~100 linhas de atribuição, e o `Post` só vem na 936. **Não há nenhum `Exit` nesse trecho — só exceção escapa.** E nenhum dos dois handlers devolve o dataset ao estado de navegação:

| Handler | O que faz | Cancela a query? |
|---|---|---|
| `On E: EUniError` | `fRollBack` + `cxGridCitel1DBTableViewCitel1.DataController.Cancel` | **sim** — comprovado em bancada (CA15b): o `Cancel` do `DataController` alcança o dataset |
| `On E: Exception` | `fRollBack` + `pMensagensErro` | **não** — é por aqui que vaza |

Não existia um único `qryParCon.Cancel` no form.

**Consequência para o diagnóstico:** só escapa pelo handler genérico, e `EUniError` descende de `EDatabaseError`, logo é capturada antes. Ou seja, o vazamento exige uma exceção que **não** seja de banco — e os dois gatilhos do defeito 7 são exatamente isso: `EStringListError` do `Items[-1]` e `EConvertError` do `StrToDate`. Falha no próprio `Post` já estava coberta.

Sequência do defeito:

1. Exceção entre o `Edit` e o `Post`.
2. `fRollBack` desfaz a transação — **mas o buffer continua em `dsEdit`, com os valores novos**.
3. O usuário vê a mensagem de erro e fecha.
4. Qualquer navegação posterior na query — scroll na grade, `Locate`, `First`, `RecNo :=`, `Close` — dispara `CheckBrowseMode` e, com ele, um `Post` implícito.
5. Esse Post grava **fora da transação**, sem passar por nada do `btnConfirmarClick`, e **só com os campos atribuídos antes da falha**.

Como as atribuições são sequenciais, o conjunto de campos alterados identifica onde a exceção estourou. Ordem no caminho Alterar:

```
 1 SEQPAR   2 TIPLAN   3 DESVAL   4 FORPGO   5 CLAFIS   6 PAGAME   7 NATOPE
 8 NATCFO   9 MD5CLA  10 CODTRI  11 DTAHRA  12 CONCRE  13 CFCRED  14 PORCRE
15 PCCRED  16 PCDEBI  17 HISCRE  18 CONDEB  19 CFDEBI  20 PORDEB  21 CMPDEB
22 ORIGEM  23 PAGANT  24 BANDEB  25 BANCRE  26 ABFDEB  27 ABFCRE  28 TIPPCD
29 TIPPCC  30 TITPDD  31 VIGINI  32 VIGFIN
```
(em seguida: MarketPlace, OrigemCPC, GrupoProd, EmpresaLogada, e então o `Post`)

**Gatilhos possíveis dentro da janela crítica**, apurados um a um. A maioria dos `Items[ItemIndex]` já é exercitada **antes** do `Edit`, na montagem da `qryInsert` (linhas 696, 717, 718, 720, 721, 725), então não chega a sujar o dataset. Sobram:

| Linha | Gatilho | Guarda hoje |
|---|---|---|
| 878 | `edtCmpDebito.Items[edtCmpDebito.ItemIndex]` | **nenhuma** — e o controle fica oculto quando `cklComplemento` está em uso (`edtCmpDebito.Visible := not cklComplemento.Visible`) |
| 928 | `StrToDate(mskVigFin.Text)` | `fPreencheuVigenciaFinal`, que só testa **não-vazio**, não data válida — `31/__/2024` passa e estoura |
| 932-935 | `pSalvaMarketPlace` / `pSalvaOrigemCPC` / `pSalvaGrupoProd` / `pSalvaEmpresaLogada` | — |
| 936 | o próprio `Post` falhando (`EUniError`: chave duplicada, FK, tamanho) | **já coberto** — cai no handler `EUniError`, cujo `DataController.Cancel` cancela o dataset |

### Defeito 6 — escritas em PARCON fora da query auditada

**Regra estabelecida pelo solicitante: tudo que altera PARCON precisa ser auditado na LOGAJC.** Três caminhos do form violavam isso, todos com a mesma assinatura do defeito 5 — dado muda, `CON_DTAHRA` fica parado, LOGAJC vazia — e causa diferente.

| Rotina | Como gravava | Por que não auditava |
|---|---|---|
| `pAtualizaMd5` (`:3339`) | `fCriaQuery` + `Edit`/`Post` | `fCriaQuery` devolve `TUniQuery` comum, sem os hooks |
| `pAtualizaVigenciaNull` (`:3372`) | `fCriaQuery` + `UPDATE ... ExecSQL` | query comum **e** `ExecSQL`, que não dispara hook nenhum |
| `pDeletarParametro` (`:4343`) | query auditada + `DELETE ... ExecSQL` | os hooks são eventos de dataset; `ExecSQL` não os dispara |

Agravantes de cada um:

- **`pAtualizaMd5` roda no `FormCreate`** e varre `PARCON WHERE IFNULL(CON_MD5CLA,"") = ""`, gravando em todas as linhas que encontrar — toda vez que a tela abre. Atualização em massa, silenciosa.
- **`pAtualizaVigenciaNull` escreve num registro que não é o que o usuário editou** — fecha a vigência de um parâmetro vizinho encontrado por `fGetDatasetDuplicados`.
- **`pDeletarParametro` deixava a exclusão do pai sem log enquanto os filhos tinham:** `PARNCO` e `CMPPAR` já usavam `Open` + `Delete` e eram auditados; só o PARCON saía por `ExecSQL`.

### Defeito 7 — os dois gatilhos de exceção da janela crítica

Não causam gravação indevida por si (a rede do defeito 5 cobre isso), mas provocam a falha que a origina, com erro cru na tela.

- **`edtCmpDebito.Items[ItemIndex]` (`:878`)** — sem guarda. `pCarregarComboDeComplementos` faz `Items.Clear`, que zera o `ItemIndex` para -1, e nada o reposiciona até o usuário escolher ou um registro ser carregado. O combo também fica oculto quando o check list de complementos está em uso.
- **`StrToDate(mskVigFin.Text)` (`:928`)** — `fPreencheuVigenciaFinal` só testa **não-vazio**, não data válida: `31/__/2024` atravessa e estoura entre o `Edit` e o `Post`.

## 2. Módulos e entidades envolvidos

| Arquivo | Papel |
|---|---|
| `Contabilidade/View/Contabilidade.View.ParametrosContabilizacao.pas` | tela; `btnConfirmarClick`, `pCarregarDadosEmTela`, `pLimparTela`, `pCarregaParCon` |
| `Contabilidade/Classes/Contabilidade.Classes.UniQueryAuditoria.pas` | `TUniQueryAuditoria` — captura de snapshot e geração dos itens de LOGAJC |
| `Contabilidade/Classes/Contabilidade.Classes.LogAjc.pas` | `TLogAjc` — monta e grava o lote; dona da constante de largura de `VALANT`/`VALATU` |
| `Contabilidade/Classes/Contabilidade.Classes.TGravacaoEmLote.pas` | segundo gravador de LOGAJC (lote FireDAC) — tinha cópia própria do limite |
| `Contabilidade/Outros/Contabilidade.Funcoes.pas` | helper do módulo — passa a abrigar `TSondaTabela` e `fSondarTabelaContabil` |

Tabelas: `PARCON` (chave `CON_SEQPAR`), `LOGAJC`, `PARNCO`, `CMPPAR`.

## 3. Requisitos funcionais

- **RF01** — Ao confirmar com `intAltera = 1` (opção "Alterar") sobre um parâmetro carregado, se o Tipo de Lançamento em tela for diferente do tipo do registro carregado, a operação deve ser **bloqueada** com mensagem explicativa, sem gravar nada e sem abrir transação.
- **RF02** — A mensagem deve informar o tipo original e o tipo novo, e orientar o uso de "Incluir Novo".
- **RF03** — O caminho "Incluir Novo" (`intAltera = 2`) não sofre alteração: continua gerando `CON_SEQPAR` novo e rodando `fValidaDuplicidade` / `fValidaSAI_ENT` / `fValidaCPC`.
- **RF04** — Alteração que **não** troca o tipo continua funcionando normalmente.
- **RF05** — Alteração de registro via `TUniQueryAuditoria` deve gerar um registro `ALT` na LOGAJC por coluna efetivamente alterada, com `VALANT` correto.
- **RF06** — Inclusão (`Append`/`Insert`) continua gerando `INC`, e exclusão continua gerando `EXC`, sem alteração de comportamento.
- **RF07** — Valor gravado em `LOG_VALANT`/`LOG_VALATU` deve usar o mesmo limite de caracteres que a comparação do snapshot usa, e esse limite deve ser a largura real da coluna (512).
- **RF08** — `LOG_INCDOC` deve usar o mesmo limite nos dois gravadores da LOGAJC (unitário e em lote), igual à largura real da coluna (128).
- **RF09** — A verificação de existência da LOGAJC deve usar a **mesma conexão** que grava o log.
- **RF10** — O resultado da verificação deve ser cacheado, para não consultar o banco a cada query criada.
- **RF11** — Falha transitória na verificação não pode desligar a auditoria de forma permanente.
- **RF12** — A verificação não pode depender de `fTabelaExiste` do autcom. O módulo tem sonda própria, que distingue "existe", "não existe" e "a sondagem falhou".
- **RF13** — A sonda atende os dois DACs do módulo, por sobrecarga: `TUniConnection` (auditoria unitária) e `TFDConnection` (gravação em lote).
- **RF14** — O gravador em lote deve sondar a LOGAJC na `FDDatabase`, a mesma conexão em que grava.
- **RF15** — Ao sair do `btnConfirmarClick` por qualquer caminho, a `qryParCon` não pode ficar em `dsEdit`/`dsInsert`. Falha na gravação não pode deixar buffer pendente para ser gravado por uma navegação posterior.
- **RF16** — Toda escrita em PARCON feita por este form — inclusão, alteração e exclusão, inclusive as de efeito colateral — deve gerar registro na LOGAJC.
- **RF17** — Confirmar com data de vigência inválida deve exibir mensagem própria e não iniciar a gravação.
- **RF18** — Confirmar sem complemento de débito selecionado deve gravar complemento vazio, não falhar.

## 4. Regras de negócio

- **RN01** — O bloqueio exige as três condições simultâneas: `intAltera = 1` **e** `blnAltera` **e** tipo diferente do carregado. Qualquer uma ausente, o fluxo segue como antes.
- **RN02** — O tipo original é capturado em `pCarregarDadosEmTela`, no mesmo ponto em que `intRegAlt := qryParCon.RecNo` é capturado — os dois têm o mesmo tempo de vida e descrevem o mesmo registro. O código existente já repõe o cursor em `intRegAlt` antes das validações baseadas em `CON_SEQPAR` (`fValidaSAI_ENT`, `fValidaCPC`), o que confirma que ler `CON_TIPLAN` da query no momento da confirmação **não** seria confiável.
- **RN03** — O tipo original é zerado em `pLimparTela`. `blnAltera` nunca volta a `False` após um salvamento bem-sucedido; sem o reset, um parâmetro novo digitado logo após uma gravação compararia o tipo novo contra o tipo do registro **anterior**.
- **RN04** — A extração do tipo a partir do combo usa `LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3)`, replicando como o próprio código já extrai o tipo nos demais pontos do `btnConfirmarClick`.
- **RN05** — O snapshot de auditoria para `dsEdit` passa a ser tirado em `DoBeforeEdit`, com `Value` (ainda o valor original do banco). `OldValue` fica apenas como fallback, para o caso de o `Post` ocorrer sem `Edit` prévio.
- **RN06** — `Append`/`Insert` continuam caindo em `dsInsert` no `DoBeforePost` → `pLimparSnapshot`. `TDataSet.Edit` sobre dataset vazio vira `Insert` e **não** dispara `DoBeforeEdit`, então o caminho INC fica preservado.
- **RN07** — O limite de `VALANT`/`VALATU` é enunciado **uma vez**, na constante `CTamMaxValor` de `Contabilidade.Classes.LogAjc`, e referenciado nos três pontos que o aplicam. O limite de `INCDOC` idem, em `CTamMaxIncDoc`, nos dois pontos que o aplicam. Valor literal nesses pontos é proibido: foi exatamente a duplicação da regra que produziu as duas divergências.
- **RN08** — Se a largura de `LOG_VALANT`/`LOG_VALATU` ou de `LOG_INCDOC` mudar no banco, muda-se a constante correspondente e nada mais.
- **RN09** — A verificação da LOGAJC é resolvida **sob demanda**, na primeira vez que um evento de auditoria precisa dela, e não no construtor — é a única forma de ela enxergar a `Connection` definitiva.
- **RN10** — O cache é chaveado pela **identidade lógica do banco** (`Server` + `Port` + `Database`), não pelo endereço do objeto conexão: conexão liberada e endereço reaproveitado produziriam resposta de outro banco.
- **RN11** — Só resposta **conclusiva** entra no cache. `staExiste` e `staNaoExiste` são definitivas e ficam guardadas; `staFalhou` não é guardada e a auditoria fica **suspensa** naquela operação, voltando a tentar na seguinte. Guardar uma falha é o defeito original.
- **RN12** — A sonda usa `INFORMATION_SCHEMA.TABLES` com `TABLE_SCHEMA = DATABASE()`, e não um `SELECT` na tabela alvo: tabela ausente devolve conjunto vazio em vez de exceção, e assim sobra exceção só para falha de verdade. É o que permite separar os três estados sem depender de código de erro do servidor. Mesmo idioma que `fObterCamposChavePK` já usa na unit.
- **RN13** — O SQL da sonda é enunciado **uma vez**, em `CSQLSondaTabelaContabil`; as sobrecargas diferem só no DAC. Duplicar o SQL entre elas reconstruiria, em escala menor, a divergência do defeito 3.
- **RN14** — No gravador em lote, `staFalhou` no construtor não fixa a decisão: `pGravarLogAjc` sonda de novo antes da primeira gravação. Sem isso, uma falha transitória na criação do objeto faria o lote inteiro deixar de auditar em silêncio.
- **RN15** — O cancelamento vai no `finally`, não nos dois `except`. Só o `finally` cobre **todo** escape — os dois handlers atuais, um `Exit` que alguém acrescente amanhã, e uma exceção levantada de dentro do próprio handler. Repetir a regra nos dois `except` deixaria o terceiro caminho descoberto.
- **RN17** — Escrita em PARCON só por `fCriaQueryContabilidade` e só por `Edit`/`Append`/`Delete` + `Post`. `ExecSQL` é proibido para DML em PARCON: os hooks de auditoria são eventos de dataset e `ExecSQL` passa por baixo deles.
- **RN18** — A variável local continua declarada como `TUniQuery` mesmo recebendo `fCriaQueryContabilidade`, porque `pSetarFiltroEmpresa` recebe `var TUniQuery` e parâmetro `var` exige tipo exato. O objeto é `TUniQueryAuditoria` em tempo de execução e os métodos virtuais disparam normalmente — é o mesmo arranjo que a própria `qryParCon` já usava.
- **RN19** — O preenchimento de MD5 do `FormCreate` compartilha um único `SEQAJU` (`TLogAjcOpContext`), porque é uma operação só, não N operações independentes.
- **RN20** — Complemento de débito sem seleção grava string vazia, que é exatamente o primeiro item da lista (`''`) — não é default inventado.
- **RN16** — O cancelamento é condicionado a `State In [dsEdit, dsInsert]`. Após o caminho de sucesso a query está em browse, e após uma falha em `pCarregaParCon` pode estar em `dsInactive`; `Cancel` fora de edição levantaria exceção dentro do `finally`.

## 5. Requisitos técnicos / não-funcionais

- `Contabilidade.Classes.UniQueryAuditoria.pas` é ASCII puro — comentários novos escritos sem acento para manter o arquivo como estava.
- `Contabilidade.View.ParametrosContabilizacao.pas` é cp1252 sem BOM, CRLF — encoding conferido byte a byte antes e depois.
- Nenhum padrão bloqueado pelo pre-commit introduzido (varredura executada sobre as linhas novas).
- Nomenclatura: `strTipLanOriginal` segue o Hungarian do arquivo (`strSeqPar`, `strTipLan`). O CLAUDE.md classifica `Contabilidade/` como Zona Moderna, mas esta View é legado VCL integralmente; consistência com o arquivo pesa mais em manutenção.

## 6. Critérios de aceitação

- [ ] **CA01** — Editar um parâmetro **mantendo** o mesmo tipo e escolher "Alterar": grava normalmente e gera registros `ALT` na LOGAJC, um por coluna alterada, com `VALANT` trazendo o valor anterior correto.
- [ ] **CA02** — Editar um parâmetro **trocando** o tipo (`SAI` → `ENT`) e escolher "Alterar": exibe a mensagem de bloqueio, não grava, não abre transação, e a tela permanece preenchida para o usuário repetir a confirmação.
- [ ] **CA03** — Mesmo cenário do CA02 escolhendo "Incluir Novo": gera `CON_SEQPAR` novo, respeita `fValidaDuplicidade` / `fValidaSAI_ENT` / `fValidaCPC` e gera `INC` na LOGAJC.
- [ ] **CA04** — Conferência na LOGAJC: `SEQAJU` único por operação, `INCDOC` = `CON_SEQPAR`, `TIPAJU` correto, `VALANT`/`VALATU` coerentes por coluna.
- [ ] **CA05** — Exclusão de parâmetro continua gerando `EXC` com os valores anteriores (não regrediu).
- [ ] **CA06** — Regressão nos demais forms que usam `fCriaQueryContabilidade` sobre query de tabela única (`PLANCO`, `HISPAD`, `TPLACO`, `LANCON`): alteração continua gerando `ALT` com `VALANT` correto.
- [ ] **CA07** — Alterar `CON_CLAFIS` de um parâmetro com lista longa de CFOPs (acima de 250 caracteres, ~50 CFOPs): a linha de `ALT` grava `VALANT` e `VALATU` distintos, com o texto completo até 512 caracteres.
- [ ] **CA08** — Geração contábil em lote (`TGravacaoEmLote`): LOGAJC continua sendo gravada, agora com até 512 caracteres em `VALANT`/`VALATU` e até 128 em `INCDOC`, sem erro de tamanho de coluna. Conferir que o `INCDOC` das linhas geradas em lote casa com a chave do registro auditado — antes, chave acima de 20 caracteres saía truncada e não casava com nada.
- [ ] **CA09** — Base **com** LOGAJC: a auditoria funciona normalmente, e a sondagem `SELECT ... FROM LOGAJC WHERE FALSE` aparece **uma vez por banco**, não uma por query criada (conferir no log de SQL ou no profiler do MySQL).
- [ ] **CA10** — Base **sem** LOGAJC: o sistema continua operando, sem erro e sem gravar log; a sondagem ocorre uma vez por banco e o resultado negativo fica guardado.
- [ ] **CA11** — Recuperação de falha transitória: derrubar a conexão no momento da abertura da tela, restabelecer, e confirmar que a auditoria volta a gravar na operação seguinte — antes ficava desligada até fechar o form.
- [ ] **CA12** — Gravação contábil em lote com a `FDDatabase` apontando para banco diferente da conexão UniDAC corrente: a LOGAJC é gravada corretamente. Antes a sondagem consultava o banco errado.
- [ ] **CA13** — Falha transitória na criação do `TGravacaoEmLote`: a primeira gravação sonda de novo e a auditoria do lote funciona. Antes o lote inteiro ficava sem log.
- [x] **CA14** — Exceção forçada entre o `Edit` (850) e o `Post` (962): o `finally` roda, `State` = `dsEdit`, o `Cancel` executa e navegar na grade não grava nada. Antes, o scroll gravava. **Só dá para testar com um `raise` no fonte** — a crítica de vigência do defeito 7 fechou o gatilho natural. Remover o `raise` antes do commit.
- [x] **CA15** — Caminho `Append` (Incluir Novo): `State` = `dsInsert`, o `Cancel` executa e a navegação não cria registro novo.
- [ ] **CA15b** — Falha no próprio `Post` (chave duplicada), que entra pelo handler `EUniError` — o único que chama `DataController.Cancel`: idem.
- [ ] **CA16** — Caminho feliz não regrediu: gravar normalmente e conferir que o `Cancel` do `finally` não interfere (após o `Post` a query está em browse).
- [ ] **CA17** — Excluir um parâmetro: gera `EXC` na LOGAJC para **PARCON** (antes só PARNCO e CMPPAR apareciam), com os valores anteriores.
- [ ] **CA18** — Abrir a tela numa base com parâmetros de `CON_MD5CLA` vazio: o preenchimento gera `ALT` na LOGAJC, todos sob o **mesmo** `SEQAJU`.
- [ ] **CA19** — Gravar com vigência que feche a de um parâmetro vizinho: o vizinho recebe `ALT` na LOGAJC em `CON_VIGINI`/`CON_VIGFIN`, sob o mesmo `SEQAJU` da operação principal.
- [ ] **CA20** — Confirmar com `mskVigFin` = `31/__/2024`: mensagem "data final de vigência é inválida", sem erro cru e sem iniciar gravação. Idem para a inicial.
- [ ] **CA21** — Incluir um parâmetro sem escolher complemento de débito: grava com `CON_CMPDEB` vazio, sem erro. Antes levantava `List index out of bounds (-1)`.
- [ ] **CA17** — Compilação limpa de `padra_atualizado/autcom.groupproj` no Delphi Seattle. Atenção ao `TGravacaoEmLote` (unit nova na `uses`) e ao `Contabilidade.Funcoes` (FireDAC na `uses` de interface).

## 7. Fora de escopo

- Reescrever o diálogo de `btnConfirmarClick` para **não oferecer** "Alterar" quando o tipo mudou (suprimir a opção em vez de recusar depois). É a alternativa mais elegante em UX; foi deixada de fora por ser mudança de comportamento maior do que a correção pede.
- Colunas duplicadas no SELECT de `pCarregaParCon` (`CON_NATCFO` e `CON_MD5CLA` aparecem em `PARCON.*` e de novo explicitamente) — pré-existente, não afeta esta correção.
- Execução do gate DelphAI, `/citel-aprovaRequisito` e commit no SVN.

### Outros erros silenciosos levantados na mesma auditoria, **não** corrigidos aqui

Levantados ao investigar o defeito 3, todos anteriores a este requisito. Ficam registrados para virar requisito próprio.

1. **Os outros oito `fTabelaExiste` da Contabilidade.** Decisão explícita do solicitante: ficam para outro requisito. A sonda já existe e migrar é mecânico. São `FechamentoDiaMes` (`FECCDM`, 2×), `TControleContabilidade`, `TGerLanCon` (`CMPPAR`), `TGravacaoEmLote` (`LANDET` — vizinho de linha do que foi migrado), `TImportacaoDadosContabeisDprini` (`DPRDET`), `TLanConADT` (`BANNCO`), mais os `fCampoExiste` correlatos. Consequência a registrar: o construtor do `TGravacaoEmLote` fica com duas linhas vizinhas em estilos diferentes — `LANDET` pela função do autcom, `LOGAJC` pela sonda do módulo.
2. **`fTabelaExisteFat` continua engolindo exceção.** `padra_atualizado/fontes/Core/Faturamento.Connections.Functions.pas:168-170` tem `except Result := False`, e o cache interno dela grava a negativa mesmo quando veio do `except`. Qualquer chamador que use `blnUsarCache := True` está exposto a uma falha transitória virar negativa permanente para o processo. Corrigir na origem alcança o Faturamento inteiro — fora do alcance de um requisito da Contabilidade.
3. **`INCDOC` vazio.** `fObterChaveRegistro` faz `Exit('')` se `FindField` devolver `nil` para qualquer coluna da PK; as linhas são gravadas assim mesmo, órfãs. Não ocorre aqui (`PARCON.*` traz a PK), ocorre em query que selecione colunas específicas.
4. **Vazio vira NULL.** `VALANT`/`VALATU` iguais a `''` viram `Clear` → NULL; "campo apagado" e "campo que nunca teve valor" ficam indistinguíveis.
5. **Falha de auditoria derruba a gravação do dado.** Não há `try/except` em `DoAfterPost` nem em `pGravarLote`; a exceção propaga pelo `Post`, cai no `except` do `btnConfirmarClick`, faz `fRollBack` e abre diálogo. É visível — mas LOGAJC indisponível ou cheia impede cadastrar parâmetro.
6. **O caminho `INC` loga colunas que não existem na tabela auditada.** Confirmado em bancada (`SEQAJU 58B78AEE`, 21/09/2026): incluir um parâmetro gerou nove linhas de `INC` para `CLAFIS`, `DESCRE`, `DESDEB`, `HISCRE`, `STATUS`, `ORIGEM`, `NAT_DESCRI`, `CON_NATCFO_1` e `CON_MD5CLA_1` — as colunas derivadas do `SELECT` de `pCarregaParCon` e as duplicadas que a UniDAC renomeia com sufixo `_1` (`CON_NATCFO` e `CON_MD5CLA` aparecem duas vezes naquele SELECT). Todas com valor nulo: é ruído, não corrupção, e é pré-existente — o caminho `INC` nunca esteve quebrado. `DoAfterPost` percorre `Fields.Count` sem filtrar por pertencimento à tabela. O `ALT` sai limpo porque só loga coluna alterada, e o `EXC` saiu limpo porque `pDeletarParametro` passou a usar `SELECT * FROM PARCON`, de tabela única. Corrigir exige a classe de auditoria conhecer as colunas reais da tabela — `INFORMATION_SCHEMA` com cache, no molde de `fObterCamposChavePK` — e alcança todos os forms do módulo. **Decisão do solicitante: requisito próprio.**
7. **Os demais limites de coluna continuam duplicados** entre os dois gravadores da LOGAJC: `CODEMP` e `CODOPE` (3), `TABELA` (10), `TIPAJU` (3), `COLUNA` (30), `NOMFRM` (60), `SEQAJU` (36). Hoje as duas cópias **concordam** — por isso ficaram fora deste requisito —, mas é o mesmo arranjo que produziu as divergências de `VALANT`/`VALATU` e `INCDOC`. Extrair as sete para constantes ao lado de `CTamMaxValor` e `CTamMaxIncDoc` fecharia o assunto.
