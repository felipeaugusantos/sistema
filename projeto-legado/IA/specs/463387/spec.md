# Especificação — Req. 463387

**Título:** Replicação de Comissão Tabela (LTP_COMTB) não propaga para as demais tabelas de preço
**Objetivo:** Corrigir a rotina de dígito de valor em lote de preços para que, ao alterar o campo
"Comissão Tabela 1" com a opção "Replicar para todas as tabelas" marcada, o valor seja
efetivamente replicado para todas as tabelas de preço ativas do item.
**Zona:** Legado
**Data:** 2026-09-22

## 1. Contexto / problema atual

Na tela **Principal > Movimentação de Itens > Ativar Lote de Preços da Entrada de Mercadorias**,
ao posicionar sobre o campo "Comissão Tabela 1" e pressionar `Enter`, o sistema abre a tela
`frmDigValorLote` (unit `untDigValorLote.pas`) para digitação do novo valor. Essa tela possui o
checkbox `chkReplica` ("Replicar para todas as tabelas"), que deveria propagar o valor digitado
para todas as tabelas de preço ativas do item (definidas em `VS_strTabPrc`).

Ao digitar o valor e marcar `chkReplica`, o sistema confirma a operação sem erro, porém **apenas a
Tabela 1 recebe o novo valor** — as demais tabelas ativas (no caso relatado pelo cliente MRA Auto
Peças, tabelas 2, 3 e 7) permanecem com o valor anterior de `LTP_COMTB`.

A causa raiz está na unit `untLotePrecos.pas`, método `pAlterarPrecoMargem` (classe
`TLotePrecos`). A rotina interna `pRecalculaDados` decide se o valor deve ser propagado para todas
as tabelas ativas ou gravado apenas na tabela do campo editado, com base em uma variável booleana
que reconhecia como "campo replicável entre tabelas" somente os campos de preço de venda (`PREVE`)
e margem bruta (`MARBR`). O campo de comissão de tabela (`COMTB`), apesar de também existir uma
instância por tabela (`LTP_COMTB1` a `LTP_COMTB7`), não estava incluído nessa verificação — por
isso, mesmo com o checkbox de replicação marcado, o laço de propagação nunca chegava a iterar sobre
as demais tabelas para esse campo.

## 2. Módulos e entidades envolvidos

- Módulo: Movimentação de Itens (lote de preços de entrada de mercadorias)
- Units: `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas` (classe `TLotePrecos`,
  método `pAlterarPrecoMargem`); `padra_atualizado/fontes/movimentacaoitens/untDigValorLote.pas`
  (tela `frmDigValorLote`, checkbox `chkReplica`)
- Tabela: `LOTPRE` (lote de preços) — chave `AUTOINCREM`
  - Campos envolvidos: `LTP_COMTB1` a `LTP_COMTB7` (Comissão Tabela por tabela de preço, com
    variantes `_ANT`/`_ATU`/`_ALT`), `LTP_USATA1` a `LTP_USATA7` (flag de tabela ativa)
- Configuração relevante: `CFGSIS.SIS_CODCFG = 'CFG_PCMPRO'` — controla a utilização/rótulo do
  campo de percentual de acréscimo na composição da tabela de preço (confirmado no banco do
  cliente: valor `3`, empresa `001`, usando o rótulo definido em `TCOMTB`)

## 3. Requisitos funcionais

- RF01 — Ao editar o campo "Comissão Tabela N" (`LTP_COMTBn`) via `frmDigValorLote` com a opção
  "Replicar para todas as tabelas" marcada, o sistema deve gravar o valor digitado em todas as
  tabelas de preço ativas do item (`LTP_USATA1..7 = 'S'`), e não apenas na tabela de origem.
- RF02 — Sem a opção "Replicar para todas as tabelas" marcada, o comportamento deve permanecer
  inalterado: o valor é gravado apenas na tabela do campo editado.

## 4. Regras de negócio

- RN01 — A replicação entre tabelas de preço já é suportada pela rotina para os campos de preço de
  venda (`PREVE`) e margem bruta (`MARBR`). O campo de comissão de tabela (`COMTB`) segue a mesma
  regra de negócio (um valor por tabela de preço) e deve ser tratado de forma simétrica a esses
  dois campos no mecanismo de replicação.
- RN02 — A replicação deve respeitar apenas as tabelas efetivamente ativas para o item
  (`VS_strTabPrc` / `LTP_USATAn`), sem alterar tabelas inativas.

## 5. Requisitos técnicos / não-funcionais

- Alteração restrita à zona Legado — manter padrão Hungarian, prefixos de escopo (`p`/`f`/`bln`) e
  estilo já existente na unit.
- Nenhuma alteração de estrutura de tabela ou de tela (`.dfm`) é necessária — o ajuste é
  inteiramente na lógica de propagação de valor em `pAlterarPrecoMargem`.

## 6. Critérios de aceitação

- [x] Ao editar "Comissão Tabela 1" com "Replicar para todas as tabelas" marcado, as demais
  tabelas ativas do item (ex.: 2, 3 e 7) passam a receber o mesmo valor digitado.
- [x] Sem a opção de replicação marcada, apenas a tabela editada é alterada (comportamento
  anterior preservado).
- [x] Nenhum outro campo (`PREVE`, `MARBR`, demais campos de `LOTPRE`) teve seu comportamento de
  replicação alterado.

## 7. Fora de escopo

- Revisão de outros campos de `LOTPRE` que eventualmente possuam a mesma limitação e ainda não
  tenham sido reportados.
- Alteração da tela `frmDigValorLote` (`.dfm`) ou de sua lógica de validação de campos.

## 8. Dependências e riscos

- Nenhuma dependência de outros módulos/serviços.
- Risco baixo: alteração aditiva, simétrica ao tratamento já existente para `PREVE`/`MARBR`, sem
  impacto em outros fluxos da unit.
