# Plano de Execução — Req. 458331

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Correção pontual de ordem de atribuição de campo dentro de um bloco condicional já existente. Não há mudança de arquitetura, apenas reposicionar `FieldByName('GER_ENTDIR').AsString := 'S'` para dentro do sub-ramo `Else` (FLUPDC inativo) e adicionar `FieldByName('GER_ENTDIR').AsString := 'N'` no sub-ramo `if (fCfgSis('FLUPDC', varBoolean))` (FLUPDC ativo), dentro do bloco `FOR_MATREV = 'M'` de `TNFeXml.fGravaGerEle`.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untEntNfeXml.pas` | `padra_atualizado/fontes/movimentacaoitens/untEntNfeXml.pas` | alterar |

## 3. Sequência de implementação

1. Localizar o ramo `If fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'], [FGerEle.GER_CODFOR]) = 'M' Then` em `TNFeXml.fGravaGerEle` (`untEntNfeXml.pas`, função em torno da linha 3941).
2. Remover a atribuição `FieldByName('GER_ENTDIR').AsString := 'S';` do topo do bloco (antes do `if FLUPDC`).
3. No sub-ramo `if (fCfgSis('FLUPDC', varBoolean)) then`, antes de `FieldByName('GER_DTACON').AsDateTime := VS_Date`, adicionar `FieldByName('GER_ENTDIR').AsString := 'N';`.
4. No sub-ramo `Else` (FLUPDC inativo), antes de `FieldByName('GER_DTALIB').AsDateTime := VS_Date`, adicionar `FieldByName('GER_ENTDIR').AsString := 'S';`.
5. Conferir que `GER_HORLIB`, `GER_OPELIB`, `GER_UNICOM` continuam sendo gravados nos dois sub-ramos (fora do `if`/`Else`), sem alteração.
6. Validar encoding do arquivo (`.pas` em Windows-1252/latin1 via `.editorconfig`) após a edição.

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian style, prefixo `unt`, sem exigência de interface — nenhuma mudança de convenção, só reordenação de atribuições já existentes no mesmo estilo do arquivo.
- Nenhum componente/chamada proibida envolvida.
- Nenhuma alteração de SQL (`ParamByName` já usado nas queries relacionadas, não tocadas neste requisito).

## 5. Estratégia de testes

- Suite: nenhuma (zona Legado sem infraestrutura de teste automatizado) — validação manual, com roteiro descrito.
- Casos a cobrir (roteiro manual):
  1. Importar XML de fornecedor `FOR_MATREV='M'` com `FLUPDC='S'` → conferir `GER_ENTDIR='N'` e `GER_DTACON` preenchido em `GERELE`.
  2. Abrir `TPreNota.fSelecionaNFE` → confirmar que a nota do passo 1 aparece na consulta.
  3. Processar/liberar a pré-nota (`untEntPreNotaEntrada.pas`) → confirmar `GER_DTALIB` preenchido.
  4. Abrir `TEntradaAutomatizada` (`fCarregaNota`/`fSQLNotas`) → confirmar que a nota aparece para finalizar a entrada.
  5. Regressão: repetir os passos 1-4 com fornecedor `FOR_MATREV='M'` e `FLUPDC='N'` → confirmar que a entrada continua fechando direto na importação (`GER_ENTDIR='S'`, `GER_DTALIB`/`GER_CONDIR='S'` já na importação, sem passar por pré-nota).
  6. Regressão: importar XML de fornecedor sem `FOR_MATREV='M'` (ramo `Else` original) → confirmar que continua gravando `GER_ENTDIR='N'` como antes.

## 6. Riscos e mitigação

- Risco: reordenar a atribuição pode deixar `GER_ENTDIR` sem valor explícito em algum caminho não coberto → mitigação: os dois sub-ramos (`if`/`Else`) cobrem 100% do bloco `FOR_MATREV='M'`, cada um com atribuição explícita de `GER_ENTDIR`.
- Risco: impacto em outros pontos que leem `GER_ENTDIR` fora da cadeia pré-nota/entrada automatizada já validada → mitigação: seção 1 do spec.md documenta o rastreamento ponta a ponta (importação → pré-nota → liberação → entrada automatizada) confirmando coerência.
