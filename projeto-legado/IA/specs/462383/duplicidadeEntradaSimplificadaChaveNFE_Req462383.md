# Análise de Requisito — Req. 462383

**Título:** Duplicidade de entrada de mercadoria na Entrada Simplificada (transferência entre lojas) após correção do Req. 449073
**Solicitante:** Marcos Bastos — Só Tintas RJ, Loja 002 (Mais Tintas), produção Cloud
**Data da análise/implementação:** 2026-09-16

## 1. Contexto de negócio

A tela de **Entrada de Mercadorias Simplificada** (transferência entre lojas), implementada na unit
`padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas` (form `TfrmRecTransfEstoque`), permite
confirmar a entrada, em uma loja de destino, de documentos de transferência originados em outra loja.

O Req. 449073 tratou o caso de notas fiscais já efetivadas (com entrada já confirmada) que permaneciam
disponíveis para nova confirmação nessa tela: antes da correção, tentar confirmar novamente resultava em
erro de chave duplicada em nível de banco. A correção substituiu esse erro por um fluxo de negócio:
verificar se já existe um documento com a mesma chave de acesso de NF-e e, em caso positivo, perguntar ao
usuário se deseja apenas **baixar o pedido de compra vinculado** (sem gerar nova entrada), em vez de deixar
o erro de banco interromper o processo.

Essa verificação depende da função global `fExisteNotaEntradaChaveNFE` (unit
`padra_atualizado/fontes/genericos/untFuncoesSimples.pas`), que consulta a tabela `CADFIS` (Livro Fiscal)
pela chave de acesso da NF-e (`FIS_ACESSO`) dentro da empresa atual (`FIS_CODEMP`).

## 2. Problema e causa raiz

### 2.1 Sintoma relatado

Após a atualização do Autcom em 15/09/2026 (Req. 449073), o erro de chave duplicada deixou de ser
apresentado — mas o sistema passou a permitir uma **nova entrada** para notas fiscais que já possuíam
entrada efetivada, em vez de exibir o prompt de baixa de pedido. Isso gerou duplicidade de entrada de
mercadoria e reserva indevida de saldo.

**Caso reproduzido (evidências em anexo, produção `SO_TINTAS_RJ_PROD_CLOUD_BR07`):**
- Nota fiscal `000000017097`, série `001`.
- Empresa de origem: `033` — Só Tintas Teresópolis Ltda (Macaé 2).
- Empresa de destino: `400` — Só Tintas RJ.
- Entrada original efetivada em `14/05/2026`, contendo os produtos `16011`, `18221` e `14476`.
- O documento permaneceu disponível na tela de Entrada de Mercadorias Simplificada e foi reconfirmado em
  `16/09/2026`, gerando novo `MOVGER`/`CADFIS` (mesma chave de acesso `FIS_ACESSO`) e nova reserva de saldo.
- Produto `18221`, quantidade `1,00`, apareceu pronto para endereçamento na rotina de Guardar Itens de
  Vendas e Devoluções, com localização de picking `03-07-00-203` sugerida pelo coletor.
- Consulta de estoque do produto `18221` confirmou o efeito colateral: saldo físico `1,00` no lote
  "A DEFINIR", saldo de endereçamento `1,00`, saldo disponível zerado.

### 2.2 Causa raiz

A função `fExisteNotaEntradaChaveNFE` já era chamada exatamente no ponto correto do fluxo — dentro de
`TfrmRecTransfEstoque`, no bloco que monta a mensagem "Já existe um documento com a chave da Nota
Eletrônica ... Deseja baixar pedido de transferência deste documento?" — mas a query dessa função filtrava
`FIS_TIP_FC = "F"` (fixo, só registros do Livro Fiscal marcados como Fornecedor).

A rotina de confirmação de transferência grava o `CADFIS` como `FIS_TIP_FC = 'C'` (Cliente) no fluxo de
devolução/transferência entre lojas (`IIF(Not FblnDevolu,'F','C')`, em `untRecTransfEstoque.pas`). Como a
checagem de duplicidade só reconhecia `'F'`, ela nunca encontrava o registro `'C'` já existente — a query
retornava vazio, a função retornava `False`, o prompt de "baixar pedido" nunca era exibido, e a confirmação
seguia adiante gravando uma nova entrada e reservando saldo novamente.

