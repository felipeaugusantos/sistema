# untPreparaGNRE

## Responsabilidade

Tela "Prepara GNRE" (`TfrmPreparaGNRE`, herda `TfrmPaiConfirma`): mostra os itens da importação do
XML com divergência de ICMS-ST e deixa o operador ajustar o valor da GNRE de cada um antes de seguir.

## Caminho

`padra_atualizado/fontes/movimentacaoitens/untPreparaGNRE.pas` + `.dfm` — encoding cp1252.

## Comportamento

Aberta por `TfrmEntNFEDivergencias.fPreparaGNRE` durante a importação do XML, quando a tela de
divergências mostra divergência de ST:

1. Filtra a grade de divergências por `((VSTCAL + VSTXML) > 0) AND ELETRO = 'S'`; sem linhas, não abre.
2. Pergunta "Existem produtos com divergência de ST. Deseja preparar automaticamente a GNRE?".
3. Com `CFG_GNRETN`, só abre se o usuário tiver liberação (`fLiberaPrepararGNRE`); senão avisa que a
   importação segue sem a preparação.
4. A tela recebe o **mesmo dataset** da grade de divergências (`dtsDados.DataSet`): o valor editado
   em `VALGNR` vai direto para ele.
5. Confirmar → `btnConfirma = True`. Fechar sem confirmar → prévia suspensa (`blnPreviaGnreSuspensa`).

A tela não grava no banco. O caminho do valor depois dela:

1. `fPreparaGNRE` devolve `True` (confirmado) para a importação (`untEntImportacaoNotaEletronica`
   ou `untEntImportaNotaEletDivFiscal`), que o passa como `blnPreGnre` para
   `TNFeXml.fGravarNotaFiscal`.
2. `TNFeXml` grava `GERELE.GER_PREGNR = 'S'` e, por item eletrônico, `DETELE.DET_VLRGNR = VALGNR` e
   `DETELE.DET_CALGNR` = memória, ou `MSG_VLR_GNR_MANUAL` se `VALGNR ≠ VALGNR_ORIGINAL`.
3. Na entrada, a carga do XML leva `DET_VLRGNR` para `TMP_ENTMER.ENT_VLRGNR` e `GER_PREGNR` para
   `ENT_PREGNR`; o resumo cobra a guia por `pVerificaPrevia` ([untGNRE](untGNRE.md)).

Detalhe campo a campo em [gnre_entrada](gnre_entrada.md#campos-que-definem-o-comportamento).

## Configurações que impactam esta unit

| Código CFGSIS | Efeito |
|---------------|--------|
| `IFCPST` | Mostra "Vr. ST FCP Sistema" e "Vr. ST FCP Xml"; o hint do "Vr. GNRE" passa a somar a diferença de FCP |
| `GNRETN` | (em `untEntNFEDivergencias`) exige liberação para abrir a tela |

## Tabelas

Nenhuma — trabalha só no dataset recebido.

## Métodos

| Método | Tipo | O que faz | Efeito colateral |
|--------|------|-----------|------------------|
| `FormActivate` | evento | Zera `btnConfirma`, aplica `IFCPST` e o hint da fórmula | — |
| `btnConfirmaClick` | evento | `btnConfirma := True` | Fecha (herdado) |
| `cxItensDBVALGNRPropertiesValidate` | evento | Valor negativo volta para `VSTCAL − VSTXML` (mínimo 0) com aviso | Altera o dataset |
| `cxItensDBCustomDrawCell` | evento | Desenha o ícone de memória de cálculo na coluna "Vr. St" | — |
| `cxItensDBMouseDown` | evento | Clique na área do ícone abre a memória | — |
| `pExibeMemoriaCalculoVrSt` | procedure | Mostra: ((BC ICMS-ST × alíquota) / 100) − ICMS, com os valores do XML | Abre tela |
| `btnExportaExcelClick` | evento | Exporta a grade | Arquivo |

## Tela associada (.dfm)

| Coluna | Campo | Observação |
|--------|-------|------------|
| Nota / Fornecedor | `DOCSER` / `FORNEC` | |
| Cód. Item, Descrição, Cód. Fábrica, Referência, Unidade | `CODITE`, `DESITE`, `CODFAB`, `REFERE`, `SIGUNI` | |
| Quantidade, NCM, CST | `QCOMXML`, `NCMXML`, `CODSIT` | |
| Vr. Subst. Sistema / Vr. Subst. Xml | `VSTCAL` / `VSTXML` | |
| Vr. ST FCP Sistema / Xml | `CAL_VFCPST` / `VSTFCP` | Só com `IFCPST` |
| Vr. Prod. XML, Valor Unitário, Valor Total | `PROXML`, `UNCOMXML`, `PRODXML` | |
| Base ICMS-ST, Alq. ICMS, Vr. ICMS, Bc. ST, Vr. St | `BCXML`, `PICMSXML`, `ICMSXML`, `BCSTXML`, `ICMSSTXML` | "Vr. St" tem o ícone da memória |
| **Vr. GNRE** | `VALGNR` | Editável. Padrão: Vr. Subst. Sistema − Vr. Subst. Xml (+ diferença de FCP) |

Botões: confirmar/cancelar (herdados), "Exportar Excel".

## Pontos de atenção

- O clique da memória de cálculo é detectado por faixa fixa de pixels (`Right − 130` a `Right − 75`)
  da linha, não pela coluna — muda de lugar se o layout da grade mudar.
- A tela altera o dataset da tela de divergências; cancelar **não** desfaz o que foi digitado.

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-10-16 | Mapeamento (`--analisar`), base r500183 | Documentação inicial da unit inteira; sem alteração de código |
| 2026-10-16 | Mapeamento de campos | Confirmado o caminho da prévia até `DETELE`/`GERELE`/`TMP_ENTMER` |
