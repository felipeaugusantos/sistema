# untCadRelatorios

## Responsabilidade
Tela de cadastro do relatório (`TfrmCadRelatorios`): edição do SQL, campos, filtros, parâmetros, seleção dos **destinos permitidos** e das **opções por destino**.

## Caminho
`padra_atualizado/fontes/editorRelatorios/untCadRelatorios.pas` (+ `.dfm`)

## Comportamento (escopo relevante à rotina)
- **Destinos:** `cklDestin` (CheckListBox) é preenchido por `pSetaDestinos` a partir de `ArrDestino` (exceto `'Trace'` e `'DesignReport'`). Os marcados são gravados em `CADREL.REL_DESTIN` por `pDestinosToCampo` (texto, um rótulo por linha). `fDestinoMarcado(desDestino)` diz se um destino está marcado.
- **Painéis por destino:** `pAjustaModelo` ajusta a visibilidade dos painéis conforme o destino marcado — ex.: `pnlTXT`, `pnlXML` e (novo) `pnlArqSai` (`pnlArqSai.Visible := fDestinoMarcado(desArquivoSaida)`).
- **Opções do Arquivo Saída (novo):** painel `pnlArqSai` com:
  - `dbeEncArq: TDBComboBoxFocus` (DataField `REL_ENCARQ`) — itens `UTF-8`, `UTF-8 BOM`, `ANSI`, `UTF-16`, `Base64` (populados no `FormCreate`).
  - `chkSanArq: TDBCheckBox` (DataField `REL_SANARQ`, 'S'/'N').
- **Defaults na inclusão:** `REL_ENCARQ := 'UTF-8'`, `REL_SANARQ := 'N'` (junto dos demais defaults de novo registro).
- **Checkbox de pasta:** `dbePasSai` (DataField `REL_PASSAI`) — caption atualizado para incluir "Arquivo Saída".

## Tabelas
`CADREL` (L/G) via `qryTabela` (form herda de `TfrmPaiCad`, chave `REL_CODREL`).

## Métodos (relevantes)
| Método | Tipo | O que faz |
|---|---|---|
| `pSetaDestinos` | proc | Popula `cklDestin` a partir de `ArrDestino` |
| `pDestinosToCampo` | proc | Grava destinos marcados em `REL_DESTIN` |
| `fDestinoMarcado(desDestino): Boolean` | função | Diz se o destino está marcado no checklist |
| `pAjustaModelo` | proc | Ajusta visibilidade de painéis por destino (inclui `pnlArqSai`) |
| `FormCreate` (inherited) | proc | Popula itens dos combos, inclusive `dbeEncArq.Items` |

## Tela associada (.dfm)
| Componente | Tipo | Dispara/serve |
|---|---|---|
| `cklDestin` | TcxCheckListBox | Seleção dos destinos permitidos |
| `dbePasSai` | TDBCheckBox (`REL_PASSAI`) | Liga o filtro de pasta na execução |
| `pnlArqSai` | TPanel | Painel do destino Arquivo Saída (visível quando marcado) |
| `dbeEncArq` | TDBComboBoxFocus (`REL_ENCARQ`) | Codificação/modo (inclui Base64) |
| `chkSanArq` | TDBCheckBox (`REL_SANARQ`) | Sanitizar nome do arquivo |

## Pontos de atenção
- Componentes novos do `.dfm` (`pnlArqSai`, `grbArqSai`, `lblEncArq`, `dbeEncArq`, `chkSanArq`) foram **declarados manualmente** na classe do form no `.pas` (necessário quando se edita o `.dfm` fora da IDE; o IDE sincroniza ao abrir).
- `TDBComboBoxFocus` em `csDropDownList` grava no campo o **texto** do item selecionado (por isso `REL_ENCARQ` guarda `'UTF-8'`, `'Base64'`, etc.).

## Alterações documentadas
| Data | Requisito/Revisão | O que mudou |
|---|---|---|
| 2026-09-10 | Req. 459921 | Painel `pnlArqSai` (combo `REL_ENCARQ` + checkbox `REL_SANARQ`), defaults, população do combo (com `Base64`), caption do `dbePasSai` e visibilidade em `pAjustaModelo` |
