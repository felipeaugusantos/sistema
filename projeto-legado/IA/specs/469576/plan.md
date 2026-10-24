# Plano de Execução — Req. 469576

**Referência:** spec.md
**Zona:** Moderna (`Contabilidade\`). O estilo segue o da unit tocada; `Contabilidade.Funcoes.pas` é procedural.

## 1. Abordagem técnica

Uma função nova em `Outros\Contabilidade.Funcoes.pas` concentra a regra (RN01/RN02) e devolve a data do último fechamento para o aviso. As portas de lançamento trocam a chamada a `fPeriodoFechado`/`fTemFechamento` pela nova. As demais chamadas dessas duas funções ficam intactas.

Assinatura proposta (nome final na implementação):

```pascal
function fDataBloqueadaPorFechamento(const ADtaLan: TDateTime; const AstrCodEmp: string;
  out ADtaUltFec: TDateTime): Boolean;
```

SQL: `SELECT MAX(COALESCE(CON_FECFIN, '9999-01-01')) FROM FECCON WHERE IFNULL(CON_CODEMP,'') IN (<grupo por raiz de CNPJ>)`, com bloqueio se `ADtaLan <= resultado`. O grupo vem de `fGetInEmpresas(fObtemEmpresasFiliais(...))`, com o mesmo fallback do `fPeriodoFechado`. A disponibilidade da tabela usa o `VC_intTemFecCon` existente.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| Contabilidade.Funcoes | `Contabilidade\Outros\` | alterar: função nova |
| Contabilidade.Classes.TValidaProcessoLancamentoContabil | `Contabilidade\Classes\` | alterar: `fValidaPeriodoFechado` usa a nova |
| Contabilidade.View.ImportacaoContabil | `Contabilidade\View\` | alterar: verificação em `fValidarDados`, guardada por empresa |
| Contabilidade.View.ManutencaoLancamentoContabil | `Contabilidade\View\` | alterar: incluir/alterar/excluir |
| Contabilidade.View.LancamentosLotesContabeis | `Contabilidade\View\` | alterar |
| Contabilidade.View.MultLancamentosLotesContabeis | `Contabilidade\View\` | alterar |
| Contabilidade.View.ManutencaoLoteContabil | `Contabilidade\View\` | alterar |
| Contabilidade.View.ExclusaoLanctoContabil | `Contabilidade\View\` | alterar: início do período |
| Contabilidade.View.GeracaoLancamentoContabil | `Contabilidade\View\` | alterar: início do período, por empresa selecionada |
| Contabilidade.View.TransferenciaLancamentosEntreContas | `Contabilidade\View\` | alterar |

Os números de linha estão no `record`/conversa da sessão; conferir na hora, porque o módulo é compartilhado e muda.

## 3. Sequência de implementação

1. Função nova em `Contabilidade.Funcoes.pas` e texto do aviso (constante junto das mensagens existentes, se houver padrão).
2. `TValidaProcessoLancamentoContabil.fValidaPeriodoFechado`, que cobre a importação "Lançamentos Contábeis" e os lotes.
3. `ImportacaoContabil.fValidarDados`, com dicionário por empresa.
4. Manutenções e exclusão.
5. Geração e transferência.
6. Conferir que fechamento, estorno e fechamento mensal continuam chamando as funções antigas.

## 4. Conformidade com padrões do projeto

- `fMensagem` para avisar; nada de `raise` para o operador; sem log novo.
- `ParamByName` para datas; a lista `IN` é a já montada por `fGetInEmpresas` (códigos do `CADEMP`).
- `pSetFocus`, `fStrToFloat`, `fNow` se algum ponto tocado precisar.
- Encoding: as units têm acentos → `fonte_delphi.py substituir`, nunca Edit/Write.

## 5. Estratégia de testes

- `Contabilidade\`: os casos de teste são escritos pelo **analista**. Lista a cobrir: os critérios de aceitação da spec.
- Validação do programador: roteiro manual da Parada 2 numa base de teste com `FECCON` montada.

## 6. Riscos e mitigação

- Mudança de comportamento para todos os clientes → registrado na spec (RN05) e na consideração de baixa.
- Desempenho na importação → guardar o resultado por empresa.
- Chamada antiga esquecida numa porta → `grep -n "fPeriodoFechado(\|fTemFechamento("` antes da Parada 3, conferido contra a tabela acima.
