# Plano de Execução — Req. 462720

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Dois ajustes pontuais e independentes, aplicados nas três working copies:

1. **Guard em `fCarregaItensPedidoAux`** (`untPedidoCompra.pas`): remover a restrição `(Not blnUsarGiro) And (Not blnAltPedGir)` do guard que antecede a chamada a `pCarrregaDadosGiro`. Mantém-se apenas `recOpcGir.strPedMlj <> 'S'`, replicando o padrão já aplicado (e deixado comentado como pista) na função irmã `fAdicionaItem`.
2. **`FIL_AGRUPA`/`FIL_CODPRI` em `pCriaTabelaFiltroItem`** (`untFuncoesPedido.pas`): no branch de alteração (semeadura de `FILTRO_ITEM` a partir de `PCMDET`, ativo quando `strNumPedAlt` está preenchido), alinhar o critério de agrupamento por similares ao mesmo já usado no branch padrão (`IFNULL(ITE_CODSIM, "") = ""` em vez de `ITE_PRISIM = "S"`), e usar `fSQLCodItemPrincipal` para `FIL_CODPRI` em vez de `PCD_CODITE` bruto.

O ajuste 1 foi necessário mas não suficiente: corrigiu o carregamento de `cdsItensPedido` (grade principal), mas o painel "Meses de Giro" continuou zerado porque é alimentado por uma cadeia separada (`cdsItensGiroExt`, populado em `untMenuPedCom.pas` via a mesma rotina `fCalculaGiroEstoque`/`FILTRO_ITEM` usada no "giro do zero" — só que chamada com `strNumPedAlt` preenchido). O ajuste 2 é a causa raiz do sintoma visível na tela.

Nenhuma alteração em schema. As rotinas `pCarrregaDadosGiro`/`fSQLGiro` e o branch padrão de `pCriaTabelaFiltroItem`/`pIncluiSimilares` (usado no "giro do zero") não foram tocados — já validados como corretos.

