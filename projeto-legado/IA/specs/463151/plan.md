# Plano de Execução — Req. 463151

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Correção pontual, sem alteração de arquitetura, dentro de uma única procedure da Zona Legado. A estratégia é trocar o mecanismo de navegação do laço de replicação de "avanço por posição relativa" (`Dataset.Next`) para "reposicionamento por chave estável" (`Dataset.Locate`), sobre uma lista de chaves capturada antecipadamente:

1. Antes de qualquer alteração, percorrer o `Dataset` uma única vez (`First`/`Next` até `Eof`) apenas para coletar os `ITE_CODITE` de todos os itens do lote numa `TStringList`.
2. Iterar essa lista fixa com um `For`, reposicionando o `Dataset` a cada item via `Dataset.Locate('ITE_CODITE', <codigo>, [])`.
3. Manter inalterado o restante da lógica por item: filtro de grupo de preço (`strGrupoPrecoReplica`/`ITE_CODGPR`), chamada a `pAlterarPrecoMargem`, reposicionamento de `DataSetPrecos.RecNo`, atualização de `pgbStatus` e `Application.ProcessMessages`.

Isso garante que a ordem/composição do lote processado é imune a qualquer reordenação que o próprio recálculo de preço cause no dataset de itens durante a execução do laço — incluindo reordenações que só passam a ocorrer "ao vivo" por causa do `Application.ProcessMessages` já existente (Req. 461662).

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untLotePrecos.pas | `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas` | alterar (`TLotePrecos.pReplicaPrecoParaItens`) |

Nenhum outro arquivo/unit precisa ser tocado: `pAlterarPrecoMargem`, `fReplicaPrecoParaItensPrg`, `TfrmGravando` e o restante do fluxo de responsividade permanecem exatamente como estão.

## 3. Sequência de implementação

1. Diagnosticar a causa raiz com instrumentação temporária (log local, nunca commitado) em `pAlterarPrecoMargem` e `pReplicaPrecoParaItens`, cobrindo: entrada/saída de cada validação, valor aplicado, e estado de navegação do `Dataset` (`RecNo`/`RecordCount`/`Bof`/`Eof`) a cada iteração.
2. Validar em teste real (documento com 30 itens) que o `RecNo` do item recém-processado muda de posição durante a própria chamada de `pAlterarPrecoMargem`, antes do `Next` seguinte.
3. Localizar a origem do `Application.ProcessMessages` nesse laço via `svn log`/`svn diff` das últimas revisões do arquivo — confirmado como introduzido na r494484 (Req. 461662).
4. Reescrever `pReplicaPrecoParaItens`: declarar `lstCodItens: TStringList` e `intIdx: Integer`; substituir o laço `While not Dataset.Eof do ... Dataset.Next` por (a) coleta de `ITE_CODITE` antes de processar, e (b) `For` sobre essa lista com `Dataset.Locate` a cada item, dentro de `Try/Finally` para liberar a `TStringList`.
5. Validar integridade do arquivo (`cp1252`, ausência de `\xef\xbf\xbd`, contagem de CRLF) após a edição.
6. Retestar em cenário real: alterar frete e replicar (regressão do bug original) e alterar preço de venda/margem e replicar (regressão do que já funcionava).
7. Remover toda a instrumentação de diagnóstico temporária, deixando no fonte apenas a correção definitiva e seu comentário curto.

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian style mantido (`lstCodItens`, `intIdx`); nenhuma refatoração fora do escopo da correção.
- Componentes/chamadas: nenhum componente ou chamada proibida introduzida — `TStringList` e `TDataSet.Locate` são recursos padrão já usados em outros pontos da mesma unit (ex.: `TfrmLotePrecosEfetivacaoCx.pAtualizarValorDoPrecoDeVendaDosItensSelecionados`, Req. 460063, já usa o mesmo padrão `Locate` por chave).
- Sem SQL tocado, sem alteração de transação.
- Pre-commit: nenhum padrão proibido (`TButton`/`TDBGrid`/`Now()`/`StrToFloat`/etc.) envolvido nesta correção.

## 5. Estratégia de testes

- Não há suite DUnit cobrindo este fluxo (Ativação de Lote de Preços / replicação em massa).
- Validação manual em cenário real, já executada nesta sessão:
  - Documento com 30 itens: alterar frete (FREENT) no item 43481 e marcar replicar — antes da correção, apenas 3 itens recebiam o valor (43446, 43481, 43465); depois da correção, os 30 itens recebem o valor.
  - Mesmo documento: alterar margem/preço de venda (MARBR1) e replicar — os 30 itens continuam recebendo o valor corretamente (sem regressão).
- Recomendação para o futuro (fora do escopo de implementação deste requisito): considerar um teste de integração/unitário para `pReplicaPrecoParaItens` que simule reordenação do dataset entre chamadas, caso a suite `AutcomTestesClientes.groupproj` venha a cobrir este módulo.

## 6. Riscos e mitigação

- **Risco:** dataset de itens deixar de expor `ITE_CODITE` no futuro → `Locate` falha silenciosamente (item pulado, RN03). **Mitigação:** `ITE_CODITE` já é chave funcional amplamente usada na mesma unit; qualquer remoção seria um breaking change detectável em outros pontos primeiro.
- **Risco:** lotes muito maiores (milhares de itens) tornarem o `Locate` por item mais custoso que `Next`. **Mitigação:** não observado nos testes reais (30 itens, resposta instantânea); average esperado dos lotes reais do cliente é de dezenas a poucas centenas de itens (mesma ordem de grandeza do Req. 461662, que tratou lotes de ~270 itens).
- **Risco:** reintroduzir o travamento "tela não responde" ao mexer no laço. **Mitigação:** `Application.ProcessMessages` e a atualização de `pgbStatus` foram mantidos exatamente como estavam, apenas o mecanismo de navegação foi trocado.
