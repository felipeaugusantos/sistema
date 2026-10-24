# Registro da Sessão — Req. 458331

## 1. Contexto de negócio

O sistema permite configurar, por empresa, o fluxo `FLUPDC` (`fCfgSis('FLUPDC', varBoolean)`), que obriga
notas de entrada de fornecedores de **material de uso e consumo** a passar por uma etapa de **conferência
e pré-nota** antes de a entrada de mercadoria ser efetivamente finalizada. Fornecedores são classificados
como "material de uso e consumo" pelo campo `CADFOR.FOR_MATREV = 'M'`.

O campo `GERELE.GER_ENTDIR` ("entrada direta") sinaliza se uma nota fechou a entrada sem passar pelo fluxo
de conferência/pré-nota (`'S'`) ou se ainda depende de processamento posterior (`'N'`). Ele é consultado em
pelo menos três pontos distintos da cadeia de importação/entrada de mercadoria (ver seção 4).

## 2. Problema relatado e causa raiz

**Ticket:** Zendesk 1645568 — fornecedor 1238, nota 584364. Cliente não conseguia finalizar a entrada de
material de uso e consumo; o suporte identificou que faltava a etapa de conferência/pré-nota e fez um ajuste
manual via banco para o cliente conseguir prosseguir, mas pediu abertura de requisito para investigar a
causa raiz.

**Investigação (rastreamento de código, sem hipótese descartada — a causa raiz foi localizada diretamente
seguindo a cadeia de consultas):**

1. `TNFeXml.fGravaGerEle` (`untEntNfeXml.pas`), no ramo em que o fornecedor tem `FOR_MATREV = 'M'`, gravava
   `FieldByName('GER_ENTDIR').AsString := 'S'` **antes** de verificar `FLUPDC`, ou seja, incondicionalmente
   para qualquer fornecedor desse tipo — independentemente de a empresa usar ou não o fluxo de pré-nota.
2. A consulta que localiza notas pendentes de pré-nota — `fPesqGerelePreNotaEntrada` → função interna
   `fSQLWhere` (`untConsultas.pas:31119-31125`), usada por `TPreNota.fSelecionaNFE` — exige
   `IFNULL(GER_ENTDIR, "N") <> "S"`. Como o campo já vinha `'S'` da importação, a nota nunca aparecia nessa
   tela, mesmo com FLUPDC ativo (quando deveria aparecer, pois a pré-nota ainda era necessária).
3. Sem passar pela pré-nota, o campo `GER_DTALIB` (data de liberação) nunca era preenchido — ele só é
   gravado pela rotina de liberação da pré-nota (`untEntPreNotaEntrada.pas:1898-1915`,
   `UPDATE GERELE SET GER_DTALIB = ...`).
4. A tela final de fechamento da entrada — `TEntradaAutomatizada.fCarregaNota`/`fSQLNotas`
   (`untEntradaAutomatizada.pas:568-573`) → `fSQLNotasEntrada` (`untConsultas.pas:31686-31687`) — exige, com
   FLUPDC ativo, `GER_DTALIB IS NOT NULL AND GER_DTACON IS NOT NULL`. Como `GER_DTALIB` nunca era
   preenchido (passo 3), a nota também nunca aparecia nessa tela. Este é exatamente o sintoma relatado no
   ticket: "não está encontrando o item para finalizar a entrada".

**Validação cruzada realizada:** os demais ramos de `fGravaGerEle` que também gravam `GER_ENTDIR := 'S'`
(`xmlEntradaMercadoriasSistemaAnteriorDevolucao`, `xmlDevolucaoEntradaEmitidaFornecedor`,
`xmlCFG_UVNEGFEntMerRetornoFornecedor`, `xmlCFG_IMPXGRGarantiaRetFornecedor` — fluxos de
devolução/retorno de garantia) foram inspecionados e **não dependem de FLUPDC**: fecham a entrada direta
por definição de negócio (não passam por conferência/pré-nota em nenhuma configuração), e a própria consulta
de garantia (`blnRetornoGarantia`) filtra apenas por `GER_TIPXML`/`GER_DOCENT`, sem checar
`GER_ENTDIR`/`GER_CONDIR`. Confirmado que o bug está isolado ao ramo `FOR_MATREV = 'M'`.

## 3. Solução aplicada

