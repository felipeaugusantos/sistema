# Plano de Execução — Req. 462563

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Correção pontual e isolada em `untLogAltCadIte.pas`, sem tocar na função genérica `fRetAutoIncrem`/`fRetAutoIncremInterno` (usada por outras tabelas). Duas mudanças independentes na mesma unit:

1. **`pGravaLogAlteracao`** — aumentar a reserva de sequenciais de `qryCadIte.Fields.Count - 1` para `qryCadIte.Fields.Count + 1`, cobrindo o pior caso de consumo (um número de log por campo elegível alterado) com uma margem de segurança adicional de 1 (decisão explícita do usuário).
2. **`pGravaLogAlteracaoEcommerce`** — mesma correção de reserva (`qryInfos.Fields.Count + 1`) **e** remoção da chamada duplicada de `pIncrementaAutoIncrem` (hoje chamado antes e depois do `Post`; manter só a chamada após o `Post`, como no fluxo normal).

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untLogAltCadIte.pas | padra_atualizado/fontes/cadastros/untLogAltCadIte.pas | alterar |

## 3. Sequência de implementação

1. Em `pGravaLogAlteracao` (linha ~88), trocar o terceiro parâmetro de `fRetAutoIncrem('LOGCPR', VS_strCodEmp, qryCadIte.Fields.Count - 1)` para `qryCadIte.Fields.Count + 1`.
2. Em `pGravaLogAlteracaoEcommerce` (linha ~204), trocar o terceiro parâmetro de `fRetAutoIncrem('LOGCPR', VS_strCodEmp, qryInfos.Fields.Count - 1)` para `qryInfos.Fields.Count + 1`.
3. Na mesma rotina, remover uma das duas chamadas a `pIncrementaAutoIncrem(strAutIncBkp)` (linhas ~269 e ~273), mantendo apenas a chamada posterior ao `Post` (linha ~273), alinhando com o padrão já usado em `pGravaLogAlteracao`.
4. Conferir visualmente, após a edição, que não sobrou nenhuma referência ao cálculo antigo (`Fields.Count - 1`) nem à chamada duplicada removida.

## 4. Conformidade com padrões do projeto

- Zona Legado: nenhuma mudança de convenção — mantém Hungarian style, nomes e estrutura já existentes na unit.
- Não introduz nem remove componentes proibidos, SQL concatenado, `Now()`/`StrToFloat` diretos ou qualquer padrão vetado pelo pre-commit.
- Não altera assinatura pública de `pGravaLogAlteracao`/`pGravaLogAlteracaoEcommerce` nem de `fRetAutoIncrem`.

## 5. Estratégia de testes

- Não há suite DUnit cobrindo `untLogAltCadIte.pas` nesta cópia.
- Teste manual: no Cadastro de Produtos (ou via Consulta de Preços > Consulta/Alteração de Catálogos), alterar simultaneamente o maior número possível de campos logáveis de um produto e salvar duas vezes seguidas, confirmando ausência do erro `#23000 Duplicate entry` em `LOGCPR` atribuível ao déficit de reserva corrigido.
- Conferir, após o teste, que o número de linhas gravadas em `LOGCPR` para a operação corresponde exatamente à quantidade de campos efetivamente alterados (sem duplicidade nem lacunas introduzidas pela correção).

## 6. Riscos e mitigação

- **Incidente já instalado no cliente FAZO** (contador `PROINC.PRO_AUTINC` alinhado com `MAX(AUTOINCREM)`) não é resolvido por esta correção de código → tratado como fora de escopo (spec.md, seção 7), fica pendente de ação separada no banco daquele cliente.
- **Nenhum outro chamador identificado** que dependa do tamanho exato do bloco reservado por estas duas rotinas → risco de regressão considerado baixo.

## 7. Replicação em cópias irmãs

