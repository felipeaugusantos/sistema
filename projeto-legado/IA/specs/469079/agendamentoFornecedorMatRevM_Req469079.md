# Entrada simplificada — fornecedor MATREV = 'M' não gera agendamento de recebimento (Req. 469079)

## 1. Contexto de negócio

- **Entrada simplificada de transferência** (`TfrmRecTransfEstoque`, unit `untRecTransfEstoque.pas`): dá entrada, na filial
  de destino, em uma nota de transferência (espécie PD/TE) emitida por outra empresa.
- **CFG_TIPPNT** define quando ocorre a conferência de mercadorias: `A` = antes da entrada; `D` = depois da entrada.
  `fConferenciaDepoisDaEntrada` (`untFuncoesGenerica.pas`) é apenas `TIPPNT = 'D'`.
- Com `TIPPNT = D` a entrada nasce **pendente**: o `MOVDET` é gravado com `DET_FILKAR = 1`, a data de entrada do `MOVGER`
  fica nula e **nenhum saldo é creditado na gravação** (`fAtualizaProduto` sai logo no início porque `fZeraDataEntrada`
  é verdadeiro). O crédito acontece depois, na **efetivação do movimento fiscal**.
- Com WMS (`blnUsaRotinaWms`) e `TIPPNT = D`, a entrada gera **agendamento de recebimento** (`AGEREC` + `AGEITE`) para
  o item ser endereçado via coletor (`fGeraAgendamento`).
- **CADFOR.FOR_MATREV** classifica o fornecedor (`I` = indústria, `M` = material de uso e consumo). Regra conhecida da equipe: **fornecedor `M`
  nunca credita saldo** (`DET_FILKAR` fica 1, "filtrar na Kardex").

## 2. Problema e causa raiz

Cenário reportado: nota de transferência com fornecedor `MATREV = M`, entrada simplificada com WMS e `TIPPNT = D`.
O sistema gerou o `AGEREC`/`AGEITE`, o coletor endereçou o item, mas **o saldo não entrou no lote "A DEFINIR"**.

Causa raiz (evidência no log `LOGREP_ARQUIV_20260829`, transação `7451922199264493448`, 24/08/2026, documento
`000001000077`, fornecedor `00000002`, item `0945807`, empresa `052`):

| Comando do log | O que mostra |
|---|---|
| 10236091 `INSERT MOVDET` | `DET_NUMLOT = 'A DEFINIR'`, `DET_FILKAR = 1` (pendente de crédito) |
| 10236113 `INSERT AGEREC` | agendamento gerado (status `EC`) |
| 10236138 `INSERT AGEITE` | item agendado, `AIT_NUMLOT` nulo, `AIT_QTDEND = 0`, `AIT_TOTEND = 10` |
| 10236141 `UPDATE MOVGER` | `GER_DTAENT` preenchida (era nula): entrada zerada na gravação |
| 10236148 `UPDATE MOVDET` | `DET_FILKAR = 1` + `DET_DTAENT`: é o `pEfetiva` rodando |
| 10236150 `UPDATE AGEREC` | `ARC_STATUS = 'EP'` |
| — | **nenhuma** escrita de saldo (item/lote/localização) entre 10236148 e o fim |

Mecanismo, em `TEfetivaMovimentoFiscal.pEfetiva` (`untEfetivaMovimentoFiscal.pas`, linhas 902-906, introduzidas na
r426578): para `FOR_MATREV = 'M'` o código força `blnFilKar := True`. Como o crédito de saldo
(`fAtualizaEstoqueCadIte` + `TDetLoc.pAtualizaEstoqueLocalizacao(..., 'A DEFINIR', ...)`, linhas 948-975) e o pedido de
endereçamento (linha 985) exigem `Not blnFilKar`, nada é creditado nem endereçado. O `UPDATE MOVDET` final regrava
`DET_FILKAR = 1`. Ao mesmo tempo, `fGeraAgendamento` seguia verdadeiro e gerava o agendamento: o coletor tinha o que
endereçar, mas o saldo não existia.

## 3. Jornada de investigação (incluindo caminhos descartados)

1. Consulta read-only ao log da transação (30 comandos). Mapeados contra o `Result :=` de `fGeraEntrada`
   (`fGravaMovGer`, `fGravaMovDet`, `fGravaFatGor`, `fGravaFatDor`, `fAtualizaPedido`, `fGravaCadFis`,
   `fGravaFinanceiro`, `fGravaAgendamentoDeRecebimento`, `fEfetivaMvtoFiscal`, `fGeraPlanoRecebimentoAutomatico`).
