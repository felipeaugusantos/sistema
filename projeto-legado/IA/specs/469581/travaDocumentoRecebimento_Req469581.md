# Req. 469581 — NF duplicada em dois agendamentos / trava por NF no Recebimento de Entrega Agendada

Registro de memória completo da investigação e da implementação. Complementa `spec.md`, `plan.md` e `tasks.md` desta pasta.

## 1. Contexto de negócio

- **Agendamento de Recebimento de Mercadorias** (`untCadAgendamentodeEntrega`, tabelas AGEREC e AGEDOC): o operador agenda a chegada de
  um caminhão e vincula a ele uma ou mais NFs de entrada. AGEREC é o cabeçalho do agendamento (`ARC_CODIGO`, transportadora, placa,
  data/hora, `ARC_STATUS`). AGEDOC são os documentos vinculados (`ADC_NUMDOC`, `ADC_ESPDOC`, `ADC_SERIE_`, `ADC_CODFOR`, `ADC_CODEMP`,
  `ADC_ACESSO` = chave de acesso, `ADC_SEQGER` = `AUTOINCREM` do AGEREC).
- Valores de `ARC_STATUS` relevantes: `AG` = agendado (aguardando chegada); `EC` = recebimento confirmado/entrada do caminhão efetuada;
  `EP` = já em processamento (visto em dados reais após o plano de recebimento).
- **Recebimento de Entrega Agendada** (`untRecebimentoEntregaAgendada`): na chegada do caminhão o operador carrega o agendamento,
  confere as NFs e confirma. A confirmação atualiza AGEREC (placa, motorista, status `EC`, `ARC_IDEDIG`), grava `GER_IDEDIG` em GERELE
  e, se `PLAAUT = 'S'`, dispara a confirmação automática do plano de recebimento.
- **Fluxo de Processo de Compras** (`untFluxoCompras` / `untProcessoCompras`): painel que lista as NFs de compra com o andamento de cada
  etapa (agendamento, recebimento, entrada...). A coluna "Agendamento" mostra `REALIZAR`/`REALIZADO` calculada no momento em que o grid
  é carregado (JOIN AGEREC/AGEDOC). Clicar em "Realizar" abre o form da etapa com a NF já preenchida.
- **Tabela de travas** `LCKATC` (chave `LCK_CHAACE` varchar(150), `LCK_CON_ID` varchar(10)): `fLock_Unlock(chave, True)` faz INSERT; a
  chave duplicada é a recusa da trava. `fLock_Unlock(chave, False)` faz DELETE restrito ao `LCK_CON_ID` da conexão. O nome é gravado com o
  prefixo do schema (`<database>.<chave>`).

## 2. O problema observado

A NF 000000080187 (série 3, fornecedor 00005593, espécie NF, empresa 003) ficou em dois agendamentos em 2026-10-09:

| Agendamento | Entrada | Operador / conexão | AGEDOC.AUTOINCREM | Gravação (LOGREP) | Transportadora |
|---|---|---|---|---|---|
| 311563 | menu "Agendamento de Recebimento de Mercadorias" | 687 / 19366 | ...13032003 | 08:53:25 | 00041, placa GOF-8646 |
| 311562 | Fluxo de Processo de Compras | 641 / 19959 | ...13033003 | 08:55:19 | 00040, placa UGF-7894 (depois) |

Evidências (consultas somente leitura em AUTCOM):

- `LOGREP_ARQUIV_20261010` filtrado por data/operador/conexão/transação: três linhas por transação (`INSERT AGEREC`, `DELETE FROM
  AGEDOC WHERE ADC_SEQGER = ...`, `INSERT AGEDOC`) — exatamente o `btnGravarClick` do form de agendamento.
- `MNUACE` (acessos a menu): o operador 641 abriu "Fluxo de Processo de Compras" às 08:34:43 e não fechou; o 687 abriu "Plano de
  Recebimento" (08:52:02), "Agendamento de Recebimento de Mercadorias" (08:52:26–08:53:26), "Recebimento de Entrega Agendada" etc.
- Estado atual: AGEDOC com duas linhas para a mesma NF; AGEREC 311562 `EP`, 311563 `AG`; CADTRA 00040 e 00041 existem.
- Os `LOG_CODIGO` não refletem a ordem real de gravação (641 recebeu códigos menores que 687, embora tenha gravado depois); a ordem
  correta vem de `LOG_HRACAD` e do `AUTOINCREM` do AGEDOC, que concordam entre si.

## 3. Causa raiz (o que se sabe e o que não se sabe)

Sabido:

1. O grid do fluxo é uma foto do banco no momento da carga. A tela do 641 estava aberta desde 08:34, antes do agendamento do 687 (08:53),
   então a NF ainda aparecia como `REALIZAR`.