### 2.3 Validação empírica (dados reais, consulta somente-leitura ao banco de produção)

Consulta a `MOVGER` e `CADFIS` pelo documento `000000017097` confirmou três registros:

| Empresa | `FIS_ENTSAI` | `FIS_TIP_FC` | `FIS_FORCLI` | `FIS_DTAENT` | `FIS_ACESSO` |
|---|---|---|---|---|---|
| `033` (origem) | `S` (saída) | — | `10001214` | `2026-05-14` | `3326...9198` |
| `400` (destino) | `E` (entrada) | `C` | `10100986` | `2026-05-14` (original) | `3326...9198` |
| `400` (destino) | `E` (entrada) | `C` | `10100986` | `2026-09-16` (duplicado) | `3326...9198` |

Os dois registros de entrada (`400`/`E`) têm `FIS_TIP_FC = 'C'` — exatamente o valor que a query antiga não
reconhecia, confirmando a causa raiz.

## 3. Investigação realizada

1. Consulta somente-leitura ao banco de produção (`AUTCOM`, host `10.0.1.87:10701`, via script Python/pymysql
   do projeto) para reproduzir o cenário: `MOVGER` e `CADFIS` do documento `000000017097`.
2. Leitura de `untRecTransfEstoque.pas` (`fExisteDocumento`, `fChecaChaveAcesso`, `fVerificaDocumentoExiste`)
   para entender as validações de duplicidade existentes por `NUMDOC+ESPDOC+SÉRIE+CLIFOR` — todas
   vulneráveis a divergência de série (`"1"` vs `"001"`), hipótese inicial de causa raiz.
3. Localização do ponto exato do fluxo do Req. 449073 dentro de `untRecTransfEstoque.pas`: chamada a
   `fExisteNotaEntradaChaveNFE(strAcesso, strDocume)` seguida da mensagem "Deseja baixar pedido de
   transferência deste documento?".
4. Leitura da implementação real de `fExisteNotaEntradaChaveNFE` em `untFuncoesSimples.pas` (função global,
   distinta de um método homônimo em `untEntNfeXml.pas`, classe `TNFeXml`, que é implementação separada e
   usada em outro fluxo — import automático de XML — sem relação com este requisito).
5. Cruzamento do filtro `FIS_TIP_FC = "F"` da função com o valor real gravado (`'C'`) nos registros
   duplicados — confirmando a causa raiz definitiva (divergência de série, hipótese inicial, foi descartada
   como causa principal deste caso específico).
6. Levantamento de todos os chamadores da função global (`untEntradaAutomatizada.pas`,
   `untEntDadosFiscaisResumo.pas`, `untRecTransfEstoque.pas`) para dimensionar o impacto de qualquer mudança
   de comportamento na função compartilhada.

## 4. Abordagens consideradas e descartadas

- **Reforçar a validação por `NUMDOC+ESPDOC+SÉRIE+CLIFOR` (normalizando a série)** — descartada como foco
  principal depois que a causa raiz real (filtro `FIS_TIP_FC = "F"`) foi confirmada; normalização de série
  permanece como lacuna conhecida, mas não é a causa deste caso.
- **Extrair uma função global nova, compartilhada entre `untEntNfeXml.pas` e `untRecTransfEstoque.pas`** —
  descartada ao se confirmar que a função relevante (`untFuncoesSimples.fExisteNotaEntradaChaveNFE`) já era
  compartilhada e já estava corretamente posicionada no fluxo; o método homônimo em `untEntNfeXml.pas`
  (`TNFeXml.fExisteNotaEntradaChaveNFE`) é implementação totalmente separada, sem relação com o bug.
- **Remover o filtro `FIS_TIP_FC` incondicionalmente** — descartada em favor de parametrizar (booleano
  opcional com default preservando o comportamento atual), para não alterar o comportamento dos demais
  chamadores da função compartilhada.