2. **Hipótese descartada 1:** "item sem lote 'A DEFINIR' cadastrado". Nascida de um parser meu que quebrou o `INSERT`
   na vírgula da descrição do produto ("0,9L") e mostrou `DET_NUMLOT = ''` e `DET_FILKAR = 0`. Conferindo as colunas
   com o `INSERT` completo informado pelo usuário: lote era `A DEFINIR` e `DET_FILKAR` já era 1. **Lição:** não usar
   regex para separar valores de `INSERT` com texto livre.
3. Consulta `SHOW TRIGGERS` em `MOVDET`: nenhum trigger. O crédito de saldo é feito só por código.
4. Leitura de `pEfetiva` → achada a regra do `M` (linhas 902-906) e o efeito em cadeia (linhas 948, 985, 1025).
5. **Abordagem descartada 2:** "impedir que o insert grave `FILKAR = 1` para fornecedor M". Não funciona: com
   `TIPPNT = D` o `fAtualizaProduto` não credita na gravação; o crédito só vem na efetivação, que só credita se o
   `DET_FILKAR` lido do banco for 1. Gravar 0 faria o saldo **nunca** entrar.
6. **Abordagem descartada 3:** em `pEfetiva`, aplicar a regra do `M` só quando `DET_FILKAR <> 1`. Descartada pelo
   usuário: a regra de negócio é que o `M` **nunca credita saldo** (`FILKAR = 1`), portanto o problema não é o saldo
   faltar, e sim o agendamento/endereçamento existir.
7. Solução adotada (decisão do usuário): fornecedor `M` não gera agendamento. Comparadas as três telas que aplicam
   `FILKAR`: `untPcmGer` (linha 6104, `strTipFor = 'M'` → `blnFilKar := True` no insert), `pEfetiva` (linhas 902-906)
   e `fGravaMovDet` da entrada simplificada (sem regra do `M`).

## 4. Solução aplicada

Arquivo único: `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas`.

- Novo campo de classe `blnFornecedorMaterialUsoConsumo: Boolean`, ao lado de `blnFornecedorIndustria`.
- `pCarregaFornecedor`: após carregar `blnFornecedorIndustria` (`FOR_MATREV = 'I'`), passa a preencher
  `blnFornecedorMaterialUsoConsumo := FieldByName('FOR_MATREV').AsString = 'M'`. Reaproveita a consulta que já existia, sem
  consulta nova. `pCarregaFornecedor(strCodFor)` é chamado em `fGeraEntrada` (por documento) antes de qualquer uso de
  `fGeraAgendamento`, então o valor não fica desatualizado em multisseleção.
- `fGeraAgendamento`: depois do cálculo original, `If Result And blnFornecedorMaterialUsoConsumo Then Result := False`.

Efeitos em cadeia (todos dependem de `fGeraAgendamento`, nenhum foi alterado):

| Ponto | Efeito para fornecedor `M` |
|---|---|
| `fGravaAgendamentoDeRecebimento` | sai com `True` no início: sem `AGEREC`/`AGEITE`/`GERELE`/`DETELE`/`PEDELE`/`AGEDOC` |
| `fGeraPlanoRecebimentoAutomatico` | `strIdeDig` vazio: não confirma plano de recebimento |
| `fValidaTransportadoraAgendamento` (linha 2288) | deixa de ser exigida transportadora/`CFG_TRASUG` |
| `fRetNumLot` (linha 3772) | ramo "agendamento ou endereçamento" não força `A DEFINIR` por esse motivo |
| bloco WMS de `fDocumentoGeraEnderecamento` (linha 4013) | override do `CONEFE` não se aplica; sem endereçamento imediato |

**Complemento (decisão posterior do usuário): fornecedor `M` entra efetivado, igual a `untPcmGer`.** Além de não gerar
agendamento, para `M` (e não devolução) a entrada simplificada passou a:

