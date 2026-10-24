# Especificação — Req. 462383

**Título:** Duplicidade de entrada de mercadoria na Entrada Simplificada (transferência entre lojas) após correção do Req. 449073
**Objetivo:** impedir que uma nota fiscal já efetivada (entrada confirmada) volte a gerar uma nova entrada e reserva de saldo ao ser reconfirmada na tela de Entrada de Mercadorias Simplificada, mantendo o comportamento esperado do Req. 449073 (baixar o pedido de compra sem erro, sem duplicar a entrada).
**Zona:** Legado
**Data:** 2026-09-16

## 1. Contexto / problema atual

O Req. 449073 tratou notas fiscais já efetivadas que permaneciam na tela de Entrada de Mercadorias Simplificada: ao confirmar, o sistema apresentava erro de chave duplicada (nível de banco). A correção substituiu esse erro por uma mensagem de confirmação — "Deseja baixar o pedido de compra?" — implementada em `untRecTransfEstoque.pas`, na função responsável por confirmar a entrada de uma transferência entre lojas.

Essa mensagem depende da função global `fExisteNotaEntradaChaveNFE` (`untFuncoesSimples.pas`), que localiza no `CADFIS` um registro já existente para a mesma chave de acesso de NF-e. A query dessa função filtra `FIS_TIP_FC = "F"` (fixo, só registros tipo Fornecedor).

Ocorre que a rotina de confirmação de transferência (`untRecTransfEstoque.pas`) grava o CADFIS com `FIS_TIP_FC = 'C'` quando o fluxo é de devolução/transferência entre lojas (`IIF(Not FblnDevolu,'F','C')`). Como a checagem de duplicidade só enxerga `'F'`, ela nunca encontra o registro `'C'` já existente — a mensagem de "baixar pedido" não é exibida, e a confirmação segue para gravação de uma nova entrada.

### Caso reproduzido
- Nota fiscal `000000017097`, série `001`, empresa origem `033` (Só Tintas Teresópolis), empresa destino `400` (Só Tintas RJ).
- Entrada original efetivada em `14/05/2026` (CADFIS: `FIS_ENTSAI='E'`, `FIS_TIP_FC='C'`, `FIS_CODEMP=400`).
- Documento permaneceu disponível na tela de Entrada Simplificada e foi reconfirmado em `16/09/2026`, gerando novo `MOVGER`/`CADFIS` (mesma chave de acesso) e reserva de saldo (produto 18221, endereçamento 03-07-00-203, saldo físico 1,00 reservado, saldo disponível zerado).

## 2. Módulos e entidades envolvidos

- Módulo: movimentação de itens — Entrada de Mercadorias Simplificada (transferência entre lojas)
- Units:
  - `padra_atualizado/fontes/genericos/untFuncoesSimples.pas` — função global `fExisteNotaEntradaChaveNFE`
  - `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas` — chamador no fluxo de confirmação de transferência
- Tabelas: `CADFIS` (chave primária `AUTOINCREM`; campos relevantes: `FIS_ACESSO`, `FIS_CODEMP`, `FIS_TIP_FC`, `FIS_ENTSAI`, `FIS_NUMDOC`, `FIS_ESPDOC`, `FIS_SERIE_`)

## 3. Requisitos funcionais

- RF01 — A função `fExisteNotaEntradaChaveNFE` deve aceitar dois novos parâmetros booleanos opcionais: `blnFiltraFornecedor` (default `True`) e `blnFiltraSomenteEntrada` (default `False`), sem alterar o comportamento dos chamadores existentes que não os informam.
- RF02 — Quando `blnFiltraFornecedor = False`, a query não deve restringir por `FIS_TIP_FC`, permitindo localizar registros tipo Cliente (`'C'`) além de Fornecedor (`'F'`).
- RF03 — Quando `blnFiltraSomenteEntrada = True`, a query deve exigir `FIS_ENTSAI = 'E'`, evitando falso-positivo contra o registro de saída (`'S'`) da própria transferência (gravado na empresa de origem).
- RF04 — Em `untRecTransfEstoque.pas`, a chamada existente a `fExisteNotaEntradaChaveNFE` deve passar `blnFiltraFornecedor = False` e `blnFiltraSomenteEntrada = True`, para que o prompt "Deseja baixar pedido de transferência deste documento?" seja exibido corretamente quando já existir entrada efetivada (independente do `FIS_TIP_FC` gravado).