- **Reforçar também o gate final de gravação (`fExisteDocumento`, dentro de `fGeraEntrada`)** — avaliado e
  descartado por decisão do usuário; o ajuste em `fExisteNotaEntradaChaveNFE` já cobre o cenário
  reproduzido, sem necessidade de segunda camada de defesa neste momento.

## 5. Solução aplicada

A função global `fExisteNotaEntradaChaveNFE` recebeu dois parâmetros booleanos opcionais, com default
reproduzindo exatamente o comportamento anterior:

- Um parâmetro que controla se a cláusula `AND FIS_TIP_FC = "F"` é adicionada ao `WHERE` (default `True` =
  comportamento antigo, só Fornecedor).
- Um parâmetro novo, `blnFiltraSomenteEntrada` (default `False`), que controla se a cláusula
  `AND FIS_ENTSAI = "E"` é adicionada ao `WHERE` — restringindo a busca a documentos de entrada.

Na chamada de `untRecTransfEstoque.pas`, os dois parâmetros passam a ser informados explicitamente (`False`
para o filtro de tipo, `True` para restringir a entrada), fazendo a verificação reconhecer os registros tipo
Cliente e, ao mesmo tempo, nunca casar com o registro de saída (`FIS_ENTSAI='S'`) da própria transferência
(que é gravado na empresa de origem, com a mesma chave de acesso).

### Arquivos alterados (mesmo diff, com uma divergência de nomenclatura entre cópias — ver seção 6)

| Working copy | Nome do 1º parâmetro (tipo Fornecedor/Cliente) | Status |
|---|---|---|
| `379.48.2.30.74.150.45` (origem da correção) | `blnFiltraFornecedor` | Alterado |
| `74.Fechadas/74.150.45.Fechadas/379.48.2.30.74.150.45.68` | `blnFiltraFornecedor` | Alterado |
| `379.48.2.30.74.150` | `blnFiltraTipFc` (já existente, mantido) | Alterado |
| `379.48.2.30.74.150.100` | `blnFiltraTipFc` (já existente, mantido) | Alterado |

Em todas: `padra_atualizado/fontes/genericos/untFuncoesSimples.pas` (declaração da função na interface, e
implementação) e `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas` (chamada dentro do
bloco de confirmação de transferência).

### Validação pós-implementação

Validado via `svn diff` em cada cópia, conferindo que apenas as linhas pretendidas foram alteradas.
Reprodução funcional em ambiente de homologação (reconfirmar a NF `000000017097` ou documento equivalente)
fica registrada como pendência em `tasks.md` (Fase 3), a ser executada antes do commit/gate DelphAI.

## 6. Decisões de escopo

**Incluído:** os dois parâmetros na função compartilhada `fExisteNotaEntradaChaveNFE` e o ajuste da chamada
em `untRecTransfEstoque.pas`, replicados nas quatro cópias de produção listadas.

**Excluído deliberadamente:**

- Reforço do gate final de gravação (`fExisteDocumento`/`fGeraEntrada`) como segunda camada de defesa —
  avaliado e descartado por decisão do usuário; ver seção 4.
- Alteração do método homônimo `TNFeXml.fExisteNotaEntradaChaveNFE` (`untEntNfeXml.pas`) — implementação
  separada, sem relação com este fluxo.
- Normalização de série (`"1"` vs `"001"`) nas demais validações do módulo (`fExisteDocumento`,
  `fVerificaDocumentoExiste`, `fChecaChaveAcesso`) — permanece como lacuna conhecida, fora do escopo desta
  correção pontual.
- Uniformização do nome do parâmetro (`blnFiltraFornecedor` vs `blnFiltraTipFc`) entre as quatro cópias —
  decisão explícita do usuário de manter o nome já integrado em `379.48.2.30.74.150` e
  `379.48.2.30.74.150.100` por outro requisito anterior, em vez de renomear um parâmetro já revisado/
  commitado por outro fluxo.

## 7. Achados colaterais (fora de escopo, registrados para não serem esquecidos)

