# Plano de Execução — Req. 457605

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Reversão pontual de uma regressão de comportamento introduzida pela revisão SVN r425895 (Req. 384736). Não é uma nova funcionalidade nem uma correção estrutural — é restaurar, em um único ponto de entrada, o valor padrão de uma flag (`blnEstornoAutomatico`) que nunca deveria ter sido setada como `True` ali.

Não há criação de camada nova, não há alteração de `untCancelaDocumentos.pas` nem `untTEstornoPagar.pas`: o comportamento correto (checagem de acesso `frmEstornoCtaPagar`, regras de negócio de estorno e gravação de MOVBAN) já existe e é usado pelo fluxo padrão interativo (`TfrmCancelamentoDocumentos` → `TfrmEstornoPagar`); a correção apenas para de contorná-lo.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untProcessoCompras.pas` | `padra_atualizado/fontes/movimentacaoitens/untProcessoCompras.pas` | alterar (`TProcessoEntradaMercadoria.pCancelaNotaEntrada`) |

Nenhum outro arquivo é alterado.

## 3. Sequência de implementação

1. Em `TProcessoEntradaMercadoria.pCancelaNotaEntrada` (`untProcessoCompras.pas`, linha ~1135), trocar:
   ```pascal
   objCancelaDocumentos.blnEstornoAutomatico := True;
   ```
   por:
   ```pascal
   objCancelaDocumentos.blnEstornoAutomatico := False;
   ```
2. Adicionar comentário curto imediatamente acima da linha, explicando o motivo não óbvio e referenciando a nota técnica da análise (padrão do projeto — comentário curto no fonte + nota completa na análise/`resumoAnaliseRequisito`):
   ```pascal
   {Estorno automatico desabilitado: CTP baixado deve passar pela tela de Estorno de
    Contas a Pagar (acesso + MOVBAN corretos), como era antes do Req. 384736/r425895
    ter introduzido este fluxo headless aqui por engano. Verificar Nota 1 - Req. 457605}
   ```
3. Não remover nem alterar as demais linhas do bloco (`objCancelaDocumentos.EstornoPagarAutomatico := pEstornoPagarAutomatico;`, `objCancelaDocumentos.GravaLogCtp := untLogCtp.GravaLogCtp;`) — permanecem inofensivas (referências injetadas que simplesmente deixam de ser exercitadas, pois `FEstornoAutomatico = False` impede que `FPrcEstornoPagarAutomatico` seja chamado em `untCancelaDocumentos.pas:2269`).

## 4. Conformidade com padrões do projeto

- Zona Legado: nenhuma violação introduzida — só se altera o valor de uma propriedade já existente.
- Nenhum componente proibido, nenhuma chamada proibida (`Now`, `StrToFloat`, `SetFocus`, `Application.CreateForm`, SQL concatenado) envolvida.
- Comentário curto + referência a "Nota N" segue a convenção do projeto para explicações não óbvias no fonte, evitando poluir a unit com o histórico completo da investigação.

## 5. Estratégia de testes

Não há suíte DUnit aplicável a este fluxo (cancelamento de NE / estorno de CTP). Estratégia de validação manual, via ambiente de teste (`74.150.45..dev`, conforme dados do chamado original) e `citel-conectarBanco` para conferência de dados:

**Casos a cobrir:**
1. Cancelar NE **sem** CTP baixado vinculado → cancela normalmente, sem qualquer mensagem nova (regressão zero).
2. Cancelar NE **com** CTP baixado, operador **sem** `frmEstornoCtaPagar` → bloqueado com a mensagem "Duplicatas que já foram baixadas e portanto não será permitido cancelar o documento! Será necessário realizar o estorno para cancelar este documento."; NE permanece intacta; CTP permanece baixado; MOVBAN inalterada.
3. Cancelar NE **com** CTP baixado, operador **com** `frmEstornoCtaPagar` → mesmo bloqueio (não há mais atalho automático); operador estorna manualmente via `TfrmEstornoPagar` (tela confirma o direito, pede confirmação, grava MOVBAN); depois disso, cancelar a NE funciona normalmente.
4. Após o cenário 3, conferir no banco (`citel-conectarBanco`, somente leitura): `LOGCTP` com o estorno registrado e `MOVBAN` com o lançamento reverso correspondente ao portador original.
5. Reprodução do cenário do relato original (nota semelhante à NF 374522-NF-001) confirmando que o comportamento relatado (cancelamento silencioso sem estorno de MOVBAN) não ocorre mais.

## 6. Riscos e mitigação

| Risco | Mitigação |
|---|---|
| Operadores que hoje cancelam NE com CTP baixado em um único passo passam a precisar de dois passos (estornar, depois cancelar) | Comportamento intencional e correto — é o padrão já usado em `TfrmCancelamentoDocumentos` hoje; mensagem de bloqueio já existente é clara sobre o que fazer |
| Alguma rotina/relatório interno dependa do comportamento atual (estorno silencioso em cancelamento de NE) | Baixo risco — `pCancelaNotaEntrada` tem chamada única confirmada (`pOnCancelar`), exclusivamente pelo botão F6 do Fluxo de Processo de Compras; nenhum serviço Linux/Fulfillment passa por este método |
| Regressão não intencional em NE sem CTP baixado | Caso de teste 1 cobre explicitamente esse cenário — fluxo permanece idêntico ao atual, pois `fVaiGerarResumoCtp` só é `True` quando há CTP a estornar |
