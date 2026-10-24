# Especificação — Req. 470557

**Título:** Fechamento fiscal, de estoque e financeiro por raiz de CNPJ (inclusão e exclusão)
**Objetivo:** permitir fechar e desfazer o fechamento de todas as empresas da mesma raiz de CNPJ de uma vez, nas três telas de Fechamentos Mensais, copiando a regra do Fechamento Contábil Diário/Mensal.
**Zona:** Legado (`padra_atualizado\fontes\fechamentosmensais\`)
**Data:** 19/10/2026
**Versões:** `379.48.2.30.74.150`, `379.48.2.30.74.150.100` (implementação) e `379.48.2.30.74.150.100.12` (fechada, em uso pelo cliente)

## 1. Contexto / problema atual

O cliente 489 (Amarelinha) tem 54 empresas ativas, todas na raiz `07517759`. Em `PRINCIPAL > FECHAMENTOS MENSAIS > FECHAMENTO FISCAL / FECHAMENTO DE ESTOQUE / FECHAMENTO FINANCEIRO`, o fechamento (F2) e a exclusão (F3) são feitos empresa por empresa, o que dá 54 operações por módulo a cada período.

A tela `PRINCIPAL > CONTABILIDADE > FECHAMENTOS > FECHAMENTO CONTÁBIL DIÁRIO/MENSAL` já tem a caixa "Fechar todas as empresas com a mesma raiz do CNPJ":
- grava todas as empresas numa transação só;
- se uma empresa tem fechamento posterior, aborta tudo e diz qual empresa travou;
- na exclusão, pergunta se é para excluir também as outras empresas da raiz.

O Financeiro já permite escolher várias empresas no F2, mas grava uma a uma, cada uma com sua própria transação. Se uma falha no meio, as anteriores ficam gravadas.

## 2. Módulos e entidades envolvidos

- Módulos: fiscal, estoque (suprimentos) e financeiro (fechamentos mensais).
- Units: `padra_atualizado\fontes\fechamentosmensais\`
  - classes: `untFechamentoFiscal`, `untFechamentoEstoque`, `untFechamentoFinanceiro`;
  - telas de inclusão: `untIncluiFechamento{Fiscal,Estoque,Financeiro}`;
  - telas de exclusão: `untExcluiFechamento{Fiscal,Estoque,Financeiro}`.
- Modelo (somente leitura, sem alteração):
  - `Contabilidade\View\Contabilidade.View.FechamentoDiaMesIncluir.pas`;
  - `Contabilidade\Classes\Contabilidade.Classes.FechamentoDiaMes.pas`;
  - `Contabilidade\Outros\Contabilidade.Funcoes.pas` — `fObtemEmpresasFiliais`, reaproveitada;
  - `Contabilidade\Outros\Contabilidade.OutrosFechamentos.Funcoes.pas` — `TOutrosFechamentos.fPodeDeletarFechamento`.
- Tabelas:
  - `CADEMP` (`EMP_CODEMP`, `EMP_C_G_C_`);
  - `FECFIS` / `DELFIS` (fiscal, por `FEC_CODEMP` + `FEC_DTAREF`);
  - `CADFEC` / `DELFEC` (estoque, por `FEC_CODEMP` + `FEC_ANOREF` + `FEC_MESREF`);
  - `FECFIN` / `DELFECFIN` / `LOGFIN` (financeiro, por `FEC_CODEMP` + data de referência).
- Nenhuma tabela ou campo novo (sem DDL).

## 3. Requisitos funcionais

- RF01 — As telas de inclusão do fiscal, do estoque e do financeiro ganham a caixa **"Fechar todas as empresas com a mesma raiz do CNPJ"**, desmarcada por padrão.
- RF02 — Com a caixa marcada, o fechamento é gravado em todas as empresas da raiz da empresa informada, incluindo ela mesma.
- RF03 — A confirmação antes de gravar diz que o fechamento vale para todas as empresas da raiz e informa quantas são.
- RF04 — Na exclusão (F3), quando outras empresas da raiz têm fechamento na mesma data (no estoque, no mesmo mês/ano), o sistema pergunta **"Deseja excluir o fechamento para as outras empresas na mesma raiz?"**:
  - **Sim** exclui nas empresas da raiz que têm essa data;
  - **Não** exclui só a empresa informada, como hoje.
- RF05 — Financeiro: a seleção de várias empresas no F2 continua. Com a caixa marcada, entram as raízes de todas as empresas selecionadas.

## 4. Regras de negócio

- RN01 — Raiz = os 8 primeiros caracteres de `CADEMP.EMP_C_G_C_`. A lista sai de `fObtemEmpresasFiliais` e inclui a própria empresa.
- RN02 — **Inclusão por raiz, tudo ou nada.** Cada empresa da raiz passa pela regra do seu módulo:
  - fiscal: data nova maior que o último fechamento;
  - estoque: o mês seguinte ao último fechado, quando a empresa já tem fechamento;
  - financeiro: data nova maior que o último fechamento.

  Se qualquer empresa falha, **nada é gravado**, e a mensagem diz a empresa e o motivo (ex.: "O fechamento sugerido para a empresa 007 deve ser maior que o último fechamento realizado (30/09/2026)!").
- RN03 — **Exclusão por raiz, tudo ou nada.** As empresas-alvo são as da raiz que têm fechamento na data (ou mês) excluída. Para cada uma:
  - em todos os módulos, essa data tem que ser o último fechamento de cada empresa. No fiscal e no estoque, isso já é exigido hoje. No financeiro, passa a ser exigido **só na exclusão por raiz**: a data vem da empresa digitada e, numa filial com fechamento posterior, apagaria um fechamento do meio que a inclusão não consegue refazer (apontamento do DelphAI). A exclusão de uma empresa só e a da grade continuam como hoje;
  - em todos os módulos, o fechamento não pode estar preso ao fechamento contábil (`fPodeDeletarFechamento`).

  Se qualquer empresa falha, nada é excluído, e a mensagem diz qual empresa travou. As empresas da raiz sem fechamento nessa data não são afetadas.
- RN04 — **Financeiro sem reprocessamento.** Com a caixa marcada, a lista final é a união das raízes de cada empresa selecionada, sem repetição: cada empresa é validada e gravada uma vez só.
- RN05 — Empresa com CNPJ vazio ou NULL: a operação vale só para ela. Nunca agrupa as empresas sem CNPJ.
- RN06 — **Trava entre estações** (quando `UTIFEC` está ligada):
  - cada empresa-alvo é travada (`MOVIMENTACAO_FISCAL_` / `_ESTOQUE_` / `_FINANCEIRA_` + empresa) antes de gravar;
  - se uma trava falha, nada é gravado, aparece o aviso que já existe hoje, com a estação que está com a trava, e todas as travas obtidas são liberadas;
  - no fim, todas as travas são liberadas, com sucesso ou com erro.
- RN07 — **Sem a caixa** (ou com a resposta Não na exclusão), o comportamento atual fica intacto, inclusive o financeiro com várias empresas, que hoje grava uma a uma.
- RN08 — Os métodos atuais das classes, que o fechamento contábil anual (`TOutrosFechamentos`, com `Contabilidade = True`) também chama, **não mudam de comportamento**.

## 5. Requisitos técnicos / não-funcionais

- Uma transação só por operação por raiz (`fStartTransaction` / `fCommit` / `fRollBack`).
- Sem DDL, sem configuração nova e sem permissão nova. As permissões `INCLUIRFECFIN` / `EXCLUIRFECFIN` continuam valendo no financeiro.
- A auditoria existente continua por empresa: `DELFIS`, `DELFEC`, `DELFECFIN`/`LOGFIN`.
- Na `.150`, `untFechamentoFinanceiro.pas` também compila para os serviços Linux (`{$IFDEF LINUX}`), então os métodos novos têm que compilar nos dois alvos.
- As classes entram em 13 projetos (`autcom.dpr`, `libAutban`, `libCadastros`…). Só ganham métodos, sem nova unit no `uses`.
- Encoding: os `.pas` são cp1252 com acento, então a edição é feita pelo `fonte_delphi.py`.

## 6. Critérios de aceitação

- [ ] CA01 — Fiscal, estoque e financeiro: com a caixa marcada e todas as empresas da raiz aptas, o fechamento é gravado em todas, e a grade "Último fechamento de todas as empresas" mostra a nova data em cada uma.
- [ ] CA02 — Com a caixa marcada e uma empresa da raiz já fechada na data ou depois (no estoque, fora da sequência), nada é gravado em nenhuma empresa, e a mensagem diz qual empresa travou.
- [ ] CA03 — Com a caixa desmarcada, a inclusão funciona como hoje.
- [ ] CA04 — Exclusão com outras empresas da raiz na mesma data: aparece a pergunta. Sim exclui em todas as que têm a data; Não exclui só a empresa informada.
- [ ] CA05 — Exclusão por raiz com uma empresa em que a data não é o último fechamento (fiscal, estoque e financeiro), ou presa ao contábil: nada é excluído, e a mensagem diz qual empresa travou.
- [ ] CA06 — Exclusão sem outras empresas da raiz na mesma data: a pergunta não aparece, e a exclusão é a de hoje.
- [ ] CA07 — Financeiro: selecionando duas empresas da mesma raiz com a caixa marcada, cada empresa recebe um único fechamento, sem duplicidade em `FECFIN` nem em `LOGFIN`.
- [ ] CA08 — Empresa com CNPJ vazio e a caixa marcada: só ela é fechada.
- [ ] CA09 — Com outra estação travando uma empresa da raiz (`UTIFEC` ligada), nada é gravado, aparece o aviso de trava, e nenhuma trava fica presa depois.
- [ ] CA10 — O fechamento contábil anual (`PRINCIPAL > CONTABILIDADE > FECHAMENTOS > FECHAMENTO CONTÁBIL`) continua gravando os fechamentos fiscal, de estoque e financeiro como hoje.

## 7. Fora de escopo

- Ignorar empresas inativas no fechamento por raiz (Req. 470500).
- A exclusão de várias datas pela grade do Fechamento Financeiro (continua por empresa).
- Qualquer alteração em `Contabilidade\` (external compartilhado por todas as versões).
- O ramo `379.48.2.30.72.352_AMARELINHA` e as principais `.72`, `.111` e `.150.45`.
- Corrigir o comportamento atual do financeiro com várias empresas sem a caixa (grava uma a uma).

## 8. Dependências e riscos

- `fObtemEmpresasFiliais` já está no `autcom.dpr`, e as telas só existem nele. Na `.150.100.12`, o external `Contabilidade` está fixado em `@499779`, revisão que já tem a função.
- 54 empresas numa transação: poucas linhas por empresa, risco baixo de travamento longo.
- A trava por empresa usa `FTravou` (um booleano por objeto), então o método por raiz precisa controlar a lista de travas obtidas.