1. **Cópias `379.48.2.30.74.150` e `379.48.2.30.74.150.100` já tinham uma correção parcial anterior**, de
   outro requisito não identificado nesta sessão: a função já havia ganhado o parâmetro `blnFiltraTipFc`
   (mesmo papel do parâmetro de tipo Fornecedor/Cliente), inclusive já usado com `False` em
   `untEntDadosFiscaisResumo.pas` (tela de digitação manual) — mas a chamada em `untRecTransfEstoque.pas`
   nunca havia sido atualizada para usar esse parâmetro, ou seja, o bug deste requisito (462383) permanecia
   presente mesmo com o mecanismo parcial já disponível. Vale investigar, se possível, qual requisito
   introduziu esse parâmetro parcial, para entender por que a chamada em `untRecTransfEstoque.pas` ficou de
   fora daquela correção.
2. **Validação por chave de acesso ainda depende de `FIS_ACESSO` estar preenchido** — se a nota ainda não
   tiver retornado da SEFAZ (chave de acesso vazia), a função retorna `False` imediatamente e a checagem não
   se aplica; esse comportamento já existia antes da correção e não foi alterado.
3. **Normalização de série não resolvida** — `fExisteDocumento`, `fVerificaDocumentoExiste` e
   `fChecaChaveAcesso` (todas em `untRecTransfEstoque.pas`) continuam comparando série por igualdade exata de
   string (`IFNULL(GER_SERIE_, "") = :SERIE_`), vulnerável a documentos com série gravada de formas
   diferentes (ex.: `"1"` vs `"001"`) — hipótese inicial de causa raiz deste chamado, descartada como causa
   principal mas ainda uma lacuna real do sistema.
4. **Alteração pré-existente não relacionada, sinalizada e depois replicada por pedido explícito do
   usuário (fora do escopo do Req. 462383):** durante o diff da cópia `379.48.2.30.74.150.45`, foi
   observada uma alteração já presente na working copy, em `TfrmRecTransfEstoque.fRetLivro` (linha ~5125):
   `If Not IsEmpty Then` → `If Not FieldByName('VLCONT').IsNull Then` — troca do teste de "conjunto de
   resultado vazio" para "campo `VLCONT` nulo", tratando corretamente o caso em que a consulta retorna
   linha mas com `VLCONT` (valor contábil) nulo. Essa alteração não tem relação com a causa raiz deste
   requisito (duplicidade por `FIS_TIP_FC`/`FIS_ENTSAI`). Inicialmente não foi tocada — apenas sinalizada
   ao usuário durante a implementação do Req. 462383. Em seguida, o usuário pediu explicitamente que a
   mesma alteração fosse replicada nas outras três cópias (`379.48.2.30.74.150.45.68`,
   `379.48.2.30.74.150`, `379.48.2.30.74.150.100`), o que foi feito à parte, no mesmo texto exato
   (localizado por conteúdo, não por número de linha fixo, e confirmado em cada cópia antes da edição).
   Por isso, o `svn diff` de `untRecTransfEstoque.pas` nas quatro cópias contém **dois hunks
   independentes**: um do `fRetLivro` (fora do escopo deste requisito) e outro da correção do Req. 462383
   (chamada a `fExisteNotaEntradaChaveNFE`) — não confundir os dois ao revisar ou ao escrever a mensagem
   de commit (a numeração `Req. 462383` do commit cobre apenas o segundo hunk; o ajuste do `fRetLivro` não
   tem requisito associado nesta sessão e deve ser mencionado à parte, se for o caso, na revisão/commit).

   **Importante para quem escrever a mensagem de commit ou revisar o diff:** a troca
   `Not IsEmpty` → `Not FieldByName('VLCONT').IsNull` **não é cosmética** — muda a semântica de
   `fRetLivro`. Antes, o `Else` (log "Registro do Livro Fiscal não encontrado" + `Result := False`) só era
   alcançado quando a consulta retornava zero linhas; depois, também passa a ser alcançado quando a consulta
   retorna uma linha, mas com `VLCONT` nulo (`SUM(...)` sobre um `CADFIS` sem os campos `FIS_VLCON*`
   preenchidos, por exemplo). Ou seja, `fRetLivro` pode agora retornar `False` em um caso que antes retornava
   `True` (com totais implicitamente zerados). Isso é uma correção comportamental real, deliberadamente
   replicada nas quatro cópias — a mensagem de commit não deve descrevê-la como "não tocada" ou como ruído;
   se for necessário registrar o motivo/contexto dessa troca especificamente, isso deve ser levantado à
   parte (fora deste `.md`, que documenta o Req. 462383), já que sua causa raiz e requisito de origem não
   foram investigados nesta sessão.

