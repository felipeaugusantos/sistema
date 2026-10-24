# Especificação — Req. 469576

**Título:** Fechamento contábil bloqueia lançamentos em todos os exercícios anteriores
**Objetivo:** Após o fechamento contábil até uma data, impedir inclusão, alteração, exclusão, geração e importação de lançamentos com data igual ou anterior a ela, e não só dentro dos períodos fechados.
**Zona:** Moderna (`Contabilidade\`)
**Data:** 13/10/2026

## 1. Contexto / problema atual

O cliente Amarelinha (CNPJ raiz 07517759, 54 empresas) tem a empresa 006 fechada de 01/01/2024 a 31/12/2025. Mesmo assim, em 08/10/2026, o operador 194 importou 522 lançamentos com data de novembro de 2023 em 20 empresas dessa raiz, pela tela CONTABILIDADE > IMPORTAÇÕES > LANÇAMENTOS CONTÁBEIS (`CON_TIPLAN = 'IMP'`).

Toda verificação contra a `FECCON` pergunta se a data cai **dentro** de algum intervalo `[CON_FECINI, CON_FECFIN]`. Data anterior ao primeiro período fechado passa:

- `fPeriodoFechado` (`Outros\Contabilidade.Funcoes.pas`): sobreposição de intervalo. Usada na importação "Lançamentos Contábeis", nos lotes e nas manutenções.
- `fTemFechamento` (mesmo arquivo): `BETWEEN` só nas pontas do intervalo pedido. Usada na geração de movimento e na transferência entre contas.
- `TfrmImportacaoContabil.fValidarDados` (CONTABILIDADE > IMPORTAÇÕES > IMPORTAÇÃO CONTÁBIL): **nenhuma** verificação de fechamento.

## 2. Módulos e entidades envolvidos

- Módulo: `Contabilidade\` (external `^/Contabilidade`, compartilhado pelas principais)
- Tabelas:
  - `FECCON`: `CON_CODEMP`, `CON_FECINI`, `CON_FECFIN`, `CON_DTAFEC`, `CON_HRAFEC`, `CON_CODOPE`.
  - `LANCON`: `AUTOINCREM`, `CON_EMPLAN`, `CON_DTALAN`.
  - `CADEMP`: `EMP_CODEMP`, `EMP_C_G_C_`.
- Agrupamento de empresas: raiz de CNPJ (8 primeiros dígitos), o mesmo de `fObtemEmpresasFiliais`.

## 3. Requisitos funcionais

- RF01 — Data de lançamento igual ou anterior ao último fechamento contábil do grupo da empresa é **bloqueada**.
- RF02 — O bloqueio vale para inclusão, alteração e exclusão de lançamento nas telas de manutenção de lançamento, de lote, de lotes múltiplos e de exclusão de lançamentos por período.
- RF03 — O bloqueio vale para as duas importações de lançamentos: "Lançamentos Contábeis" e "Importação Contábil" (layouts Folha, Patrimonial e Dimob). A linha bloqueada é recusada como as demais linhas inválidas daquela tela.
- RF04 — Geração de movimento e transferência entre contas: período que comece em data igual ou anterior ao último fechamento é recusado por inteiro, com aviso.
- RF05 — Aviso ao operador por `fMensagem`, sem exceção: *"Lançamento com data DD/MM/AAAA não permitido: a empresa XXX tem fechamento contábil até DD/MM/AAAA."*

## 4. Regras de negócio

- RN01 — Último fechamento do grupo = maior `CON_FECFIN` da `FECCON` entre as empresas com a mesma raiz de CNPJ da empresa do lançamento.
- RN02 — Bloqueada ⇔ existe fechamento no grupo com `data <= COALESCE(CON_FECFIN, '9999-01-01')`. Isso abrange a regra atual: data dentro de um período fechado continua bloqueada. O `COALESCE` mantém o tratamento atual de `CON_FECFIN` nulo.
- RN03 — Sem nenhum fechamento no grupo, nada se bloqueia.
- RN04 — O estorno do fechamento (exclusão da linha da `FECCON`) recua a data de corte automaticamente.
- RN05 — Vale para todos os clientes, sem configuração.
- RN06 — Empresa sem CNPJ: o grupo é só a própria empresa, como no `fPeriodoFechado` atual.
- RN07 — Sem empresa informada (geração de movimento de todas as empresas), vale o último fechamento de qualquer empresa, como a geração já fazia antes. Achado no teste de 14/10/2026.

## 5. Requisitos técnicos / não-funcionais

- Consulta parametrizada (`ParamByName`), sem concatenação de valor.
- Importação: resultado guardado por empresa durante o arquivo, sem consulta por linha.
- `fPeriodoFechado` e `fTemFechamento` **não mudam**: seguem atendendo o fechamento, o estorno, o fechamento mensal e a tela de parcelas de cartão.

## 6. Critérios de aceitação

- [ ] Com o grupo fechado até 31/12/2025, importar por "Lançamentos Contábeis" um lançamento de 2023 é recusado.
- [ ] O mesmo pela "Importação Contábil" (layout) é recusado.
- [ ] Data dentro de um período fechado continua recusada (regressão).
- [ ] Empresa sem linha própria na `FECCON`, mas da mesma raiz de CNPJ de uma fechada, é recusada.
- [ ] Empresa de raiz sem nenhum fechamento: aceita.
- [ ] Data posterior ao último fechamento: aceita.
- [ ] Depois do estorno do fechamento, a data volta a ser aceita.
- [ ] Inclusão, alteração e exclusão manual de lançamento de 2023 recusadas.
- [ ] Geração de movimento e transferência com início em 2023 recusadas, com aviso.
- [ ] Fechamento mensal, fechamento e estorno funcionam como antes.

## 7. Fora de escopo

- Ramo `379.48.2.30.72.352_AMARELINHA`.
- Remover os 522 lançamentos já importados no cliente (ajuste de dados, com suporte/contabilidade).
- Verificação de fechamento diário/mensal (`FECCDM`), que já bloqueia "igual ou anterior".
- `padra_atualizado\fontes\financeiro\cartoes\untCadMovCartoesParcelas.pas`.

## 8. Dependências e riscos

- Mudança de comportamento para todo cliente com `FECCON`: quem lança em ano anterior a um fechamento passa a ser barrado ao atualizar. Saída: estorno do fechamento.
- A fechada `379.48.2.30.74.150.100.12` usa `^/Contabilidade@499703`: o usuário avança o peg depois do commit.
