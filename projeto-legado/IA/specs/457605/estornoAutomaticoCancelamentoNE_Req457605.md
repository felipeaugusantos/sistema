# Análise Técnica — Req. 457605

## 1. Contexto de negócio

O sistema permite cancelar uma Nota de Entrada (NE) de fornecedor pela tela **Fluxo de Processo de Compras**,
botão **[F6-Cancelar Entrada de Mercadoria]**. Quando o título financeiro (Contas a Pagar / CTP) gerado por
essa nota já foi baixado (pago), o cancelamento da nota exige que o CTP seja estornado antes — não é possível
simplesmente apagar a entrada de mercadoria deixando um pagamento "órfão" no financeiro.

A rotina de **Estorno de Contas a Pagar** (tela `TfrmEstornoPagar`, acessível pelo menu "Financeiro > Estorno
de Contas a Pagar" ou pelo botão "Estorno" dentro da Manutenção de Contas a Pagar) é a rotina oficial e
protegida para isso: exige o direito de acesso específico `frmEstornoCtaPagar`, aplica uma série de regras de
negócio (data de caixa, saldo, pagamento antecipado, lançamento contábil já processado, etc.) e grava
corretamente o lançamento reverso na movimentação bancária (MOVBAN).

## 2. Problema identificado

### 2.1 Sintoma relatado (cliente Ponto Final Revestimento, LJ001)

Um operador de estoque, **sem** o direito de acesso `frmEstornoCtaPagar`, conseguiu cancelar uma Nota de
Entrada cujo Contas a Pagar já estava baixado — sem a tela de Estorno de Contas a Pagar ser exibida e sem
nenhum aviso ou bloqueio. Caso reproduzido: NF de fornecedor 374522-NF-001, título baixado; operador código
004 (sem direito de estorno) cancelou a entrada normalmente; vídeo de reprodução do chamado confirma que a
tela de estorno nunca aparece durante o processo.

O histórico do título (tabela `LOGCTP`) registrou uma linha de estorno gravada automaticamente — com apenas
0:01 segundo de diferença entre o registro de "estorno" e o de "exclusão" da nota, evidenciando que o processo
ocorreu de forma automática e sequencial, sem intervenção humana — mas o lançamento correspondente **não foi
gravado na MOVBAN**. O portador bancário ficou com a baixa original registrada, mas sem o lançamento reverso,
gerando divergência de saldo. O setor financeiro precisou, como contorno manual, rebaixar o título em um
portador provisório (`99999`) até a correção ser aplicada.

### 2.2 Investigação e causa raiz

O ponto de entrada do cancelamento (`TProcessoEntradaMercadoria.pOnCancelar`, unit `untProcessoCompras.pas`)
já validava o direito genérico `frmCancelamentoDocumentos` antes de permitir o cancelamento — mas nunca
validava o direito específico `frmEstornoCtaPagar`, que é o que realmente autoriza estornar um contas a pagar.
Rastreando o fluxo de execução, identificou-se que o cancelamento de uma NE com CTP baixado, internamente,
aciona um "modo automático" de estorno (propriedade `blnEstornoAutomatico` da classe `TCancelaDocumentos`,
unit `untCancelaDocumentos.pas`) que **estorna o contas a pagar sem passar pela tela protegida** — ou seja,
sem checar o direito de acesso, sem aplicar as demais regras de negócio da rotina de estorno, e sem gravar o
lançamento reverso na MOVBAN (a gravação de MOVBAN, nesse caminho interno de estorno automático, só existe no
código do fluxo manual/interativo, nunca no automático).

Consultando o histórico de versionamento (SVN) do arquivo `untProcessoCompras.pas`, identificou-se a origem
exata dessa condição: até a revisão **r425895** (Req. 384736, autor `renan`, 25/06/2025), o cancelamento de NE
chamava a rotina padrão da tela de Cancelamento de Documentos, que abre a tela modal de confirmação e realiza
o cancelamento **sem** o modo automático de estorno ativado — ou seja, sempre exigindo o estorno manual e
protegido quando havia CTP baixado. O Req. 384736 tinha como objetivo desacoplar a rotina de cancelamento de
documentos da interface gráfica, para permitir que o serviço de Fulfillment (que roda em Linux, sem tela)
também pudesse cancelar documentos automaticamente. Ao implementar esse desacoplamento, o modo automático de
estorno foi ativado também para o cancelamento de Nota de Entrada feito pela tela desktop — um ponto que
continua sendo 100% interativo, com operador logado presente — sem que isso fosse uma decisão de negócio
deliberada para este fluxo específico. Um problema semelhante já havia sido relatado anteriormente (Req.
449101, citado no chamado atual), mas não foi localizado nenhum registro desse requisito no histórico de
versionamento das rotinas envolvidas.

## 3. Alteração realizada

Foi desativado o modo automático de estorno especificamente no cancelamento de Nota de Entrada feito pela tela
desktop (Fluxo de Processo de Compras), restaurando o comportamento que existia antes da alteração que
introduziu a falha. Confirmou-se que esse é o único ponto do sistema que aciona essa rotina de cancelamento de
NE, e que a mudança não interfere no cancelamento automático usado pelo serviço de Fulfillment (que utiliza
outra rotina).

## 4. Novo funcionamento

- Cancelar uma NE **sem** contas a pagar baixado: nenhuma mudança — continua sendo cancelada normalmente.
- Cancelar uma NE **com** contas a pagar baixado: o sistema passa a **bloquear** o cancelamento, informando que
  é necessário estornar o contas a pagar antes de prosseguir — independentemente de o operador ter ou não o
  direito de acesso ao estorno. Quem tiver o direito `frmEstornoCtaPagar` deve realizar o estorno pela rotina
  própria (tela de Estorno de Contas a Pagar) e, só então, cancelar a Nota de Entrada. Quem não tiver o
  direito não consegue mais concluir a operação sem passar por alguém autorizado.
- Uma vez estornado pela rotina correta, o lançamento reverso é gravado corretamente na movimentação bancária,
  eliminando a divergência de saldo relatada.

## 5. Impacto funcional

A alteração fecha uma brecha de controle de acesso (operadores sem permissão de estorno financeiro
conseguiam, indiretamente, estornar um contas a pagar apenas cancelando a nota de entrada relacionada) e uma
inconsistência contábil/bancária (estorno sem lançamento correspondente na movimentação bancária). O
cancelamento de Notas de Entrada com título já baixado volta a exigir duas etapas — estornar o contas a pagar
pela rotina correta e, em seguida, cancelar a nota — em vez de uma única etapa automática e desprotegida.

---

## Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit:** `padra_atualizado/fontes/movimentacaoitens/untProcessoCompras.pas`
**Função/Procedure:** `TProcessoEntradaMercadoria.pCancelaNotaEntrada`

O comentário no fonte, ao lado de `objCancelaDocumentos.blnEstornoAutomatico := False;`, existe para que uma
revisão futura não "corrija" essa linha de volta para `True` por parecer uma inconsistência ou uma trava
desnecessária, sem entender que se trata de uma reversão deliberada de uma regressão.

Explicação completa: até a revisão SVN r425895 (Req. 384736, autor `renan`, 25/06/2025), o cancelamento de
Nota de Entrada pelo botão F6 do Fluxo de Processo de Compras delegava para o método de classe
`TfrmCancelamentoDocumentos.pCancelaNotaEntrada` (então existente em `untCancelamentoDocumentos.pas`), que
abria a tela `TfrmCancelamentoDocumentos` de forma modal, com os campos travados e apenas o botão "Cancelar"
habilitado. O clique nesse botão cria `TCancelaDocumentos.Create(False)` sem nunca setar a propriedade
`blnEstornoAutomatico` — comportamento que continua sendo o padrão hoje em `untCancelamentoDocumentos.pas`,
linha 1383, para o fluxo normal de cancelamento interativo de qualquer documento.

Na revisão r425895, esse método de classe foi removido e substituído por uma nova procedure própria e
headless (`TProcessoEntradaMercadoria.pCancelaNotaEntrada`, diretamente em `untProcessoCompras.pas`), que
passou a setar `objCancelaDocumentos.blnEstornoAutomatico := True`. O objetivo declarado do Req. 384736 era
desacoplar `TCancelaDocumentos` de qualquer dependência de formulário, para viabilizar o cancelamento
automático de documentos pelo serviço Fulfillment (que roda em Linux, sem interface gráfica, e portanto
depende do modo `blnEstornoAutomatico := True` para funcionar sem intervenção humana). Só que essa mudança de
comportamento foi aplicada também a este ponto de entrada específico — que é inteiramente desktop/interativo
(botão F6 do Fluxo de Processo de Compras, sempre com um operador logado presente) — sem que isso fosse uma
decisão de negócio deliberada para este caso. Trata-se de um efeito colateral não intencional do refactor, e
não de uma escolha de arquitetura para este fluxo.

Com `blnEstornoAutomatico = True`, ao cancelar uma NE com Contas a Pagar baixado, `TCancelaDocumentos`
(`untCancelaDocumentos.pas`, linha ~2269) chama diretamente a procedure injetada `FPrcEstornoPagarAutomatico`
(`pEstornoPagarAutomatico`, em `untTEstornoPagar.pas`, linha 158), que por sua vez chama diretamente os
métodos "worker" `pEstornaDuplicataSimples`/`pEstornaDuplicataParcial` — sem passar pela tela
`TfrmEstornoPagar` nem pelo método de orquestração `TEstornoPagar.fEstornaDuplicataConjugadas`, que é onde
vivem a checagem de acesso `fVerificaAcessoSistema('frmEstornoCtaPagar')` (que hoje só existe como `Enabled`
de botão de UI em `untCadCtaPagar.pas`, nunca como validação de negócio), as demais regras de estorno, e a
gravação do lançamento reverso na MOVBAN (`pGravaMovBan`, chamada apenas dentro de
`fEstornaDuplicataConjugadas`, nunca dentro dos métodos "worker").

A correção reverte `blnEstornoAutomatico` para `False` neste único ponto de entrada, restaurando o
comportamento que já é comprovadamente usado hoje pelo fluxo padrão interativo de cancelamento de documentos
(`untCancelamentoDocumentos.pas:1383`). Com `blnEstornoAutomatico = False`, ao detectar Contas a Pagar
baixado vinculado à NE, `TCancelaDocumentos` segue para `pGeraResumo(ExceptionPrecisaEstornarCTP)`
(`untCancelaDocumentos.pas`, linha ~2290), que já apresenta a mensagem "Duplicatas que já foram baixadas e
portanto não será permitido cancelar o documento! Será necessário realizar o estorno para cancelar este
documento." e interrompe o cancelamento — comportamento pré-existente, reaproveitado sem necessidade de
código novo.

---

## Contexto Técnico (IA)

- ARQUIVO ALTERADO: `padra_atualizado/fontes/movimentacaoitens/untProcessoCompras.pas`
- FUNÇÃO/PROCEDURE: `TProcessoEntradaMercadoria.pCancelaNotaEntrada` (linha ~1135 antes da alteração)
- ALTERAÇÃO EXATA: `objCancelaDocumentos.blnEstornoAutomatico := True;` → `objCancelaDocumentos.blnEstornoAutomatico := False;`, precedida de comentário curto de 3 linhas referenciando "Nota 1 - Req. 457605"
- PROPRIEDADE: `blnEstornoAutomatico` é propriedade pública de `TCancelaDocumentos` (`untCancelaDocumentos.pas`), default `False` no construtor (`FEstornoAutomatico := False`, linha ~433) — a alteração apenas deixa de sobrescrever esse default neste call site específico
- NENHUMA OUTRA LINHA FOI ALTERADA: as injeções `objCancelaDocumentos.EstornoPagarAutomatico := pEstornoPagarAutomatico;` e `objCancelaDocumentos.GravaLogCtp := untLogCtp.GravaLogCtp;` permanecem no código, mas deixam de ser exercitadas (o branch que as usaria em `untCancelaDocumentos.pas:2269` é condicionado a `FEstornoAutomatico = True`)
- CADEIA DE CHAMADA CONFIRMADA (busca exaustiva no código-fonte, único caminho existente): `untFluxoCompras.pas:1861` (`objProcesso.objComum.pCancelar`, clique do botão F6) → `TProcessoComum.pCancelar` (`untProcessoCompras.pas:1751`, dispatcher genérico compartilhado por 4 "processos" do Fluxo de Compras) → `FComum.OnCancelar` wired em `TProcessoEntradaMercadoria.Create` (`untProcessoCompras.pas:1020`) para `Self.pOnCancelar` → `TProcessoEntradaMercadoria.pOnCancelar` (linha 1151, já valida `frmCancelamentoDocumentos`) → `pCancelaNotaEntrada` (linha 1163). `pCancelaNotaEntrada` não tem nenhuma outra chamada em todo o código-fonte — logo a correção é isolada e não afeta o serviço Fulfillment/Linux nem qualquer outro fluxo.
- EVIDÊNCIA DA REGRESSÃO: `svn diff -c 425895` no arquivo mostrou que o método `class procedure TfrmCancelamentoDocumentos.pCancelaNotaEntrada` (em `untCancelamentoDocumentos.pas`) foi removido nessa revisão e substituído pela nova `TProcessoEntradaMercadoria.pCancelaNotaEntrada`, que introduziu `blnEstornoAutomatico := True`. O commit da revisão 425895 (Req. 384736) documenta como objetivo desacoplar `TCancelaDocumentos` de UI para uso pelo serviço `Faturamento.Services.API`/Fulfillment (Linux) — não há qualquer menção a mudar o comportamento do cancelamento de NE feito pela tela desktop.
- CONFIRMAÇÃO DE QUE `False` É O COMPORTAMENTO PADRÃO ATUAL: `untCancelamentoDocumentos.pas:1383`, dentro do handler padrão de cancelamento da tela `TfrmCancelamentoDocumentos`, cria `TCancelaDocumentos.Create(False)` sem setar `blnEstornoAutomatico` em nenhum ponto subsequente — único uso de `blnEstornoAutomatico := True` nesse arquivo está em três cenários específicos e não relacionados (Fator/factoring, Consignado, Abastecimento), linhas 1231/1834/1896, que não foram tocados.
- COMPORTAMENTO RESULTANTE COM CTP BAIXADO: `TCancelaDocumentos.fCancelarDocumentos` (`untCancelaDocumentos.pas`), no branch que trata `strEspSel = 'NE'` (linha ~2245-2296), avalia `fVaiGerarResumoCtp`; com `FEstornoAutomatico = False`, o branch condicional `(fVaiGerarResumoCtp) And (FEstornoAutomatico)` (linha ~2269) não é mais satisfeito, então `FPrcEstornoPagarAutomatico` nunca é chamada; o fluxo cai direto em `If fVaiGerarResumoCtp Then pGeraResumo(...)` (linha ~2287-2294), e como há duplicata em `lstCtpCFrBaixa`, `pGeraResumo(ExceptionPrecisaEstornarCTP)` é chamado, apresentando ao usuário a mensagem de bloqueio já existente no sistema (função `pGeraResumo`, linha ~10296) e interrompendo o cancelamento via `Exit`.
- ESCOPO EXPLICITAMENTE EXCLUÍDO (decisão registrada em `spec.md` deste requisito, seção 7): o mesmo padrão de bypass existe no lado de Contas a Receber (propriedade `frmEstornoReceber.blnEstornoAutomatico` / procedure injetada `FPrcEstornoReceberAutomatico`, ambas em `untCancelaDocumentos.pas`) e em ~26 outros pontos de chamada de `blnEstornoAutomatico := True` espalhados por `faturamento/`, `movimentacaoitens/` e `util/Fulfillment/` (locação de equipamentos, importação de NF-e, confirmação de orçamentos, etc.) — nenhum desses outros pontos foi alterado; ficam registrados como risco conhecido para requisito futuro, não como pendência deste.
- ABORDAGEM ALTERNATIVA CONSIDERADA E DESCARTADA: cogitou-se inicialmente adicionar checagens de acesso (`fVerificaAcessoSistema('frmEstornoCtaPagar')`) tanto em `pOnCancelar`/`pCancelaNotaEntrada` quanto centralizadamente em `untCancelaDocumentos.pas`, além de replicar a chamada de `pGravaMovBan` dentro do fluxo automático (`pEstornoPagarAutomatico`, `untTEstornoPagar.pas`) para corrigir a ausência de gravação em MOVBAN. Essa abordagem foi descartada em favor da reversão simples porque: (a) exigiria duplicar lógica de negócio já existente e testada (risco de divergência futura entre os dois caminhos); (b) a reprodução fiel da gravação de MOVBAN exigiria replicar a determinação de `blnEstDtaDoc` (que depende dos direitos granulares `DTAOEP`/`DTESTP`) e a ordem exata de operações (gravar MOVBAN antes de zerar os campos da duplicata nos métodos "worker", sob risco de gravar valores já nulados); (c) a reversão restaura um caminho de código já comprovadamente correto e em uso, reduzindo a superfície de teste e o risco de regressão.
- INVESTIGAÇÃO DO REQ. 449101 (citado no relato do cliente como ocorrência anterior semelhante): buscado em `svn log` completo (147-183 revisões, todo o histórico disponível, não apenas desde a criação desta cópia) dos arquivos `untTEstornoPagar.pas`, `untCancelaDocumentos.pas` e `untProcessoCompras.pas` na cópia `379.48.2.30.74.150.100` — nenhuma menção encontrada. Não foi possível confirmar se esse requisito teve correção de código, e se teve, ela não está presente nesta linha de cópia/branch.
- APLICAÇÃO EM CÓPIA IRMÃ: a mesma alteração (idêntica, byte a byte) foi aplicada também em `C:\Users\danilo.stefaneli\Documents\AUTPAS\379.48.2.30.74.150` (sem o sufixo `.100`) — confirmado que ambas as cópias estavam na mesma revisão-base SVN (r491291) e que o contexto ao redor da linha alterada era idêntico antes da aplicação (mesmo número de linha, mesmo conteúdo). `svn diff` em ambas as cópias resulta no mesmo diff.
- ENCODING: arquivo Delphi legado, Windows-1252/Latin-1, CRLF. Edição feita via Python (`io.open` com `encoding='cp1252'`, `newline=''`) em ambas as cópias, nunca pela ferramenta de edição de texto genérica, para evitar risco de resave acidental em UTF-8. Validado após a edição: decodificação sem erro em cp1252, ausência da sequência de bytes `\xef\xbf\xbd` (indicador de corrupção UTF-8/mojibake) no arquivo, e `svn diff` mostrando exatamente as 4 linhas pretendidas em cada cópia.
- TESTES: não há suíte automatizada (DUnit) aplicável a este fluxo. Estratégia de validação definida em `plan.md`/`tasks.md` deste requisito é manual, cobrindo: NE sem CTP baixado (regressão zero), NE com CTP baixado sem direito de acesso (bloqueio), NE com CTP baixado com direito de acesso (bloqueio + estorno manual + cancelamento em duas etapas), conferência de LOGCTP/MOVBAN após o estorno manual via `citel-conectarBanco`, e reprodução do cenário original do chamado (NF 374522-NF-001 ou equivalente).