2. `TProcessoAgendamento.pOnRealizar` (untProcessoCompras) só valida direito de acesso e abre o form de agendamento com
   `strAutIncExterno`; não trava nem reconsulta. O form, em `FormShow`, chama `pAdicionaDocFluxoCompra` → `fAdicionaDocumento`, o mesmo
   caminho do menu; o retorno de `fAdicionaDocumento` é ignorado.
3. Não existe índice único em AGEDOC. Só existe `IDX_AGEDOC_05` (índice comum nas mesmas cinco colunas), que o `untFluxoCompras`
   verifica por nome e usa com `FORCE INDEX`.
4. A única trava existente (`frmRecebimentoEntregaAgendada_<emp>_<ARC_CODIGO>`) é por agendamento. Dois agendamentos com a mesma NF
   têm chaves diferentes e podem ser recebidos em paralelo — a NF poderia ser recebida duas vezes.
5. O fluxo e o form de agendamento não geram nenhuma trava ao carregar a NF. `TfrmPaiCad.pDestravarRegistros` é um método vazio a ser
   implementado pelo filho, e o filho não o implementa.

Não explicado:

- O form de agendamento tem checagem de NF já agendada em dois pontos: ao incluir a NF (`fAdicionaDocumento` →
  `fVerificaDocumentoOutosAgendamentos`) e ao gravar (`fVerificaDocumentos`). Pelo fonte atual, a segunda gravação (08:55:19, com a
  primeira já confirmada às 08:53:25) deveria ter sido barrada. Hipóteses não confirmadas: executável de versão diferente na estação do
  641, ou caminho de código não mapeado. Não foi possível verificar a versão do executável a partir do banco.

## 4. Jornada de investigação e abordagens descartadas

- Hipótese "corrida entre checagem e INSERT": descartada como causa principal, pois as gravações foram separadas por ~2 minutos.
  (Chegou-se a afirmar o contrário a partir dos `LOG_CODIGO`, depois revisto; ver seção 2.)
- Hipótese "o `INNER JOIN CADTRA` da checagem derrubaria o resultado": descartada — as duas transportadoras existem em CADTRA.
- Hipótese "UK precisa derrubar o `IDX_AGEDOC_05`": descartada — o `untFluxoCompras` o usa por nome e com `FORCE INDEX`; a UK entra
  com outro nome (`UK_AGEDOC_01`).
- Trava por NF no form de agendamento (em `fAdicionaDocumento`): proposta inicialmente, **substituída** por decisão do usuário pela trava
  no Recebimento, na carga do agendamento. Motivos do usuário: o ponto comum ao fluxo e ao menu é a carga do documento; a trava deve
  nascer ao carregar o documento, antes de qualquer gravação.
- Exclusão de documento do grid como ponto de liberação: avaliada e descartada para o Recebimento — o grid é somente leitura
  (`OptionsData.Deleting = False`, sem `OnKeyDown/OnKeyUp`). A remoção por tecla Delete existe só no form de agendamento
  (`cxgDocumentosTableViewKeyUp` → `pRemoverDocDaLista`), onde não há trava por NF.

## 5. Solução aplicada

### 5.1 Banco — UK (entregue apenas como script em tela, sem arquivo)

```sql
ALTER TABLE AGEDOC
  ADD UNIQUE KEY UK_AGEDOC_01 (ADC_NUMDOC, ADC_ESPDOC, ADC_SERIE_, ADC_CODFOR, ADC_CODEMP);
```

- Pré-requisito: AGEDOC sem duplicados nas cinco colunas. Hoje há dois grupos: NF 000000080187 (agendamentos 311562/311563) e
  NF 000000680767 (agendamentos não investigados). Decisão do usuário: ajuste manual no cliente, fora deste requisito.
- As cinco colunas aceitam NULL; a UK não cobre linhas com campo nulo. Os `INSERT` do form sempre preenchem as cinco.
- DDL no MySQL 5.7 não tem rollback; aplicar com cuidado e só após limpar os duplicados.

### 5.2 `untRecebimentoEntregaAgendada.pas` (nas três working copies)

- Campo privado `lstTravaDocs: TStringList` (criada em `FormCreate`, liberada em `destructor Destroy`; usado `Destroy` e não
  `FormDestroy` para não alterar o `.dfm`).
- `fTravaDocumentos`: percorre `cdsAgeDoc` e trava cada NF com `fLock_Unlock(chave, True, False)`; chave
  `AGEDOC_<NUMDOC>_<ESPDOC>_<SERIE>_<CODFOR>_<CODEMP>`; chaves já na lista são ignoradas; falha → `fMensagem` com
  `fGetHostLock`, libera as já obtidas e retorna `False` (tudo ou nada).
- Chamada em `fCarregaDocumentos` depois das validações de status (`AG`) e data (hoje), antes de preencher os campos. Em falha o
  `Result := False` aciona o `finally` existente (`pLimpaAgendamento`), que também libera a trava do agendamento.