**Arquivo:** `padra_atualizado/fontes/movimentacaoitens/untEntNfeXml.pas`
**Função:** `TNFeXml.fGravaGerEle`, ramo `If fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'],
[FGerEle.GER_CODFOR]) = 'M' Then`

A atribuição `GER_ENTDIR := 'S'`, antes feita incondicionalmente no início do bloco, foi movida para dentro
dos dois sub-ramos existentes (`if FLUPDC` / `Else`):

```pascal
if (fCfgSis('FLUPDC', varBoolean)) then
Begin
  {Com FLUPDC ativo, a entrada de material de uso e consumo ainda precisa passar
   pela pré-nota (fSelecionaNFE exige GER_ENTDIR <> 'S'). Manter 'N' aqui evita
   que a nota fique invisível para a pré-nota e trave a finalização da entrada.
   Verificar Nota 1 - Req. 458331}
  FieldByName('GER_ENTDIR').AsString := 'N';
  FieldByName('GER_DTACON').AsDateTime := VS_Date;
End
Else
Begin
  FieldByName('GER_ENTDIR').AsString := 'S';
  FieldByName('GER_DTALIB').AsDateTime := VS_Date;
  FieldByName('GER_CONDIR').AsString := 'S';
End;
```

- Com **FLUPDC ativo**: `GER_ENTDIR` passa a `'N'` na importação — a nota fica localizável em
  `TPreNota.fSelecionaNFE`; após a liberação da pré-nota (que grava `GER_DTALIB`), a nota passa a satisfazer
  a condição de `TEntradaAutomatizada.fSQLNotas` e aparece para finalizar a entrada.
- Com **FLUPDC inativo**: comportamento inalterado — `GER_ENTDIR := 'S'` continua sendo gravado junto com
  `GER_DTALIB`/`GER_CONDIR := 'S'` já na importação (entrada direta, sem pré-nota), exatamente como antes.

## 4. Cadeia validada ponta a ponta

| Etapa | Local | Condição relevante |
|---|---|---|
| Importação do XML | `untEntNfeXml.pas` — `TNFeXml.fGravaGerEle` | grava `GER_ENTDIR`/`GER_DTACON` (alterado) |
| Seleção para pré-nota | `untConsultas.pas:31119-31125` (`fPesqGerelePreNotaEntrada`/`fSQLWhere`), usada por `untPreNota.pas` — `TPreNota.fSelecionaNFE` | exige `GER_ENTDIR <> 'S'`; com FLUPDC e `FOR_MATREV='M'`, exige `GER_DTALIB IS NULL AND GER_DTACON IS NOT NULL` |
| Liberação da pré-nota | `untEntPreNotaEntrada.pas:1898-1915` | `UPDATE GERELE SET GER_DTALIB=...` — não altera `GER_ENTDIR` nem `GER_DTACON` |
| Fechamento da entrada | `untEntradaAutomatizada.pas:568-573` (`fSQLNotas`) → `untConsultas.pas:31686-31687` (`fSQLNotasEntrada`) | com FLUPDC, exige `GER_DTALIB IS NOT NULL AND GER_DTACON IS NOT NULL` |

## 5. Decisões de escopo

- **Incluído:** apenas o ramo `FOR_MATREV = 'M'` de `TNFeXml.fGravaGerEle`.
- **Excluído deliberadamente:** levantamento/correção em lote de notas já gravadas no banco com o padrão do
  bug (`GER_ENTDIR='S'` indevido em notas ainda pendentes de pré-nota). Decisão tomada com o usuário durante
  o levantamento (`/citel-IAArquitectDesenv`): o caso do ticket (nota 584364/fornecedor 1238) já havia sido
  corrigido manualmente via banco pelo próprio suporte antes da abertura deste requisito, e não há indício de
  outros casos reportados — o requisito ficou restrito à correção da causa raiz no código-fonte.
- **Excluído por não ser o mesmo bug:** os ramos de devolução/retorno de garantia em `fGravaGerEle` (ver
  seção 2, "Validação cruzada") — não dependem de FLUPDC e não apresentam o mesmo problema.

## 6. Achados colaterais (não corrigidos nesta sessão)

Nenhum achado colateral relevante identificado durante a análise deste requisito.

## 7. Replicação em outras working copies

A mesma alteração de código (idêntica, incluindo o comentário/nota no fonte) foi replicada nas working
copies irmãs do mesmo projeto, a pedido do usuário:

| Working copy | Arquivo | Linha do bloco alterado (base rev. 491291) |
|---|---|---|
| `379.48.2.30.74.150` (esta) | `untEntNfeXml.pas` | ~3941-3966 |
| `379.48.2.30.74.150.45` | `untEntNfeXml.pas` | ~3775-3796 |
| `379.48.2.30.74.150.100` | `untEntNfeXml.pas` | ~3819-3840 |

Em todas, validado antes da edição que o trecho original (não corrigido) era idêntico byte a byte
(considerando CRLF/cp1252), e validado depois que o arquivo resultante decodifica corretamente em cp1252,
sem marcador de corrupção (`\xef\xbf\xbd`). Edição feita via Python (leitura/gravação explícita em
`cp1252`, `newline=''`), nunca via ferramenta de edição genérica, por exigência do usuário para arquivos
Delphi legados nesse encoding.

Este `record.md` e os demais artefatos (`spec.md`, `plan.md`, `tasks.md`) foram gerados apenas na working
copy `379.48.2.30.74.150` (pasta `IA\specs\458331\`); não foram duplicados para `.45`/`.100`.

## 8. Ressalvas / lições para continuidade

- A pasta `IA\specs\` deste projeto estava vazia antes deste requisito — não havia precedente de
  `record.md`/`analysis.md` para servir de referência de estilo; este arquivo é o primeiro do projeto
  seguindo essa convenção.
- Fase 4 (revisão/`/citel-aprovaRequisito`/gate DelphAI/commit) ainda não foi executada em nenhuma das
  três working copies — segue pendente, a critério do usuário.

## 9. Validação (Fase 3)

Usuário validou manualmente o fix nos dois cenários de configuração:

- **FLUPDC ativo:** confirmado que a nota de fornecedor `FOR_MATREV='M'` passa a ser localizada
  normalmente pela pré-nota e a entrada é finalizada corretamente (fluxo antes travado, ver seção 2).
- **FLUPDC inativo:** confirmado que o comportamento de entrada direta permanece inalterado (sem
  regressão).

Não foi confirmada explicitamente a regressão do caso 6 do roteiro (`plan.md` seção 5 — fornecedor sem
`FOR_MATREV='M'`, ramo `Else` não alterado pelo fix); risco residual considerado baixo por não ter havido
alteração de código nesse ramo.

## Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit:** `untEntNfeXml.pas`
**Função:** `TNFeXml.fGravaGerEle`, ramo `FOR_MATREV = 'M'`, sub-ramo `if (fCfgSis('FLUPDC', varBoolean))`

O bloco `FOR_MATREV = 'M'` representa fornecedor de material de uso e consumo. Antes da correção,
`GER_ENTDIR` era gravado `'S'` incondicionalmente logo no início do bloco, antes de qualquer verificação de
`FLUPDC` — ou seja, mesmo quando a configuração `FLUPDC` está ativa e o fluxo exige que a nota passe pela
etapa de pré-nota antes de fechar a entrada. Como a consulta que localiza notas pendentes de pré-nota
(`fPesqGerelePreNotaEntrada`, usada por `TPreNota.fSelecionaNFE`, em `untConsultas.pas:31125`) exige
`GER_ENTDIR <> 'S'`, a nota ficava permanentemente invisível para a pré-nota assim que era importada — e,
sem pré-nota, `GER_DTALIB` nunca era preenchido, o que também bloqueava a nota na listagem final de
`TEntradaAutomatizada.fSQLNotas` (que exige `GER_DTALIB IS NOT NULL AND GER_DTACON IS NOT NULL` com FLUPDC
ativo). Esse era exatamente o sintoma do ticket Zendesk 1645568 (Req. 458331): "não está encontrando o item
para finalizar a entrada". A correção move a atribuição para dentro do `if`/`Else`: com FLUPDC ativo,
`GER_ENTDIR` fica `'N'` (a entrada não está fechada, falta a pré-nota); com FLUPDC inativo, mantém-se `'S'`
como antes (entrada fecha direto, sem pré-nota). Se uma revisão futura "limpar" esse `if`/`Else` voltando a
atribuição para o topo do bloco por parecer redundante, reintroduz o bug: a nota volta a ficar invisível
para a pré-nota sempre que FLUPDC estiver ativo.