## 8. Ressalvas e lições

- **Arquivos `.pas` em encoding legado (cp1252/Latin-1), com corrupção pré-existente identificada:** durante
  a inspeção de `untFuncoesSimples.pas` (cópia `379.48.2.30.74.150.45`), uma tentativa de leitura com
  `encoding='cp1252'` falhou (`UnicodeDecodeError` no byte `0x81`) — o arquivo contém, em pelo menos um
  trecho (comentário de bloco por volta da linha 24962, "REPRESENTARÁ"), sequências UTF-8 (`\xc3\x81`)
  gravadas dentro de um arquivo que deveria ser cp1252/Latin-1 de ponta a ponta — corrupção antiga, não
  relacionada a esta sessão. Para não arriscar alterar esse trecho ou qualquer outro já corrompido, todas as
  edições desta correção foram feitas com round-trip `encoding='latin1'` (mapeamento 1:1 byte-a-byte, sem
  necessidade de decodificar corretamente cada caractere), fazendo substituição de texto exato apenas nos
  trechos ASCII (código Delphi, sem acentuação) alvo da correção — garantindo que nenhum outro byte do
  arquivo, incluindo os já corrompidos, fosse tocado. Cada gravação foi conferida via `svn diff`.
- **Função compartilhada por múltiplas rotinas — validar todos os chamadores antes de mudar o comportamento
  padrão:** qualquer alteração em `fExisteNotaEntradaChaveNFE` precisa considerar `untEntradaAutomatizada.pas`
  e `untEntDadosFiscaisResumo.pas`, além de `untRecTransfEstoque.pas` — por isso a solução usou parâmetros
  opcionais com default preservando o comportamento atual, em vez de alterar a query incondicionalmente.
- **Cuidado com nomes de função duplicados em units diferentes:** `fExisteNotaEntradaChaveNFE` existe tanto
  como função global (`untFuncoesSimples.pas`) quanto como método de `TNFeXml` (`untEntNfeXml.pas`), com
  implementações totalmente diferentes. Investigações futuras devem confirmar qual das duas está de fato em
  uso no ponto de interesse antes de propor qualquer alteração.
- **Working copies irmãs podem divergir por correções parciais de outros requisitos** — antes de replicar um
  diff "às cegas" em cópias irmãs, é necessário conferir se a cópia já não recebeu uma correção prévia
  relacionada (neste caso, `blnFiltraTipFc` em duas das quatro cópias), para não sobrescrever ou duplicar
  trabalho já integrado.

## 9. Complemento — cópia `379.48.2.30.74.150`: `FblnDevolu` não populado em `pAddListaQuery` e `CODCLI`/`strTipFC` fixos em `fRetChaveAcesso`

Durante a validação da correção do Req. 462383 nesta cópia, identificado um segundo problema latente no
mesmo fluxo de confirmação (`TfrmRecTransfEstoque.pAddListaQuery`), distinto do já corrigido em
`fExisteNotaEntradaChaveNFE` mas na mesma vizinhança de código.

### 9.1 Causa raiz adicional