## 4. Regras de negócio

- RN01 — A checagem de duplicidade por chave de acesso é sempre restrita à empresa atual (`FIS_CODEMP = VS_strCodEmp`), preservando a distinção entre o lado de saída (empresa de origem) e o lado de entrada (empresa de destino) de uma mesma transferência.
- RN02 — Se a chave de acesso (`strChaNFE`) estiver vazia, a função retorna `False` imediatamente, sem alterar esse comportamento existente.
- RN03 — Os parâmetros novos são aditivos (via `AND`) à cláusula `WHERE` já existente (`FIS_ACESSO = :ACESSO AND FIS_CODEMP = :CODEMP`), nunca a substituem.

## 5. Requisitos técnicos / não-funcionais

- Sem alteração de assinatura obrigatória para os chamadores atuais (parâmetros novos como opcionais, com default que reproduz o comportamento de hoje).
- SQL parametrizado (`ParamByName`) — sem concatenação de valor de usuário.

## 6. Critérios de aceitação

- [ ] Reconfirmar a NF `000000017097` (série `001`) na tela de Entrada de Mercadorias Simplificada, empresa `400`, exibe o prompt "Deseja baixar pedido de transferência deste documento?" em vez de gerar nova entrada.
- [ ] Ao confirmar o prompt, o pedido de compra é baixado (`PCG_BAIXAD = 1`) sem novo registro em `MOVGER`/`CADFIS` nem nova reserva de saldo.
- [ ] Chamadores existentes de `fExisteNotaEntradaChaveNFE` (`untEntradaAutomatizada.pas`, `untEntDadosFiscaisResumo.pas`) mantêm o comportamento atual (sem regressão), pois usam os defaults.
- [ ] Uma nova NF-e (chave de acesso ainda não registrada) continua sendo confirmada normalmente, sem falso-positivo.

## 7. Fora de escopo

- Reforço do gate final de gravação (`fExisteDocumento`, dentro de `fGeraEntrada`) — avaliado nesta análise e descartado por ora; o ajuste em `fExisteNotaEntradaChaveNFE` já cobre o cenário reproduzido.
- Qualquer alteração em `TNFeXml.fExisteNotaEntradaChaveNFE` (método homônimo em `untEntNfeXml.pas`, usado no fluxo de importação automática de XML) — é uma implementação separada, sem relação com este requisito.
- Normalização de série (`"1"` vs `"001"`) nas demais validações do módulo — fora do escopo desta correção pontual.

## 8. Dependências e riscos

- Depende de que todo CADFIS gravado por `untRecTransfEstoque.pas` já contenha `FIS_ACESSO` preenchido (nota eletrônica com retorno da SEFAZ) — se a chave estiver vazia, a checagem não se aplica (RN02), mantendo a lacuna original para esse caso raro.
- Risco: outro chamador de `fExisteNotaEntradaChaveNFE` passar a depender implicitamente do filtro `FIS_TIP_FC = "F"` sem usar o parâmetro — mitigado por manter o default `True`.

## 9. Complemento — cópia `379.48.2.30.74.150` (`pAddListaQuery` — `FblnDevolu` não populado e `CODCLI` fixo em `fRetChaveAcesso`)

Durante a validação da correção nesta cópia, identificado um segundo ponto do mesmo fluxo (marcação/confirmação do documento em `TfrmRecTransfEstoque.pAddListaQuery`, não a gravação da entrada em `fGeraEntrada`) com o mesmo tipo de causa raiz: `FblnDevolu` — do qual depende a lógica de `CODCLI`/`CODFOR` já existente em `fChecaChaveAcesso` (linhas ~1525-1529) — nunca era populado dentro de `pAddListaQuery`, permanecendo sempre `False` mesmo para documentos de devolução (`TIPSEN = 'DEVOLU'`).

