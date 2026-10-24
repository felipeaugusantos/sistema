# Plano de Execução — Req. 462383

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Ajuste pontual e aditivo em duas units já existentes — sem criar função nova nem tocar em `untEntNfeXml.pas` (o método `TNFeXml.fExisteNotaEntradaChaveNFE` é uma implementação separada, sem relação com este fluxo).

1. `untFuncoesSimples.pas` — adicionar dois parâmetros booleanos opcionais (`blnFiltraFornecedor: Boolean = True`; `blnFiltraSomenteEntrada: Boolean = False`) à função global `fExisteNotaEntradaChaveNFE`, tornando condicionais as cláusulas `FIS_TIP_FC = "F"` e `FIS_ENTSAI = "E"` na query.
2. `untRecTransfEstoque.pas` — atualizar a chamada existente (linha ~9340) para `fExisteNotaEntradaChaveNFE(strAcesso, strDocume, False, True)`.

Os demais chamadores (`untEntradaAutomatizada.pas`, `untEntDadosFiscaisResumo.pas`) não são alterados — continuam usando os defaults, que reproduzem exatamente o comportamento atual.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untFuncoesSimples.pas` | `padra_atualizado/fontes/genericos/untFuncoesSimples.pas` | Alterar — assinatura (linha 1618, declaração da interface) e implementação (linha 59718) de `fExisteNotaEntradaChaveNFE` |
| `untRecTransfEstoque.pas` | `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas` | Alterar — chamada na linha ~9340 |

## 3. Sequência de implementação

1. Em `untFuncoesSimples.pas`, atualizar a declaração da função (linha 1618) para incluir os dois parâmetros opcionais.
2. Na implementação (linha 59718), envolver `Add('  AND FIS_TIP_FC = "F" ');` em `If blnFiltraFornecedor Then` e adicionar `If blnFiltraSomenteEntrada Then Add('  AND FIS_ENTSAI = "E" ');`, mantendo a cláusula base (`FIS_ACESSO = :ACESSO AND FIS_CODEMP = :CODEMP`) inalterada.
3. Em `untRecTransfEstoque.pas`, ajustar a chamada em `If fExisteNotaEntradaChaveNFE(strAcesso, strDocume) Then` para `If fExisteNotaEntradaChaveNFE(strAcesso, strDocume, False, True) Then`.
4. Conferir encoding do arquivo (`.pas` em Windows-1252/latin1) antes de gravar — usar Python com `encoding='cp1252'`, nunca a ferramenta de edição direta, para não corromper acentuação (comentários/mensagens em português no arquivo).
5. Validar manualmente reproduzindo o cenário do requisito (NF `000000017097`, série `001`, empresa `400`) em ambiente de homologação.

## 4. Conformidade com padrões do projeto

- Zona Legado: manter Hungarian style (`bln`, `str`) já usado nos parâmetros existentes da unit.
- SQL: `ParamByName()` já em uso — nenhuma concatenação de valor de usuário introduzida.
- Nenhum componente ou chamada proibida envolvida (só lógica de query condicional).
- Parâmetros opcionais com default preservam compatibilidade binária/comportamental com os demais chamadores — não é necessário alterar `untEntradaAutomatizada.pas` nem `untEntDadosFiscaisResumo.pas`.

## 5. Estratégia de testes

- Não há suíte DUnit cobrindo este fluxo (Entrada Simplificada / transferência entre lojas).
- Validação manual em homologação:
  1. Reconfirmar a NF `000000017097` (ou outro documento com entrada já efetivada e `FIS_TIP_FC = 'C'`) na Entrada Simplificada — deve exibir o prompt de baixa de pedido, não gerar nova entrada.
  2. Confirmar uma NF nova (chave de acesso inédita) — deve seguir o fluxo normal, sem falso-positivo.
  3. Confirmar um documento cuja checagem antiga por Fornecedor (`FIS_TIP_FC = 'F'`) já funcionava — comportamento inalterado nos outros dois chamadores (rodar um caso de entrada automatizada e um de digitação manual, se houver ambiente para isso).

## 6. Riscos e mitigação

- **Risco:** confundir esta função global (`untFuncoesSimples.fExisteNotaEntradaChaveNFE`) com o método homônimo `TNFeXml.fExisteNotaEntradaChaveNFE` em `untEntNfeXml.pas` (implementação diferente, não relacionada) → mitigado por esta análise já ter isolado e documentado a distinção; nenhuma alteração planejada nesse método.
- **Risco:** algum chamador futuro assumir que a função sempre filtra por `FIS_TIP_FC = 'F'` → mitigado mantendo o default `True`, que preserva o comportamento documentado hoje.
- **Risco residual:** chave de acesso vazia (nota ainda sem retorno da SEFAZ) continua sem proteção por este critério — comportamento já existente, fora do escopo desta correção (ver spec.md, seção 7).

## 7. Complemento — cópia `379.48.2.30.74.150` (`pAddListaQuery`)

Ver spec.md, seção 9 (RF05-RF14), para o contexto completo. Estado final desta cópia, em `untRecTransfEstoque.pas` e `untRecTransfEstoqueDevolucao.pas` (a implementação passou por várias rodadas de revisão nesta sessão — cópia mecânica de `fGeraEntrada`, correções pontuais, extração para método compartilhado, achados adicionais; só o resultado final é descrito aqui):

1. Novo método privado `TfrmRecTransfEstoque.pPreparaFlagsDevolucao` (RF11) — declarado logo após `fChecaChaveAcesso`, implementado logo antes de `fGeraEntrada`. Var local `LObjRecTransfEstoqueDevolucao: TRecTransfEstoqueDevolucao`. Corpo: reset de `FblnDevolu`, `FstrEmpresaDevolucao`, `FstrEspecieDevolucao`, `FstrDocumentoDevolucao` e `FstrAutIncVenda` (RF12); bloco `If SameText(cdsConsulta.FieldByName('TIPSEN').AsString, 'DEVOLU') Then` (RF09), instanciando `TRecTransfEstoqueDevolucao.fNovo` e populando as flags via API fluente (`fAutoIncremeto` → `fExecutar` → `fEntradaDevolucao` → `fEmpresaDevolucao` → `fEspecieDevolucao` → `fDocumentoDevolucao` → `fAutoincrementoVenda`), liberando o objeto em `Finally`/`FreeAndNil` (RF08).
2. `pAddListaQuery`: var section com `strCodCli : String` (a `LObjRecTransfEstoqueDevolucao` local foi removida — vive só no método compartilhado); `Begin` chama `pPreparaFlagsDevolucao;` seguido de `FstrFatGor := '';` (RF14) no lugar do reset/bloco `TIPSEN` inline.
3. Antes da chamada a `fRetChaveAcesso` em `pAddListaQuery`: `strCodCli` calculado com a mesma regra de `fChecaChaveAcesso` (`GER_CODCLI` → fallback `GER_CODFOR` se vazio → força `GER_CODFOR` se `FblnDevolu`).
4. Chamada a `fRetChaveAcesso` em `pAddListaQuery`: `strCodCli` no lugar de `FieldByName('GER_CODCLI').AsString` (3º parâmetro) e `IIF(FblnDevolu, 'F', 'C')` como novo 6º parâmetro (`strTipFC`), para casar com o tipo real do código informado em `strCodCli`.
5. `fGeraEntrada`: a variável local `LObjRecTransfEstoqueDevolucao` e o bloco de reset/`TIPSEN` inline foram removidos; `Begin` chama `pPreparaFlagsDevolucao;` seguido de `FstrFatGor := '';` (já existia neste método, RF10).
6. `untRecTransfEstoqueDevolucao.pas`, `TRecTransfEstoqueDevolucao.fExecutar`: removido o `Try ... Except raise; End;` que envolvia todo o corpo (RF13) — sem código entre `Except` e `raise;`, era equivalente a não ter `Try/Except`, só adicionava um frame de exceção na pilha.

**RF08 — por que `FreeAndNil` e não `pFreeAndNil`:** `pFreeAndNil` (`genericos/untFuncoesSimples.pas`, a unit resolvida no `uses` de `untRecTransfEstoque.pas`) é uma rotina para liberar formulários (`TForm`): dentro do `Try/Except`, além de tentar `FreeAndNil`, chama `pTrimAppMemorySize` e, se a aplicação não estiver finalizando, `pProcessMessages(True)` — que executa `Application.ProcessMessages` incondicionalmente. O objeto não é `TForm`; bombear a fila de mensagens do Windows dentro do `Finally` de um fluxo de negócio cria risco de reentrância (ex.: duplo clique disparando execução concorrente), e exceções na destruição do objeto ficam só logadas em arquivo, não sinalizadas ao fluxo. O padrão já existia em `fGeraEntrada` antes desta sessão (copiado mecanicamente para `pAddListaQuery`); corrigido nos dois pontos e depois unificado no método compartilhado (RF11).

**RF11 — por que extrair:** as duas invocações (`fGeraEntrada` e `pAddListaQuery`) eram cópias literais uma da outra — mesmo reset, mesmo bloco `TIPSEN`, mesma API fluente. Deixar duplicado significa que qualquer correção futura (como RF08/RF09/RF12 desta própria sessão) precisa lembrar de tocar os dois lugares; um método privado único remove esse risco. `FstrFatGor` foi deliberadamente deixado fora do método compartilhado (RF10) por ser exclusivo de `fGeraEntrada`.

**RF12 — por que resetar `FstrAutIncVenda`:** o único ponto que lê esse campo (`untRecTransfEstoque.pas`, linha ~3058, dentro de `fCarregaClienteConsumidor`) já está sob `If FblnDevolu Then`, e `FblnDevolu` é sempre resetado corretamente — então hoje não há bug ativo. Mas sem o reset explícito, o campo depende inteiramente dessa segunda guarda para nunca expor um valor de uma execução anterior; um consumidor futuro sem essa mesma checagem falharia silenciosamente. Reset por defesa, sem mudança de comportamento observável.

**RF14 — por que resetar `FstrFatGor` também em `pAddListaQuery`:** `FstrFatGor` fica fora do método compartilhado por não ser flag de devolução (RF10), mas isso não significa que `pAddListaQuery` deva ignorá-lo — `fGeraEntrada` sempre resetou esse campo isoladamente, e `pAddListaQuery` nunca resetou, deixando-o sujeito a reter valor de um documento anterior entre confirmações. Corrigido replicando exatamente o `FstrFatGor := '';` de `fGeraEntrada`, logo após `pPreparaFlagsDevolucao;`, sem movê-lo para dentro do método compartilhado.

**Validação:** cada gravação feita por substituição de texto exato via Python (round-trip `encoding='latin1'`, preservando `\r\n` — o arquivo `untRecTransfEstoqueDevolucao.pas` tinha uma linha com terminador `\n` isolado em meio ao `\r\n` predominante, tratado por localização de linha em vez de substituição de bloco de texto exato), conferida com `svn diff` mostrando apenas os hunks pretendidos.

**Achado investigado e descartado:** `fGravaAgendamentoDeRecebimento` (não `fGeraEntrada` — correção de atribuição) também chama `fRetChaveAcesso` (linha ~2548) com `GER_CODCLI` fixo e sem o 6º parâmetro, o que pareceria à primeira vista a mesma classe de problema do RF06/RF07. Porém `fGravaAgendamentoDeRecebimento` começa com `If not fGeraAgendamento Then Exit(True);`, e `fGeraAgendamento` (linha 2367-2371) já retorna `False` quando `FblnDevolu` (`Result := ... And (Not FblnDevolu)`, com o comentário original "`FblnDevolu = True, a gravação vai ser com CODCLI, logo não existe plano de recebimento`"). Ou seja, para documentos de devolução a função sai em `Exit(True)` antes de chegar à linha 2548 — o trecho com `GER_CODCLI` fixo é código morto nesse caso e só executa no fluxo normal por fornecedor, onde `GER_CODCLI` fixo e o default `strTipFC='C'` já são coerentes. Não há inconsistência real aqui; nenhuma correção necessária neste ponto.
