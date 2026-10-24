# Especificação — Req. 462019

**Título:** Falha na importação de NF de uso e consumo modelo 75 (NFAg) por divergência de espécie de documento
**Objetivo:** Corrigir a importação de notas fiscais de uso e consumo (rotina `TEntImpConsumo`) para que documentos dos modelos 62 (NFCom), 66 (NF3e) e 75 (NFAg) sejam gravados de forma consistente entre `CADFIS` e `MOVGER`/`MOVDET`, eliminando a falha silenciosa que hoje impede a geração do movimento.
**Zona:** Legado
**Data:** 15/09/2026

## 1. Contexto / problema atual

O Req. 458421 (revisão SVN 492989 nesta cópia, `379.48.2.30.72.352_AMARELINHA`) alterou `TEntImpConsumo.fCarregarArquivosDiretorio` para passar a reconhecer os modelos de documento fiscal 62 (NFCom — telecomunicações), 66 (NF3e — energia elétrica) e 75 (NFAg — água/esgoto), atribuindo ao campo em memória `ESPECIE_DOCUMENTO` os valores `'CO'`, `'EL'` e `'AG'`, respectivamente (demais modelos continuam `'NF'`).

Entretanto, `TEntImpConsumo.pGravarCadFis` — chamado logo depois, em `fConfirmarImportacaoConsumo` — continuou gravando o campo `CADFIS.FIS_ESPDOC` com o literal fixo `'NF'`, independente do valor calculado. Já `pCriaMovGerMovDet` (chamado na sequência) usa o valor dinâmico (`'CO'`/`'EL'`/`'AG'`/`'NF'`) para localizar o registro de CADFIS recém-gravado, via `SELECT ... FROM CADFIS WHERE FIS_ESPDOC = :EspDoc ...` em `untXMLConsumoItem.pas`.

Como o `CADFIS.FIS_ESPDOC` gravado (`'NF'`) nunca bate com a espécie buscada (`'EL'`/`'AG'` para modelos 66/75), o `INSERT ... SELECT` que gera `MOVGER`/`MOVDET`/`MOVTRI` executa com sucesso porém sem encontrar linhas — o movimento simplesmente não é criado, sem exceção visível ao usuário. Foi o cenário relatado no ticket (XML NFAg modelo 75, `xmlDfe-35260903582243000173750010001466551008598968.xml`, concessionária DAE Jundiaí): a nota não é importada corretamente.

Adicionalmente, o modelo 62 sempre recebe espécie `'CO'`, mesmo quando o CFOP do XML não corresponde a uma operação de comunicação — não há hoje nenhuma validação equivalente à usada em `TfrmCadLivroFiscal.fValidaClaFisCT` (que só permite a espécie `'CO'` quando o CFOP está dentro da faixa de comunicação).

O mesmo Req. 458421 também alterou `TfrmCadLivroFiscal` (`untCadLivroFiscal.pas`) para tratar `FIS_ESPDOC = 'AG'` como caso especial na exclusão de CADFIS (isentando da checagem de "não excluir notas com produtos" e equiparando a nota de serviço para apagar o MOVGER vinculado). Como a espécie `'AG'` só é originada por essa rotina de importação — e essa importação está com erro sempre que o modelo é 75 — não existe hoje nenhum documento em produção gravado com `FIS_ESPDOC = 'AG'`; o tratamento especial é seguro para remoção.

## 2. Módulos e entidades envolvidos