A mesma correção (reserva `Fields.Count + 1` + incremento único por campo alterado) foi replicada em `379.48.2.30.74.111`, `379.48.2.30.74.150`, `379.48.2.30.74.150.45` e `379.48.2.30.74.150.100`, cada uma respeitando o estado real do código local (ver spec.md, seção 9) — em três dessas cópias o incremento duplicado estava em `pGravaLogAlteracao`, não em `pGravaLogAlteracaoEcommerce`.

## 8. Segunda correção — alinhar `30.72`/`72.453` à arquitetura de log das demais cópias

Ver spec.md, seção 10. Abordagem: em vez de criar um mecanismo novo (backfill de `LOG_CODITE` via `UPDATE` após o código do item ser gerado), alinhar `30.72` e `72.453` à estrutura já usada em `74.150`/`74.111`/`74.150.45`/`74.150.100`, onde `pGravaLogAlteracao(qryTabela)` só roda em Alteração (nunca em Inclusão).

**Arquivo impactado (adicional):** `padra_atualizado/fontes/cadastros/untCadProdutos.pas` (classe `TfrmCadProdutos`), nas duas cópias `379.48.2.30.72` e `72.Fechadas\379.48.2.30.72.453`.

**Sequência de implementação:**
1. Em `fGravaItem`, comentar (não remover) o bloco:
   ```pascal
   If fCfgSis('LOGCPR', VarBoolean) Then
     TLogAltCadIte.pGravaLogAlteracao(qryTabela);

   If fCfgSis('LOGCPR', VarBoolean) and ((fCfgSis('TIPABF') = '2') Or (fCfgSis('TPABPC') = '2')) Then
     TLogAltCadIte.pGravaLogAlteracao(qryIteGer, fCfgSis('TIPABF'), fCfgSis('TPABPC'));
   ```
   (chamado hoje antes de `inherited pGravaRegistro`) — mesma convenção de comentário já usada nas outras 4 cópias para esse mesmo bloco.
2. Em `qryTabelaOnBeforePost`, acrescentar as variáveis locais `strNomeCampo`, `strValorAtual`, `strValorAntigo` (inicializadas em branco) e, após o bloco existente de `TAltDes.pSalvaLog`, inserir:
   ```pascal
   If fCfgSis('LOGCPR', VarBoolean) Then
   Begin
     TLogAltCadIte.pGravaLogAlteracao(qryTabela);

     If qryIteGer.FieldByName('ITE_IMPLIS').Value <> qryIteGer.FieldByName('ITE_IMPLIS').OldValue Then
     Begin
       strNomeCampo := 'Imprime Lista';
       strValorAntigo := String(qryIteGer.FieldByName('ITE_IMPLIS').OldValue);
       strValorAtual := String(qryIteGer.FieldByName('ITE_IMPLIS').Value);

       TLogAltCadIte.pGravaLogAlteracaoIndividual(dbeCodIte.text, strNomeCampo, strValorAntigo, strValorAtual);
     End;

     If ((fCfgSis('TIPABF') = '2') Or (fCfgSis('TPABPC') = '2')) Then
       TLogAltCadIte.pGravaLogAlteracao(qryIteGer, fCfgSis('TIPABF'), fCfgSis('TPABPC'));
   End;
   ```
   texto idêntico ao já existente nas outras 4 cópias no mesmo evento. Como o evento inteiro sai (`Exit`) quando `blnInserindo = True` (guarda já existente na primeira linha do evento), esse bloco nunca executa em Inclusão — eliminando o cenário de `LOG_CODITE` em branco sem precisar tocar em `untPaiCad.pas`.
3. Validar com `corrigeUnitFlipCRLF-LF` que o `svn diff` de `untCadProdutos.pas`, em ambas as cópias, contém só as mudanças pretendidas (sem ruído de EOL/encoding).

**Risco:** itens incluídos por essas duas cópias deixam de gerar qualquer linha em `LOGCPR` (mesmo comportamento das outras 4 cópias — não é regressão introduzida por este requisito, é a paridade explicitamente pedida pelo usuário).
