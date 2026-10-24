# untFuncEditorRel

## Responsabilidade
Tipos e constantes base do editor de relatórios — em especial o enum de destinos `TDestinoRel` e o array de rótulos `ArrDestino` exibidos ao usuário.

## Caminho
`padra_atualizado/fontes/editorRelatorios/untFuncEditorRel.pas`

## Comportamento (escopo tocado no Req. 459921)
- `TDestinoRel` — enum de todos os destinos possíveis do relatório: `desVideo, desImpressora, desPDF, desCSV, desEmail, desTXT, desExcel, desTrace, desDesignReport, desXML, desValidacao, <gráficos>, desGrid, <dashboards>, desArquivoSaida`.
- `ArrDestino: Array[desVideo..desArquivoSaida] Of String[50]` — rótulo textual de cada destino (ex.: `'PDF'`, `'CSV'`, `'Arquivo Saída'`). **O limite superior do array acompanha o último membro do enum.**
- Conjuntos auxiliares por membros explícitos: `SET_GRAFICO`, `SET_GRAFICO_DASH` (não dependem do limite do enum).

## Pontos de atenção
- Ao adicionar um destino: incluir o membro no fim de `TDestinoRel`, **ajustar o limite** de `ArrDestino` (`[desVideo..<novo>]`) e acrescentar o rótulo na **mesma posição** do array (correspondência posicional enum↔array).
- A persistência em `CADREL.REL_DESTIN` é por **rótulo** (texto de `ArrDestino`), então mudar a ordem do enum não corrompe dados existentes; mas mudar o **rótulo** de um destino existente sim (deixa de casar com o que está gravado).
- Tipos de array usados pelos geradores: `TArrQuery` (array de `TUniQuery`, usado em `arrCadRel`) e `TArrDataSet` (array de `TDataSet`, usado em `qryDados`).

## Alterações documentadas
| Data | Requisito/Revisão | O que mudou |
|---|---|---|
| 2026-09-10 | Req. 459921 | Adicionado `desArquivoSaida` ao enum, ajustado limite de `ArrDestino` e incluído o rótulo `'Arquivo Saída'` |
