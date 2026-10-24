# Plano de Execução — Req. 462421

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Alteração em `untPcmGer.pas`: (1) somar, via `Or`, a condição `Not fEmptyStr(strEmpresaDeposito)` ao parâmetro já existente na chamada de `fBaixaNotaEletronica` (linha 4979); (2) renomear o parâmetro `blnX922` para `blnFinalizaGerele` na declaração forward, na assinatura da função e no uso interno, por clareza semântica — sem alteração de tipo, valor default ou comportamento. Não há alteração de form nem introdução de nova lógica de gravação — reaproveita-se integralmente o mecanismo existente de finalização de NF-e.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|-----------------|---------|------|
| `untPcmGer.pas` | `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas` (linha 4979) | alterar |

## 3. Sequência de implementação

1. Abrir `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas` e localizar a linha 4979 (chamada única de `fBaixaNotaEletronica`, dentro de `fConfirmaEntradaMercadorias`).
2. Substituir:
   ```pascal
   If Not fBaixaNotaEletronica(strAutEle, strNumDoc, strEspDoc, VS_strCodEmp, fTemItemX922) Then
   ```
   por:
   ```pascal
   If Not fBaixaNotaEletronica(strAutEle, strNumDoc, strEspDoc, VS_strCodEmp, fTemItemX922 Or (Not fEmptyStr(strEmpresaDeposito))) Then
   ```
3. Renomear o parâmetro `blnX922` para `blnFinalizaGerele` nas 3 ocorrências: declaração forward (linha 601), assinatura da função (linha 10809) e uso interno (`If blnX922 Then` → `If blnFinalizaGerele Then`, linha 10828).
4. Confirmar via grep que a chamada a `fBaixaNotaEletronica` continua única no projeto (nenhum outro ponto impactado).
5. Validar que o arquivo permanece em cp1252/latin1 sem corrupção de caracteres acentuados (edição via Python).

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian style, prefixos `unt`/`p`/`f` já respeitados — nenhuma mudança de nomenclatura.
- Nenhum componente/chamada proibida envolvida (mudança é puramente lógica/booleana).
- Encoding: arquivo `.pas` em cp1252/latin1 — edição obrigatória via Python (`io.open` com `encoding='cp1252', newline=''`), nunca via ferramenta `Edit`, para não corromper acentuação do restante do arquivo.
- Pre-commit: sem SQL alterado, sem componentes proibidos, sem `FOREIGN_KEY_CHECKS`.

## 5. Estratégia de testes

- Não há suíte DUnit cobrindo este fluxo específico de Entrada de Mercadorias com Depósito Fechado.
- Teste manual seguindo a simulação do chamado:
  1. Empresa logada 015, `CFG_UTIWMS=S`, `CFG_TIPPNT=D`, `CFG_ETRAUT=S`.
  2. Realizar Entrada de Mercadorias com NF-e vinculada e depósito fechado informado (`edtCodEmpresa` preenchido em `untEntDadosFiscaisResumo`).
  3. Confirmar a entrada e verificar que a Nota Especial de Transferência é gerada normalmente (comportamento já existente, não deve mudar).
  4. Consultar `GERELE.GER_FNLZDA` da NF-e original — deve estar `'S'`.
  5. No fluxo de compras, verificar que as colunas "Agendamento de Recebimento", "Recebimento de Agendamento" e "Plano Recebimento" não exibem mais "A Realizar" para essa NF-e.
  6. Regressão: repetir com item CFOP 1922/2922 (sem depósito fechado) e confirmar que `GER_FNLZDA` continua sendo gravado `'S'` como antes.
  7. Regressão: entrada sem NF-e vinculada (`strAutEle` vazio) — confirmar que nada muda (bloco nem é executado).

## 6. Riscos e mitigação

- Nenhum risco relevante identificado. Chamada a `fBaixaNotaEletronica` é única no projeto (confirmado via grep) e a alteração é aditiva (`Or`), preservando 100% do comportamento anterior para os demais cenários.