- **RF05** — Em `pAddListaQuery`, antes de chamar `fChecaChaveAcesso`, para documentos de devolução, popular `FblnDevolu`, `FstrEmpresaDevolucao`, `FstrEspecieDevolucao`, `FstrDocumentoDevolucao` e `FstrAutIncVenda` a partir de `TRecTransfEstoqueDevolucao` (unit nova `untRecTransfEstoqueDevolucao.pas`) — mesma preparação que já era feita, de forma independente, em `fGeraEntrada` (linhas ~2130-2151, fora do escopo original desta correção).
- **RF06** — A chamada a `fRetChaveAcesso` dentro de `pAddListaQuery` deve receber o código de cliente/fornecedor decidido pela mesma regra de `fChecaChaveAcesso` (`GER_CODCLI`, com fallback para `GER_CODFOR` se vazio, e força `GER_CODFOR` quando `FblnDevolu`), em vez do valor fixo `FieldByName('GER_CODCLI').AsString`.
- **RF07** — A mesma chamada a `fRetChaveAcesso` deve informar o 6º parâmetro (`strTipFC`, que a função repassa como `FIS_TIP_FC` na consulta ao `CADFIS`) como `'F'` quando `FblnDevolu`, mantendo o default `'C'` nos demais casos — para ficar consistente com o código passado em `strCodCli` (RF06): quando `FblnDevolu`, `strCodCli` contém `GER_CODFOR` (um código de fornecedor), então o tipo buscado no `CADFIS` também precisa ser `'F'`, não o default `'C'`.
- **RF08** — A liberação do objeto `TRecTransfEstoqueDevolucao` deve usar `FreeAndNil`, não `pFreeAndNil`. `pFreeAndNil` é uma rotina pensada para formulários (`TForm`): bombeia a fila de mensagens do Windows (`Application.ProcessMessages`, via `pProcessMessages(True)`) dentro do próprio `Finally` de um fluxo de negócio, criando risco de reentrância, e mascara exceções da destruição atrás de um log silencioso. O objeto não é `TForm`; usar `pFreeAndNil` nele — ainda que já fosse o padrão herdado de `fGeraEntrada` — não tem justificativa.
- **RF09** — A checagem de devolução deve usar `SameText(cdsConsulta.FieldByName('TIPSEN').AsString, 'DEVOLU')`, não `= 'DEVOLU'` (case-sensitive), para ficar consistente com as demais comparações do mesmo tipo já existentes em `pAddListaQuery` (`blnDevoluMarcada`, linhas ~9210 e ~9217).
- **RF10** — O reset de flags de devolução usado por `pAddListaQuery` não deve incluir `FstrFatGor := ''`: esse campo não é populado pela API fluente de `TRecTransfEstoqueDevolucao` (que só cobre `FblnDevolu`, `FstrEmpresaDevolucao`, `FstrEspecieDevolucao`, `FstrDocumentoDevolucao` e `FstrAutIncVenda`) nem é lido em `pAddListaQuery` — só é relevante em `fGeraEntrada` (populado na linha ~4905, lido nas linhas ~10402-10407).
- **RF11** — A preparação de flags de devolução (RF05, RF08, RF09, RF10) deve existir em **um único lugar**: método privado `TfrmRecTransfEstoque.pPreparaFlagsDevolucao`, chamado tanto por `pAddListaQuery` quanto por `fGeraEntrada`. As duas invocações eram cópias literais uma da outra (divergindo só em `FstrFatGor`, que só `fGeraEntrada` usa, e permanece exclusivo dele, fora do método compartilhado) — extrair evita que as duas voltem a divergir em manutenções futuras.
- **RF12** — O reset de flags no início de `pPreparaFlagsDevolucao` deve incluir `FstrAutIncVenda := ''`, junto com `FblnDevolu`/`FstrEmpresaDevolucao`/`FstrEspecieDevolucao`/`FstrDocumentoDevolucao`. `FstrAutIncVenda` só é populado pela API fluente dentro do `If SameText(TIPSEN, 'DEVOLU')` — sem reset, um valor de uma execução anterior (outro documento, devolução) permanece no campo quando o documento atual não é devolução. Hoje isso não causa bug porque o único ponto que lê `FstrAutIncVenda` (linha ~3058, dentro de `fCarregaClienteConsumidor`) já está sob `If FblnDevolu Then`, e `FblnDevolu` é sempre resetado corretamente — mas depender dessa segunda guarda para nunca expor o valor obsoleto é acoplamento implícito e frágil: um consumidor futuro de `FstrAutIncVenda` sem essa mesma checagem falharia silenciosamente. Resetado por defesa, sem alterar comportamento atual.
- **RF13** — `TRecTransfEstoqueDevolucao.fExecutar` (`untRecTransfEstoqueDevolucao.pas`) tinha um `Try ... Except raise; End;` envolvendo todo o corpo do método, sem nenhum código entre `Except` e `raise;`. Isso é semanticamente idêntico a não ter `Try/Except` nenhum (a exceção já propagaria da mesma forma) — só adiciona um frame de exceção na pilha. Removido o `Try/Except`, mantendo o mesmo contrato: quem chama continua responsável por tratar a exceção.
- **RF14** — `pAddListaQuery` deve resetar `FstrFatGor := ''` logo após chamar `pPreparaFlagsDevolucao`, espelhando o que `fGeraEntrada` já faz. `FstrFatGor` não é uma flag de devolução (RF10) e por isso fica fora do método compartilhado, mas `pAddListaQuery`, isoladamente, nunca zerava esse campo — um valor de um documento anterior podia ficar retido nele entre confirmações. Os consumidores conhecidos (`fGravarDigCon`, linha ~10530) hoje só são alcançados depois de `fGeraEntrada` já ter resetado o campo, então não havia bug observável, mas o reset elimina a lacuna por defesa.