| Ponto | Mudança para `M` |
|---|---|
| `fZeraDataEntrada` | não zera a data de entrada (`GER_DTAENT`/`DET_DTAENT` gravados no insert), espelhando `untPcmGer.fZeraDataEntrada` (`strTipFor <> 'M'`) |
| `fGravaMovDet` | `blnFilKar := True` sempre (antes só com `TIPPNT = D`), espelhando `untPcmGer` linha 6117 |
| `fAtualizaProduto` | sai antes de atualizar ACAGER, última compra, preço e saldo (`fAtualizaEstoqueCadIte` / `TDetLoc` / produto acabado). Sem isso, ao deixar de zerar a data o saldo seria creditado no insert e uma compra de uso e consumo sobrescreveria preço e última compra (em `untPcmGer`, `fAtualizaItem` e as condições de preço já bloqueiam `strTipFor = 'M'`) |
| `fGravaMovDet` (lote de preços) | `fGeraLotePrecos` não é chamado para `M`: o `Exit` de `fAtualizaProduto` vem depois de `pRecalculaPrecos`, que já preenche `recPrecos`; com `ATPREN` + `LOTPRE`/`LOTSIM` e fornecedor filial (caso da transferência) o lote de preços seria gerado com o custo da nota e, com `ENTEFE`, efetivado, sobrescrevendo o preço do item |
| `fGravaFinanceiro` | grava a data do lançamento do `CADPAG` (`CTP_DTACAD`) para `M`, pois nenhuma rotina posterior a preencheria: a Efetivação do Movimento Fiscal só seleciona notas com `GER_DTAENT` nulo. A competência já era gravada fixa |
| Validação de acesso (`BitBtnLocked1Click`) | usa `fZeraDataEntradaSemUsoConsumo`, pois roda antes do loop de documentos e `blnFornecedorMaterialUsoConsumo` ainda reflete o último documento carregado |
| `fDocumentoGeraEnderecamento` | retorna `False`: sem saldo não há o que endereçar |
| `fRetNumLot` | se o lote resultante for "A DEFINIR", troca pelo lote principal de compra (erro se não houver) |

Como `fZeraDataEntrada` passa a ser falso para `M`, `fEfetivaMvtoFiscal` (que exige `CONEFE` e `fZeraDataEntrada`) não roda mais para ele:
o documento já nasce efetivado, com `DET_FILKAR = 1` e sem saldo. Isso resolve também o caso `CONEFE` desligado, que ficaria
com a nota pendente sem agendamento. `fGeraAgendamento` continua retornando `False` para `M` (Nota 1), pois
`fConferenciaDepoisDaEntradaLocal` segue verdadeiro e geraria agendamento para documento já efetivado.

## 5. Decisões de escopo

- **Dentro:** apenas `CFG_TIPPNT = D` (único cenário em que `fGeraAgendamento` pode ser verdadeiro, pois depende de
  `fConferenciaDepoisDaEntradaLocal`).
- **Fora:** regra do `M` em `pEfetiva` (inalterada).
- **Ampliado depois:** a regra do `M` passou a valer em qualquer `CFG_TIPPNT` (FILKAR = 1, sem crédito, lote principal), o que
  também fecha o achado colateral 1 (`TIPPNT = A` + `M`).

## 6. Achados colaterais não corrigidos

1. **(Resolvido pelo complemento da seção 4) Inconsistência `TIPPNT = A` + fornecedor `M` na entrada simplificada.** Em `untPcmGer` o `M` força `FILKAR = 1` no
   insert e o saldo só é creditado com `Not blnFilKar` (linhas 6104 e 7311), em qualquer `TIPPNT`. Em `pEfetiva` o `M`
   também não credita. Na entrada simplificada com `TIPPNT = A`, `fGravaMovDet` não tem regra do `M`: grava
   `FILKAR = 0` e `fAtualizaProduto` credita o saldo no insert (o crédito não depende de `blnFilKar`). A regra geral
   ("`M` nunca credita") não é respeitada nesse caso. Correção equivalente seria forçar `blnFilKar := True` para `M`
   em `fGravaMovDet` e condicionar o crédito de `fAtualizaProduto` a `Not blnFilKar`. Decisão do usuário: tratar em
   outro momento.
2. (Resolvido: agora grava o lote principal de compra) O `MOVDET` de fornecedor `M` gravava lote `A DEFINIR` sem ter saldo (comportamento anterior à
   alteração).
3. Em multisseleção, `strIdeDig` é compartilhado entre os documentos; seleção mista (`M` e não-`M`) não foi analisada.
4. O bloco de conferência depois da entrada em `untPcmGer` (linhas ~6108-6112) pode zerar `blnFilKar` depois da regra
   do `M`; não foi analisado se isso reabre o crédito do `M` em `untPcmGer`.

## 7. Ressalvas e lições de ferramenta/processo

- Consultas ao log foram feitas por `citel-conectarBanco` (somente leitura); SQL passado por arquivo/stdin.
- Não existe suíte automatizada para esta tela (`AutcomTestesClientes` cobre apenas regras tributárias).
- Arquivos `.pas` em cp1252 com CRLF: editar sempre por Python (nunca pela ferramenta `Edit`).

