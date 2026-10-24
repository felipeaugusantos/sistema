# Plano de Execução — Req. 466702

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Alteração localizada em um único form VCL (`TfrmCalNivGirEstFornecGrid`, herdeiro de `TfrmPai`). `fGravaMarkup` recebe o ramo `Else If` do RF07 e a proteção de reentrada/`Try/Finally`; o ramo B e a gravação do `ITEGER` não mudam.

1. **Validação em `btnGraMkp`:** nova função privada `fExisteTabelaMarcada: Boolean` percorre `chkTabelasAtivas.Items`; retorna `True` se a lista estiver vazia (nada a marcar) ou se algum item estiver marcado. `btnGraMkpClick` chama a validação logo após o `Post` pendente e antes do `fPergunta`; se falhar, mostra mensagem, `pSetFocus(chkTabelasAtivas)` e sai.
2. **Progresso em `pMarcaDesmarca`:** seguir o padrão já usado em `fGravaNivelGiro`/`fGravaMarkup` na mesma unit: `DisableControls` + `prgProgresso.Max := RecordCount`, `Position := 0`, `Visible := True`; a cada registro `prgProgresso.StepBy(1)` e `Application.ProcessMessages`; no `finally` restaurar `BeforePost`, ocultar a barra e `EnableControls`.
3. **`ATUPRO = 0` (RF07):** em `fGravaMarkup`, ligar um `Else If fCheckedLista(i) And (ITE_TABPRi = strCodTab)` ao `If ATUPRO = 1` do ramo A, chamando `fAtualizaDetCus` com os mesmos argumentos do ramo A (margem e `ITE_PREVEi × CNVCUS`) e sem tocar `ITEGER`/`blnPrealt`.
4. **Reentrada:** como `ProcessMessages` permite novo F5/F6 durante o laço, proteger `pMarcaDesmarca` com campo privado de controle (`FblnProcessando`), saindo imediatamente se já estiver em execução e limpando o campo no `finally`.

5. **Proteção de reentrada ampliada (revisões):** par `pIniciaProcessamento`/`pFinalizaProcessamento` (flag `FblnProcessando` + trava de `cxgItens`/`chkTabelasAtivas` + foco ao grid) em `pMarcaDesmarca`, `fGravaMarkup`, `btnGravarClick`, `btnInfMkpClick` e `pGeraExcel`; guards nos handlers `btnGraMkpClick`, `btnGravarClick`, `btnExcelClick`, `btnInfMkpClick`; `CloseQuery` override retornando `False` durante o processamento.
6. **`Try/Finally` (revisões):** `fGravaMarkup`, `fGravaNivelGiro`, `fCompletaMarkup` e `pGeraExcel` restauram barra, `EnableControls` e flag em `Finally`; `Result := Result And fAtualizaIteger(...)`; rótulo do `pMensagensErro` de `fCompletaMarkup` corrigido.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untCalNivGirEstFornecGrid.pas | padra_atualizado/fontes/movimentacaoitens/ | alterar |
| untCalNivGirEstFornecGrid.dfm | padra_atualizado/fontes/movimentacaoitens/ | sem alteração |

## 3. Sequência de implementação
1. Confirmar o encoding da unit (cp1252) e usar Python para toda edição.
2. Ler `btnGraMkpClick` (≈ linha 837), `pMarcaDesmarca` (≈ linha 636), `fCheckedLista` (≈ linha 1280) e o uso de mensagens/`pSetFocus` na unit para imitar o padrão local.
3. Declarar `fExisteTabelaMarcada` e o campo `FblnProcessando` na seção privada da classe.
4. Implementar `fExisteTabelaMarcada` e inserir a validação em `btnGraMkpClick`.
5. Reescrever `pMarcaDesmarca` com `DisableControls`, progresso, `ProcessMessages` e proteção de reentrada, mantendo a regra de `ATUPRO` idêntica.
6. Comentário curto no fonte onde houver decisão não óbvia (reentrada, validação antes da pergunta), sem número de requisito no identificador.
7. Validar: arquivo decodifica em cp1252, sem U+FFFD, `svn diff` contendo só as mudanças pretendidas, sem flip de CRLF/LF.

## 4. Conformidade com padrões do projeto
- Zona Legado: Hungarian (`FblnProcessando`, `blnMarca`), prefixos `p`/`f`, herança `TfrmPai` mantida.
- Componentes: nenhum componente novo; `prgProgresso` e `chkTabelasAtivas` já existem no form.
- Chamadas: `pSetFocus(chkTabelasAtivas)` (nunca `.SetFocus`), mensagem pelo helper já usado na unit (`pMensagemOk`/`fMensagem`), sem `ActiveControl :=`, sem `Now`/`StrToFloat`.
- Lógica fora do `OnClick`: validação em função própria, `btnGraMkpClick` só delega.
- `try/finally` obrigatório para restaurar `BeforePost`, `EnableControls`, barra e flag de reentrada.
- Pre-commit: sem componentes/chamadas/SQL proibidos; sem alterações em `.dfm`.

## 5. Estratégia de testes
- Não há suite DUnit aplicável (form VCL com dependências de dados); validação manual com a rotina Nível de Giro por Fornecedor (fornecedor 00001756, tabela 005861, base AUTCOM).
- Casos:
  1. Nenhuma tabela marcada → mensagem, foco no `chkTabelasAtivas`, nada gravado.
  2. Tabela 1 marcada → grava; conferir `DETCUS` tabela 1 do item 90013 e `LOGREP`.
  3. Lista vazia (cliente sem tabelas de venda ativas) → não bloqueia.
  4. F5 / F6 com carga grande → barra avança, janela responde, ao final barra oculta e controles voltam.
  5. F5 repetido durante o processamento → não inicia segundo laço.
  6. Exceção simulada durante o laço → `BeforePost`, barra e controles restaurados.
  7. Regressão: `ATUPRO` resultante idêntico ao anterior (itens sem `ITE_TABPR` igual à tabela escolhida ficam em 0).

## 6. Riscos e mitigação
- Bloqueio de quem gravava sem marcar nada → mudança intencional; mensagem clara orientando a marcar a tabela.
- Reentrada por `ProcessMessages` → proteção `FblnProcessando` (par `pIniciaProcessamento`/`pFinalizaProcessamento` em `Finally`) cobrindo F5/F6, botões, grid, `chkTabelasAtivas` e `CloseQuery`.
- Exceção relançada por `pMensagensErro` deixando barra/controles/flag presos → `Try/Finally` externo nas rotinas de gravação.
- `fGravaMarkup` sem transação (pré-existente) → apenas registrado no .md, fora do escopo.
- Overhead de `ProcessMessages` a cada registro em cargas enormes → seguir o padrão da unit; se medido como lento, chamar a cada N registros.
- Corrupção de acentos por resave em UTF-8 → edição só via Python em cp1252 e validação de bytes `\xef\xbf\xbd`.
- Regressão de `ATUPRO` → manter a lógica interna do laço inalterada; só envolver com progresso/controle.