**Efeito colateral da unificação (RF11) sobre `fGeraEntrada`:** como o método compartilhado usa `SameText` (RF09) e `FreeAndNil` (RF08), `fGeraEntrada` — que antes comparava `TIPSEN = 'DEVOLU'` (case-sensitive) e liberava o objeto com `pFreeAndNil` — passa a se comportar como `pAddListaQuery` nesses dois pontos. É uma mudança de comportamento real em código pré-existente, não coberta pelo pedido original do requisito, mas inevitável ao unificar; documentada aqui para não ser confundida com regressão.

**Arquivos alterados (adicional a esta cópia):**
- `untRecTransfEstoque.pas` — novo método privado `TfrmRecTransfEstoque.pPreparaFlagsDevolucao` (declarado logo após `fChecaChaveAcesso`, implementado logo antes de `fGeraEntrada`): contém a variável local `LObjRecTransfEstoqueDevolucao: TRecTransfEstoqueDevolucao`, o reset de `FblnDevolu`/`FstrEmpresaDevolucao`/`FstrEspecieDevolucao`/`FstrDocumentoDevolucao`/`FstrAutIncVenda` (RF10, RF12) e o bloco `If SameText(TIPSEN, 'DEVOLU')` (RF09) com `FreeAndNil` (RF08).
- `untRecTransfEstoque.pas` — `pAddListaQuery`: variável `strCodCli : String` declarada (a `LObjRecTransfEstoqueDevolucao` local foi removida, movida para o método compartilhado); `Begin` passa a chamar `pPreparaFlagsDevolucao;` no lugar do reset/bloco `TIPSEN` inline; `strCodCli` calculada com a regra `CODCLI`/`CODFOR`/`FblnDevolu` e usada como 3º parâmetro de `fRetChaveAcesso`; 6º parâmetro (`strTipFC`) da mesma chamada informado como `IIF(FblnDevolu, 'F', 'C')`.
- `untRecTransfEstoque.pas` — `fGeraEntrada`: a variável local `LObjRecTransfEstoqueDevolucao` e o bloco de reset/`TIPSEN` inline foram removidos; `Begin` passa a chamar `pPreparaFlagsDevolucao;` seguido de `FstrFatGor := '';` (já existia).
- `untRecTransfEstoque.pas` — `pAddListaQuery`: `Begin` passa a chamar `pPreparaFlagsDevolucao;` seguido de `FstrFatGor := '';` (RF14, novo — antes não existia aqui).
- `untRecTransfEstoqueDevolucao.pas` — `TRecTransfEstoqueDevolucao.fExecutar`: removido o `Try/Except raise; End;` sem efeito (RF13); corpo do método inalterado.

**Achado investigado e descartado (não é bug):** `fGravaAgendamentoDeRecebimento` (não `fGeraEntrada` — nome corrigido) também chama `fRetChaveAcesso` (linha ~2548) com `GER_CODCLI` fixo e sem o 6º parâmetro. Porém essa função começa com `If not fGeraAgendamento Then Exit(True);`, e `fGeraAgendamento` já retorna `False` quando `FblnDevolu` (comentário original no código: "FblnDevolu = True, a gravação vai ser com CODCLI, logo não existe plano de recebimento"). Para devolução a função sai antes de chegar à linha 2548 — código morto nesse caso, coerente no fluxo normal por fornecedor. Nenhuma correção necessária.
