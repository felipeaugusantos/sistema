# Plano de Execução — Req. 463909

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Ajuste pontual de condição booleana em function nested já existente, seguindo o idioma já usado no restante da unit para identificar fornecedor filial (`Pos(strCodFor, strForFil) > 0`, mesmo padrão de linhas como 7000, 11570 e 15051 de `untPcmGer.pas`, comentadas `// Fornecedor Filial`).

`strForFil` já é uma variável local de `fConfirmaEntradaMercadorias`, atribuída em `strForFil := fRetForFilialTodos;` (linha ~4892), e `strCodFor` é parâmetro da mesma function — ambos já visíveis no escopo da nested function `fBaixaPedidosEntrada` sem necessidade de novo parâmetro.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untPcmGer.pas | `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas` | alterar |

## 3. Sequência de implementação

1. Localizar a condição em `fConfirmaEntradaMercadorias.fBaixaPedidosEntrada` (linha ~4683):
   ```pascal
   If (Not fZeraDataEntrada(ValidacaoZeraData)) or (blnGarantia) Then
   ```
2. Alterar para:
   ```pascal
   If (Not fZeraDataEntrada(ValidacaoZeraData)) or (blnGarantia) or ( fZeraDataEntrada(ValidacaoZeraData) and (Pos(strCodFor, strForFil) > 0) ) Then
   ```
   Na cópia `379.48.2.30.74.150.48` (versão anterior à refatoração de `fZeraDataEntrada`, que usa `blnConferenciaDepoisDaEntrada`), a alteração equivalente é:
   ```pascal
   If (Not blnConferenciaDepoisDaEntrada) or (blnGarantia) or (blnConferenciaDepoisDaEntrada and (Pos(strCodFor, strForFil) > 0)) Then
   ```
3. Editar via Python, lendo/gravando com encoding explícito `cp1252` (arquivo `.pas` legado) — nunca via ferramenta `Edit` genérica, para não corromper acentuação do restante do arquivo.
4. Validar após a edição: o arquivo decodifica sem erro em cp1252 e não contém a sequência `\xef\xbf\xbd` (sinal de corrupção).

## 4. Conformidade com padrões do projeto

- Zona Legado: manter Hungarian style e estilo já existente na function — sem refatorar trechos não relacionados.
- Nenhum componente ou chamada proibida (`TButton`, `TDBGrid`, `StrToFloat`, `.SetFocus`, `Application.CreateForm`, `NOW()`, concatenação SQL) está envolvida nesta alteração.
- Edição de arquivo `.pas` em cp1252 realizada via Python, não via `Edit`.

## 5. Estratégia de testes

- Não há suite DUnit automatizada cobrindo este fluxo de entrada/baixa de pedido de compra nas suítes existentes (`AutcomTestesClientes.groupproj` cobre regras tributárias, não movimentação/estoque).
- Validação funcional manual, reproduzindo o cenário do ticket:
  1. Emitir TE de empresa origem para empresa destino com fornecedor configurado como filial.
  2. Confirmar a TE em NF (importação de XML) na empresa destino.
  3. Dar entrada em um dos documentos (TE ou NF) via Entrada Simplificada.
  4. Verificar que o pedido de compra vinculado já foi baixado no momento da entrada (não aparece mais pendente de baixa na Efetivação do Movimento Fiscal).
  5. Verificar que a entrada do documento remanescente não gera duplicidade de estoque.
- Validar adicionalmente outros fluxos de entrada de fornecedor filial (não relacionados a TE/NF) para confirmar ausência de regressão, especialmente cenários com `blnConferenciaDepoisDaEntrada`/CFG_CLARET.

## 6. Riscos e mitigação

- Risco: antecipar a baixa do pedido de compra para todo fornecedor filial pode alterar comportamento de fluxos de entrada de filial que hoje dependem da baixa deferida (ex.: conferência pós-entrada com CFG_CLARET) → Mitigação: validar com o solicitante (Lucas) outros cenários de entrada de fornecedor filial além do caso TE/NF, antes de liberar em produção.
- Dependência: correção pressupõe que `strForFil` (via `fRetForFilialTodos`) esteja corretamente parametrizado para identificar fornecedores filiais no cliente Montanna Distribuidora.