## NOTAS REFERENCIADAS NO CÓDIGO-FONTE

### Nota 1

Unit `untRecTransfEstoque.pas`, função `TfrmRecTransfEstoque.fGeraAgendamento`.

Fornecedor com `CADFOR.FOR_MATREV = 'M'` não credita saldo: tanto `untPcmGer` (entrada de mercadorias) quanto
`TEfetivaMovimentoFiscal.pEfetiva` (efetivação do movimento fiscal) forçam `blnFilKar := True` para ele, e o crédito
de saldo e o endereçamento só ocorrem com `Not blnFilKar`. Se a entrada simplificada com conferência depois da entrada
(`CFG_TIPPNT = D`) gerasse `AGEREC`/`AGEITE` para esse fornecedor, o coletor teria um item agendado para endereçar sem
que houvesse saldo no lote "A DEFINIR" (a efetivação não credita para `M`), deixando o agendamento sem correspondência.
Por isso `fGeraAgendamento` retorna `False` para `M`, usando `blnFornecedorMaterialUsoConsumo` (carregado em `pCarregaFornecedor`),
o que também faz `fGravaAgendamentoDeRecebimento` e `fGeraPlanoRecebimentoAutomatico` não executarem nada e dispensa a
transportadora sugerida. Não remover essa checagem por parecer redundante com a regra do `M` em `pEfetiva`: lá ela
impede o crédito de saldo, aqui impede que o agendamento exista.

### Nota 2

Unit `untRecTransfEstoque.pas`, funções `fZeraDataEntrada`, `fDocumentoGeraEnderecamento` (local de `fGravaMovDet`), o ponto de
`blnFilKar` em `fGravaMovDet`, o bloco de crédito de saldo de `fAtualizaProduto` e `fRetNumLot`.

Fornecedor `CADFOR.FOR_MATREV = 'M'` (material de uso e consumo) nunca credita saldo. Em `untPcmGer` ele entra efetivado (data de
entrada preenchida, `fZeraDataEntrada` falso por `strTipFor <> 'M'`), com `blnFilKar := True` e sem crédito de saldo
(`If Not blnFilKar`). A entrada simplificada passou a seguir o mesmo contrato. As cinco mudanças são interdependentes e não devem
ser removidas isoladamente: se `fZeraDataEntrada` deixasse de ser verdadeiro para `M` sem o bloqueio de crédito em
`fAtualizaProduto` (que só saia cedo quando `fZeraDataEntrada` era verdadeiro), o saldo seria creditado no insert, contra a regra
de que `M` não credita; sem `fDocumentoGeraEnderecamento` falso, o WMS geraria pedido de endereçamento sem saldo; sem o ajuste
de `fRetNumLot`, o item seguiria com lote "A DEFINIR" sem coletor para endereçá-lo. Todas as condições excluem devolução
(`FblnDevolu`), cuja contraparte é cliente e já tem regra própria. O campo `blnFornecedorMaterialUsoConsumo` é carregado em
`pCarregaFornecedor` antes de `fGravaMovDet`.

Complementos da Nota 2:

- `fZeraDataEntrada` agora é `fZeraDataEntradaSemUsoConsumo` (regra original) combinada com o flag do fornecedor carregado. O flag
  só vale após `pCarregaFornecedor`, então `fZeraDataEntrada` só pode ser usada dentro do loop de documentos; antes dele (validação de
  acesso a `frmEntMercadoriasEfetivaMovFiscal`) usa-se `fZeraDataEntradaSemUsoConsumo`, que mantém o comportamento anterior e não
  depende de qual documento foi carregado por último (seleção mista de 'M' e outros).
- `fFornecedorMaterialUsoConsumo` não existe como função: a condição é sempre `blnFornecedorMaterialUsoConsumo And (Not FblnDevolu)`.
- Observação não tratada: em `untPcmGer`, o `CADPAG` de 'M' grava tipo de documento '1' e uso e consumo 'S'
  (`strTipDoc`/`strUsoCon`); a entrada simplificada não grava esses campos para 'M' (comportamento anterior, fora do escopo).
- A condição de `fGeraLotePrecos` em `fGravaMovDet` (linha após `fGravaCalcPreMed`) exige também `Not (blnFornecedorMaterialUsoConsumo And (Not FblnDevolu))`; sem ela o `Exit` de `fAtualizaProduto` não impediria a atualização de preço pelo caminho de lote de preços.