`fChecaChaveAcesso` (chamada logo após o bloco do Req. 462383) já continha, desde antes desta sessão, uma
lógica para decidir entre `GER_CODCLI` e `GER_CODFOR` a partir de `FblnDevolu` (linhas ~1525-1529). Essa
mesma lógica também existe, de forma completa (populando `FblnDevolu` a partir de `TRecTransfEstoqueDevolucao`),
em `fGeraEntrada` (linhas ~2130-2151) — mas **nunca existia em `pAddListaQuery`**: `FblnDevolu` simplesmente
não era atribuído nessa procedure, permanecendo com o valor residual de uma execução anterior do form (ou
`False` por padrão), mesmo para documentos de devolução (`TIPSEN = 'DEVOLU'`). Como resultado, tanto
`fChecaChaveAcesso` quanto a chamada a `fRetChaveAcesso` logo abaixo (que usava `GER_CODCLI` fixo, sem
nenhuma regra de fallback) podiam operar com o código de cliente/fornecedor errado para documentos de
devolução.

Adicionalmente, a chamada a `fRetChaveAcesso` tem um 6º parâmetro opcional (`strTipFC`, default `'C'`) que a
função repassa como `FIS_TIP_FC` na consulta ao `CADFIS` (`untFuncoesGenerica.fGetChaveAcesso`, filtro
`FIS_FORCLI = :CODCLI AND FIS_TIP_FC = :TIP_FC`). Ao decidir passar `GER_CODFOR` (um código de fornecedor)
como `CODCLI` nos casos de `FblnDevolu`, o `strTipFC` também precisa virar `'F'` nesses casos — do contrário
a consulta buscaria `FIS_TIP_FC = 'C'` com um código de fornecedor, nunca encontrando o registro correto.

### 9.2 Solução aplicada

A implementação passou por três rodadas nesta sessão: (1) cópia mecânica do padrão de `fGeraEntrada` para
`pAddListaQuery`; (2) correções pontuais nessa cópia (9.2.1-9.2.4); (3) extração de tudo para um método
privado compartilhado (9.2.5), usado pelos dois pontos de invocação. Só o estado final é necessário para
entender o código hoje; o histórico fica registrado abaixo porque explica decisões (ex.: por que `FstrFatGor`
ficou de fora do método compartilhado).

**Estado final** — novo método privado `TfrmRecTransfEstoque.pPreparaFlagsDevolucao` (`untRecTransfEstoque.pas`):

1. Reset de `FblnDevolu`, `FstrEmpresaDevolucao`, `FstrEspecieDevolucao`, `FstrDocumentoDevolucao` e
   `FstrAutIncVenda` (ver 9.2.4) — **sem** `FstrFatGor` (ver 9.2.1).
2. `If SameText(cdsConsulta.FieldByName('TIPSEN').AsString, 'DEVOLU') Then` (ver 9.2.2), instanciando
   `TRecTransfEstoqueDevolucao.fNovo` e populando as flags via API fluente, liberando o objeto com
   `FreeAndNil` (ver 9.2.3), não `pFreeAndNil`.

Chamado por `pAddListaQuery` (antes de `fChecaChaveAcesso`) e por `fGeraEntrada` (que, na sequência, ainda
faz `FstrFatGor := '';` — único campo que permanece fora do método compartilhado). Em `pAddListaQuery`, além
disso: `strCodCli` calculado com a mesma regra de `fChecaChaveAcesso` (`GER_CODCLI` → fallback `GER_CODFOR`
se vazio → força `GER_CODFOR` se `FblnDevolu`) e usado no lugar do `GER_CODCLI` fixo na chamada a
`fRetChaveAcesso`, que também passa a informar o 6º parâmetro como `IIF(FblnDevolu, 'F', 'C')`.

#### 9.2.1 `FstrFatGor` removido do reset

A primeira versão desta correção copiou mecanicamente todo o reset de flags de `fGeraEntrada`, incluindo
`FstrFatGor := ''`. Revisão posterior constatou que `FstrFatGor` não é populado pela API fluente de
`TRecTransfEstoqueDevolucao` (que só cobre `FblnDevolu`, `FstrEmpresaDevolucao`, `FstrEspecieDevolucao`,
`FstrDocumentoDevolucao` e `FstrAutIncVenda`) nem é lido em nenhum ponto de `pAddListaQuery` — só é
relevante em `fGeraEntrada` (populado na linha ~4905, lido nas linhas ~10402-10407). Sem impacto funcional,
mas confundia a leitura; por isso, ao extrair o método compartilhado (9.2.5), `FstrFatGor` ficou de fora
dele e continua sendo resetado só em `fGeraEntrada`, logo após a chamada ao método.

