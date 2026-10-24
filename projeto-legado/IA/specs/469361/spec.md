# Especificação — Req. 469361

**Título:** Colunas cortadas no grid da digitação multi-lojas (EntDigMultiLojasNovo)
**Objetivo:** Garantir que a barra de rolagem horizontal do grid `cxgItensView` alcance todas as colunas visíveis.
**Zona:** Legado (`padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/`)
**Data:** 14/10/2026

## 1. Contexto / problema atual
Na tela `frmEntDigMultiLojasNovo` (`untEntDigMultiLojasNovo.pas`) o grid `cxgItensView` (`TcxGridDBBandedTableView`) tem duas
bandas ("Empresa", fixa à esquerda, e "Informações do Item") e cerca de 130 colunas, das quais 52 a 82 ficam visíveis.
Mesmo com a barra de rolagem horizontal, ao rolar até o fim as últimas colunas não eram exibidas.

O layout do grid é salvo por operador na tabela `CFGPDC` (`StoreToIniFile`) e restaurado com `RestoreFromIniFile` em
`untCdsDigMultLoja.pas`. O ini guarda a largura de cada banda; ao restaurar, a banda deixa de ser automática (`Width = 0`) e
fica com largura fixa. Depois disso, `FormShow` e `TCdsDigMultLoja.pAjustaConfigs` mostram/escondem colunas e a banda 0,
e a largura fixa da banda não acompanha. Medido em log: banda 1 com `Width` 3187 contra 4221 de colunas visíveis; banda 0 com
408 contra 453. A rolagem horizontal usa a largura da banda, então ~8-9 colunas finais ficavam inacessíveis.

## 2. Módulos e entidades envolvidos
- Módulo: movimentação de itens / pedido de compra (digitação multi-lojas).
- Units: `untEntDigMultiLojasNovo.pas` (+ `.dfm`) e `untCdsDigMultLoja.pas` (em `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/`);
  `untCfgGrid.pas` (em `padra_atualizado/fontes/genericos/`, compartilhada por várias telas).
- Tabela: `CFGPDC` (configuração salva do grid por operador; apenas lida/gravada, sem alteração de estrutura).

## 3. Requisitos funcionais
- RF01 — A rolagem horizontal do grid deve alcançar a última coluna visível, em qualquer combinação de colunas/bandas visíveis.
- RF02 — O comportamento deve valer com tela ancorada no painel, em janela, maximizada e após "Restaurar padrão".
- RF03 — O menu do `btnFuncoes` deve oferecer "Restaurar Padrão" (removido na r376938, Req. 337789), sempre visível, no pedido
  de compra e na cotação (tela compartilhada). A ação pede confirmação antes de apagar o layout salvo.
- RF05 — "Restaurar Padrão" com a tela ancorada não pode deixar a instância anterior do form viva na memória.
- RF06 — "Restaurar Padrão" apaga só o layout do modo em uso (`CFG_NOMGRI` = `TELMUL` ou vazio), nunca o do outro modo.
- RF07 — O form recriado por "Restaurar Padrão" mantém `strEmpCalc` (rodapé e destaque das empresas fora do cálculo).
- RF04 — A janela "Configura Colunas" não deve listar colunas sem título (`Caption` e `AlternateCaption` vazios).

## 4. Regras de negócio
- RN01 — A configuração salva do operador (visibilidade e ordem de colunas) continua sendo respeitada; só a largura das bandas
  deixa de ser fixa.
- RN02 — A largura da banda deve ser sempre automática (`Width = 0`), acompanhando as colunas visíveis.

## 5. Requisitos técnicos / não-funcionais
- Sem alteração de banco e sem impacto fiscal/financeiro.
- Fontes em cp1252/CRLF: edição apenas via Python com encoding explícito.
- Sem componentes/chamadas proibidos pelo pre-commit.

## 6. Critérios de aceitação
- [x] Com configuração salva restaurada e tela ancorada, a rolagem exibe todas as colunas visíveis.
- [x] Bandas permanecem com largura automática após `FormShow` e `pAjustaConfigs`.
- [x] "Restaurar Padrão" visível no `btnFuncoes` no pedido de compra e na cotação, com confirmação (validado na 74.150.45).
- [x] "Configura Colunas" sem linhas em branco (validado na 74.150.45).
- [x] "Restaurar Padrão" ancorado libera a instância anterior (`Release`).
- [ ] Validar nas cópias 74.150 e 74.150.100 após compilar.

## 7. Fora de escopo
- Alterar o formato do ini salvo em `CFGPDC` ou apagar configurações existentes.
- Usar `TGridConfigManagerDB` (não é utilizado por esta tela).
- Reativar o ajuste comentado em `cxgItensViewColumnSizeChanged` / `fGetWidthBand`.

## 8. Dependências e riscos
- Dependência: `RestoreFromIniFile` é executado antes dos pontos onde a largura é resetada.
- Risco: remover uma das duas chamadas de `pAutoLarguraBandas` reintroduz o problema em algum fluxo de abertura.
- Risco: o filtro de colunas sem título em `TCfgGrid.pAjustaColunas` vale para todas as telas que usam `TCfgGrid` com grid em
  banda.