- `pDestravaDocumentos`: `fLock_Unlock(chave, False)` para cada chave (ordem inversa) e `Clear`. Chamado em `pLimpaAgendamento`
  (cobre o COMMIT, o cancelamento e os retornos antecipados), em `FormClose` quando o fechamento é efetivado e no `Destroy`.
- `fTravasDocumentosValidas`: compara `fGetHostLock(chave, False, True, True)` (devolve o `LCK_CON_ID` da trava) com
  `fGetConnectionID` — o mesmo teste que `Lock_Unlock` usa internamente. Chamada em `btnConfirmaClick` logo depois de
  `fVerificaCampos` e antes de `fAtualizaProCod`/`fStartTransaction`; se a trava foi perdida, avisa e limpa o recebimento.
- `btnConfirmaClick`: no `except` e no ramo `blnResult = False` (rollback por falha do plano de recebimento), após o `fRollBack`, chama
  `pLimpaDocumento` + `pLimpaAgendamento` — libera as travas e força o operador a recarregar o agendamento. Decisão do usuário.

### 5.3 `untCadAgendamentodeEntrega.pas` (nas três working copies)

- `btnGravarClick`, no `except`, após `fRollback`: se a mensagem do banco contém `UK_AGEDOC_01`, exibe "O Documento já se encontra em
  outro agendamento!"; senão segue para `pMensagensErro`. O `fRollback` desfaz também o AGEREC já inserido pelo `inherited`
  (`blnStartTransactionNoPaiMasCommitRoolBackNoFilho`).

## 6. Decisões técnicas relevantes

- A liberação da trava depois do rollback/commit não é estética: `Lock_Unlock` só abre/commita transação própria quando não há
  transação aberta (`blnComitar`). Dentro de uma transação aberta o `DELETE` da trava participaria da transação e seria desfeito num
  rollback, deixando a trava presa. `pMensagensErro` já faz `fRollBack` antes de exibir o erro, então a liberação logo depois fica fora
  de transação.
- `FormClose` nunca fecha enquanto há registros carregados (`Action := caNone`); ao responder "Sim" o `pLimpaAgendamento` libera tudo.
  Por isso a liberação em `FormClose` com `Action <> caNone` e o `Destroy` funcionam como garantias secundárias.
- `LCK_CHAACE` tem 150 posições; a chave por NF (~40 caracteres + prefixo do schema) cabe com folga.
- Comentário no fonte: apenas uma linha curta explicando a chamada em `fCarregaDocumentos`; nenhum "Verificar Nota N" foi necessário.
- Edição dos `.pas` feita por script Python (cp1252/CRLF) com asserção de âncora única; nas cópias antigas o `btnConfirmaClick` difere
  (`End;` maiúsculo, `Close` dentro do `try`), e o script foi ajustado para a variação.

## 7. Comportamentos a observar

- Na `.45`, após erro na confirmação em um form aberto pelo fluxo (`FStrAutIncExt` preenchido), `Close` é executado e o recebimento já
  foi limpo — o form fecha sem a pergunta "Deseja Cancelar o Recebimento Carregado?". Nas cópias antigas o `Close` está dentro do
  `try` e não roda após erro.
- O `Destroy` engole exceções ao destravar (`Try ... Except End`), para não falhar no encerramento da aplicação.
- Trava presa por queda da estação: permanece em `LCKATC` como as demais travas do sistema.

## 8. Achados colaterais (não corrigidos)

- Causa da checagem existente não ter barrado a segunda gravação (seção 3) segue sem confirmação.
- Segundo grupo duplicado em AGEDOC: NF 000000680767 (série 1, fornecedor 00004667, empresa 003).
- Fluxo: o grid de compras é estático; mesmo com as travas, a coluna "Agendamento" continua podendo exibir `REALIZAR` desatualizado.
- A conta de banco usada nas consultas desta investigação (`atendimentoII`) tem `INSERT/UPDATE/DELETE` em `AUTCOM.DIROPE` além de
  `SELECT`/`SUPER`; as consultas foram feitas com `SET SESSION TRANSACTION READ ONLY`. Não é um problema do requisito, apenas um alerta.
- Trava por NF no form de agendamento não existe (fora de escopo).

## 9. Estado e testes

- Código aplicado nas três working copies (`74.150.45`, `74.150`, `74.150.100`); não foi compilado nem testado em estação.
- Testes manuais pendentes (ver `tasks.md`, fase 5): dois agendamentos com a mesma NF (fluxo e menu, nos dois sentidos), liberação
  após commit/cancelamento/erro, agendamento com 2+ NFs com a 2ª travada, e a UK com mensagem do erro 1062.

## 10. Notas referenciadas no código-fonte

Nenhuma nota foi necessária nesta alteração (o único comentário adicionado é curto e autoexplicativo).
