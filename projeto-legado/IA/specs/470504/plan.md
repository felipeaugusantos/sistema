# Plano de Execução — Req. 470504

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Ajustes localizados em `UpdateMasterCheckbox` (VCL + DevExpress cxGrid master-detail):
- **Nota 1:** se `FocusedRecordIndex < 0`, `Exit` antes de consultar relação/detalhe (aplicado no projeto aberto).
- **Nota 3:** usar o mestre do lote clicado (`FindRecordIndexByKey` por `CHAVE_MASTER` do detalhe corrente) em vez do focado (validado em log, só na `.12`).
- **Nota 4:** guardar bookmark do mestre antes do `Locate`/`Post` e voltar com `GotoBookmark` (com `DisableControls`). Ver 2.0, insuficiente para o foco.
- **Pendente:** tratar o `pSelecionar(False)` do checkbox do pai (grava no registro do cursor, não no clicado) e o repaint dos pais após Marcar/Desmarcar Todos.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untMovimentacaoProgramadaManual | padra_atualizado\fontes\movimentacaoitens\ | alterar |
| untGridSafety | padra_atualizado\fontes\genericos\ | nenhuma (só leitura) |

## 3. Sequência de implementação
1. Testar a ver 2.1 na cópia `.12` (logs de clique em Marcar/Desmarcar Todos, PropertiesChange do pai e pSelecionar).
2. Definir a correção do clique no pai e do repaint dos pais.
3. Validar com log e tela na `.12`.
4. Aplicar a correção limpa no projeto aberto (Notas 1, 3, 4 conforme a validação), sem LOGDIAG.
5. Reverter a `.12`.
6. Gerar a análise do requisito com as Notas.

## 4. Conformidade com padrões do projeto
- Zona Legado: Hungarian, prefixos `p`/`f`/`F`; sem número do requisito em identificadores.
- Chamadas do projeto: `fNow()`, `fMensagem()`, `pSetFocus()`.
- Pre-commit: sem componentes ou chamadas proibidas.

## 5. Estratégia de testes
- Sem suíte DUnit para a tela; validação manual guiada por log temporário na `.12`.
- Casos: carregar; filtro "começa com D"; expandir 19932; marcar/desmarcar lote; clicar no pai; Marcar/Desmarcar Todos; com e sem filtro; mouse-over sem erro.

## 6. Riscos e mitigação
- Foco da grade desacoplado do cursor do dataset → não usar `Locate`/`RecNo` sem restaurar; validar por log.
- Guard da Nota 1 parece redundante → não remover (Nota registrada na análise).
- Escopo → não corrigir outros defeitos junto; relatar.