Arquivos são `.pas` em encoding **Windows-1252/cp1252** (Delphi legado) — toda edição via **Python** (`io.open(..., encoding='cp1252', newline='')`), nunca via ferramenta `Edit`, para não corromper acentuação (regra já registrada em memória).

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untPedidoCompra.pas` | `379.48.2.30.74.150.45\padra_atualizado\fontes\movimentacaoitens\PedidoDeCompra\untPedidoCompra.pas` | Ajuste 1 (guard) — **manter instrumentação de log existente** (`pLogGiroDebug`) |
| `untFuncoesPedido.pas` | `379.48.2.30.74.150.45\padra_atualizado\fontes\movimentacaoitens\PedidoDeCompra\untFuncoesPedido.pas` | Ajuste 2 (`FIL_AGRUPA`/`FIL_CODPRI`, versão sem `SIMEMP`) |
| `untMenuPedCom.pas` | `379.48.2.30.74.150.45\padra_atualizado\fontes\movimentacaoitens\PedidoDeCompra\untMenuPedCom.pas` | Instrumentação de log temporária (`PONTO7`), sem alteração funcional |
| `untPedidoCompra.pas` | `379.48.2.30.74.150\padra_atualizado\fontes\movimentacaoitens\PedidoDeCompra\untPedidoCompra.pas` | Ajuste 1 (guard) — sem instrumentação de log |
| `untFuncoesPedido.pas` | `379.48.2.30.74.150\padra_atualizado\fontes\movimentacaoitens\PedidoDeCompra\untFuncoesPedido.pas` | Ajuste 2 (`FIL_AGRUPA`/`FIL_CODPRI`, versão com `SIMEMP`) |
| `untPedidoCompra.pas` | `379.48.2.30.74.150.100\padra_atualizado\fontes\movimentacaoitens\PedidoDeCompra\untPedidoCompra.pas` | Ajuste 1 (guard) — sem instrumentação de log |
| `untFuncoesPedido.pas` | `379.48.2.30.74.150.100\padra_atualizado\fontes\movimentacaoitens\PedidoDeCompra\untFuncoesPedido.pas` | Ajuste 2 (`FIL_AGRUPA`/`FIL_CODPRI`, versão com `SIMEMP`) |

## 3. Sequência de implementação

1. Em `74.150.45`: alterar o guard de `fCarregaItensPedidoAux` (Ajuste 1), preservando a instrumentação de log já inserida.
2. Validar via log que `cdsItensPedido.ITE_Q_V_01` passa a ser preenchido — confirmado (`16`), mas sintoma na tela persiste.
3. Instrumentar `untMenuPedCom.pas` (`PONTO7`) para isolar se o bug estava na propagação para o painel ou no próprio cálculo de giro em alteração — confirmado: já vinha zerado do cálculo.
4. Investigar `TGiroPedido.pCriaTabelaFiltroItem`, comparar branch de alteração (`PCMDET`) com branch padrão (`CADITE`), identificar a divergência em `FIL_AGRUPA`/`FIL_CODPRI` (Ajuste 2). Confirmar via consulta ao banco que `ITE_PRISIM = 'N'` para todos os itens do grupo `031272`.
5. Aplicar o Ajuste 2 em `74.150.45` (versão sem `SIMEMP`). Validar encoding.
6. Recompilar e reproduzir: log confirma `cdsItensGiro.ITE_Q_V_01 = 16` logo após `fCalculaGiroEstoque`; confirmado visualmente na tela (painel "Meses de Giro" exibindo `16,00`).
7. Em `74.150`: aplicar Ajuste 1 e Ajuste 2 (versão com suporte a `SIMEMP='2'`, alias `fSQLCodItemPrincipal(strAlias)` com parâmetro). Validar encoding.
8. Em `74.150.100`: aplicar Ajuste 1 e Ajuste 2 (mesma variante `SIMEMP`). Validar encoding.
9. Conferir `svn diff` nas três working copies para garantir que só as linhas pretendidas foram tocadas (nenhuma alteração colateral).

## 4. Conformidade com padrões do projeto

- Zona Legado: alteração dentro de código VCL/SQL existente, sem introduzir componentes/chamadas novas — não há violação de padrão a verificar (Hungarian, `TBitBtnLocked`, etc. não se aplicam a esta mudança pontual).
- SQL construído via concatenação de string já era o padrão pré-existente em `pCriaTabelaFiltroItem` (não é ParamByName porque monta DDL/consulta dinâmica sobre tabela em memória, sem dados de usuário na expressão alterada) — nenhuma mudança nesse aspecto, apenas na condição `IF(...)`.
- Nenhuma chamada proibida envolvida (`Now`, `StrToFloat`, `.SetFocus`, `Application.CreateForm`) — a correção não introduz esses pontos.
- Edição de `.pas` cp1252 exclusivamente via Python (nunca `Edit`), conforme regra de encoding do projeto.

## 5. Estratégia de testes

- **Manual**, no `74.150.45` (ambiente com acesso a banco e app rodando nesta sessão): reabrir o pedido `000000000111` (empresa `004`) em alteração com Giro=Sim.
  - Com `chkAgrSim` marcado: painel "Meses de Giro" exibe `16,00` em 2026/08 para o item `03699` — **validado**.
  - Com `chkAgrSim` desmarcado: deve exibir `0,00` (giro do item isolado, sem agregação) — pendente de validação pelo usuário.
  - Log (`giro_debug.log`) usado para confirmar, em cada etapa, o valor em cada camada (`cdsItensGiro` → `cdsItensPedido` → grid rodapé).
- Não há suite DUnit específica para telas de Pedido de Compra (VCL) neste projeto — validação é manual/funcional.
- Em `74.150` e `74.150.100`: validação por leitura de código e `svn diff` restrito à variante `SIMEMP` — sem ambiente de teste ativo nesta sessão para reprodução funcional.

## 6. Riscos e mitigação

- **Ajuste 1 — chamada extra a `pCarrregaDadosGiro` por item recarregado** (query adicional) → mitigado: rotina já é usada no fluxo de item novo sem impacto perceptível; é somente leitura.
- **Ajuste 2 — mudança de critério de agrupamento pode alterar o resultado de giro para outros grupos de similares** (além do `031272`) → mitigado: o novo critério é estritamente mais abrangente (agrupa sempre que há `ITE_CODSIM`, como o branch padrão já validado), não mais restritivo; grupos que já tinham um item `ITE_PRISIM = 'S'` continuam se comportando igual, pois `ITE_CODSIM` é o mesmo valor em todo o grupo.
- **Correção não testável funcionalmente em `74.150`/`74.150.100`** (sem app rodando nessas working copies nesta sessão) → mitigado por ser a mesma lógica de correção já comprovada em `74.150.45`, adaptada à variante `SIMEMP` existente no código dessas cópias, e por validação de `svn diff` restrita.
- **Dependência:** nenhuma alteração de schema ou de outras units além de `untPedidoCompra.pas` e `untFuncoesPedido.pas`.