- Módulo(s): movimentacaoitens (importação de NF de uso e consumo), cadastros (livro fiscal)
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/untEntImpConsumo.pas` — classe `TEntImpConsumo`
  - `padra_atualizado/fontes/cadastros/untCadLivroFiscal.pas` — classe `TfrmCadLivroFiscal`
- Tabelas/entidades:
  - `CADFIS` — cadastro de espécie/documento fiscal. Chave lógica usada nesse fluxo: `FIS_NUMDOC` + `FIS_ESPDOC` + `FIS_CODEMP` + `FIS_FORCLI` + `FIS_SERIE_`.
  - `MOVGER` / `MOVDET` / `MOVTRI` / `MOVREF` — movimento gerado a partir do CADFIS, chaveado por `AUTOINCREM` (MOVGER) e `DET_SEQGER`/`REF_SEQGER` (MOVDET/MOVTRI/MOVREF).

## 3. Requisitos funcionais

- RF01 — Ao importar um XML de modelo 62 (NFCom), o sistema deve gravar `ESPECIE_DOCUMENTO = 'CO'` somente se o CFOP do item corresponder à faixa de Comunicação (constante `CFOP_COMUNICACAO`, `genericos\untConstantes.pas`); caso contrário, gravar `'NF'`.
- RF02 — Ao importar um XML de modelo 66 (NF3e) ou 75 (NFAg), o sistema deve gravar `ESPECIE_DOCUMENTO = 'NF'` (não mais `'EL'`/`'AG'`).
- RF03 — `TEntImpConsumo.pGravarCadFis` deve gravar em `CADFIS.FIS_ESPDOC` o mesmo valor de `ESPECIE_DOCUMENTO` calculado no carregamento do arquivo (em vez do literal fixo `'NF'`), garantindo consistência com o valor usado posteriormente por `pCriaMovGerMovDet` para localizar o CADFIS.
- RF04 — A geração de `MOVGER`/`MOVDET`/`MOVTRI` deve ocorrer normalmente para os modelos 62, 66 e 75, sem falha silenciosa por divergência de espécie.
- RF05 — O tratamento especial da espécie `'AG'` em `TfrmCadLivroFiscal` (exclusão de CADFIS) deve ser removido, pois essa espécie deixa de ser gravada por qualquer rotina do sistema.

## 4. Regras de negócio

- RN01 — Espécie `'CO'` só pode ser atribuída quando o CFOP do documento está contido em `CFOP_COMUNICACAO` (mesma verificação usada em `TfrmCadLivroFiscal.fValidaClaFisCT`, padrão `Pos(CFOP, CFOP_COMUNICACAO) > 0`).
- RN02 — CFOP calculado por `fCFOPConsumo` (mapeamento por modelo: 62→1302/1303, 66→1252/1253, 75→1556, demais→1949) **não é alterado** por este requisito — é usado apenas como entrada para a regra RN01.
- RN03 — Para modelos 66 e 75, a espécie de documento é sempre `'NF'` — não existe mais regra de negócio que produza `'EL'` ou `'AG'`.
- RN04 — O valor de `ESPECIE_DOCUMENTO` gravado em `CADFIS.FIS_ESPDOC` (por `pGravarCadFis`) deve ser sempre o mesmo usado na busca por `pCriaMovGerMovDet`/`untXMLConsumoItem.pas` para o mesmo documento.

## 5. Requisitos técnicos / não-funcionais

- Transação: sem alteração — `fConfirmarImportacaoConsumo` já executa `pGravarCadFis` + `pCriaMovGerMovDet` (+ opcional `pGravarCadPag`) dentro de `fStartTransaction`/`fCommit` por registro.
- Sem impacto em permissões ou auditoria.
- Sem impacto fiscal direto — a mudança é de classificação interna de espécie de documento (`CADFIS.FIS_ESPDOC`), não de tributos/CFOP em si.

## 6. Critérios de aceitação

- [ ] Importar XML modelo 62 com CFOP de comunicação → `CADFIS.FIS_ESPDOC = 'CO'` e MOVGER/MOVDET gerados.
- [ ] Importar XML modelo 62 com CFOP fora da faixa de comunicação → `CADFIS.FIS_ESPDOC = 'NF'` e MOVGER/MOVDET gerados.
- [ ] Importar XML modelo 66 (NF3e) → `CADFIS.FIS_ESPDOC = 'NF'` e MOVGER/MOVDET gerados.
- [ ] Importar XML modelo 75 (NFAg) — incluindo o XML de exemplo do ticket (`xmlDfe-35260903582243000173750010001466551008598968.xml`) → `CADFIS.FIS_ESPDOC = 'NF'` e MOVGER/MOVDET gerados.
- [ ] Excluir um CADFIS com espécie `'NF'` proveniente dessa importação segue a regra padrão (bloqueia exclusão se houver produtos em MOVDET, exceto nota de serviço).
- [ ] Nenhuma referência a espécie `'EL'` ou `'AG'` permanece no código após a correção.

## 7. Fora de escopo

- Migração/correção de registros históricos eventualmente gravados com `FIS_ESPDOC` inconsistente antes desta correção.
- Alterações no parsing do XML NFAg/NF3e em `untXMLConsumo.pas` (já funcional, não relacionado a este bug).
- Qualquer alteração em `fCFOPConsumo` (mapeamento de CFOP por modelo).

## 8. Dependências e riscos

- Risco: código morto — nenhum registro em produção deve ter `FIS_ESPDOC = 'AG'`, pois a importação sempre falhou para modelo 75; removida a checagem especial em `untCadLivroFiscal.pas`, não há impacto esperado em dados existentes (confirmado com o solicitante).
- Dependência: constante `CFOP_COMUNICACAO` (`padra_atualizado/fontes/genericos/untConstantes.pas`) já em uso na unit de destino (`untEntImpConsumo.pas` já importa `untConstantes` no `uses`).