#### 9.2.2 Comparação de `TIPSEN` tornada case-insensitive

A primeira versão usou `cdsConsulta.FieldByName('TIPSEN').AsString = 'DEVOLU'` (case-sensitive), copiando o
padrão de `fGeraEntrada` (pré-existente). Porém as demais comparações do mesmo tipo dentro do próprio
`pAddListaQuery` (`blnDevoluMarcada`, linhas ~9210 e ~9217) já usam
`SameText(FieldByName('TIPSEN').AsString, 'DEVOLU')`. Corrigido para `SameText`. Como o método foi depois
unificado (9.2.5), `fGeraEntrada` passou a usar `SameText` também — efeito colateral da unificação sobre
código pré-existente, não uma correção pedida para `fGeraEntrada` isoladamente.

#### 9.2.3 `pFreeAndNil` trocado por `FreeAndNil`

A primeira versão liberou `LObjRecTransfEstoqueDevolucao` com `pFreeAndNil` (mesmo padrão de `fGeraEntrada`,
pré-existente). `pFreeAndNil` (resolvido para `genericos/untFuncoesSimples.pas`, a unit no `uses` de
`untRecTransfEstoque.pas`) é uma rotina pensada para liberar formulários (`TForm`): dentro do `Try/Except`,
chama `pTrimAppMemorySize` e, se a aplicação não estiver finalizando, `pProcessMessages(True)` — que executa
`Application.ProcessMessages` incondicionalmente. O objeto não é `TForm`; bombear a fila de mensagens do
Windows dentro do `Finally` de um fluxo de negócio cria risco de reentrância (ex.: duplo clique disparando
execução concorrente), e exceções na destruição do objeto ficam só logadas em arquivo
(`pGravaLogErrArquivoLocal`), não sinalizadas ao fluxo. Corrigido para `FreeAndNil` nos dois pontos antes de
unificá-los (9.2.5).

#### 9.2.4 `FstrAutIncVenda` incluído no reset

`FstrAutIncVenda` só é populado dentro do bloco `SameText(TIPSEN, 'DEVOLU')`, via `.fAutoincrementoVenda`.
Sem reset explícito no início, um valor de uma execução anterior (outro documento, de devolução) permanece
no campo quando o documento atual não é devolução. Hoje isso não é um bug ativo: o único ponto que lê
`FstrAutIncVenda` (`untRecTransfEstoque.pas`, linha ~3058, dentro de `fCarregaClienteConsumidor`) já está
sob `If FblnDevolu Then`, e `FblnDevolu` é sempre resetado corretamente — mas depender dessa segunda guarda
para nunca expor o valor obsoleto é acoplamento implícito: um consumidor futuro de `FstrAutIncVenda` sem essa
mesma checagem falharia silenciosamente. Adicionado `FstrAutIncVenda := '';` ao reset, por defesa, sem
alterar comportamento observável atual.

#### 9.2.5 Extração para método privado compartilhado

As duas invocações (`fGeraEntrada` e, depois desta correção, `pAddListaQuery`) eram cópias literais uma da
outra — mesmo reset, mesmo bloco `TIPSEN`, mesma API fluente — divergindo apenas em `FstrFatGor` (exclusivo
de `fGeraEntrada`, ver 9.2.1). Extraído para `TfrmRecTransfEstoque.pPreparaFlagsDevolucao` (método privado,
declarado após `fChecaChaveAcesso`, implementado antes de `fGeraEntrada`), chamado pelos dois pontos. Motivo:
duas cópias da mesma preparação divergem silenciosamente em manutenções futuras — como já havia acontecido
aqui mesmo, com `pAddListaQuery` tendo ficado sem popular `FblnDevolu` (causa raiz original desta seção 9)
enquanto `fGeraEntrada` já fazia certo. Unificar remove essa classe de risco.

