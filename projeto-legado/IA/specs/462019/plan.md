# Plano de Execução — Req. 462019

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Ajuste pontual em código VCL legado, sem mudança de arquitetura. Três units impactadas:

1. `untEntImpConsumo.pas` — corrigir cálculo e gravação da espécie de documento no fluxo de importação de consumo (`TEntImpConsumo`), reordenando o cálculo do CFOP para antes da definição da espécie e validando a espécie `'CO'` contra a faixa de CFOP de comunicação; alinhar `pGravarCadFis` para gravar a espécie dinâmica em vez do literal `'NF'`.
2. `untCadLivroFiscal.pas` — reverter o tratamento especial da espécie `'AG'` na exclusão de CADFIS (código morto após a correção, já que `'AG'` deixa de ser produzida).

Nenhuma alteração em `untXMLConsumo.pas` (parsing NFAg/NF3e já funcional) nem em `fCFOPConsumo` (mapeamento de CFOP por modelo).

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untEntImpConsumo.pas` | `padra_atualizado/fontes/movimentacaoitens/untEntImpConsumo.pas` | alterar |
| `untCadLivroFiscal.pas` | `padra_atualizado/fontes/cadastros/untCadLivroFiscal.pas` | alterar |

## 3. Sequência de implementação

1. Em `TEntImpConsumo.fCarregarArquivosDiretorio` (unit `untEntImpConsumo.pas`):
   1.1. Antecipar o bloco de cálculo de `LstrCFOP` (hoje nas linhas ~350-354: `LstrCFOP := ''; If Assigned(LobjXML.Product(0)) Then LstrCFOP := LobjXML.Product(0).CFOP; LstrCFOP := fCFOPConsumo(LstrCFOP);`) para imediatamente **antes** do `case LobjXML.Modelo of` (linha 312), já que o novo `case` passa a depender do CFOP calculado.
   1.2. Reescrever o `case LobjXML.Modelo of` (linhas 312-318):
       - `62`: `if Pos(LstrCFOP, CFOP_COMUNICACAO) > 0 then qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString := 'CO' else qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString := 'NF';`
       - Comentar (não excluir) as linhas `66: ... 'EL'` e `75: ... 'AG'`, com comentário curto indicando o motivo (ex.: `{Modelo 66/75 nao possuem regra de negocio para especie propria - caem no Else = 'NF'. Ver Req. 462019}`).
       - `else`: mantém `'NF'` (comportamento já existente).
   1.3. Ajustar a atribuição de `qryTabela.FieldByName('CFOP').AsString := LstrCFOP;` (hoje logo após o cálculo original, linha ~355) para continuar ocorrendo normalmente após o bloco antecipado, sem duplicar o cálculo.
2. Em `TEntImpConsumo.pGravarCadFis` (linha 882): trocar o literal `'NF'` por `qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString`.
3. Em `TfrmCadLivroFiscal` (unit `untCadLivroFiscal.pas`):
   3.1. Linha 6733: reverter `If (Not fNFServico(str_ClaFis)) And (qryTabela.FieldByName('FIS_ESPDOC').AsString <> 'AG') And (Not qryFisItens.IsEmpty) Then` para `If (Not fNFServico(str_ClaFis)) And (Not qryFisItens.IsEmpty) Then`.
   3.2. Linha 6777: reverter `If blnExcluiu and (fNFServico(str_ClaFis) or (str_EspDoc = 'AG')) Then` para `If blnExcluiu and fNFServico(str_ClaFis) Then`.
4. Conferir que nenhuma outra ocorrência de `'EL'`/`'AG'` como espécie de documento permanece nas duas units (grep final).

## 4. Conformidade com padrões do projeto

- Zona Legado: manter Hungarian style, sem refatoração além do escopo.
- Reaproveitar constante já existente `CFOP_COMUNICACAO` (`padra_atualizado/fontes/genericos/untConstantes.pas`) — `untEntImpConsumo.pas` já tem `untConstantes` no `uses` (linha 28), não requer novo import.
- Seguir o mesmo padrão de checagem `Pos(CFOP, CFOP_COMUNICACAO) > 0` já usado em `TfrmCadLivroFiscal.fValidaClaFisCT`.
- Comentário curto no fonte + referência de nota, conforme convenção do time, nas linhas comentadas do `case` (explicando por que 66/75 não têm espécie própria).
- Pre-commit: nenhum componente/chamada proibida envolvida nesta alteração.

## 5. Estratégia de testes

- Suite: não há suite automatizada disponível para este fluxo nesta cópia (ver nota do CLAUDE.md sobre `TESTES_AUTOMATIZADOS/` — escopo não verificado). Validação por simulação manual via rotina de importação de NF de uso e consumo.
- Casos a cobrir:
  1. XML modelo 62 com CFOP de comunicação (1301-1306/2301-2306/3301/5301-5307/6301-6307) → espera `ESPECIE_DOCUMENTO = 'CO'`, CADFIS e MOVGER/MOVDET gerados e consistentes.
  2. XML modelo 62 com CFOP fora dessa faixa → espera `'NF'`.
  3. XML modelo 66 (NF3e) → espera `'NF'`, movimento gerado.
  4. XML modelo 75 (NFAg) — usar o arquivo do ticket `xmlDfe-35260903582243000173750010001466551008598968.xml` (`\\citel-fileserve\AutDbf\AMARELINHA\14092026\`) → espera `'NF'`, movimento gerado sem erro.
  5. Exclusão de um CADFIS gerado por essa importação (espécie `'NF'`) → segue regra padrão de bloqueio quando há produtos em MOVDET (exceto nota de serviço).

## 6. Riscos e mitigação

- Risco: reordenar o cálculo do CFOP para antes do `case` pode introduzir duplicação se não remover o cálculo original mais abaixo → mitigação: mover (não copiar) o bloco, e revisar o diff antes de finalizar.
- Risco: remoção do tratamento de `'AG'` em `untCadLivroFiscal.pas` afetar documento histórico gravado com essa espécie → mitigação: confirmado com o solicitante que não há documento em produção com `FIS_ESPDOC = 'AG'`, pois a importação sempre falhou para modelo 75 até esta correção.
