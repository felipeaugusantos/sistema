# Especificação — Req. 462421

**Título:** Finalizar NF-e (GER_FNLZDA) também para entrada com Depósito Fechado
**Objetivo:** Fazer com que a NF-e vinculada a uma Entrada de Mercadorias seja marcada como finalizada (`GERELE.GER_FNLZDA = 'S'`) quando a entrada for destinada a um Depósito Fechado (transferência automática), evitando que colunas do fluxo de compras fiquem indevidamente pendentes.
**Zona:** Legado
**Data:** 17/09/2026

## 1. Contexto / problema atual

No módulo **Movimentação de Itens > Entrada de Mercadorias**, quando a entrada é configurada para ir para outro depósito (`CFG_ETRAUT = S`, campo `edtCodEmpresa` do form `untEntDadosFiscaisResumo` preenchido), o sistema gera automaticamente uma nota de transferência para a empresa depósito — a mercadoria fisicamente não permanece na empresa que recebeu a NF-e original.

Hoje, `GERELE.GER_FNLZDA` só é gravado como `'S'` (finalizada) na função `fBaixaNotaEletronica` (unit `untPcmGer.pas`) quando existem itens com CFOP 1922/2922 (`fTemItemX922 = True`). No cenário de depósito fechado, essa condição não é atendida, então a NF-e permanece como não finalizada.

Consequência observada no cliente RIOCOLOR (LJ008): no fluxo de compras, as colunas **"Agendamento de Recebimento"**, **"Recebimento de Agendamento"** e **"Plano Recebimento"** continuam exibindo **"A Realizar"** indefinidamente, mesmo a mercadoria já tendo sido processada e transferida — pois ela nunca chegará fisicamente na empresa que recebeu a NF-e original.

Caso de simulação relatado: NF Entrada `000000343947-NF-015-00004450` gerou a Transferência `000000000161-NF-015` (empresa logada 015, `CFG_UTIWMS=S`, `CFG_TIPPNT=D`, `CFG_ETRAUT=S`).

## 2. Módulos e entidades envolvidos

- Módulo: `movimentacaoitens` (Entrada de Mercadorias)
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas` — regra de baixa/finalização da NF-e (função `fBaixaNotaEletronica`, chamada em `fConfirmaEntradaMercadorias`)
  - `padra_atualizado/fontes/movimentacaoitens/untEntDadosFiscaisResumo.pas` — form de dados fiscais/resumo da entrada (não sofre alteração; já propaga `strEmpresaDeposito` corretamente)
- Tabelas/entidades:
  - `GERELE` — chave `AUTOINCREM`; campos envolvidos: `GER_EMPENT`, `GER_DOCENT`, `GER_ESPENT`, `GER_FNLZDA`

## 3. Requisitos funcionais

- RF01 — Ao confirmar uma Entrada de Mercadorias vinculada a NF-e (`strAutEle` preenchido) que seja destinada a Depósito Fechado (`strEmpresaDeposito` preenchido), o sistema deve gravar `GERELE.GER_FNLZDA = 'S'` para essa NF-e, da mesma forma que já ocorre para itens com CFOP 1922/2922.
- RF02 — O comportamento existente de finalização por CFOP 1922/2922 (`fTemItemX922`) deve ser mantido inalterado e continuar sendo avaliado em conjunto (`Or`) com a nova condição.
- RF03 — Entradas sem NF-e vinculada (`strAutEle` vazio) não devem ser afetadas — a chamada a `fBaixaNotaEletronica` só ocorre dentro do bloco `If Not fEmptyStr(strAutEle)`.

## 4. Regras de negócio

- RN01 — `GER_FNLZDA` é gravado como `'S'` quando a NF-e original é considerada encerrada porque: (a) um novo documento espelho será emitido para retorno de terceiros (CFOP 1922/2922), OU (b) a entrada gera uma nota especial de transferência para depósito fechado (`strEmpresaDeposito` informado).
- RN02 — `strEmpresaDeposito` só chega preenchido quando `CFG_ETRAUT = S` (visibilidade do campo `edtCodEmpresa`) e `chkTransfAut` está marcado no form `untEntDadosFiscaisResumo`; a validação de que a empresa depósito é diferente da empresa logada já existe nesse form (linha 1063) e não é reavaliada aqui.
- RN03 — Não deve haver gravação de `GER_FNLZDA` em nenhum outro ponto do fluxo além da chamada já existente a `fBaixaNotaEletronica` (linha 4979 de `untPcmGer.pas`).

## 5. Requisitos técnicos / não-funcionais

- Alteração composta por: (a) condição booleana (`Or`) somada ao argumento já existente na chamada a `fBaixaNotaEletronica`; (b) renomeação do parâmetro `blnX922` para `blnFinalizaGerele` na assinatura da função, por clareza semântica — sem alteração de tipo, valor default ou comportamento.
- Arquivo `.pas` em encoding cp1252/latin1 — edição obrigatória via Python (nunca via ferramenta `Edit`), preservando todos os demais caracteres do arquivo.
- Sem impacto em transação, auditoria ou permissões — a gravação em `GERELE` já ocorre dentro do fluxo transacional existente de `fBaixaNotaEletronica`.

## 6. Critérios de aceitação

- [ ] Ao confirmar uma Entrada de Mercadorias com NF-e vinculada e `strEmpresaDeposito` preenchido (depósito fechado), `GERELE.GER_FNLZDA` é gravado como `'S'`.
- [ ] O comportamento para itens CFOP 1922/2922 permanece inalterado (continua marcando `GER_FNLZDA = 'S'`).
- [ ] Entradas sem NF-e vinculada (`strAutEle` vazio) continuam sem qualquer gravação de `GER_FNLZDA` por este ponto do código.
- [ ] No cenário de simulação do chamado (NF `000000343947-NF-015-00004450` → Transferência `000000000161-NF-015`), as colunas "Agendamento de Recebimento", "Recebimento de Agendamento" e "Plano Recebimento" deixam de exibir "A Realizar" indevidamente.

## 7. Fora de escopo

- Alteração no form `untEntDadosFiscaisResumo.pas` — a propagação de `strEmpresaDeposito` já funciona corretamente e não será tocada.
- Criação de nova função de baixa de NF-e — reaproveita-se `fBaixaNotaEletronica` existente.
- (removido — a renomeação de `blnX922` para `blnFinalizaGerele` foi decidida e aplicada; ver seção 5)
- Qualquer ajuste nas regras de emissão da Nota Especial de Transferência (`TEmissaoNotaEspecial`) — já funcionam corretamente.

## 8. Dependências e riscos

- Dependência: `strEmpresaDeposito` já trafega corretamente até o ponto da chamada (`fConfirmaEntradaMercadorias`), confirmado em código.
- Risco: nenhum identificado — chamada a `fBaixaNotaEletronica` é única no projeto (confirmado via grep), e a condição é puramente aditiva via `Or`.