#### 9.2.6 `Try/Except raise;` removido de `fExecutar`

`TRecTransfEstoqueDevolucao.fExecutar` (`untRecTransfEstoqueDevolucao.pas`) envolvia todo o corpo do método
(montagem da query e leitura dos campos) num `Try ... Except raise; End;`, sem nenhum código entre `Except`
e `raise;`. Um `Except` que só re-eleva, sem logar, sem `Close`, sem limpar estado, é semanticamente idêntico
a não ter `Try/Except` — a exceção propaga para quem chama (`pPreparaFlagsDevolucao`) do mesmo jeito, só que
com um frame de exceção a mais na pilha. Removido; contrato inalterado (quem chama continua responsável por
tratar a exceção).

#### 9.2.7 `FstrFatGor` também resetado em `pAddListaQuery`

`pPreparaFlagsDevolucao` reseta `FblnDevolu`, `FstrEmpresaDevolucao`, `FstrEspecieDevolucao`,
`FstrDocumentoDevolucao` e `FstrAutIncVenda` (9.2.4), mas não `FstrFatGor` — continua fora do método
compartilhado porque não é uma flag de devolução (ver 9.2.1). Até este ajuste, `pAddListaQuery` nunca zerava
`FstrFatGor` isoladamente (nem antes desta correção, nem depois da extração do método compartilhado),
diferente de `fGeraEntrada`, que sempre fez `FstrFatGor := '';` logo após a preparação de devolução. Os
consumidores conhecidos de `FstrFatGor` (`untRecTransfEstoque.pas`, `fGravarDigCon` linha ~10530, e a
atribuição em `fGeraEntrada` linha ~4910) hoje ficam atrás de `fGeraEntrada`, então não havia bug
observável — mas um valor de um documento anterior podia ficar retido no campo entre uma chamada de
`pAddListaQuery` e a próxima, sem necessidade. Corrigido adicionando `FstrFatGor := '';` logo após a chamada
a `pPreparaFlagsDevolucao;` em `pAddListaQuery`, espelhando exatamente o que `fGeraEntrada` já fazia — sem
mover `FstrFatGor` para dentro do método compartilhado, para não misturar um campo que não é de devolução
com os que são.

### 9.3 Decisão de escopo

Incluído apenas em `pAddListaQuery`, por ser o ponto explicitamente apontado pelo usuário nesta sessão.

**Achado investigado e descartado (não é um bug):** `fGravaAgendamentoDeRecebimento` também chama
`fRetChaveAcesso` (linha ~2548) com `cdsConsulta.FieldByName('GER_CODCLI').AsString` fixo e sem informar o
6º parâmetro — à primeira vista, a mesma classe de problema do item 9.2. Porém essa função começa com
`If not fGeraAgendamento Then Exit(True);`, e `fGeraAgendamento` (linhas 2367-2371) já retorna `False`
quando `FblnDevolu` é `True`:

```pascal
Function TfrmRecTransfEstoque.fGeraAgendamento : Boolean;
Begin
  //FblnDevolu = True, a gravação vai ser com CODCLI, logo não existe plano de recebimento.
  Result := (blnUsaRotinaWms and fConferenciaDepoisDaEntradaLocal And (fCfgSis('TPLREC', varString) <> 'N') And (Not FblnDevolu));
End;
```

Ou seja, para documentos de devolução `fGravaAgendamentoDeRecebimento` sai em `Exit(True)` antes de chegar à
linha 2548 — o trecho com `GER_CODCLI` fixo é código morto para devolução e só executa no fluxo normal por
fornecedor, onde `GER_CODCLI` fixo e o default `strTipFC='C'` já são coerentes (não há devolução, logo não
há a inconsistência que motivou o RF06/RF07). Investigado e descartado nesta sessão; nenhuma correção
necessária neste ponto.

### 9.4 Validação

Cada alteração foi feita por substituição de texto exato via Python (round-trip `encoding='latin1'`,
preservando terminação `\r\n` do arquivo), conferida com `svn diff` mostrando apenas os hunks pretendidos,
sem impacto em nenhum outro trecho do arquivo.
